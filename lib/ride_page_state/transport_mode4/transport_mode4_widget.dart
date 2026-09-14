import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as gmaps;
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '/components/publish_ride_progress_header.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'transport_mode4_model.dart';
export 'transport_mode4_model.dart';

class RouteOption {
  final int index;
  final String summary;
  final String durationText;
  final String distanceText;
  final int durationSeconds;
  final int distanceMeters;
  final bool hasTolls;
  final List<gmaps.LatLng> polylinePoints;
  final gmaps.LatLng? startLocation;
  final gmaps.LatLng? endLocation;
  final String startAddress;
  final String endAddress;
  final gmaps.LatLngBounds? bounds;

  RouteOption({
    required this.index,
    required this.summary,
    required this.durationText,
    required this.distanceText,
    required this.durationSeconds,
    required this.distanceMeters,
    required this.hasTolls,
    required this.polylinePoints,
    this.startLocation,
    this.endLocation,
    required this.startAddress,
    required this.endAddress,
    this.bounds,
  });
}

class TransportMode4Widget extends StatefulWidget {
  const TransportMode4Widget({super.key});

  static String routeName = 'transportMode4';
  static String routePath = '/transportMode4';

  @override
  State<TransportMode4Widget> createState() => _TransportMode4WidgetState();
}

class _TransportMode4WidgetState extends State<TransportMode4Widget> {
  late TransportMode4Model _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  gmaps.GoogleMapController? _mapController;
  List<RouteOption> _availableRoutes = [];
  int _selectedRouteIndex = 0;
  bool _isFetchingRoutes = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TransportMode4Model());
    _model.transportModeValue ??= 'Car';

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchRoutesWithAlternatives();
    });
  }

  @override
  void dispose() {
    _mapController = null;
    _model.dispose();
    super.dispose();
  }

  List<gmaps.LatLng> _decodePolyline(String encoded) {
    List<gmaps.LatLng> points = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      points.add(gmaps.LatLng(lat / 1E5, lng / 1E5));
    }
    return points;
  }

  Future<void> _fetchRoutesWithAlternatives() async {
    try {
      String startLocation = FFAppState().RideStartLocaction.trim();
      String endLocation = FFAppState().RideEndLocaction.trim();

      if (startLocation.isEmpty) startLocation = 'Aligarh, Uttar Pradesh';
      if (endLocation.isEmpty) endLocation = 'Dehradun, Uttarakhand';

      setState(() {
        _isFetchingRoutes = true;
        _model.isCalculatingTime = true;
        _errorMessage = null;
      });

      const String apiKey = 'AIzaSyDZkxRpoy0BOIAPwMaMIvAd5xpCe-6ZYvs';
      String travelMode = _getGoogleTravelMode(_model.transportModeValue ?? 'Car');

      final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/directions/json?'
        'origin=${Uri.encodeComponent(startLocation)}&'
        'destination=${Uri.encodeComponent(endLocation)}&'
        'mode=$travelMode&'
        'alternatives=true&'
        'departure_time=now&'
        'traffic_model=best_guess&'
        'key=$apiKey',
      );

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['status'] == 'OK' &&
            data['routes'] != null &&
            (data['routes'] as List).isNotEmpty) {
          List<dynamic> routesList = data['routes'];
          List<RouteOption> parsedRoutes = [];

          for (int i = 0; i < routesList.length; i++) {
            final r = routesList[i];
            final leg = r['legs']?[0];
            if (leg == null) continue;

            final durationText = leg['duration']?['text'] ?? '';
            final distanceText = leg['distance']?['text'] ?? '';
            final durationSeconds = (leg['duration']?['value'] as num?)?.toInt() ?? 0;
            final distanceMeters = (leg['distance']?['value'] as num?)?.toInt() ?? 0;
            final summary = (r['summary'] != null && (r['summary'] as String).trim().isNotEmpty)
                ? r['summary'] as String
                : 'Main Route';

            bool hasTolls = false;
            final warnings = r['warnings'] as List<dynamic>?;
            if (warnings != null &&
                warnings.any((w) => w.toString().toLowerCase().contains('toll'))) {
              hasTolls = true;
            }

            final encodedPoints = r['overview_polyline']?['points'] ?? '';
            final points = _decodePolyline(encodedPoints);

            gmaps.LatLng? startLoc;
            if (leg['start_location'] != null) {
              startLoc = gmaps.LatLng(
                (leg['start_location']['lat'] as num).toDouble(),
                (leg['start_location']['lng'] as num).toDouble(),
              );
            }

            gmaps.LatLng? endLoc;
            if (leg['end_location'] != null) {
              endLoc = gmaps.LatLng(
                (leg['end_location']['lat'] as num).toDouble(),
                (leg['end_location']['lng'] as num).toDouble(),
              );
            }

            gmaps.LatLngBounds? bounds;
            if (r['bounds'] != null) {
              final ne = r['bounds']['northeast'];
              final sw = r['bounds']['southwest'];
              if (ne != null && sw != null) {
                bounds = gmaps.LatLngBounds(
                  southwest: gmaps.LatLng(
                    (sw['lat'] as num).toDouble(),
                    (sw['lng'] as num).toDouble(),
                  ),
                  northeast: gmaps.LatLng(
                    (ne['lat'] as num).toDouble(),
                    (ne['lng'] as num).toDouble(),
                  ),
                );
              }
            }

            parsedRoutes.add(RouteOption(
              index: i,
              summary: summary,
              durationText: durationText,
              distanceText: distanceText,
              durationSeconds: durationSeconds,
              distanceMeters: distanceMeters,
              hasTolls: hasTolls,
              polylinePoints: points,
              startLocation: startLoc,
              endLocation: endLoc,
              startAddress: leg['start_address'] ?? startLocation,
              endAddress: leg['end_address'] ?? endLocation,
              bounds: bounds,
            ));
          }

          if (parsedRoutes.isNotEmpty) {
            _availableRoutes = parsedRoutes;
            _selectedRouteIndex = 0;
            final sel = _availableRoutes[0];
            _model.travelTime = '${sel.durationText} (${sel.distanceText})';
            safeSetState(() {});
            _fitMapBounds();
          }
        } else {
          _errorMessage = 'No routes available for ${_model.transportModeValue}';
        }
      } else {
        _errorMessage = 'Network error calculating routes';
      }
    } catch (e) {
      _errorMessage = 'Error loading routes: $e';
    } finally {
      if (mounted) {
        setState(() {
          _isFetchingRoutes = false;
          _model.isCalculatingTime = false;
        });
      }
    }
  }

  Future<void> _fitMapBounds() async {
    if (!mounted || _mapController == null || _availableRoutes.isEmpty) return;
    try {
      final currentRoute = _availableRoutes[_selectedRouteIndex];
      if (currentRoute.bounds != null) {
        await _mapController?.animateCamera(
          gmaps.CameraUpdate.newLatLngBounds(currentRoute.bounds!, 40.0),
        );
      } else if (currentRoute.startLocation != null) {
        await _mapController?.animateCamera(
          gmaps.CameraUpdate.newLatLngZoom(currentRoute.startLocation!, 9.0),
        );
      }
    } catch (_) {}
  }

  String _getGoogleTravelMode(String mode) {
    switch (mode.toLowerCase()) {
      case 'car':
        return 'driving';
      case 'bike':
        return 'bicycling';
      case 'bus':
        return 'transit';
      case 'train':
        return 'transit';
      default:
        return 'driving';
    }
  }

  Set<gmaps.Marker> _buildMarkers() {
    final markers = <gmaps.Marker>{};
    if (_availableRoutes.isEmpty) return markers;

    final route = _availableRoutes[_selectedRouteIndex];

    if (route.startLocation != null) {
      markers.add(
        gmaps.Marker(
          markerId: const gmaps.MarkerId('origin_pin'),
          position: route.startLocation!,
          icon: gmaps.BitmapDescriptor.defaultMarkerWithHue(gmaps.BitmapDescriptor.hueOrange),
          infoWindow: gmaps.InfoWindow(
            title: route.startAddress.split(',').first,
            snippet: 'Start',
          ),
        ),
      );
    }

    if (route.endLocation != null) {
      markers.add(
        gmaps.Marker(
          markerId: const gmaps.MarkerId('destination_pin'),
          position: route.endLocation!,
          icon: gmaps.BitmapDescriptor.defaultMarkerWithHue(gmaps.BitmapDescriptor.hueRed),
          infoWindow: gmaps.InfoWindow(
            title: route.endAddress.split(',').first,
            snippet: 'Destination',
          ),
        ),
      );
    }

    return markers;
  }

  Set<gmaps.Polyline> _buildPolylines() {
    final polylines = <gmaps.Polyline>{};

    for (int i = 0; i < _availableRoutes.length; i++) {
      final r = _availableRoutes[i];
      final bool isSelected = (i == _selectedRouteIndex);

      polylines.add(
        gmaps.Polyline(
          polylineId: gmaps.PolylineId('route_polyline_$i'),
          points: r.polylinePoints,
          color: isSelected ? const Color(0xFFEE7B4D) : const Color(0xFFFFCC80),
          width: isSelected ? 5 : 3,
          zIndex: isSelected ? 3 : 1,
        ),
      );
    }

    return polylines;
  }

  DateTime? _getCalculatedArrivalDateTime() {
    if (FFAppState().pickupTime == null) return null;
    int totalMinutes = 0;

    if (_availableRoutes.isNotEmpty) {
      final currentRoute = _availableRoutes[_selectedRouteIndex];
      totalMinutes = (currentRoute.durationSeconds / 60).round();
    } else if (_model.travelTime != null) {
      String travelTimeStr = _model.travelTime!;
      RegExp minutesRegExp = RegExp(r'(\d+)\s*mins?');
      RegExp hoursRegExp = RegExp(r'(\d+)\s*hours?');
      final hoursMatch = hoursRegExp.firstMatch(travelTimeStr);
      if (hoursMatch != null) {
        totalMinutes += int.parse(hoursMatch.group(1)!) * 60;
      }
      final minutesMatch = minutesRegExp.firstMatch(travelTimeStr);
      if (minutesMatch != null) {
        totalMinutes += int.parse(minutesMatch.group(1)!);
      }
    }

    if (totalMinutes == 0) return null;
    return FFAppState().pickupTime!.add(Duration(minutes: totalMinutes));
  }

  Widget _buildVehicleOptionCard({
    required String mode,
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    final isSelected = (_model.transportModeValue ?? 'Car').toLowerCase() == mode.toLowerCase();

    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () async {
            _model.transportModeValue = mode;
            safeSetState(() {});
            await _fetchRoutesWithAlternatives();
          },
          borderRadius: BorderRadius.circular(16.0),
          child: Container(
            height: 116.0,
            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 4.0),
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFFFFF6EE) : Colors.white,
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(
                color: isSelected ? const Color(0xFFEE7B4D) : const Color(0xFFEAECEF),
                width: isSelected ? 2.0 : 1.0,
              ),
              boxShadow: isSelected
                  ? const [
                      BoxShadow(
                        color: Color(0x1AEE7B4D),
                        blurRadius: 8.0,
                        offset: Offset(0, 3),
                      ),
                    ]
                  : const [
                      BoxShadow(
                        color: Color(0x06000000),
                        blurRadius: 4.0,
                        offset: Offset(0, 2),
                      ),
                    ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 40.0,
                  height: 40.0,
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xFFEE7B4D) : const Color(0xFFF3F4F6),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    color: isSelected ? Colors.white : const Color(0xFF6B7280),
                    size: 20.0,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 13.0,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                    color: isSelected ? const Color(0xFFEE7B4D) : const Color(0xFF1F2937),
                  ),
                ),
                const SizedBox(height: 2.0),
                Text(
                  subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 10.0,
                    fontWeight: FontWeight.w500,
                    color: isSelected ? const Color(0xFFD97706) : const Color(0xFF9CA3AF),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    final arrivalDateTime = _getCalculatedArrivalDateTime();
    final initialCenter = _availableRoutes.isNotEmpty && _availableRoutes[0].startLocation != null
        ? _availableRoutes[0].startLocation!
        : const gmaps.LatLng(28.6139, 77.2090);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: const Color(0xFFF8FAFC),
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30.0,
            borderWidth: 1.0,
            buttonSize: 48.0,
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: Color(0xFF1F2937),
              size: 24.0,
            ),
            onPressed: () async {
              context.pop();
            },
          ),
          title: Text(
            'Publish Ride',
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w700,
              color: const Color(0xFF111827),
              fontSize: 18.0,
            ),
          ),
          centerTitle: true,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Step Progress Header
                      const PublishRideProgressHeader(
                        currentStep: 4,
                        totalSteps: 8,
                        title: 'Transport Mode',
                        subtitle: 'Select vehicle type and preferred navigation route.',
                        badgeText: 'STEP 4 OF 8',
                      ),

                      // Vehicle Type Cards (Evenly aligned with IntrinsicHeight & equal 116px height)
                      IntrinsicHeight(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            _buildVehicleOptionCard(
                              mode: 'Car',
                              icon: Icons.directions_car_rounded,
                              title: 'Car',
                              subtitle: 'Personal',
                            ),
                            const SizedBox(width: 8.0),
                            _buildVehicleOptionCard(
                              mode: 'Bike',
                              icon: Icons.two_wheeler_rounded,
                              title: 'Bike',
                              subtitle: '2-Wheeler',
                            ),
                            const SizedBox(width: 8.0),
                            _buildVehicleOptionCard(
                              mode: 'Bus',
                              icon: Icons.directions_bus_rounded,
                              title: 'Bus',
                              subtitle: 'Transit',
                            ),
                            const SizedBox(width: 8.0),
                            _buildVehicleOptionCard(
                              mode: 'Train',
                              icon: Icons.train_rounded,
                              title: 'Train',
                              subtitle: 'Rail',
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20.0),

                      // Routes and Map Preview
                      if (_isFetchingRoutes)
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(20.0),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFF7ED),
                            borderRadius: BorderRadius.circular(16.0),
                            border: Border.all(color: const Color(0xFFFFEDD5)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                width: 20.0,
                                height: 20.0,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.5,
                                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFEE7B4D)),
                                ),
                              ),
                              const SizedBox(width: 14.0),
                              Text(
                                'Calculating optimal routes & traffic...',
                                style: GoogleFonts.inter(
                                  color: const Color(0xFFC2410C),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13.0,
                                ),
                              ),
                            ],
                          ),
                        )
                      else if (_availableRoutes.isNotEmpty) ...[
                        // Larger Map Preview Container (Increased to 280px)
                        Container(
                          height: 280.0,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            border: Border.all(color: const Color(0xFFE5E7EB)),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x0A000000),
                                blurRadius: 12.0,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: Stack(
                            children: [
                              gmaps.GoogleMap(
                                initialCameraPosition: gmaps.CameraPosition(
                                  target: initialCenter,
                                  zoom: 8.0,
                                ),
                                onMapCreated: (controller) {
                                  _mapController = controller;
                                  Future.delayed(const Duration(milliseconds: 350), () {
                                    if (mounted) {
                                      _fitMapBounds();
                                    }
                                  });
                                },
                                markers: _buildMarkers(),
                                polylines: _buildPolylines(),
                                zoomControlsEnabled: false,
                                myLocationButtonEnabled: false,
                                mapToolbarEnabled: false,
                                compassEnabled: false,
                              ),
                              // Distance badge on map
                              Positioned(
                                top: 12.0,
                                right: 12.0,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20.0),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Color(0x1A000000),
                                        blurRadius: 6.0,
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(
                                        Icons.navigation_rounded,
                                        size: 13.0,
                                        color: Color(0xFFEE7B4D),
                                      ),
                                      const SizedBox(width: 4.0),
                                      Text(
                                        _availableRoutes[_selectedRouteIndex].distanceText,
                                        style: GoogleFonts.inter(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 12.0,
                                          color: const Color(0xFF111827),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 16.0),

                        // Route Alternative Selection Cards
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.0),
                            border: Border.all(color: const Color(0xFFEAECEF)),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x0A000000),
                                blurRadius: 16.0,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Available Routes',
                                style: GoogleFonts.inter(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF111827),
                                ),
                              ),
                              const SizedBox(height: 12.0),

                              ..._availableRoutes.asMap().entries.map((entry) {
                                final int index = entry.key;
                                final route = entry.value;
                                final bool isSelected = (index == _selectedRouteIndex);

                                return InkWell(
                                  onTap: () {
                                    setState(() {
                                      _selectedRouteIndex = index;
                                      _model.travelTime = '${route.durationText} (${route.distanceText})';
                                    });
                                    _fitMapBounds();
                                  },
                                  borderRadius: BorderRadius.circular(14.0),
                                  child: Container(
                                    margin: const EdgeInsets.only(bottom: 8.0),
                                    padding: const EdgeInsets.all(12.0),
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? const Color(0xFFFFF6EE)
                                          : const Color(0xFFF9FAFB),
                                      borderRadius: BorderRadius.circular(14.0),
                                      border: Border.all(
                                        color: isSelected
                                            ? const Color(0xFFEE7B4D)
                                            : const Color(0xFFE5E7EB),
                                        width: isSelected ? 1.5 : 1.0,
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 20.0,
                                          height: 20.0,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: const Color(0xFFEE7B4D),
                                              width: isSelected ? 5.5 : 2.0,
                                            ),
                                            color: isSelected ? Colors.white : Colors.transparent,
                                          ),
                                        ),
                                        const SizedBox(width: 12.0),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    route.durationText,
                                                    style: GoogleFonts.inter(
                                                      fontSize: 14.0,
                                                      fontWeight: FontWeight.w700,
                                                      color: const Color(0xFF111827),
                                                    ),
                                                  ),
                                                  if (route.hasTolls) ...[
                                                    const SizedBox(width: 6.0),
                                                    Container(
                                                      padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 1.5),
                                                      decoration: BoxDecoration(
                                                        color: const Color(0xFFFEF3C7),
                                                        borderRadius: BorderRadius.circular(6.0),
                                                      ),
                                                      child: Text(
                                                        'Tolls',
                                                        style: GoogleFonts.inter(
                                                          fontSize: 9.5,
                                                          fontWeight: FontWeight.w700,
                                                          color: const Color(0xFFD97706),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ],
                                              ),
                                              const SizedBox(height: 2.0),
                                              Text(
                                                '${route.distanceText} • via ${route.summary}',
                                                style: GoogleFonts.inter(
                                                  fontSize: 12.0,
                                                  color: const Color(0xFF6B7280),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                            ],
                          ),
                        ),

                        const SizedBox(height: 14.0),

                        // Departure & Arrival ETA Summary Card
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16.0),
                            border: Border.all(color: const Color(0xFFEAECEF)),
                          ),
                          padding: const EdgeInsets.all(14.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF9FAFB),
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: Column(
                                    children: [
                                      Text(
                                        'Departure',
                                        style: GoogleFonts.inter(
                                          color: const Color(0xFF6B7280),
                                          fontSize: 11.0,
                                        ),
                                      ),
                                      const SizedBox(height: 2.0),
                                      Text(
                                        FFAppState().pickupTime != null
                                            ? dateTimeFormat('jm', FFAppState().pickupTime)
                                            : '--:--',
                                        style: GoogleFonts.inter(
                                          color: const Color(0xFF111827),
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                child: Icon(
                                  Icons.arrow_forward_rounded,
                                  color: Color(0xFFEE7B4D),
                                  size: 18.0,
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFFF6EE),
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: Column(
                                    children: [
                                      Text(
                                        'Estimated Arrival',
                                        style: GoogleFonts.inter(
                                          color: const Color(0xFFC2410C),
                                          fontSize: 11.0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(height: 2.0),
                                      Text(
                                        arrivalDateTime != null
                                            ? dateTimeFormat('jm', arrivalDateTime)
                                            : '--:--',
                                        style: GoogleFonts.inter(
                                          color: const Color(0xFFC2410C),
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ] else if (_errorMessage != null)
                        Container(
                          padding: const EdgeInsets.all(14.0),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFEF2F2),
                            borderRadius: BorderRadius.circular(14.0),
                            border: Border.all(color: const Color(0xFFFEE2E2)),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.info_outline_rounded,
                                color: Color(0xFFEF4444),
                                size: 20.0,
                              ),
                              const SizedBox(width: 10.0),
                              Expanded(
                                child: Text(
                                  _errorMessage!,
                                  style: GoogleFonts.inter(
                                    color: const Color(0xFFB91C1C),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12.5,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),

              // Bottom Fixed Action Button Container
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    top: BorderSide(
                      color: Color(0xFFF1F5F9),
                      width: 1.0,
                    ),
                  ),
                ),
                child: InkWell(
                  onTap: () async {
                    if (_model.transportModeValue != null && _model.transportModeValue!.isNotEmpty) {
                      if (_availableRoutes.isNotEmpty) {
                        final sel = _availableRoutes[_selectedRouteIndex];
                        FFAppState().modeOfTransport = _model.transportModeValue!;
                        FFAppState().travelTime = '${sel.durationText} (${sel.distanceText})';
                        safeSetState(() {});
                      } else if (_model.travelTime != null) {
                        FFAppState().modeOfTransport = _model.transportModeValue!;
                        FFAppState().travelTime = _model.travelTime!;
                        safeSetState(() {});
                      }

                      context.pushNamed(CaryItems5Widget.routeName);
                    } else {
                      await showDialog(
                        context: context,
                        builder: (alertDialogContext) => AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          title: Text(
                            'Select Transport Mode',
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w700,
                              fontSize: 17.0,
                            ),
                          ),
                          content: Text(
                            'Please select your mode of transport to proceed.',
                            style: GoogleFonts.inter(
                              fontSize: 13.5,
                              color: const Color(0xFF4B5563),
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(alertDialogContext),
                              child: Text(
                                'Ok',
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFFEE7B4D),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  borderRadius: BorderRadius.circular(16.0),
                  child: Container(
                    width: double.infinity,
                    height: 52.0,
                    decoration: BoxDecoration(
                      color: const Color(0xFFEE7B4D),
                      borderRadius: BorderRadius.circular(16.0),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x33EE7B4D),
                          blurRadius: 12.0,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Continue to Luggage & Items',
                          style: GoogleFonts.inter(
                            fontSize: 15.5,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        const Icon(
                          Icons.arrow_forward_rounded,
                          color: Colors.white,
                          size: 20.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
