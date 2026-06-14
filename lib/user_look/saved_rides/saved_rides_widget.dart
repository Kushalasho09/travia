import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/no_saved_rides_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/flutter_flow_google_map.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as gmaps;
import 'dart:math';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'saved_rides_model.dart';
export 'saved_rides_model.dart';

/// Create a page where show list of saved rides list with some other details
class SavedRidesWidget extends StatefulWidget {
  const SavedRidesWidget({super.key});

  static String routeName = 'SavedRides';
  static String routePath = '/savedRides';

  @override
  State<SavedRidesWidget> createState() => _SavedRidesWidgetState();
}

class _SavedRidesWidgetState extends State<SavedRidesWidget>
    with TickerProviderStateMixin {
  late SavedRidesModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final animationsMap = <String, AnimationInfo>{};
  
  int _activePageIndex = 0;
  PageController? _pageController;
  bool _initialMapLocationSet = false;

  // State variables for route lines and error overlays
  String? _lastFetchedRideId;
  List<gmaps.LatLng> _routePoints = [];
  bool _mapNotAvailable = false;

  // Decodes Google overview_polyline points string into a List of LatLngs
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

  // Fetches routes from Google Directions API, falls back to direct connection if it fails
  Future<void> _fetchRoute(RidesNewRecord ride) async {
    final start = ride.rideStartLocationGoogle;
    final end = ride.rideEndLocationGoogle;
    if (start == null || end == null) {
      if (mounted) {
        setState(() {
          _routePoints = [];
          _mapNotAvailable = true;
        });
      }
      return;
    }

    try {
      const String apiKey = 'AIzaSyDrBEQ4RZ9wJ_P4oqHIUtINBRbLU1SkEh4';
      final url = Uri.parse(
          'https://maps.googleapis.com/maps/api/directions/json?'
          'origin=${start.latitude},${start.longitude}&'
          'destination=${end.latitude},${end.longitude}&'
          'key=$apiKey'
      );

      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == 'OK' && data['routes']?.isNotEmpty == true) {
          final points = data['routes'][0]['overview_polyline']['points'] as String;
          final decodedPoints = _decodePolyline(points);
          if (mounted) {
            setState(() {
              _routePoints = decodedPoints;
              _mapNotAvailable = false;
            });
          }
          return;
        }
      }

      // Fallback straight line
      if (mounted) {
        setState(() {
          _routePoints = [
            gmaps.LatLng(start.latitude, start.longitude),
            gmaps.LatLng(end.latitude, end.longitude),
          ];
          _mapNotAvailable = true;
        });
      }
    } catch (e) {
      // Fallback straight line
      if (mounted) {
        setState(() {
          _routePoints = [
            gmaps.LatLng(start.latitude, start.longitude),
            gmaps.LatLng(end.latitude, end.longitude),
          ];
          _mapNotAvailable = true;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SavedRidesModel());
    _pageController = PageController(viewportFraction: 0.88);

    animationsMap.addAll({
      'listViewOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
    });
  }

  @override
  void dispose() {
    _model.dispose();
    _pageController?.dispose();
    super.dispose();
  }

  Future<void> _updateMapCamera(RidesNewRecord ride) async {
    if (ride.rideStartLocationGoogle == null) return;
    try {
      final controller = await _model.googleMapsController.future;
      if (ride.rideEndLocationGoogle != null) {
        final start = ride.rideStartLocationGoogle!;
        final end = ride.rideEndLocationGoogle!;
        final southwest = gmaps.LatLng(
          min(start.latitude, end.latitude),
          min(start.longitude, end.longitude),
        );
        final northeast = gmaps.LatLng(
          max(start.latitude, end.latitude),
          max(start.longitude, end.longitude),
        );
        await controller.animateCamera(
          gmaps.CameraUpdate.newLatLngBounds(
            gmaps.LatLngBounds(southwest: southwest, northeast: northeast),
            80.0,
          ),
        );
      } else {
        await controller.animateCamera(
          gmaps.CameraUpdate.newLatLng(ride.rideStartLocationGoogle!.toGoogleMaps()),
        );
      }
    } catch (e) {
      // Ignore map controller not ready yet
    }
  }

  Future<void> _fitAllRidesBounds(List<RidesNewRecord> rides) async {
    try {
      final controller = await _model.googleMapsController.future;
      double? minLat, maxLat, minLng, maxLng;
      for (var ride in rides) {
        if (ride.rideStartLocationGoogle != null) {
          final loc = ride.rideStartLocationGoogle!;
          minLat = minLat == null ? loc.latitude : min(minLat, loc.latitude);
          maxLat = maxLat == null ? loc.latitude : max(maxLat, loc.latitude);
          minLng = minLng == null ? loc.longitude : min(minLng, loc.longitude);
          maxLng = maxLng == null ? loc.longitude : max(maxLng, loc.longitude);
        }
        if (ride.rideEndLocationGoogle != null) {
          final loc = ride.rideEndLocationGoogle!;
          minLat = minLat == null ? loc.latitude : min(minLat, loc.latitude);
          maxLat = maxLat == null ? loc.latitude : max(maxLat, loc.latitude);
          minLng = minLng == null ? loc.longitude : min(minLng, loc.longitude);
          maxLng = maxLng == null ? loc.longitude : max(maxLng, loc.longitude);
        }
      }
      if (minLat != null && maxLat != null && minLng != null && maxLng != null) {
        final southwest = gmaps.LatLng(minLat, minLng);
        final northeast = gmaps.LatLng(maxLat, maxLng);
        await controller.animateCamera(
          gmaps.CameraUpdate.newLatLngBounds(
            gmaps.LatLngBounds(southwest: southwest, northeast: northeast),
            80.0,
          ),
        );
      }
    } catch (e) {
      // Ignore map controller not ready yet
    }
  }

  @override
  Widget build(BuildContext context) {
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
              size: 30.0,
            ),
            onPressed: () async {
              context.pop();
            },
          ),
          title: Text(
            'Saved Rides',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  font: GoogleFonts.interTight(
                    fontWeight:
                        FlutterFlowTheme.of(context).headlineMedium.fontWeight,
                    fontStyle:
                        FlutterFlowTheme.of(context).headlineMedium.fontStyle,
                  ),
                  color: FlutterFlowTheme.of(context).primaryText,
                  fontSize: 22.0,
                  letterSpacing: 0.0,
                  fontWeight:
                      FlutterFlowTheme.of(context).headlineMedium.fontWeight,
                  fontStyle:
                      FlutterFlowTheme.of(context).headlineMedium.fontStyle,
                ),
          ),
          actions: [],
          centerTitle: true,
          elevation: 2.0,
        ),
        body: SafeArea(
          top: true,
          child: StreamBuilder<List<RidesNewRecord>>(
            stream: queryRidesNewRecord(
              queryBuilder: (ridesNewRecord) => ridesNewRecord.where(
                'rideSavedByUser',
                isEqualTo: currentUserReference,
              ),
            ),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: SizedBox(
                    width: 50.0,
                    height: 50.0,
                    child: SpinKitFadingCircle(
                      color: Color(0xFF2B3C58),
                      size: 50.0,
                    ),
                  ),
                );
              }
              final savedRides = snapshot.data!;
              if (savedRides.isEmpty) {
                return NoSavedRidesWidget();
              }

              final activeIndex = _activePageIndex >= savedRides.length
                  ? savedRides.length - 1
                  : _activePageIndex;
              final activeRide = savedRides[activeIndex < 0 ? 0 : activeIndex];

              // Automatically center/zoom map to fit all saved rides on load
              if (!_initialMapLocationSet && savedRides.isNotEmpty) {
                _initialMapLocationSet = true;
                SchedulerBinding.instance.addPostFrameCallback((_) {
                  _fitAllRidesBounds(savedRides);
                });
              }

              // Load route polyline when the active ride changes
              if (_lastFetchedRideId != activeRide.reference.id) {
                _lastFetchedRideId = activeRide.reference.id;
                _routePoints = [];
                _mapNotAvailable = false;
                if (activeRide.rideStartLocationGoogle != null && _model.googleMapsController.isCompleted) {
                  _model.googleMapsController = Completer<gmaps.GoogleMapController>();
                }
                SchedulerBinding.instance.addPostFrameCallback((_) {
                  _fetchRoute(activeRide);
                });
              }

              final bool hasCoordinates = activeRide.rideStartLocationGoogle != null;

              return Stack(
                children: [
                  // 1. Google Map View or placeholder if coordinates are missing
                  Positioned(
                    top: 0.0,
                    left: 0.0,
                    right: 0.0,
                    bottom: 310.0,
                    child: hasCoordinates
                        ? FlutterFlowGoogleMap(
                            controller: _model.googleMapsController,
                            onCameraIdle: (latLng) => _model.googleMapsCenter = latLng,
                            initialLocation: _model.googleMapsCenter ??=
                                activeRide.rideStartLocationGoogle!,
                            markers: savedRides
                                .expand((ride) => [
                                      if (ride.rideStartLocationGoogle != null)
                                        FlutterFlowMarker(
                                          'start_marker_${ride.reference.id}',
                                          ride.rideStartLocationGoogle!,
                                        ),
                                      if (ride.rideEndLocationGoogle != null)
                                        FlutterFlowMarker(
                                          'end_marker_${ride.reference.id}',
                                          ride.rideEndLocationGoogle!,
                                        ),
                                    ])
                                .toList(),
                            polylines: {
                              if (_routePoints.isNotEmpty)
                                gmaps.Polyline(
                                  polylineId: const gmaps.PolylineId('active_route'),
                                  points: _routePoints,
                                  color: FlutterFlowTheme.of(context).primary,
                                  width: 4,
                                ),
                            },
                            markerColor: GoogleMarkerColor.violet,
                            mapType: MapType.normal,
                            style: GoogleMapStyle.standard,
                            initialZoom: 14.0,
                            allowInteraction: true,
                            allowZoom: true,
                            showZoomControls: false,
                            showLocation: true,
                            showCompass: false,
                            showMapToolbar: false,
                            showTraffic: false,
                            centerMapOnMarkerTap: true,
                          )
                        : Container(
                            color: FlutterFlowTheme.of(context).primaryBackground,
                            child: Center(
                              child: Container(
                                width: 240.0,
                                height: 240.0,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context).secondaryBackground,
                                  borderRadius: BorderRadius.circular(20.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.12),
                                      blurRadius: 20.0,
                                      offset: const Offset(0.0, 8.0),
                                    ),
                                  ],
                                  border: Border.all(
                                    color: FlutterFlowTheme.of(context).alternate.withOpacity(0.8),
                                    width: 1.5,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(24.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 60.0,
                                        height: 60.0,
                                        decoration: BoxDecoration(
                                          color: Colors.orange.withOpacity(0.1),
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.location_off_rounded,
                                          color: Colors.orange,
                                          size: 32.0,
                                        ),
                                      ),
                                      const SizedBox(height: 16.0),
                                      Text(
                                        'Route Unavailable',
                                        textAlign: TextAlign.center,
                                        style: FlutterFlowTheme.of(context).titleMedium.override(
                                          font: GoogleFonts.interTight(),
                                          fontWeight: FontWeight.bold,
                                          color: FlutterFlowTheme.of(context).primaryText,
                                          fontSize: 16.0,
                                        ),
                                      ),
                                      const SizedBox(height: 8.0),
                                      Text(
                                        'Map is not currently available for this route',
                                        textAlign: TextAlign.center,
                                        style: FlutterFlowTheme.of(context).bodySmall.override(
                                          font: GoogleFonts.inter(),
                                          color: FlutterFlowTheme.of(context).secondaryText,
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                  ),

                  // Overlay centered square dialog on the maps if map has coordinates but route api failed
                  if (hasCoordinates && _mapNotAvailable)
                    Positioned(
                      top: 0.0,
                      left: 0.0,
                      right: 0.0,
                      bottom: 310.0,
                      child: Center(
                        child: Container(
                          width: 240.0,
                          height: 240.0,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context).secondaryBackground.withOpacity(0.95),
                            borderRadius: BorderRadius.circular(20.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.12),
                                blurRadius: 20.0,
                                offset: const Offset(0.0, 8.0),
                              ),
                            ],
                            border: Border.all(
                              color: FlutterFlowTheme.of(context).alternate.withOpacity(0.8),
                              width: 1.5,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 60.0,
                                  height: 60.0,
                                  decoration: BoxDecoration(
                                    color: Colors.orange.withOpacity(0.1),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.location_off_rounded,
                                    color: Colors.orange,
                                    size: 32.0,
                                  ),
                                ),
                                const SizedBox(height: 16.0),
                                Text(
                                  'Route Unavailable',
                                  textAlign: TextAlign.center,
                                  style: FlutterFlowTheme.of(context).titleMedium.override(
                                    font: GoogleFonts.interTight(),
                                    fontWeight: FontWeight.bold,
                                    color: FlutterFlowTheme.of(context).primaryText,
                                    fontSize: 16.0,
                                  ),
                                ),
                                const SizedBox(height: 8.0),
                                Text(
                                  'Map is not currently available for this route',
                                  textAlign: TextAlign.center,
                                  style: FlutterFlowTheme.of(context).bodySmall.override(
                                    font: GoogleFonts.inter(),
                                    color: FlutterFlowTheme.of(context).secondaryText,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                  // 2. Carousel at the bottom with safety padding
                  Positioned(
                    bottom: 0.0,
                    left: 0.0,
                    right: 0.0,
                    height: 310.0,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 24.0),
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: savedRides.length,
                        onPageChanged: (index) {
                          final newRide = savedRides[index];
                          if (newRide.rideStartLocationGoogle != null && _model.googleMapsController.isCompleted) {
                            _model.googleMapsController = Completer<gmaps.GoogleMapController>();
                          }
                          setState(() {
                            _activePageIndex = index;
                            _routePoints = [];
                            _mapNotAvailable = false;
                          });
                          _updateMapCamera(newRide);
                        },
                        itemBuilder: (context, index) {
                          final ride = savedRides[index];
                          return _buildRideCarouselCard(context, ride);
                        },
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildRideCarouselCard(BuildContext context, RidesNewRecord ride) {
    return GestureDetector(
      onTap: () async {
        context.pushNamed(
          RideDetailsCustomerWidget.routeName,
          queryParameters: {
            'rideDetails': serializeParam(
              ride.reference,
              ParamType.DocumentReference,
            ),
          }.withoutNulls,
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              blurRadius: 16.0,
              color: Colors.black.withOpacity(0.12),
              offset: Offset(0.0, 6.0),
            ),
          ],
          border: Border.all(
            color: FlutterFlowTheme.of(context).alternate.withOpacity(0.6),
            width: 1.0,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Row 1: Transport, prices and Bookmark unsave
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: Container(
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).primaryBackground,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (ride.modeOfTransport == 'Bike')
                              Icon(Icons.motorcycle_sharp, color: FlutterFlowTheme.of(context).secondaryText, size: 16.0),
                            if (ride.modeOfTransport == 'Bus')
                              FaIcon(FontAwesomeIcons.bus, color: FlutterFlowTheme.of(context).secondaryText, size: 14.0),
                            if (ride.modeOfTransport == 'Train')
                              Icon(Icons.train, color: FlutterFlowTheme.of(context).secondaryText, size: 16.0),
                            if (ride.modeOfTransport == 'Car')
                              FaIcon(FontAwesomeIcons.carSide, color: FlutterFlowTheme.of(context).secondaryText, size: 14.0),
                            SizedBox(width: 6.0),
                            Flexible(
                              child: Text(
                                ride.travelTime,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: FlutterFlowTheme.of(context).bodySmall.override(
                                  font: GoogleFonts.inter(),
                                  color: FlutterFlowTheme.of(context).secondaryText,
                                  fontSize: 11.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Wrap(
                        spacing: 4.0,
                        runSpacing: 4.0,
                        alignment: WrapAlignment.end,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Color(0xFFFFF0E6),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                              child: Text(
                                'Ride: ₹${ride.rideCost}',
                                style: FlutterFlowTheme.of(context).bodySmall.override(
                                  font: GoogleFonts.inter(),
                                  color: Color(0xFFF97E4C),
                                  fontSize: 11.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Color(0xFFE8F2FF),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                              child: Text(
                                'Parcel: ₹${ride.totalDeliveryCost}',
                                style: FlutterFlowTheme.of(context).bodySmall.override(
                                  font: GoogleFonts.inter(),
                                  color: FlutterFlowTheme.of(context).primary,
                                  fontSize: 11.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 6.0),
                      InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          await ride.reference.update(createRidesNewRecordData(
                            rideSavedByUser: ride.creatorID,
                          ));
                        },
                        child: Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Icon(
                            Icons.bookmark,
                            color: Color(0xFFF77F4A),
                            size: 24.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 8.0),

              // Row 2: Route timeline
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: 3.0),
                        Icon(
                          Icons.fiber_manual_record,
                          color: FlutterFlowTheme.of(context).success,
                          size: 10.0,
                        ),
                        Container(
                          width: 2.0,
                          height: 16.0,
                          color: FlutterFlowTheme.of(context).alternate,
                        ),
                        Icon(
                          Icons.location_on,
                          color: FlutterFlowTheme.of(context).error,
                          size: 12.0,
                        ),
                      ],
                    ),
                    SizedBox(width: 10.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            ride.rideStartLocation,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                              font: GoogleFonts.inter(),
                              color: FlutterFlowTheme.of(context).primaryText,
                              fontSize: 13.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            ride.rideEndLocation,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                              font: GoogleFonts.inter(),
                              color: FlutterFlowTheme.of(context).primaryText,
                              fontSize: 13.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Divider(height: 12.0, color: FlutterFlowTheme.of(context).alternate),

              // Row 3: Driver Profile & Action Button
              StreamBuilder<UsersRecord>(
                stream: UsersRecord.getDocument(ride.creatorID!),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: SizedBox(
                        width: 24.0,
                        height: 24.0,
                        child: SpinKitFadingCircle(
                          color: Color(0xFF2B3C58),
                          size: 24.0,
                        ),
                      ),
                    );
                  }
                  final driver = snapshot.data!;
                  return Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 32.0,
                              height: 32.0,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: FlutterFlowTheme.of(context).alternate,
                                  width: 1.0,
                                ),
                              ),
                              child: Builder(
                                builder: (context) {
                                  if (driver.photoUrl != null && driver.photoUrl != '') {
                                    return Image.network(
                                      driver.photoUrl,
                                      fit: BoxFit.cover,
                                    );
                                  } else {
                                    return Image.asset(
                                      'assets/images/userIconTr.png',
                                      fit: BoxFit.cover,
                                    );
                                  }
                                },
                              ),
                            ),
                            SizedBox(width: 8.0),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    driver.displayName != null && driver.displayName != '' ? driver.displayName : 'Driver',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                      font: GoogleFonts.inter(),
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.star_rounded,
                                        color: Colors.amber,
                                        size: 14.0,
                                      ),
                                      SizedBox(width: 2.0),
                                      Text(
                                        valueOrDefault<String>(
                                          formatNumber(
                                            functions.averageRating(driver.ratings.toList()),
                                            formatType: FormatType.compact,
                                          ),
                                          '0',
                                        ),
                                        style: FlutterFlowTheme.of(context).bodySmall.override(
                                          font: GoogleFonts.inter(),
                                          color: FlutterFlowTheme.of(context).secondaryText,
                                          fontSize: 11.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 8.0),
                      FFButtonWidget(
                        onPressed: () async {
                          context.pushNamed(
                            RideDetailsCustomerWidget.routeName,
                            queryParameters: {
                              'rideDetails': serializeParam(
                                ride.reference,
                                ParamType.DocumentReference,
                              ),
                            }.withoutNulls,
                          );
                        },
                        text: 'Book Ride',
                        options: FFButtonOptions(
                          height: 32.0,
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          color: FlutterFlowTheme.of(context).primary,
                          textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                            font: GoogleFonts.interTight(),
                            color: Colors.white,
                            fontSize: 12.0,
                            fontWeight: FontWeight.w600,
                          ),
                          elevation: 2.0,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
