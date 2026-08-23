import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as gmaps;
import 'package:http/http.dart' as http;
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
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
                : 'Main Highway';

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
    } catch (e) {
      // Platform channel may not be ready or disposed during navigation
    }
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
          color: isSelected ? const Color(0xFFF57C3B) : const Color(0xFFFFCC80),
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
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30.0,
            borderWidth: 1.0,
            buttonSize: 60.0,
            icon: Icon(
              Icons.arrow_back_rounded,
              color: FlutterFlowTheme.of(context).primaryText,
              size: 28.0,
            ),
            onPressed: () async {
              context.pop();
            },
          ),
          title: Text(
            'Mode of Transport',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  font: GoogleFonts.interTight(
                    fontWeight: FontWeight.bold,
                  ),
                  color: FlutterFlowTheme.of(context).primaryText,
                  fontSize: 19.0,
                ),
          ),
          centerTitle: true,
          elevation: 1.0,
        ),
        body: SafeArea(
          top: true,
          child: Stack(
            children: [
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(
                  left: 20.0,
                  right: 20.0,
                  top: 16.0,
                  bottom: 110.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // =================== 1. 40% PROGRESS INDICATOR ===================
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: CircularPercentIndicator(
                          percent: 0.4,
                          radius: 56.0,
                          lineWidth: 11.0,
                          animation: true,
                          animateFromLastPercent: true,
                          progressColor: const Color(0xFFF57C3B),
                          backgroundColor: const Color(0xFFE2E8F0),
                          center: Text(
                            '40%',
                            style: GoogleFonts.interTight(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF0F172A),
                            ),
                          ),
                        ),
                      ),
                    ),

                    // =================== 2. MODE OF TRANSPORT DROPDOWN ===================
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 4.0, bottom: 8.0),
                        child: Text(
                          'Mode of transport',
                          style: GoogleFonts.interTight(
                            fontWeight: FontWeight.w600,
                            fontSize: 15.0,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                      ),
                    ),
                    FlutterFlowDropDown<String>(
                      controller: _model.transportModeValueController ??= FormFieldController<String>(
                        _model.transportModeValue ??= (FFAppState().modeOfTransport.isNotEmpty
                            ? FFAppState().modeOfTransport
                            : 'Car'),
                      ),
                      options: const ['Car', 'Bike', 'Bus', 'Train'],
                      onChanged: (val) async {
                        _model.transportModeValue = val;
                        safeSetState(() {});
                        if (val != null && val.isNotEmpty) {
                          await _fetchRoutesWithAlternatives();
                        }
                      },
                      width: double.infinity,
                      height: 54.0,
                      textStyle: GoogleFonts.inter(
                        fontSize: 14.5,
                        color: const Color(0xFF0F172A),
                      ),
                      hintText: 'Select...',
                      icon: const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: Color(0xFF64748B),
                        size: 24.0,
                      ),
                      fillColor: Colors.white,
                      elevation: 1.0,
                      borderColor: const Color(0xFF4DABF7),
                      borderWidth: 1.5,
                      borderRadius: 10.0,
                      margin: const EdgeInsetsDirectional.fromSTEB(14.0, 0.0, 14.0, 0.0),
                      hidesUnderline: true,
                      isOverButton: false,
                      isSearchable: false,
                      isMultiSelect: false,
                    ),

                    const SizedBox(height: 18.0),

                    // =================== 3. INTERACTIVE ROUTE SELECTION & MAP (REPLACES OLD STATIC CARD) ===================
                    if (_isFetchingRoutes)
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFF7ED),
                          borderRadius: BorderRadius.circular(14.0),
                          border: Border.all(color: const Color(0xFFFFEDD5)),
                        ),
                        child: const Row(
                          children: [
                            SizedBox(
                              width: 22.0,
                              height: 22.0,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.5,
                                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFF57C3B)),
                              ),
                            ),
                            SizedBox(width: 12.0),
                            Expanded(
                              child: Text(
                                'Finding the best routes with real-time traffic...',
                                style: TextStyle(
                                  color: Color(0xFFC2410C),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    else if (_availableRoutes.isNotEmpty) ...[
                      // A. Map Route Preview Container
                      Container(
                        height: 190.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.04),
                              blurRadius: 8.0,
                              offset: const Offset(0, 2),
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
                            // Map badge
                            Positioned(
                              top: 10.0,
                              right: 10.0,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.9),
                                  borderRadius: BorderRadius.circular(8.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.06),
                                      blurRadius: 4.0,
                                    ),
                                  ],
                                ),
                                child: Text(
                                  _availableRoutes[_selectedRouteIndex].distanceText,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11.5,
                                    color: Color(0xFFF57C3B),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 16.0),

                      // B. Route Options Card
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16.0),
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.02),
                              blurRadius: 6.0,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'What is your route?',
                                  style: GoogleFonts.inter(
                                    fontSize: 16.5,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF0F172A),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF57C3B).withOpacity(0.12),
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: Text(
                                    (_model.transportModeValue ?? 'CAR').toUpperCase(),
                                    style: const TextStyle(
                                      color: Color(0xFFF57C3B),
                                      fontWeight: FontWeight.w700,
                                      fontSize: 10.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12.0),

                            // Routes list
                            ..._availableRoutes.asMap().entries.map((entry) {
                              final int index = entry.key;
                              final route = entry.value;
                              final bool isSelected = (index == _selectedRouteIndex);

                              String titleText = route.durationText;
                              if (route.hasTolls) {
                                titleText += ' - Tolls';
                              }
                              String subtitleText = '${route.distanceText} - ${route.summary}';

                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    _selectedRouteIndex = index;
                                    _model.travelTime = '${route.durationText} (${route.distanceText})';
                                  });
                                  _fitMapBounds();
                                },
                                borderRadius: BorderRadius.circular(12.0),
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 8.0),
                                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? const Color(0xFFFFF7ED)
                                        : const Color(0xFFF8FAFC),
                                    borderRadius: BorderRadius.circular(12.0),
                                    border: Border.all(
                                      color: isSelected
                                          ? const Color(0xFFF57C3B)
                                          : const Color(0xFFE2E8F0),
                                      width: isSelected ? 1.5 : 1.0,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      // Radio Button matching Travia Theme
                                      Container(
                                        width: 20.0,
                                        height: 20.0,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: const Color(0xFFF57C3B),
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
                                            Text(
                                              titleText,
                                              style: GoogleFonts.inter(
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.w700,
                                                color: const Color(0xFF0F172A),
                                              ),
                                            ),
                                            const SizedBox(height: 2.0),
                                            Text(
                                              subtitleText,
                                              style: GoogleFonts.inter(
                                                fontSize: 12.0,
                                                color: const Color(0xFF64748B),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          ],
                        ),
                      ),

                      const SizedBox(height: 14.0),

                      // C. Departure and Arrival Card
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16.0),
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                        ),
                        padding: const EdgeInsets.all(14.0),
                        child: Row(
                          children: [
                            // Departure
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF8FAFC),
                                  borderRadius: BorderRadius.circular(10.0),
                                  border: Border.all(color: const Color(0xFFE2E8F0)),
                                ),
                                child: Column(
                                  children: [
                                    const Text('Departure', style: TextStyle(color: Color(0xFF64748B), fontSize: 11.0)),
                                    const SizedBox(height: 2.0),
                                    Text(
                                      FFAppState().pickupTime != null
                                          ? dateTimeFormat('jm', FFAppState().pickupTime)
                                          : '--:--',
                                      style: const TextStyle(
                                        color: Color(0xFF0F172A),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13.5,
                                      ),
                                    ),
                                    if (FFAppState().pickupTime != null)
                                      Text(
                                        dateTimeFormat('yMMMd', FFAppState().pickupTime),
                                        style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 9.5),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: Icon(Icons.arrow_forward_rounded, color: Color(0xFFF57C3B), size: 18.0),
                            ),
                            // Arrival
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFF7ED),
                                  borderRadius: BorderRadius.circular(10.0),
                                  border: Border.all(color: const Color(0xFFFFEDD5)),
                                ),
                                child: Column(
                                  children: [
                                    const Text('Arrival', style: TextStyle(color: Color(0xFFC2410C), fontSize: 11.0, fontWeight: FontWeight.w600)),
                                    const SizedBox(height: 2.0),
                                    Text(
                                      arrivalDateTime != null
                                          ? dateTimeFormat('jm', arrivalDateTime)
                                          : '--:--',
                                      style: const TextStyle(
                                        color: Color(0xFFC2410C),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13.5,
                                      ),
                                    ),
                                    if (arrivalDateTime != null)
                                      Text(
                                        dateTimeFormat('yMMMd', arrivalDateTime),
                                        style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 9.5),
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
                          color: Colors.orange.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12.0),
                          border: Border.all(color: Colors.orange, width: 1.0),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 20.0),
                            const SizedBox(width: 8.0),
                            Expanded(
                              child: Text(
                                _errorMessage!,
                                style: const TextStyle(color: Colors.orange, fontWeight: FontWeight.w600, fontSize: 13.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),

              // =================== FLOATING ORANGE NEXT BUTTON (THEME COLOR) ===================
              Positioned(
                bottom: 24.0,
                right: 20.0,
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
                          title: const Text('Attention'),
                          content: const Text('Please select a mode of transport.'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(alertDialogContext),
                              child: const Text('Ok'),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  child: Container(
                    width: 70.0,
                    height: 70.0,
                    decoration: const BoxDecoration(
                      color: Color(0xFFFF8C00),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x40FF8C00),
                          blurRadius: 10.0,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.arrow_forward_rounded,
                        color: Colors.white,
                        size: 30.0,
                      ),
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

/* ==========================================================================
   PREVIOUS GREEN CARD UI & FORM (SAVED AS BACKUP FOR FUTURE USE)
   ==========================================================================

class _PreviousGreenCardBackup extends StatelessWidget {
  const _PreviousGreenCardBackup();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.green.withOpacity(0.1),
            Colors.green.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: Colors.green.withOpacity(0.3), width: 1.0),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withOpacity(0.1),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: const Icon(Icons.directions_car, color: Colors.green, size: 20.0),
                ),
                const SizedBox(width: 12.0),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Trip Duration', style: TextStyle(color: Colors.green, fontSize: 12.0)),
                      Text('5 hours 34 mins (305 km)',
                          style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 18.0)),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: const Text('CAR', style: TextStyle(color: Colors.white, fontSize: 10.0)),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                const Expanded(child: Divider(color: Colors.green, thickness: 1)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Icon(Icons.access_time_filled, color: Colors.green[600], size: 18.0),
                ),
                const Expanded(child: Divider(color: Colors.green, thickness: 1)),
              ],
            ),
            const SizedBox(height: 12.0),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(color: Colors.green.withOpacity(0.2)),
                    ),
                    child: const Column(
                      children: [
                        Text('Departure', style: TextStyle(color: Colors.grey, fontSize: 11.0)),
                        Text('4:17 PM', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                        Text('Aug 23, 2026', style: TextStyle(color: Colors.grey, fontSize: 10.0)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
                const Icon(Icons.arrow_forward, color: Colors.green, size: 16.0),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(color: Colors.green.withOpacity(0.3)),
                    ),
                    child: const Column(
                      children: [
                        Text('Arrival', style: TextStyle(color: Colors.green, fontSize: 11.0)),
                        Text('9:17 PM', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                        Text('Aug 23, 2026', style: TextStyle(color: Colors.grey, fontSize: 10.0)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
========================================================================== */
