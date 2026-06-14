import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:travia/chat_option/chat/chat_widget.dart';

import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/no_ride_posted_widget.dart';
import '/components/no_ride_to_show_user_widget.dart';
import '/compotement/main_footer/main_footer_widget.dart';
import '/customer_bookings/no_any_bids_by_users/no_any_bids_by_users_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/pages/sidebar_menu/sidebar_menu_widget.dart';
import 'dart:math';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'home_model.dart';
export 'home_model.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({
    super.key,
    int? tabNumberRef,
  }) : this.tabNumberRef = tabNumberRef ?? 0;

  final int tabNumberRef;

  static String routeName = 'Home';
  static String routePath = '/home';

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> with TickerProviderStateMixin {
  late HomeModel _model;

  String _truncateAddress(String? address) {
    if (address == null || address.isEmpty) {
      return '';
    }
    final words = address.trim().split(RegExp(r'\s+'));
    if (words.length <= 3) {
      return address;
    }
    var joined = words.take(3).join(' ');
    while (joined.isNotEmpty && (
      joined.endsWith(',') || 
      joined.endsWith('.') || 
      joined.endsWith(';') || 
      joined.endsWith(':') || 
      joined.endsWith('-') || 
      joined.endsWith('_')
    )) {
      joined = joined.substring(0, joined.length - 1).trim();
    }
    return '$joined...';
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  // @override
  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomeModel());

    // Tab Controller
    _model.tabBarController = TabController(
      vsync: this,
      length: 3,
      // initialIndex: 0,
      initialIndex: min(
        valueOrDefault<int>(
          widget.tabNumberRef,  // 👈 Add this line!
          0,
        ),
        2,
      ),
    )..addListener(() => safeSetState(() {
          // ✅ RESET TO DEFAULT HOME WIDGET (date rides)
          _model.isSearchActive = false;
          _model.searchStartLocation = null;
          _model.searchEndLocation = null;
          _model.startLocationTextController.clear();
          _model.endLocationTextController.clear();
        }));

    // Text Controllers

    // Initialize the controllers
    _model.startLocationTextController = TextEditingController();
    _model.endLocationTextController = TextEditingController();
    _model.startLocationFocusNode ??= FocusNode();

    // _model.endLocationTextController ??= TextEditingController();
    _model.endLocationFocusNode ??= FocusNode();

    // Animations
    animationsMap.addAll({
      'rowOnPageLoadAnimation': AnimationInfo(
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
      'containerOnPageLoadAnimation1': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          SaturateEffect(
            curve: Curves.easeIn,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'listViewOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          ShimmerEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            color: Color(0x80FFFFFF),
            angle: 0.524,
          ),
        ],
      ),
      'containerOnPageLoadAnimation2': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          ScaleEffect(
            curve: Curves.linear,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: Offset(1.0, 1.0),
            end: Offset(1.0, 1.0),
          ),
        ],
      ),
      'mainFooterOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          ScaleEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: Offset(1.0, 1.0),
            end: Offset(1.0, 1.0),
          ),
        ],
      ),
    });

    // -------------------------------
    // Ask Location Permission & Fetch Location
    // -------------------------------
    // WidgetsBinding.instance.addPostFrameCallback((_) async {
    //   bool hasPermission = await handleLocationPermission();
    //
    //   if (hasPermission) {
    //     String loc = await getCurrentLocation();
    //     if (loc.isNotEmpty) {
    //       _model.startLocationTextController.text = loc;
    //     }
    //   } else {
    //     // Optional: show a message if permission denied
    //     print("Location permission denied");
    //   }
    // });

    _model.endLocationTextController.addListener(() {
      if (_model.endLocationTextController.text.isEmpty) {
        safeSetState(() {
          _model.isSearchActive = false;
          _model.searchStartLocation = null;
          _model.searchEndLocation = null;
          _model.endLocationTextController.clear(); // Clear start too
        });
      }
    });
    _model.startLocationTextController.addListener(() {
      if (_model.startLocationTextController.text.isEmpty) {
        safeSetState(() {
          _model.isSearchActive = false;
          _model.searchStartLocation = null;
          _model.searchEndLocation = null;
          _model.startLocationTextController.clear(); // Clear start too
        });
      }
    });
  }

  // 👈 ADD TO YOUR MODEL CLASS
  Future<void> _getCurrentLocation(BuildContext context) async {
    try {
      // 👈 PERMISSION
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Location permission denied')),
            );
          }
          return;
        }
      }

      // 👈 GET GPS LOCATION
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // 👈 REVERSE GEOCODE
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty && mounted) {
        Placemark place = placemarks[0];
        String address = [
          place.street,
          place.subLocality,
          place.locality,
          place.postalCode,
          place.administrativeArea,
          place.country,
        ].where((s) => s != null && s.isNotEmpty).join(', ');

        // 👈 UPDATE TEXT FIELD
        _model.startLocationTextController.text = address;
        _model.startLocationTextController.selection = TextSelection.fromPosition(
          TextPosition(offset: address.length),
        );

        // 👈 SET FLAGS
        _model.isCurrentLocationFetched = true;

        print('📍 Location: $address');
        print('📍 GPS: ${position.latitude}, ${position.longitude}');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }


// ---------------------------
// Location Helper Functions
// ---------------------------
  Future<bool> handleLocationPermission() async {
    LocationPermission permission;

    // Check permissions
    permission = await Geolocator.checkPermission();

    // Ask if denied
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return false;
      }
    }

    // Denied forever → cannot ask again
    if (permission == LocationPermission.deniedForever) {
      return false;
    }

    return true;
  }

  // Future<String> getCurrentLocation() async {
  //   Position pos = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  //
  //   // Optionally convert to human readable address using geocoding
  //   List<Placemark> places = await placemarkFromCoordinates(pos.latitude, pos.longitude);
  //
  //   return "${places.first.locality}, ${places.first.country}";
  // }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  Widget _buildMyListedRideCard(RidesNewRecord ride) {
    final statusColor = () {
      final status = (ride.rideStatus ?? '').trim();
      if (status.isEmpty || status == 'Under Review') {
        return Colors.orange.shade700;
      } else if (status == 'Live') {
        return Colors.green.shade700;
      } else if (status == 'Rejected') {
        return const Color(0xFFDC0A46);
      }
      return FlutterFlowTheme.of(context).primaryText;
    }();

    final statusText = () {
      final status = (ride.rideStatus ?? '').trim();
      return status.isEmpty ? 'Under Review' : status;
    }();

    final departureStr = ride.pickupTime != null
        ? dateTimeFormat("hh:mm a", ride.pickupTime).toLowerCase()
        : 'N/A';
    final arrivalStr = ride.dropTime != null
        ? dateTimeFormat("hh:mm a", ride.dropTime).toLowerCase()
        : 'N/A';

    return Stack(
      children: [
        InkWell(
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
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
          child: Material(
            color: Colors.transparent,
            elevation: 10.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).primaryBackground,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 4.0,
                      color: const Color(0x1A000000),
                      offset: const Offset(0.0, 2.0),
                    )
                  ],
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(
                    color: FlutterFlowTheme.of(context).tertiary,
                  ),
                ),
                alignment: const AlignmentDirectional(1.0, 0.0),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 5.0, 10.0),
                  child: Container(
                    color: Colors.transparent,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Start Location Row
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              color: FlutterFlowTheme.of(context).primary,
                              size: 24.0,
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Container(
                                width: 170.0,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE3E6E0),
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(15.0, 5.0, 10.0, 5.0),
                                  child: Text(
                                    _truncateAddress(ride.rideStartLocation),
                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                      font: GoogleFonts.inter(),
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8.0),
                        // Travel time & Departure/Arrival Column
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(25.0, 0.0, 0.0, 0.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if (ride.modeOfTransport == 'Bike')
                                    const Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 6.0, 0.0),
                                      child: Icon(
                                        Icons.motorcycle_sharp,
                                        color: Color(0xFF8A8888),
                                        size: 18.0,
                                      ),
                                    ),
                                  if (ride.modeOfTransport == 'Train')
                                    const Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 6.0, 0.0),
                                      child: Icon(
                                        Icons.train,
                                        color: Color(0xFF929090),
                                        size: 18.0,
                                      ),
                                    ),
                                  if (ride.modeOfTransport == 'Car')
                                    const Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 6.0, 0.0),
                                      child: FaIcon(
                                        FontAwesomeIcons.carSide,
                                        color: Color(0xFF8F9192),
                                        size: 14.0,
                                      ),
                                    ),
                                  if (ride.modeOfTransport == 'Bus')
                                    const Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 6.0, 0.0),
                                      child: FaIcon(
                                        FontAwesomeIcons.bus,
                                        color: Color(0xFF919191),
                                        size: 14.0,
                                      ),
                                    ),
                                  Text(
                                    'Travel time: ${ride.travelTime.isNotEmpty ? ride.travelTime : "N/A"}',
                                    style: FlutterFlowTheme.of(context).labelSmall.override(
                                      font: GoogleFonts.inter(),
                                      fontSize: 12.0,
                                      color: FlutterFlowTheme.of(context).secondaryText,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4.0),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.access_time,
                                    color: FlutterFlowTheme.of(context).secondaryText,
                                    size: 14.0,
                                  ),
                                  const SizedBox(width: 6.0),
                                  Text(
                                    'Dep: $departureStr  |  Arr: $arrivalStr',
                                    style: FlutterFlowTheme.of(context).labelSmall.override(
                                      font: GoogleFonts.inter(),
                                      fontSize: 12.0,
                                      color: FlutterFlowTheme.of(context).secondaryText,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        // End Location Row
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              color: FlutterFlowTheme.of(context).primary,
                              size: 24.0,
                            ),
                            Container(
                              width: 170.0,
                              decoration: BoxDecoration(
                                color: const Color(0xFFE3E6E0),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(15.0, 5.0, 10.0, 5.0),
                                child: Text(
                                  _truncateAddress(ride.rideEndLocation),
                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                    font: GoogleFonts.inter(),
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12.0),
                        // Status and Actions Row
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Current Status: ',
                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                    font: GoogleFonts.inter(),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15.0,
                                  ),
                                ),
                                Text(
                                  statusText,
                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                    font: GoogleFonts.inter(),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15.0,
                                    color: statusColor,
                                  ),
                                ),
                              ],
                            ),
                            Expanded(
                              child: Center(
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () => showDialog<void>(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext dialogContext) {
                                      return AlertDialog(
                                        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
                                        title: Row(
                                          children: [
                                            const Icon(Icons.warning_amber_rounded, color: Color(0xFFFF9561), size: 30.0),
                                            const SizedBox(width: 12.0),
                                            Text(
                                              'Delete Ride?',
                                              style: FlutterFlowTheme.of(context).headlineSmall.override(fontWeight: FontWeight.w700),
                                            ),
                                          ],
                                        ),
                                        content: Text(
                                          'Are you sure you want to permanently delete this ride? This action cannot be undone.',
                                          style: FlutterFlowTheme.of(context).bodyMedium.override(lineHeight: 1.5),
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () => Navigator.of(dialogContext).pop(),
                                            child: Text('Cancel', style: FlutterFlowTheme.of(context).bodyMedium.override(fontWeight: FontWeight.w600)),
                                          ),
                                          ElevatedButton(
                                            onPressed: () async {
                                              Navigator.of(dialogContext).pop();
                                              await ride.reference.delete();
                                              if (mounted) {
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                  const SnackBar(content: Text('Ride deleted!'), backgroundColor: Color(0xFFFF9561)),
                                                );
                                              }
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: const Color(0xFFFF9561),
                                              foregroundColor: Colors.white,
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                                              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                                            ),
                                            child: Text('Delete', style: FlutterFlowTheme.of(context).bodyMedium.override(fontWeight: FontWeight.w700, fontSize: 16.0, color: Colors.white)),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                  child: const Icon(Icons.delete, color: Color(0xFFDC0A46), size: 24.0),
                                ),
                              ),
                            ),
                            FFButtonWidget(
                              onPressed: () async {
                                context.pushNamed(
                                  RideEditPageWidget.routeName,
                                  queryParameters: {
                                    'rideEdit': serializeParam(
                                      ride.reference,
                                      ParamType.DocumentReference,
                                    ),
                                  }.withoutNulls,
                                );
                              },
                              text: 'Edit',
                              options: FFButtonOptions(
                                width: 80.0,
                                height: 30.0,
                                padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                                color: FlutterFlowTheme.of(context).accent3,
                                textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                  font: GoogleFonts.inter(),
                                  color: FlutterFlowTheme.of(context).primaryText,
                                ),
                                elevation: 0.0,
                                borderSide: BorderSide(
                                  color: FlutterFlowTheme.of(context).accent3,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: const AlignmentDirectional(0.97, -0.96),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 5.0, 0.0),
            child: Container(
              width: MediaQuery.sizeOf(context).width * 0.12,
              constraints: const BoxConstraints(
                minWidth: 55.0,
                maxWidth: 70.0,
                minHeight: 85.0,
                maxHeight: 100.0,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFF97E4C),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
                    child: Text(
                      'Ride',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                        font: GoogleFonts.inter(),
                        color: FlutterFlowTheme.of(context).info,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 4.0),
                    child: AutoSizeText(
                      '₹${formatNumber(ride.pricePerPassengers, formatType: FormatType.custom, format: '', locale: '')}',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                        font: GoogleFonts.inter(),
                        color: FlutterFlowTheme.of(context).info,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      minFontSize: 12,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    constraints: const BoxConstraints(minHeight: 48.0, maxHeight: 55.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF9561),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(0.0, 3.0, 0.0, 0.0),
                          child: Text(
                            'Parcel',
                            textAlign: TextAlign.center,
                            style: FlutterFlowTheme.of(context).labelSmall.override(
                              font: GoogleFonts.inter(),
                              color: FlutterFlowTheme.of(context).info,
                              fontSize: 11.0,
                            ),
                          ),
                        ),
                        AutoSizeText(
                          '₹${ride.totalDeliveryCost}',
                          textAlign: TextAlign.center,
                          style: FlutterFlowTheme.of(context).labelSmall.override(
                            font: GoogleFonts.inter(),
                            color: FlutterFlowTheme.of(context).info,
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          minFontSize: 11,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBookingCard(BookingsRecord booking, RidesNewRecord ride, UsersRecord creator) {
    final itemName = booking.itemName;
    final bookingType = booking.bookingType;
    final receiverName = booking.receiverName;
    final passengerName = booking.rideNameOfPerson;
    
    final phoneNum = booking.phoneNumber.isNotEmpty 
        ? booking.phoneNumber 
        : booking.ridePersonContactNumber;
        
    final meetupAddr = booking.meetupLocation.isNotEmpty
        ? booking.meetupLocation
        : booking.rideMeetupAddress;
        
    final addInfo = booking.additionalInformation.isNotEmpty
        ? booking.additionalInformation
        : booking.rideAdditionalInformation;

    Widget _buildDetailRow(IconData icon, String label, String value) {
      if (value.isEmpty) return const SizedBox.shrink();
      return Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Row(
          children: [
            Icon(icon, color: FlutterFlowTheme.of(context).secondaryText, size: 20.0),
            const SizedBox(width: 8.0),
            SizedBox(
              width: 110.0,
              child: Text(
                label,
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                  font: GoogleFonts.inter(),
                  fontWeight: FontWeight.w600,
                  color: FlutterFlowTheme.of(context).primaryText,
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: const Color(0xFFE0E0E0)),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                child: Text(
                  value,
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                    font: GoogleFonts.inter(),
                    color: FlutterFlowTheme.of(context).primaryText,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Material(
      color: Colors.transparent,
      elevation: 6.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).containerColour,
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(color: const Color(0xFFE0E0E0), width: 1.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFFF18C5E),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0),
                ),
              ),
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 44.0,
                        height: 44.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2.0),
                        ),
                        child: ClipOval(
                          child: creator.photoUrl.isNotEmpty
                              ? CachedNetworkImage(
                                  imageUrl: creator.photoUrl,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => const SizedBox(),
                                  errorWidget: (context, url, error) => Image.asset('assets/images/userIconTr.png', fit: BoxFit.cover),
                                )
                              : Image.asset('assets/images/userIconTr.png', fit: BoxFit.cover),
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            creator.displayName.isNotEmpty ? creator.displayName : 'User',
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                            ),
                          ),
                          Text(
                            'Verified Account',
                            style: GoogleFonts.inter(
                              color: const Color(0xFFFFF9C4),
                              fontSize: 12.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14.0),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                    child: Text(
                      booking.status,
                      style: GoogleFonts.inter(
                        color: const Color(0xFFF18C5E),
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (itemName.isNotEmpty) _buildDetailRow(Icons.inventory_2, 'Parcel Detail', itemName),
                  if (bookingType.isNotEmpty) _buildDetailRow(FontAwesomeIcons.carSide, 'Booked For', bookingType),
                  if (receiverName.isNotEmpty) _buildDetailRow(Icons.person, 'Recipient name', receiverName),
                  if (passengerName.isNotEmpty && passengerName != receiverName) _buildDetailRow(Icons.person, 'Passenger name', passengerName),
                  if (phoneNum.isNotEmpty) _buildDetailRow(Icons.phone, 'Contact Number', phoneNum),
                  if (meetupAddr.isNotEmpty) _buildDetailRow(Icons.location_on, 'Location', meetupAddr),
                  if (addInfo.isNotEmpty) _buildDetailRow(Icons.note_add, 'Additional Info', addInfo),
                  
                  if (booking.createdTime != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: Row(
                        children: [
                          Icon(Icons.access_time_filled, color: FlutterFlowTheme.of(context).secondaryText, size: 20.0),
                          const SizedBox(width: 8.0),
                          SizedBox(
                            width: 110.0,
                            child: Text(
                              'Requested at',
                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                font: GoogleFonts.inter(),
                                fontWeight: FontWeight.w600,
                                color: FlutterFlowTheme.of(context).primaryText,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8.0),
                                      border: Border.all(color: const Color(0xFFE0E0E0)),
                                    ),
                                    padding: const EdgeInsets.symmetric(vertical: 6.0),
                                    alignment: Alignment.center,
                                    child: Text(
                                      dateTimeFormat("hh:mm a", booking.createdTime),
                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                        font: GoogleFonts.inter(),
                                        fontSize: 12.0,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 6.0),
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8.0),
                                      border: Border.all(color: const Color(0xFFE0E0E0)),
                                    ),
                                    padding: const EdgeInsets.symmetric(vertical: 6.0),
                                    alignment: Alignment.center,
                                    child: Text(
                                      dateTimeFormat("dd-MM-yyyy", booking.createdTime),
                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                        font: GoogleFonts.inter(),
                                        fontSize: 12.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                  const SizedBox(height: 4.0),
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
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
                            height: 36.0,
                            decoration: BoxDecoration(
                              color: const Color(0x1F4CAF50),
                              borderRadius: BorderRadius.circular(18.0),
                              border: Border.all(color: const Color(0xFF2E7D32), width: 1.0),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              'View Ride Details',
                              style: GoogleFonts.inter(
                                color: const Color(0xFF2E7D32),
                                fontWeight: FontWeight.w600,
                                fontSize: 13.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      Expanded(
                        child: InkWell(
                          onTap: () async {
                            context.pushNamed(
                              AddRatingWidget.routeName,
                              queryParameters: {
                                'userRef': serializeParam(
                                  creator.reference,
                                  ParamType.DocumentReference,
                                ),
                              }.withoutNulls,
                            );
                          },
                          child: Container(
                            height: 36.0,
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFF9C4),
                              borderRadius: BorderRadius.circular(18.0),
                              border: Border.all(color: const Color(0xFFF57F17), width: 1.0),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              'Add reviews',
                              style: GoogleFonts.inter(
                                color: const Color(0xFFF57F17),
                                fontWeight: FontWeight.w600,
                                fontSize: 13.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  if (_model.myBookingStatus != 'Completed') ...[
                    const SizedBox(height: 10.0),
                    Row(
                      children: [
                        if (booking.status != 'Accepted' && booking.status != 'Completed' && booking.status != 'Rejected')
                          Expanded(
                            child: InkWell(
                              onTap: () async {
                                final confirm = await showDialog<bool>(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text('Delete Booking'),
                                    content: const Text('Are you sure you want to delete this booking?'),
                                    actions: [
                                      TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
                                      TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Delete')),
                                    ],
                                  ),
                                );
                                if (confirm == true) {
                                  await booking.reference.delete();
                                  if (mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Booking deleted successfully')),
                                    );
                                  }
                                }
                              },
                              child: Container(
                                height: 36.0,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFEBEE),
                                  borderRadius: BorderRadius.circular(18.0),
                                  border: Border.all(color: const Color(0xFFC62828), width: 1.0),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  'Delete',
                                  style: GoogleFonts.inter(
                                    color: const Color(0xFFC62828),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13.0,
                                  ),
                                ),
                              ),
                            ),
                          )
                        else
                          const Spacer(),
                        const SizedBox(width: 10.0),
                        if (booking.status == 'Pending')
                          Expanded(
                            child: InkWell(
                              onTap: () async {
                                context.pushNamed(
                                  EditBookingsWidget.routeName,
                                  queryParameters: {
                                    'editBookings': serializeParam(
                                      booking.reference,
                                      ParamType.DocumentReference,
                                    ),
                                  }.withoutNulls,
                                );
                              },
                              child: Container(
                                height: 36.0,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF5F5F5),
                                  borderRadius: BorderRadius.circular(18.0),
                                  border: Border.all(color: const Color(0xFF424242), width: 1.0),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  'Edit Details',
                                  style: GoogleFonts.inter(
                                    color: const Color(0xFF424242),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13.0,
                                  ),
                                ),
                              ),
                            ),
                          )
                        else
                          const Spacer(),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          return await showDialog<bool>(
            context: context,
            barrierDismissible: true,
            barrierColor: Colors.black54,
            builder: (context) => Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24.0),
              ),
              elevation: 0,
              backgroundColor: Colors.transparent,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.85,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 32.0,
                      spreadRadius: 0,
                      offset: Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Header with icon
                    Column(
                      children: [
                        SizedBox(height: 20.0),
                        // Icon Container
                        Container(
                          width: 72.0,
                          height: 72.0,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context).tertiary.withOpacity(0.12),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: FlutterFlowTheme.of(context).tertiary.withOpacity(0.2),
                              width: 2.0,
                            ),
                          ),
                          child: Icon(
                            Icons.exit_to_app_rounded,
                            size: 36.0,
                            color: FlutterFlowTheme.of(context).tertiary,
                          ),
                        ),
                        SizedBox(height: 16.0),
                        // Title
                        Text(
                          'Exit Application',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF333333),
                            fontFamily: 'Inter',
                          ),
                        ),
                      ],
                    ),

                    // Content
                    Padding(
                      padding: EdgeInsets.all(24.0),
                      child: Column(
                        children: [
                          Text(
                            'Are you sure you want to exit the app?',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Color(0xFF666666),
                              fontFamily: 'Inter',
                              height: 1.5,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            'Any unsaved changes may be lost.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Color(0xFF999999),
                              fontFamily: 'Inter',
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Divider
                    Divider(
                      height: 0,
                      thickness: 1,
                      color: Colors.grey[200],
                    ),

                    // Buttons
                    Container(
                      padding: EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          // Cancel Button
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () => Navigator.of(context).pop(false),
                              style: OutlinedButton.styleFrom(
                                padding: EdgeInsets.symmetric(vertical: 16.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                side: BorderSide(
                                  color: Colors.grey[300]!,
                                  width: 1.0,
                                ),
                              ),
                              child: Text(
                                'Cancel',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF666666),
                                  fontFamily: 'Inter',
                                ),
                              ),
                            ),
                          ),

                          SizedBox(width: 16.0),

                          // Exit Button
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop(true);
                                SystemNavigator.pop();
                              },
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(vertical: 16.0),
                                backgroundColor: FlutterFlowTheme.of(context).tertiary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                elevation: 0,
                                shadowColor: FlutterFlowTheme.of(context).tertiary.withOpacity(0.3),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Exit',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                      fontFamily: 'Inter',
                                    ),
                                  ),
                                  SizedBox(width: 8.0),
                                  Icon(
                                    Icons.arrow_forward_rounded,
                                    size: 18.0,
                                    color: Colors.white,
                                  ),
                                ],
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
          ) ?? false;
        },
    child:  GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        drawer: Drawer(
          width: MediaQuery.of(context).size.width * 0.88,
          elevation: 16.0,
          child: wrapWithModel(
            model: _model.sidebarMenuModel,
            updateCallback: () => safeSetState(() {}),
            child: SidebarMenuWidget(),
          ),
        ),
        appBar: AppBar(
          backgroundColor: Color(0xFFF4F4F4),
          automaticallyImplyLeading: false,
          elevation: 2.0,
          shadowColor: Colors.black.withOpacity(0.05),

          leading: Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: FlutterFlowIconButton(
              borderRadius: 12.0,
              buttonSize: 44.0,
              icon: FaIcon(
                FontAwesomeIcons.bars,
                color: Color(0xFF283B5E),
                size: 22.0,
              ),
              onPressed: () async {
                if (scaffoldKey.currentState != null) {
                  scaffoldKey.currentState!.openDrawer();
                }
              },
            ),
          ),

          title: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Container(
              height: 45.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.asset(
                  'assets/images/logoTraviaJi.png',
                  fit: BoxFit.contain,
                  alignment: Alignment.centerLeft,
                ),
              ),
            ),
          ),

          actions: [
            Container(
              padding: const EdgeInsets.only(right: 12.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Notification Icon with Badge
                  StreamBuilder<List<ChatsRecord>>(
                    stream: queryChatsRecord(
                      queryBuilder: (chatsRecord) => chatsRecord
                          .where('userIDs', arrayContains: currentUserReference)
                          .orderBy('lastMessageTime', descending: true),
                    ),
                    builder: (context, snapshot) {
                      int unreadCount = 0;

                      if (snapshot.hasData) {
                        final chatsList = snapshot.data!;
                        unreadCount = chatsList.where((chat) {
                          if (chat.lastMessagesSeenBy == null) return true;
                          final hasSeen = chat.lastMessagesSeenBy!.any(
                                  (userRef) => userRef.id == currentUserUid
                          );
                          return !hasSeen;
                        }).length;
                      }

                      return Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            width: 44.0,
                            height: 44.0,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(14.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 8.0,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(14.0),
                              onTap: () async {
                                context.pushNamed(PageNotificationWidget.routeName);
                              },
                              child: Center(
                                child: Icon(
                                  Icons.notifications_outlined,
                                  color: Color(0xFF283B5E),
                                  size: 24.0,
                                ),
                              ),
                            ),
                          ),
                          if (unreadCount > 0)
                            Positioned(
                              right: -2,
                              top: -2,
                              child: Container(
                                constraints: BoxConstraints(
                                  minWidth: 20.0,
                                  minHeight: 20.0,
                                ),
                                padding: EdgeInsets.all(4.0),
                                decoration: BoxDecoration(
                                  color: Color(0xFFE74C3C),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Color(0xFFF4F4F4),
                                    width: 2.0,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.red.withOpacity(0.3),
                                      blurRadius: 4.0,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Text(
                                    unreadCount > 9 ? '9+' : unreadCount.toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: unreadCount > 9 ? 8.0 : 10.0,
                                      fontWeight: FontWeight.w700,
                                      height: 1.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      );
                    },
                  ),

                  SizedBox(width: 12.0),

                  // Crown Icon (Plans)
                  Container(
                    width: 44.0,
                    height: 44.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 8.0,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(14.0),
                      onTap: () async {
                        context.pushNamed(PlansWidget.routeName);
                      },
                      child: Center(
                        child: FaIcon(
                          FontAwesomeIcons.crown,
                          color: Color(0xFF283B5E),
                          size: 20.0,
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ],

          centerTitle: false,
        ),
        body: SafeArea(
          top: true,
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: SizedBox(
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment(0.0, 0),
                          child: TabBar(
                            labelColor: FlutterFlowTheme.of(context).primaryText,
                            unselectedLabelColor: FlutterFlowTheme.of(context).secondaryText,
                            labelStyle: FlutterFlowTheme.of(context).titleMedium.override(
                                  font: GoogleFonts.interTight(
                                    fontWeight: FlutterFlowTheme.of(context).titleMedium.fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                  ),
                                  fontSize: 15.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context).titleMedium.fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                ),
                            unselectedLabelStyle: FlutterFlowTheme.of(context).titleMedium.override(
                                  font: GoogleFonts.interTight(
                                    fontWeight: FlutterFlowTheme.of(context).titleMedium.fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                  ),
                                  fontSize: 15.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context).titleMedium.fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                ),
                            indicatorColor: FlutterFlowTheme.of(context).primary,
                            tabs: [
                              Tab(
                                text: 'All Rides',
                              ),
                              Tab(
                                text: 'My Bookings',
                              ),
                              Tab(
                                text: 'My Listed',
                              ),
                            ],
                            controller: _model.tabBarController,
                            onTap: (i) async {
                              [() async {}, () async {}, () async {}][i]();
                            },
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                            child: Column(
                              children: [
                                if (_model.tabBarController?.index == 0)
                                  Align(
                                    alignment: AlignmentDirectional(0.0, 0.0),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          // AIzaSyDZkxRpoy0BOIAPwMaMIvAd5xpCe
                                          // Expanded(
                                          //   child: Container(
                                          //     height: 45,
                                          //     decoration: BoxDecoration(
                                          //       color: FlutterFlowTheme.of(context).alternate,
                                          //       borderRadius: BorderRadius.circular(12),
                                          //       border: Border.all(
                                          //         color: const Color(0xFFE69A6A),
                                          //         width: 1,
                                          //       ),
                                          //     ),
                                          //     child: GooglePlaceAutoCompleteTextField(
                                          //       focusNode: _model.startLocationFocusNode,
                                          //       textEditingController: _model.startLocationTextController,
                                          //       googleAPIKey: "AIzaSyDZkxRpoy0BOIAPwMaMIvAd5xpCe-6ZYvs",
                                          //       inputDecoration: const InputDecoration(
                                          //         hintText: 'Start From...',
                                          //         isDense: false,
                                          //         filled: false,
                                          //         contentPadding: EdgeInsets.symmetric(
                                          //           horizontal: 14,
                                          //           vertical: 14,
                                          //         ),
                                          //
                                          //         // ✅ NO INNER BORDER
                                          //         border: InputBorder.none,
                                          //         enabledBorder: InputBorder.none,
                                          //         focusedBorder: InputBorder.none,
                                          //         disabledBorder: InputBorder.none,
                                          //         errorBorder: InputBorder.none,
                                          //         focusedErrorBorder: InputBorder.none,
                                          //       ),
                                          //       textStyle: FlutterFlowTheme.of(context).bodyMedium.copyWith(fontSize: 14),
                                          //       debounceTime: 600,
                                          //       countries: ["in"],
                                          //       isLatLngRequired: false,
                                          //       itemClick: (prediction) {
                                          //         _model.startLocationTextController.text = prediction.description ?? "";
                                          //         _model.startLocationTextController.selection = TextSelection.fromPosition(
                                          //           TextPosition(
                                          //             offset: prediction.description?.length ?? 0,
                                          //           ),
                                          //         );
                                          //       },
                                          //       itemBuilder: (context, index, prediction) {
                                          //         return Container(
                                          //           padding: const EdgeInsets.symmetric(
                                          //             horizontal: 14,
                                          //             vertical: 10,
                                          //           ),
                                          //           child: Row(
                                          //             children: [
                                          //               Icon(
                                          //                 Icons.location_on,
                                          //                 size: 18,
                                          //                 color: FlutterFlowTheme.of(context).tertiary,
                                          //               ),
                                          //               const SizedBox(width: 8),
                                          //               Expanded(
                                          //                 child: Text(
                                          //                   prediction.description ?? "",
                                          //                   style: FlutterFlowTheme.of(context).bodyMedium.copyWith(fontSize: 13),
                                          //                 ),
                                          //               ),
                                          //             ],
                                          //           ),
                                          //         );
                                          //       },
                                          //       seperatedBuilder: const Divider(height: 1),
                                          //       isCrossBtnShown: true,
                                          //     ),
                                          //   ),
                                          // ),
                                          Expanded(
                                            child: Container(
                                              height: 45,
                                              decoration: BoxDecoration(
                                                color: FlutterFlowTheme.of(context).alternate,
                                                borderRadius: BorderRadius.circular(12),
                                                border: Border.all(color: Color(0xFFE69A6A), width: 1),
                                              ),
                                              child: StatefulBuilder(
                                                builder: (context, setStateLocal) {
                                                  return GooglePlaceAutoCompleteTextField(
                                                    focusNode: _model.startLocationFocusNode,
                                                    textEditingController: _model.startLocationTextController,
                                                    googleAPIKey: "AIzaSyDZkxRpoy0BOIAPwMaMIvAd5xpCe-6ZYvs",
                                                    inputDecoration: InputDecoration(
                                                      hintText: 'Start From...',
                                                      isDense: false,
                                                      filled: false,
                                                      contentPadding: EdgeInsets.only(
                                                        left: 14,
                                                        right: 14,
                                                        top: 14,
                                                        bottom: 12,
                                                      ),
                                                      border: InputBorder.none,
                                                      enabledBorder: InputBorder.none,
                                                      focusedBorder: InputBorder.none,
                                                      disabledBorder: InputBorder.none,
                                                      errorBorder: InputBorder.none,
                                                      focusedErrorBorder: InputBorder.none,
                                                      suffixIcon: Padding(
                                                        padding: EdgeInsets.only(right: 0.0),
                                                        child: _model.isFetchingLocation
                                                            ? SizedBox(
                                                          width: 12,
                                                          height: 12,
                                                          child: Padding(
                                                            padding: EdgeInsets.all(6.0),
                                                            child: CircularProgressIndicator(
                                                              strokeWidth: 1.2,
                                                              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFE69A6A)),
                                                            ),
                                                          ),
                                                        )
                                                        // 👇 CHANGED: Show cross if text is NOT empty (works for BOTH cases)
                                                            : _model.startLocationTextController.text.isNotEmpty
                                                            ? IconButton(
                                                          icon: Icon(Icons.clear, color: Color(0xFFE69A6A), size: 22),
                                                          onPressed: () {
                                                            _model.startLocationTextController.clear();
                                                            setStateLocal(() {
                                                              _model.isFetchingLocation = false;
                                                              _model.isCurrentLocationFetched = false;
                                                            });
                                                          },
                                                        )
                                                            : IconButton(
                                                          icon: Icon(Icons.my_location, color: Color(0xFFE69A6A), size: 22),
                                                          onPressed: () async {
                                                            setStateLocal(() {
                                                              _model.isFetchingLocation = true;
                                                            });
                                                            await _getCurrentLocation(context);
                                                            setStateLocal(() {
                                                              _model.isFetchingLocation = false;
                                                              _model.isCurrentLocationFetched = true;
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                    textStyle: FlutterFlowTheme.of(context).bodyMedium.copyWith(fontSize: 14),
                                                    debounceTime: 600,
                                                    countries: ["in"],
                                                    isLatLngRequired: false,
                                                    itemClick: (prediction) {
                                                      _model.startLocationTextController.text = prediction.description ?? "";
                                                      _model.startLocationTextController.selection = TextSelection.fromPosition(
                                                        TextPosition(offset: prediction.description?.length ?? 0),
                                                      );
                                                      // 👇 ADDED: Trigger UI update to show cross icon
                                                      setStateLocal(() {});
                                                    },
                                                    itemBuilder: (context, index, prediction) {
                                                      return Container(
                                                        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                                                        child: Row(
                                                          children: [
                                                            Icon(Icons.location_on, size: 18, color: FlutterFlowTheme.of(context).tertiary),
                                                            SizedBox(width: 8),
                                                            Expanded(
                                                              child: Text(
                                                                prediction.description ?? "",
                                                                style: FlutterFlowTheme.of(context).bodyMedium.copyWith(fontSize: 13),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    },
                                                    seperatedBuilder: Divider(height: 1),
                                                    isCrossBtnShown: false,
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              height: 45,
                                              decoration: BoxDecoration(
                                                color: FlutterFlowTheme.of(context).alternate,
                                                borderRadius: BorderRadius.circular(12),
                                                border: Border.all(
                                                  color: const Color(0xFFE69A6A),
                                                  width: 1,
                                                ),
                                              ),
                                              child: GooglePlaceAutoCompleteTextField(
                                                focusNode: _model.endLocationFocusNode,
                                                textEditingController: _model.endLocationTextController,
                                                googleAPIKey: "AIzaSyDZkxRpoy0BOIAPwMaMIvAd5xpCe-6ZYvs",
                                                inputDecoration: const InputDecoration(
                                                  hintText: 'End To...',
                                                  isDense: false,
                                                  filled: false,
                                                  contentPadding: EdgeInsets.symmetric(
                                                    horizontal: 14,
                                                    vertical: 14,
                                                  ),

                                                  // ✅ NO INNER BORDER
                                                  border: InputBorder.none,
                                                  enabledBorder: InputBorder.none,
                                                  focusedBorder: InputBorder.none,
                                                  disabledBorder: InputBorder.none,
                                                  errorBorder: InputBorder.none,
                                                  focusedErrorBorder: InputBorder.none,
                                                ),
                                                textStyle: FlutterFlowTheme.of(context).bodyMedium.copyWith(fontSize: 14),
                                                debounceTime: 600,
                                                countries: ["in"],
                                                isLatLngRequired: false,
                                                itemClick: (prediction) {
                                                  _model.endLocationTextController.text = prediction.description ?? "";
                                                  _model.endLocationTextController.selection = TextSelection.fromPosition(
                                                    TextPosition(
                                                      offset: prediction.description?.length ?? 0,
                                                    ),
                                                  );
                                                },
                                                itemBuilder: (context, index, prediction) {
                                                  return Container(
                                                    padding: const EdgeInsets.symmetric(
                                                      horizontal: 14,
                                                      vertical: 10,
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                          Icons.location_on,
                                                          size: 18,
                                                          color: FlutterFlowTheme.of(context).tertiary,
                                                        ),
                                                        const SizedBox(width: 8),
                                                        Expanded(
                                                          child: Text(
                                                            prediction.description ?? "",
                                                            style: FlutterFlowTheme.of(context).bodyMedium.copyWith(fontSize: 13),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                                seperatedBuilder: const Divider(height: 1),
                                                isCrossBtnShown: true,
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            // onTap: () async {
                                            //   if ((_model.startLocationTextController.text != null && _model.startLocationTextController.text != '') &&
                                            //       (_model.endLocationTextController.text != null && _model.endLocationTextController.text != '')) {
                                            //     context.pushNamed(
                                            //       SearchRideWidget.routeName,
                                            //       queryParameters: {
                                            //         'query1': serializeParam(
                                            //           _model.startLocationTextController.text,
                                            //           ParamType.String,
                                            //         ),
                                            //         'query2': serializeParam(
                                            //           _model.endLocationTextController.text,
                                            //           ParamType.String,
                                            //         ),
                                            //       }.withoutNulls,
                                            //     );
                                            //   } else {
                                            //     await showDialog(
                                            //       context: context,
                                            //       builder: (alertDialogContext) {
                                            //         return AlertDialog(
                                            //           title: Text('Attention Required '),
                                            //           content: Text('Please fill ride start and end location'),
                                            //           actions: [
                                            //             TextButton(
                                            //               onPressed: () => Navigator.pop(alertDialogContext),
                                            //               child: Text('Ok'),
                                            //             ),
                                            //           ],
                                            //         );
                                            //       },
                                            //     );
                                            //   }
                                            // },
                                            /// original
                                            onTap: () async {
                                              final start = _model.startLocationTextController.text.trim();
                                              final end = _model.endLocationTextController.text.trim();

                                              debugPrint('START LOCATION: $start');
                                              debugPrint('END LOCATION: $end');

                                              // ❌ EMPTY FIELDS
                                              if (start.isEmpty || end.isEmpty) {
                                                await showDialog(
                                                  context: context,
                                                  builder: (dialogContext) => AlertDialog(
                                                    backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
                                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                                    title: Row(
                                                      children: [
                                                        Container(
                                                          padding: EdgeInsets.all(12),
                                                          decoration: BoxDecoration(
                                                            color: Colors.orange.shade100,
                                                            shape: BoxShape.circle,
                                                          ),
                                                          child: Icon(Icons.location_off_outlined,
                                                              color: Colors.orange.shade500, size: 28),
                                                        ),
                                                        SizedBox(width: 16),
                                                        Text('Fill Location',
                                                          style: FlutterFlowTheme.of(context).headlineSmall.override(
                                                            fontWeight: FontWeight.w700,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    content: Text(
                                                      'Please enter both start and end locations to search rides.',
                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                        color: FlutterFlowTheme.of(context).secondaryText,
                                                      ),
                                                    ),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () => Navigator.pop(dialogContext),
                                                        style: TextButton.styleFrom(
                                                          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                                        ),
                                                        child: Text('OK', style: FlutterFlowTheme.of(context).titleSmall.override(
                                                          fontWeight: FontWeight.w600,
                                                          color: FlutterFlowTheme.of(context).primary,
                                                        )),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                                return;
                                              }

                                              // ❌ SAME LOCATION
                                              if (start.toLowerCase() == end.toLowerCase()) {
                                                await showDialog(
                                                  context: context,
                                                  builder: (dialogContext) => AlertDialog(
                                                    backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
                                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                                    title: Row(
                                                      children: [
                                                        Container(
                                                          padding: EdgeInsets.all(12),
                                                          decoration: BoxDecoration(
                                                            color: Colors.red.shade100,
                                                            shape: BoxShape.circle,
                                                          ),
                                                          child: Icon(Icons.location_off,
                                                              color: Colors.red.shade500, size: 28),
                                                        ),
                                                        SizedBox(width: 16),
                                                        Text('🚫 Invalid Route',
                                                          style: FlutterFlowTheme.of(context).headlineSmall.override(
                                                            fontWeight: FontWeight.w700,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    content: Text(
                                                      'Start and end locations cannot be the same.',
                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                        color: FlutterFlowTheme.of(context).secondaryText,
                                                      ),
                                                    ),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () => Navigator.pop(dialogContext),
                                                        style: TextButton.styleFrom(
                                                          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                                        ),
                                                        child: Text('OK', style: FlutterFlowTheme.of(context).titleSmall.override(
                                                          fontWeight: FontWeight.w600,
                                                          color: FlutterFlowTheme.of(context).primary,
                                                        )),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                                return;
                                              }

                                              // ✅ SUCCESS - Update search state
                                              setState(() {
                                                _model.searchStartLocation = start;
                                                _model.searchEndLocation = end;
                                                _model.isSearchActive = true;
                                              });

                                              // 🎉 SUCCESS FEEDBACK
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(
                                                  content: Row(
                                                    children: [
                                                      Icon(Icons.search, color: Colors.white, size: 20),
                                                      SizedBox(width: 12),
                                                      Expanded(child: Text('Searching rides from $start → $end')),
                                                    ],
                                                  ),
                                                  backgroundColor: Colors.green.shade600,
                                                  duration: Duration(seconds: 2),
                                                  behavior: SnackBarBehavior.floating,
                                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                                ),
                                              );
                                            },

/*
                                            onTap: () async {
                                              // Existing FlutterFlow null / empty checks (kept, but NAVIGATION COMMENTED)
                                              if (_model.startLocationTextController.text != null && _model.startLocationTextController.text != '' && _model.endLocationTextController.text != null && _model.endLocationTextController.text != '') {
                                                // Old navigation – now disabled but preserved
                                                */
/*
    context.pushNamed(
      SearchRideWidget.routeName,
      queryParameters: {
        'query1': serializeParam(
          _model.startLocationTextController.text,
          ParamType.String,
        ),
        'query2': serializeParam(
          _model.endLocationTextController.text,
          ParamType.String,
        ),
      }.withoutNulls,
    );
    */ /*

                                              } else {
                                                await showDialog(
                                                  context: context,
                                                  builder: (alertDialogContext) {
                                                    return AlertDialog(
                                                      title: const Text('Attention Required'),
                                                      content: const Text('Please fill ride start and end location'),
                                                      actions: [
                                                        TextButton(
                                                          onPressed: () => Navigator.pop(alertDialogContext),
                                                          child: const Text('Ok'),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                              }

                                              // ✅ STATIC TESTING: Aligarh → Faridabad
                                              final start = "Aligarh";
                                              final end = "Faridabad";

                                              debugPrint('START LOCATION: $start');
                                              debugPrint('END LOCATION: $end');

                                              if (start.isEmpty || end.isEmpty) {
                                                await showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      title: const Text('Attention Required'),
                                                      content: const Text('Please fill ride start and end location'),
                                                      actions: [
                                                        TextButton(
                                                          onPressed: () => Navigator.pop(context),
                                                          child: const Text('Ok'),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                                return;
                                              }

                                              if (start.toLowerCase() == end.toLowerCase()) {
                                                await showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      title: const Text('Invalid Route'),
                                                      content: const Text('Start and end location cannot be the same'),
                                                      actions: [
                                                        TextButton(
                                                          onPressed: () => Navigator.pop(context),
                                                          child: const Text('Ok'),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                                return;
                                              }

                                              // VALID CASE: update HomeWidget search state with static values
                                              setState(() {
                                                _model.searchStartLocation = "Aligarh";
                                                _model.searchEndLocation = "Faridabad";
                                                _model.isSearchActive = true;
                                              });
                                            },
*/

                                            child: Container(
                                              width: 40.0,
                                              height: 40.0,
                                              decoration: BoxDecoration(
                                                color: FlutterFlowTheme.of(context).tertiary,
                                                shape: BoxShape.circle,
                                              ),
                                              child: Align(
                                                alignment: AlignmentDirectional(0.0, 0.0),
                                                child: Icon(
                                                  Icons.arrow_forward,
                                                  color: Colors.white,
                                                  size: 20.0,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ].divide(SizedBox(width: 8.0)),
                                      ).animateOnPageLoad(animationsMap['rowOnPageLoadAnimation']!),
                                    ),
                                  ),
                                Expanded(
                                  child: TabBarView(
                                    controller: _model.tabBarController,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          // 📅 LEFT SIDE - Date List (with its own scroll)
                                          Expanded(
                                            flex: 2,
                                             child: SingleChildScrollView(
                                               key: PageStorageKey('home_dates_scroll'),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 5.0, 0.0),
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(12.0),
                                                  child: Container(
                                                    width: MediaQuery.sizeOf(context).width * 0.18,
                                                    decoration: BoxDecoration(
                                                      color: FlutterFlowTheme.of(context).primaryBackground,
                                                      boxShadow: [
                                                        BoxShadow(
                                                          blurRadius: 4.0,
                                                          color: Color(0x10000000),
                                                          offset: Offset(0.0, 2.0),
                                                        )
                                                      ],
                                                      borderRadius: BorderRadius.circular(12.0),
                                                    ),
                                                    child: StreamBuilder<List<AdminSetDateRecord>>(
                                                      stream: queryAdminSetDateRecord(
                                                          queryBuilder: (adminSetDateRecord) => adminSetDateRecord
                                                              .where('dateList', isGreaterThanOrEqualTo: DateTime.now().subtract(Duration(hours: 1)))
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

                                                        final now = DateTime.now();
                                                        final startDate = DateTime(now.year, now.month, 1);
                                                        final endDate = DateTime(now.year, now.month + 2, 0);
                                                        final totalDays = endDate.difference(startDate).inDays + 1;

                                                        return ListView.separated(
                                                          padding: EdgeInsets.zero,
                                                          shrinkWrap: true,
                                                          itemCount: totalDays,
                                                          physics: NeverScrollableScrollPhysics(),
                                                          separatorBuilder: (_, __) => const SizedBox(height: 15.0),
                                                          itemBuilder: (context, listViewIndex) {
                                                            final date = startDate.add(Duration(days: listViewIndex));
                                                            final isSelected = _model.pageState != null &&
                                                                _model.pageState!.year == date.year &&
                                                                _model.pageState!.month == date.month &&
                                                                _model.pageState!.day == date.day;

                                                            return InkWell(
                                                              onTap: () async {
                                                                final startOfDay = DateTime(date.year, date.month, date.day, 0, 0, 0);
                                                                _model.pageState = startOfDay;
                                                                safeSetState(() {});

                                                                ScaffoldMessenger.of(context).showSnackBar(
                                                                  SnackBar(
                                                                    content: Text('📅 Switched to ${dateTimeFormat("dd MMM yyyy", startOfDay)}'),
                                                                    backgroundColor: FlutterFlowTheme.of(context).tertiary,
                                                                    duration: const Duration(seconds: 3),
                                                                  ),
                                                                );
                                                              },
                                                              child: Container(
                                                                width: 70.53,
                                                                height: 70.0,
                                                                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                                                                decoration: BoxDecoration(
                                                                  color: isSelected ? Colors.white : const Color(0xFFF4F4F4),
                                                                  borderRadius: const BorderRadius.only(
                                                                    bottomRight: Radius.circular(15.0),
                                                                    topRight: Radius.circular(15.0),
                                                                  ),
                                                                  border: isSelected ? Border.all(
                                                                    color: FlutterFlowTheme.of(context).tertiary,
                                                                    width: 2.0,
                                                                  ) : null,
                                                                  boxShadow: [
                                                                    BoxShadow(
                                                                      blurRadius: isSelected ? 4.0 : 2.0,
                                                                      color: isSelected
                                                                          ? FlutterFlowTheme.of(context).tertiary.withOpacity(0.2)
                                                                          : const Color(0x0F000000),
                                                                      offset: Offset(0.0, isSelected ? 2.0 : 1.0),
                                                                    )
                                                                  ],
                                                                ),
                                                                child: Column(
                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                  children: [
                                                                    Text(
                                                                      '${date.day}',
                                                                      style: TextStyle(
                                                                        fontWeight: FontWeight.bold,
                                                                        color: isSelected ? FlutterFlowTheme.of(context).tertiary : Colors.black,
                                                                        fontSize: isSelected ? 22.0 : 18.0,
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      dateTimeFormat("MMM", date).toUpperCase(),
                                                                      style: TextStyle(
                                                                        fontWeight: FontWeight.w600,
                                                                        color: isSelected ? FlutterFlowTheme.of(context).tertiary : Colors.black54,
                                                                        fontSize: isSelected ? 14.0 : 12.0,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ).animateOnPageLoad(animationsMap['containerOnPageLoadAnimation1']!),
                                              ),
                                            ),
                                          ),

                                          // 🚗 RIGHT SIDE - Rides List (with its own scroll)
                                          Expanded(
                                            flex: 8,
                                             child: SingleChildScrollView(
                                               key: PageStorageKey('home_rides_scroll'),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 5.0, 0.0),
                                                child: Container(
                                                  width: MediaQuery.sizeOf(context).width * 0.78,
                                                  child: Column(
                                                    mainAxisSize: MainAxisSize.min,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      StreamBuilder<List<RidesNewRecord>>(
                                                        stream: () {
                                                          final now = DateTime.now();
                                                          final today = DateTime(now.year, now.month, now.day);
                                                          return queryRidesNewRecord(
                                                            queryBuilder: (ridesNewRecord) {
                                                              return ridesNewRecord
                                                                  .where('pickupTime', isGreaterThanOrEqualTo: today)
                                                                  .orderBy('pickupTime', descending: false);
                                                            },
                                                          );
                                                        }(),
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

                                                          List<RidesNewRecord> listViewRidesNewRecordList = snapshot.data!;

                                                          if (listViewRidesNewRecordList.isEmpty) {
                                                            return NoRideToShowUserWidget(
                                                              onDateChanged: (DateTime newDate) {
                                                                _model.pageState = newDate;
                                                                safeSetState(() {});
                                                              },
                                                            );
                                                          }

                                                          // Client-side filter: if search is active, filter by start/end location including stoppages
                                                          if (_model.isSearchActive && _model.searchStartLocation != null && _model.searchEndLocation != null) {
                                                            final startSearch = _model.searchStartLocation!.trim().toLowerCase();
                                                            final endSearch = _model.searchEndLocation!.trim().toLowerCase();

                                                            listViewRidesNewRecordList = listViewRidesNewRecordList.where((ride) {
                                                              final startAddress = (ride.rideStartLocation ?? '').toLowerCase();
                                                              final googleStart = (ride.googleStartAddress ?? '').toLowerCase();
                                                              final matchStart = startAddress.contains(startSearch) ||
                                                                  googleStart.contains(startSearch) ||
                                                                  ride.stoppages.any((stop) => stop.toLowerCase().contains(startSearch));

                                                              final endAddress = (ride.rideEndLocation ?? '').toLowerCase();
                                                              final googleEnd = (ride.googleEndAddress ?? '').toLowerCase();
                                                              final matchEnd = endAddress.contains(endSearch) ||
                                                                  googleEnd.contains(endSearch) ||
                                                                  ride.stoppages.any((stop) => stop.toLowerCase().contains(endSearch));

                                                              if (matchStart && matchEnd) {
                                                                final routeSequence = [
                                                                  startAddress,
                                                                  if (ride.googleStartAddress != null && ride.googleStartAddress!.isNotEmpty) ride.googleStartAddress!.toLowerCase(),
                                                                  ...ride.stoppages.map((s) => s.toLowerCase()),
                                                                  endAddress,
                                                                  if (ride.googleEndAddress != null && ride.googleEndAddress!.isNotEmpty) ride.googleEndAddress!.toLowerCase(),
                                                                ];

                                                                int startIndex = -1;
                                                                for (int i = 0; i < routeSequence.length; i++) {
                                                                  if (routeSequence[i].contains(startSearch)) {
                                                                    startIndex = i;
                                                                    break;
                                                                  }
                                                                }

                                                                int endIndex = -1;
                                                                for (int i = routeSequence.length - 1; i >= 0; i--) {
                                                                  if (routeSequence[i].contains(endSearch)) {
                                                                    endIndex = i;
                                                                    break;
                                                                  }
                                                                }

                                                                return startIndex != -1 && endIndex != -1 && startIndex < endIndex;
                                                              }
                                                              return false;
                                                            }).toList();
                                                          }

                                                          if (listViewRidesNewRecordList.isEmpty) {
                                                            return NoRideToShowUserWidget(
                                                              onDateChanged: (DateTime newDate) {
                                                                _model.pageState = newDate;
                                                                safeSetState(() {});
                                                              },
                                                            );
                                                          }

                                                          {
                                                            return ListView.separated(
                                                              padding: EdgeInsets.zero,
                                                              primary: false,
                                                              shrinkWrap: true,
                                                              physics: NeverScrollableScrollPhysics(),
                                                              scrollDirection: Axis.vertical,
                                                              itemCount: listViewRidesNewRecordList.length,
                                                              separatorBuilder: (_, __) => SizedBox(height: 10.0),
                                                              itemBuilder: (context, listViewIndex) {
                                                                final listViewRidesNewRecord = listViewRidesNewRecordList[listViewIndex];
                                                                // Keep your existing ride card Stack widget here
                                                                return Stack(
                                                                  children: [
                                                                    InkWell(
                                                                      splashColor: Colors.transparent,
                                                                      focusColor: Colors.transparent,
                                                                      hoverColor: Colors.transparent,
                                                                      highlightColor: Colors.transparent,
                                                                      onTap: () async {
                                                                        context.pushNamed(
                                                                          RideDetailsCustomerWidget.routeName,
                                                                          queryParameters: {
                                                                            'rideDetails': serializeParam(
                                                                              listViewRidesNewRecord.reference,
                                                                              ParamType.DocumentReference,
                                                                            ),
                                                                          }.withoutNulls,
                                                                        );
                                                                      },
                                                                      child: Material(
                                                                        color: Colors.transparent,
                                                                        elevation: 10.0,
                                                                        shape: RoundedRectangleBorder(
                                                                          borderRadius: BorderRadius.circular(12.0),
                                                                        ),
                                                                        child: ClipRRect(
                                                                          borderRadius: BorderRadius.circular(12.0),
                                                                          child: Container(
                                                                            width: double.infinity,
                                                                            decoration: BoxDecoration(
                                                                              color: FlutterFlowTheme.of(context).primaryBackground,
                                                                              boxShadow: [
                                                                                BoxShadow(
                                                                                  blurRadius: 4.0,
                                                                                  color: Color(0x1A000000),
                                                                                  offset: Offset(
                                                                                    0.0,
                                                                                    2.0,
                                                                                  ),
                                                                                )
                                                                              ],
                                                                              borderRadius: BorderRadius.circular(12.0),
                                                                              border: Border.all(
                                                                                color: FlutterFlowTheme.of(context).tertiary,
                                                                              ),
                                                                            ),
                                                                            alignment: AlignmentDirectional(1.0, 0.0),
                                                                            child: Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 5.0, 10.0),
                                                                              child: SizedBox(
                                                                                child: Column(
                                                                                  mainAxisSize: MainAxisSize.min,
                                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                                                  children: [
                                                                                    Row(
                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                                                      children: [
                                                                                        Row(
                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                          children: [
                                                                                            Icon(
                                                                                              Icons.location_on_outlined,
                                                                                              color: Colors.grey,
                                                                                              size: 24.0,
                                                                                            ),
                                                                                            ClipRRect(
                                                                                              borderRadius: BorderRadius.circular(15.0),
                                                                                              child: Container(
                                                                                                width: 170.0,
                                                                                                decoration: BoxDecoration(
                                                                                                  color: Color(0xFFE3E6E0),
                                                                                                  borderRadius: BorderRadius.circular(15.0),
                                                                                                ),
                                                                                                child: Padding(
                                                                                                  padding: EdgeInsetsDirectional.fromSTEB(15.0, 5.0, 10.0, 5.0),
                                                                                                  child: Text(
                                                                                                    _truncateAddress(listViewRidesNewRecord.rideStartLocation),
                                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                      font: GoogleFonts.inter(
                                                                                                        fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                      ),
                                                                                                      fontSize: 12.0,
                                                                                                      letterSpacing: 0.0,
                                                                                                      fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      ].divide(SizedBox(width: 5.0)),
                                                                                    ),
                                                                                    Align(
                                                                                      alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                      child: Padding(
                                                                                        padding: EdgeInsetsDirectional.fromSTEB(25.0, 0.0, 0.0, 0.0),
                                                                                        child: Container(
                                                                                          width: 184.9,
                                                                                          height: 16.8,
                                                                                          decoration: BoxDecoration(),
                                                                                          child: Row(
                                                                                            mainAxisSize: MainAxisSize.min,  // 👈 CRITICAL: min not max!
                                                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                                                            children: [
                                                                                              // 👈 TRANSPORT ICONS (only ONE shows)
                                                                                              if (listViewRidesNewRecord.modeOfTransport == 'Bike')
                                                                                                Padding(
                                                                                                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 8.0, 0.0),  // 👈 Reduced padding
                                                                                                  child: Icon(Icons.motorcycle_sharp, color: Color(0xFF8A8888), size: 18.0),  // 👈 Smaller
                                                                                                ),
                                                                                              if (listViewRidesNewRecord.modeOfTransport == 'Train')
                                                                                                Padding(
                                                                                                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 8.0, 0.0),
                                                                                                  child: Icon(Icons.train, color: Color(0xFF929090), size: 18.0),
                                                                                                ),
                                                                                              if (listViewRidesNewRecord.modeOfTransport == 'Car')
                                                                                                Padding(
                                                                                                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 8.0, 0.0),
                                                                                                  child: FaIcon(FontAwesomeIcons.carSide, color: Color(0xFF8F9192), size: 14.0),  // 👈 Smaller
                                                                                                ),
                                                                                              if (listViewRidesNewRecord.modeOfTransport == 'Bus')
                                                                                                Padding(
                                                                                                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 8.0, 0.0),
                                                                                                  child: FaIcon(FontAwesomeIcons.bus, color: Color(0xFF919191), size: 14.0),
                                                                                                ),

                                                                                              // 👈 FLEXIBLE TIME TEXT
                                                                                              Flexible(
                                                                                                child: Text(
                                                                                                  '${dateTimeFormat("hh:mm a", listViewRidesNewRecord.pickupTime).toLowerCase()} । ${dateTimeFormat("yMMMd", listViewRidesNewRecord.pickupTime)}',
                                                                                                  style: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                                    fontSize: 11.5,
                                                                                                    color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                  ),
                                                                                                  maxLines: 1,
                                                                                                  overflow: TextOverflow.ellipsis,
                                                                                                ),
                                                                                              ),
                                                                                            ],
                                                                                          ),

                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    Row(
                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                      children: [
                                                                                        Row(
                                                                                          mainAxisSize: MainAxisSize.min,
                                                                                          children: [
                                                                                            Icon(
                                                                                              Icons.location_on_outlined,
                                                                                              color: Colors.grey,
                                                                                              size: 24.0,
                                                                                            ),
                                                                                            Container(
                                                                                              width: 170.0,
                                                                                              decoration: BoxDecoration(
                                                                                                color: Color(0xFFE3E6E0),
                                                                                                borderRadius: BorderRadius.circular(15.0),
                                                                                              ),
                                                                                              child: Padding(
                                                                                                padding: EdgeInsetsDirectional.fromSTEB(15.0, 5.0, 10.0, 5.0),
                                                                                                child: Text(
                                                                                                  _truncateAddress(listViewRidesNewRecord.rideEndLocation),
                                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                    font: GoogleFonts.inter(
                                                                                                      fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                    ),
                                                                                                    fontSize: 12.0,
                                                                                                    letterSpacing: 0.0,
                                                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      ].divide(SizedBox(width: 5.0)),
                                                                                    ),
                                                                                    if (listViewRidesNewRecord.creatorID != null)
                                                                                      Padding(
                                                                                        padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                                                        child: StreamBuilder<UsersRecord>(
                                                                                          stream: UsersRecord.getDocument(listViewRidesNewRecord.creatorID!),
                                                                                          builder: (context, snapshot) {
                                                                                            // Customize what your widget looks like when it's loading.
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

                                                                                            final rowUsersRecord = snapshot.data!;

                                                                                            return Row(
                                                                                              mainAxisSize: MainAxisSize.max,
                                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                              children: [
                                                                                                // Left section with profile image and name
                                                                                                Expanded(  // 👈 CHANGED: Use Expanded to take available space
                                                                                                  child: Align(
                                                                                                    alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                                    child: Container(
                                                                                                      constraints: BoxConstraints(maxWidth: double.infinity),  // 👈 CHANGED: Allow full width
                                                                                                      decoration: BoxDecoration(),
                                                                                                      child: Row(
                                                                                                        mainAxisSize: MainAxisSize.min,
                                                                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                                                                        children: [
                                                                                                          InkWell(
                                                                                                            splashColor: Colors.transparent,
                                                                                                            focusColor: Colors.transparent,
                                                                                                            hoverColor: Colors.transparent,
                                                                                                            highlightColor: Colors.transparent,
                                                                                                            onTap: () => context.pushNamed(
                                                                                                              DriverReviewWidget.routeName,
                                                                                                              queryParameters: {
                                                                                                                'userRef': serializeParam(rowUsersRecord.reference, ParamType.DocumentReference),
                                                                                                              }.withoutNulls,
                                                                                                            ),
                                                                                                            child: Builder(
                                                                                                              builder: (context) {
                                                                                                                if (rowUsersRecord.photoUrl != null && rowUsersRecord.photoUrl!.isNotEmpty) {
                                                                                                                  return Container(
                                                                                                                    width: 30.0,
                                                                                                                    height: 30.0,
                                                                                                                    clipBehavior: Clip.antiAlias,
                                                                                                                    decoration: const BoxDecoration(shape: BoxShape.circle),
                                                                                                                    child: Image.network(
                                                                                                                      rowUsersRecord.photoUrl!,
                                                                                                                      fit: BoxFit.cover,
                                                                                                                      errorBuilder: (context, error, stackTrace) => Container(
                                                                                                                        width: 30.0,
                                                                                                                        height: 30.0,
                                                                                                                        decoration: BoxDecoration(
                                                                                                                          shape: BoxShape.circle,
                                                                                                                          color: Colors.grey.shade300,
                                                                                                                        ),
                                                                                                                        child: Icon(Icons.person, size: 16, color: Colors.grey),
                                                                                                                      ),
                                                                                                                    ),
                                                                                                                  );
                                                                                                                }
                                                                                                                return Container(
                                                                                                                  width: 30.0,
                                                                                                                  height: 30.0,
                                                                                                                  clipBehavior: Clip.antiAlias,
                                                                                                                  decoration: const BoxDecoration(shape: BoxShape.circle),
                                                                                                                  child: Image.asset('assets/images/userIconTr.png', fit: BoxFit.cover),
                                                                                                                );
                                                                                                              },
                                                                                                            ),
                                                                                                          ),
                                                                                                          SizedBox(width: 12.0),
                                                                                                          // 👈 CHANGED: Use Expanded here too for the name
                                                                                                          Expanded(
                                                                                                            child: Column(
                                                                                                              mainAxisSize: MainAxisSize.min,
                                                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                              children: [
                                                                                                                Text(
                                                                                                                  rowUsersRecord.displayName?.isNotEmpty == true
                                                                                                                      ? rowUsersRecord.displayName!
                                                                                                                      : 'Driver',
                                                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                    fontFamily: GoogleFonts.inter().fontFamily,
                                                                                                                    fontWeight: FontWeight.w600,
                                                                                                                    fontSize: 12.0,  // 👈 CHANGED: Slightly larger font
                                                                                                                  ),
                                                                                                                  maxLines: 2,  // 👈 CHANGED: Allow 2 lines if needed
                                                                                                                  softWrap: true,  // 👈 ADDED: Allow text to wrap
                                                                                                                  overflow: TextOverflow.visible,  // 👈 CHANGED: No ellipsis
                                                                                                                ),
                                                                                                              ],
                                                                                                            ),
                                                                                                          ),
                                                                                                        ],
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),

                                                                                                // Right section with rating
                                                                                                Align(
                                                                                                  alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                  child: Container(
                                                                                                    width: 40.0,  // 👈 CHANGED: Slightly wider
                                                                                                    decoration: BoxDecoration(),
                                                                                                    child: Padding(
                                                                                                      padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 5.0, 0.0),
                                                                                                      child: Stack(
                                                                                                        alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                        children: [
                                                                                                          ClipRRect(
                                                                                                            borderRadius: BorderRadius.circular(8.0),
                                                                                                            child: Image.asset(
                                                                                                              'assets/images/Ride_Search_Icons.png',
                                                                                                              width: 30.0,  // 👈 CHANGED: Slightly larger
                                                                                                              height: 30.0,
                                                                                                              fit: BoxFit.cover,
                                                                                                            ),
                                                                                                          ),
                                                                                                          Text(
                                                                                                            valueOrDefault<String>(
                                                                                                              formatNumber(
                                                                                                                functions.averageRating(rowUsersRecord.ratings.toList()),
                                                                                                                formatType: FormatType.compact,
                                                                                                              ),
                                                                                                              '0',
                                                                                                            ),
                                                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                              font: GoogleFonts.inter(
                                                                                                                fontWeight: FontWeight.w900,
                                                                                                              ),
                                                                                                              color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                              fontSize: 10.0,  // 👈 CHANGED: Slightly larger
                                                                                                              letterSpacing: 0.0,
                                                                                                              fontWeight: FontWeight.w900,
                                                                                                            ),
                                                                                                          ),
                                                                                                        ],
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                              ],
                                                                                            );
                                                                                          },
                                                                                        ),
                                                                                      ),
                                                                                  ].divide(SizedBox(height: 12.0)),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ).animateOnPageLoad(animationsMap['containerOnPageLoadAnimation2']!),
                                                                    Align(
                                                                      alignment: AlignmentDirectional(0.97, -0.96),
                                                                      child: Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 5.0, 0.0),
                                                                        child: Container(
                                                                          // ✅ RESPONSIVE SIZING
                                                                          width: MediaQuery.sizeOf(context).width * 0.12, // 12% of screen width
                                                                          constraints: BoxConstraints(
                                                                            minWidth: 55.0, // Minimum width
                                                                            maxWidth: 70.0, // Maximum width
                                                                            minHeight: 85.0, // Minimum height
                                                                            maxHeight: 100.0, // Maximum height
                                                                          ),
                                                                          decoration: BoxDecoration(
                                                                            color: Color(0xFFF97E4C),
                                                                            borderRadius: BorderRadius.circular(12.0),
                                                                          ),
                                                                          child: Column(
                                                                            mainAxisSize: MainAxisSize.min,
                                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                                            children: [
                                                                              Padding(
                                                                                padding: EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
                                                                                child: Text(
                                                                                  'Ride',
                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    font: GoogleFonts.inter(
                                                                                      fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                    ),
                                                                                    color: FlutterFlowTheme.of(context).info,
                                                                                    fontSize: 12.0,
                                                                                    letterSpacing: 0.0,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              Padding(
                                                                                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 4.0),
                                                                                child: AutoSizeText(
                                                                                  '₹${formatNumber(listViewRidesNewRecord.pricePerPassengers, formatType: FormatType.custom, format: '', locale: '')}',
                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    font: GoogleFonts.inter(
                                                                                      fontWeight: FontWeight.bold,
                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                    ),
                                                                                    color: FlutterFlowTheme.of(context).info,
                                                                                    fontSize: 15.0,
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FontWeight.bold,
                                                                                  ),
                                                                                  maxLines: 1,
                                                                                  minFontSize: 12,
                                                                                ),
                                                                              ),
                                                                              // ✅ Parcel section also responsive
                                                                              Container(
                                                                                width: double.infinity,
                                                                                // ✅ Flexible height
                                                                                constraints: BoxConstraints(minHeight: 48.0, maxHeight: 55.0),
                                                                                decoration: BoxDecoration(
                                                                                  color: Color(0xFFFF9561),
                                                                                  borderRadius: BorderRadius.circular(10.0),
                                                                                ),
                                                                                child: Column(
                                                                                  mainAxisSize: MainAxisSize.min,
                                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                                  children: [
                                                                                    Padding(
                                                                                      padding: EdgeInsetsDirectional.fromSTEB(0.0, 3.0, 0.0, 0.0),
                                                                                      child: Text(
                                                                                        'Parcel',
                                                                                        textAlign: TextAlign.center,
                                                                                        style: FlutterFlowTheme.of(context).labelSmall.override(
                                                                                          font: GoogleFonts.inter(
                                                                                            fontWeight: FontWeight.w500,
                                                                                            fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
                                                                                          ),
                                                                                          color: FlutterFlowTheme.of(context).info,
                                                                                          fontSize: 11.0,
                                                                                          letterSpacing: 0.0,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    AutoSizeText(
                                                                                      '₹${listViewRidesNewRecord.totalDeliveryCost}',
                                                                                      textAlign: TextAlign.center,
                                                                                      style: FlutterFlowTheme.of(context).labelSmall.override(
                                                                                        font: GoogleFonts.inter(
                                                                                          fontWeight: FontWeight.bold,
                                                                                          fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
                                                                                        ),
                                                                                        color: FlutterFlowTheme.of(context).info,
                                                                                        fontSize: 14.0,
                                                                                        letterSpacing: 0.0,
                                                                                      ),
                                                                                      maxLines: 1,
                                                                                      minFontSize: 11,
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                );
                                                              },
                                                            ).animateOnPageLoad(animationsMap['listViewOnPageLoadAnimation']!);
                                                          }
                                                        },
                                                      ),
                                                    ].divide(SizedBox(height: 16.0)).addToEnd(SizedBox(height: 15.0)),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
//                                       ListView(
//                                         padding: EdgeInsets.zero,
//                                         shrinkWrap: true,
//                                         scrollDirection: Axis.vertical,
//                                         children: [
//                                           Column(
//                                             mainAxisSize: MainAxisSize.min,
//                                             crossAxisAlignment: CrossAxisAlignment.start,
//                                             children: [
//                                               Padding(
//                                                 padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
//                                                 child: Row(
//                                                   mainAxisSize: MainAxisSize.max,
//                                                   mainAxisAlignment: MainAxisAlignment.start,
//                                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                                   children: [
//                                                     Padding(
//                                                       padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 5.0, 0.0),
//                                                       child: ClipRRect(
//                                                         borderRadius: BorderRadius.circular(12.0),
//                                                         child: Container(
//                                                           width: MediaQuery.sizeOf(context).width * 0.18,
//                                                           decoration: BoxDecoration(
//                                                             color: FlutterFlowTheme.of(context).primaryBackground,
//                                                             boxShadow: [
//                                                               BoxShadow(
//                                                                 blurRadius: 4.0,
//                                                                 color: Color(0x10000000),
//                                                                 offset: Offset(0.0, 2.0),
//                                                               )
//                                                             ],
//                                                             borderRadius: BorderRadius.circular(12.0),
//                                                           ),
//                                                           child: StreamBuilder<List<AdminSetDateRecord>>(
//                                                             stream: queryAdminSetDateRecord(
//                                                                 queryBuilder: (adminSetDateRecord) => adminSetDateRecord
//                                                                     .where('dateList', isGreaterThanOrEqualTo: DateTime.now().subtract(Duration(hours: 1)))
//                                                             ),
//                                                             builder: (context, snapshot) {
//                                                               if (!snapshot.hasData) {
//                                                                 return Center(
//                                                                   child: SizedBox(
//                                                                     width: 50.0,
//                                                                     height: 50.0,
//                                                                     child: SpinKitFadingCircle(
//                                                                       color: Color(0xFF2B3C58),
//                                                                       size: 50.0,
//                                                                     ),
//                                                                   ),
//                                                                 );
//                                                               }
//
//                                                               final now = DateTime.now();
//                                                               final startDate = DateTime(now.year, now.month, 1);
//                                                               final endDate = DateTime(now.year, now.month + 2, 0);
//                                                               final totalDays = endDate.difference(startDate).inDays + 1;
//
//                                                               return ListView.separated(
//                                                                 // physics: const AlwaysScrollableScrollPhysics(), // Ensures scrolling
//                                                                 padding: EdgeInsets.zero,
//                                                                 shrinkWrap: true,
//                                                                 itemCount: totalDays,
//                                                                 physics: NeverScrollableScrollPhysics(), // Disable internal scroll
//                                                                 separatorBuilder: (_, __) => const SizedBox(height: 15.0),
//                                                                 itemBuilder: (context, listViewIndex) {
//                                                                   final date = startDate.add(Duration(days: listViewIndex));
//                                                                   final isSelected = _model.pageState != null &&
//                                                                       _model.pageState!.year == date.year &&
//                                                                       _model.pageState!.month == date.month &&
//                                                                       _model.pageState!.day == date.day;
//
//                                                                   return InkWell(
//                                                                     onTap: () async {
//                                                                       final startOfDay = DateTime(date.year, date.month, date.day, 0, 0, 0);
//                                                                       _model.pageState = startOfDay;
//                                                                       safeSetState(() {});
//
//                                                                       ScaffoldMessenger.of(context).showSnackBar(
//                                                                         SnackBar(
//                                                                           content: Text('📅 Switched to ${dateTimeFormat("dd MMM yyyy", startOfDay)}'),
//                                                                           backgroundColor: FlutterFlowTheme.of(context).tertiary,
//                                                                           duration: const Duration(seconds: 3),
//                                                                         ),
//                                                                       );
//                                                                     },
//                                                                     child: Container(
//                                                                       width: 70.53,
//                                                                       height: 70.0,
//                                                                       margin: const EdgeInsets.symmetric(horizontal: 5.0),
//                                                                       decoration: BoxDecoration(
//                                                                         color: isSelected ? Colors.white : const Color(0xFFF4F4F4),
//                                                                         borderRadius: const BorderRadius.only(
//                                                                           bottomRight: Radius.circular(15.0),
//                                                                           topRight: Radius.circular(15.0),
//                                                                         ),
//                                                                         border: isSelected ? Border.all(
//                                                                           color: FlutterFlowTheme.of(context).tertiary,
//                                                                           width: 2.0,
//                                                                         ) : null,
//                                                                         boxShadow: [
//                                                                           BoxShadow(
//                                                                             blurRadius: isSelected ? 4.0 : 2.0,
//                                                                             color: isSelected
//                                                                                 ? FlutterFlowTheme.of(context).tertiary.withOpacity(0.2)
//                                                                                 : const Color(0x0F000000),
//                                                                             offset: Offset(0.0, isSelected ? 2.0 : 1.0),
//                                                                           )
//                                                                         ],
//                                                                       ),
//                                                                       child: Column(
//                                                                         mainAxisAlignment: MainAxisAlignment.center,
//                                                                         children: [
//                                                                           Text(
//                                                                             '${date.day}',
//                                                                             style: TextStyle(
//                                                                               fontWeight: FontWeight.bold,
//                                                                               color: isSelected ? FlutterFlowTheme.of(context).tertiary : Colors.black,
//                                                                               fontSize: isSelected ? 22.0 : 18.0,
//                                                                             ),
//                                                                           ),
//                                                                           Text(
//                                                                             dateTimeFormat("MMM", date).toUpperCase(),
//                                                                             style: TextStyle(
//                                                                               fontWeight: FontWeight.w600,
//                                                                               color: isSelected ? FlutterFlowTheme.of(context).tertiary : Colors.black54,
//                                                                               fontSize: isSelected ? 14.0 : 12.0,
//                                                                             ),
//                                                                           ),
//                                                                         ],
//                                                                       ),
//                                                                     ),
//                                                                   );
//                                                                 },
//                                                               );
//                                                             },
//                                                           ),
//                                                         ),
//                                                       ),
//                                                     ).animateOnPageLoad(animationsMap['containerOnPageLoadAnimation1']!),                                                    SizedBox(
//                                                       child: Padding(
//                                                         padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 5.0, 0.0),
//                                                         child: Container(
//                                                           width: MediaQuery.sizeOf(context).width * 0.78,
//                                                           decoration: BoxDecoration(),
//                                                           child: SingleChildScrollView(
//                                                             primary: false,
//                                                             child: Column(
//                                                               mainAxisSize: MainAxisSize.min,
//                                                               crossAxisAlignment: CrossAxisAlignment.start,
//                                                               children: [
//                                                                 StreamBuilder<List<RidesNewRecord>>(
//                                                                   // stream: queryRidesNewRecord(
//                                                                   //   queryBuilder: (ridesNewRecord) =>
//                                                                   //       ridesNewRecord.where(
//                                                                   //         'pickupTime',
//                                                                   //         isEqualTo: _model.pageState,
//                                                                   //       ),
//                                                                   // ),
//                                                                   stream: () {
//                                                                     if (_model.isSearchActive && _model.searchStartLocation != null && _model.searchEndLocation != null) {
//                                                                       // ✅ SEARCH MODE: rides matching start OR end location
//                                                                       return queryRidesNewRecord(
//                                                                         queryBuilder: (ridesNewRecord) => ridesNewRecord.where(
//                                                                           Filter.and(
//                                                                             Filter(
//                                                                               'RideStartLocation',
//                                                                               isEqualTo: _model.searchStartLocation,
//                                                                             ),
//                                                                             Filter(
//                                                                               'RideEndLocation',
//                                                                               isEqualTo: _model.searchEndLocation,
//                                                                             ),
//                                                                           ),
//                                                                         ),
//                                                                       );
//                                                                     } else {
//                                                                       // NORMAL MODE: original date filter
//                                                                       // NORMAL MODE: Show future rides sorted by nearest date
//                                                                       final now = DateTime.now();
//                                                                       final today = DateTime(now.year, now.month, now.day);
//
//                                                                       return queryRidesNewRecord(
//                                                                         queryBuilder: (ridesNewRecord) {
//                                                                           return ridesNewRecord
//                                                                               .where('pickupTime', isGreaterThanOrEqualTo: today) // Only future/today rides
//                                                                               .orderBy('pickupTime', descending: false); // Nearest first
//                                                                         },
//                                                                       );
//                                                                       // return queryRidesNewRecord(
//                                                                       //   queryBuilder: (ridesNewRecord) {
//                                                                       //     // 👈 NULL SAFETY FIRST!
//                                                                       //     if (_model.pageState == null) {
//                                                                       //       print('⚠️ No date selected - showing ALL rides');
//                                                                       //       return ridesNewRecord;  // No filter
//                                                                       //     }
//                                                                       //
//                                                                       //     // 👈 SAFE RANGE QUERY!
//                                                                       //     final startOfDay = _model.pageState!;
//                                                                       //     final endOfDay = startOfDay.add(Duration(days: 1));
//                                                                       //
//                                                                       //     print('🔍 RANGE: $startOfDay → $endOfDay');
//                                                                       //
//                                                                       //     return ridesNewRecord
//                                                                       //         .where('pickupTime', isGreaterThanOrEqualTo: startOfDay)
//                                                                       //         .where('pickupTime', isLessThan: endOfDay);
//                                                                       //   },
//                                                                       // );
//
//                                                                     }
//                                                                   }(),
//                                                                   builder: (context, snapshot) {
//                                                                     print('📊 SNAPSHOT DATA COUNT: ${snapshot.data?.length ?? 0}');
//                                                                     print('📊 HAS DATA: ${snapshot.hasData}');
//
//                                                                     // Customize what your widget looks like when it's loading.
//                                                                     if (!snapshot.hasData) {
//                                                                       return Center(
//                                                                         child: SizedBox(
//                                                                           width: 50.0,
//                                                                           height: 50.0,
//                                                                           child: SpinKitFadingCircle(
//                                                                             color: Color(0xFF2B3C58),
//                                                                             size: 50.0,
//                                                                           ),
//                                                                         ),
//                                                                       );
//                                                                     }
//                                                                     final rides = snapshot.data!;
//                                                                     print('🚗 TOTAL RIDES FOUND: ${rides.length}');
//
//                                                                     List<RidesNewRecord> listViewRidesNewRecordList = snapshot.data!;

//
//
//
//                                                                     // 👈 FILTER OUT PAST RIDES
//                                                                     final now = DateTime.now();
//                                                                     final futureRides = listViewRidesNewRecordList.where((ride) {
//                                                                       if (ride.pickupTime == null) return false;
//                                                                       // Include rides that are today or in the future
//                                                                       return ride.pickupTime!.isAfter(now) ||
//                                                                           ride.pickupTime!.day == now.day;
//                                                                     }).toList();
//
//                                                                     // Sort again to ensure correct order
//                                                                     futureRides.sort((a, b) {
//                                                                       if (a.pickupTime == null && b.pickupTime == null) return 0;
//                                                                       if (a.pickupTime == null) return 1;
//                                                                       if (b.pickupTime == null) return -1;
//                                                                       return a.pickupTime!.compareTo(b.pickupTime!);
//                                                                     });
//
//
//
//
//
//
//                                                                     // ✅ DEBUG PRINT 2: Show ALL ride data
//                                                                     for (int i = 0; i < listViewRidesNewRecordList.length; i++) {
//                                                                       final ride = listViewRidesNewRecordList[i];
//                                                                       print("🚗 RIDE $i:");
//                                                                       print("   RideStartLocation: '${ride.rideStartLocation}'");
//                                                                       print("   RideEndLocation: '${ride.rideEndLocation}'");
//                                                                       print("   creatorID: ${ride.creatorID}");
//                                                                       print("   travelTime: ${ride.travelTime}");
//                                                                       print("   modeOfTransport: '${ride.modeOfTransport}'");
//                                                                     }
//                                                                     if (listViewRidesNewRecordList.isEmpty) {
//                                                                       print("⏳ LOADING...");
//                                                                       // return NoRideToShowUserWidget();
//                                                                       return NoRideToShowUserWidget(
// // 👈 ADD THIS CALLBACK!
//                                                                         onDateChanged: (DateTime newDate) {
//                                                                           _model.pageState = newDate;
//                                                                           safeSetState(() {});
//                                                                         },
//                                                                       );
//                                                                     }
//
//                                                                     if (_model.isSearchActive) {
//                                                                       // ✅ DEBUG PRINT 1: Query parameters
//                                                                       print("🔍 SEARCH QUERY1 IN HOME_WIDGET: '${_model.searchStartLocation}'");
//                                                                       print("🔍 SEARCH QUERY2 IN HOME_WIDGET: '${_model.searchEndLocation}'");
//
//                                                                       return ListView.separated(
//                                                                         physics: NeverScrollableScrollPhysics(), // Disable internal scroll
//
//                                                                         padding: EdgeInsets.zero,
//                                                                         primary: false,
//                                                                         shrinkWrap: true,
//                                                                         scrollDirection: Axis.vertical,
//                                                                         itemCount: listViewRidesNewRecordList.length,
//                                                                         separatorBuilder: (_, __) => SizedBox(height: 10.0),
//                                                                         itemBuilder: (context, index) {
//                                                                           final ride = listViewRidesNewRecordList[index];
//                                                                           return Stack(
//                                                                             children: [
//                                                                               InkWell(
//                                                                                 splashColor: Colors.transparent,
//                                                                                 focusColor: Colors.transparent,
//                                                                                 hoverColor: Colors.transparent,
//                                                                                 highlightColor: Colors.transparent,
//                                                                                 onTap: () async {
//                                                                                   context.pushNamed(
//                                                                                     RideDetailsCustomerWidget.routeName,
//                                                                                     queryParameters: {
//                                                                                       'rideDetails': serializeParam(
//                                                                                         ride.reference,
//                                                                                         ParamType.DocumentReference,
//                                                                                       ),
//                                                                                     }.withoutNulls,
//                                                                                   );
//                                                                                 },
//                                                                                 child: Material(
//                                                                                   color: Colors.transparent,
//                                                                                   elevation: 10.0,
//                                                                                   shape: RoundedRectangleBorder(
//                                                                                     borderRadius: BorderRadius.circular(12.0),
//                                                                                   ),
//                                                                                   child: ClipRRect(
//                                                                                     borderRadius: BorderRadius.circular(12.0),
//                                                                                     child: Container(
//                                                                                       width: double.infinity,
//                                                                                       // constraints: BoxConstraints(
//                                                                                       //   minHeight: 155.0,  // Min card height
//                                                                                       //   maxHeight: 155.0,  // Max card height
//                                                                                       // ),
//                                                                                       decoration: BoxDecoration(
//                                                                                         color: FlutterFlowTheme.of(context).primaryBackground,
//                                                                                         boxShadow: [
//                                                                                           BoxShadow(
//                                                                                             blurRadius: 4.0,
//                                                                                             color: Color(0x1A000000),
//                                                                                             offset: Offset(
//                                                                                               0.0,
//                                                                                               2.0,
//                                                                                             ),
//                                                                                           )
//                                                                                         ],
//                                                                                         borderRadius: BorderRadius.circular(12.0),
//                                                                                         border: Border.all(
//                                                                                           color: FlutterFlowTheme.of(context).tertiary,
//                                                                                         ),
//                                                                                       ),
//                                                                                       alignment: AlignmentDirectional(1.0, 0.0),
//                                                                                       child: Padding(
//                                                                                         padding: EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 5.0, 10.0),
//                                                                                         child: Column(
//                                                                                           mainAxisSize: MainAxisSize.min, // Takes only needed space
//                                                                                           mainAxisAlignment: MainAxisAlignment.start, // Top alignment
//                                                                                           crossAxisAlignment: CrossAxisAlignment.start, // Left alignment
//                                                                                           children: [
//                                                                                             Row(
//                                                                                               mainAxisSize: MainAxisSize.max,
//                                                                                               mainAxisAlignment: MainAxisAlignment.start,
//                                                                                               children: [
//                                                                                                 Row(
//                                                                                                   mainAxisSize: MainAxisSize.max,
//                                                                                                   children: [
//                                                                                                     Icon(
//                                                                                                       Icons.location_on_outlined,
//                                                                                                       color: FlutterFlowTheme.of(context).primary,
//                                                                                                       size: 24.0,
//                                                                                                     ),
//                                                                                                     ClipRRect(
//                                                                                                       borderRadius: BorderRadius.circular(15.0),
//                                                                                                       child: Container(
//                                                                                                         width: 170.0,
//                                                                                                         decoration: BoxDecoration(
//                                                                                                           color: Color(0xFFE3E6E0),
//                                                                                                           borderRadius: BorderRadius.circular(15.0),
//                                                                                                         ),
//                                                                                                         child: Padding(
//                                                                                                           padding: EdgeInsetsDirectional.fromSTEB(15.0, 5.0, 10.0, 5.0),
//                                                                                                           child: Text(
//                                                                                                             ride.rideStartLocation,
//                                                                                                             style: FlutterFlowTheme.of(context).bodyMedium.override(
//                                                                                                                   font: GoogleFonts.inter(
//                                                                                                                     fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
//                                                                                                                     fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
//                                                                                                                   ),
//                                                                                                                   fontSize: 12.0,
//                                                                                                                   letterSpacing: 0.0,
//                                                                                                                   fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
//                                                                                                                   fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
//                                                                                                                 ),
//                                                                                                           ),
//                                                                                                         ),
//                                                                                                       ),
//                                                                                                     ),
//                                                                                                   ],
//                                                                                                 ),
//                                                                                               ].divide(SizedBox(width: 5.0)),
//                                                                                             ),
//                                                                                             Align(
//                                                                                               alignment: AlignmentDirectional(-1.0, 0.0),
//                                                                                               child: Padding(
//                                                                                                 padding: EdgeInsetsDirectional.fromSTEB(25.0, 0.0, 0.0, 0.0),
//                                                                                                 child: Container(
//                                                                                                   width: 184.9,
//                                                                                                   height: 16.8,
//                                                                                                   decoration: BoxDecoration(),
//                                                                                                   child: Row(
//                                                                                                     mainAxisSize: MainAxisSize.max,
//                                                                                                     children: [
//                                                                                                       if (ride.modeOfTransport == 'Bike')
//                                                                                                         Padding(
//                                                                                                           padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
//                                                                                                           child: Icon(
//                                                                                                             Icons.motorcycle_sharp,
//                                                                                                             color: Color(0xFF8A8888),
//                                                                                                             size: 20.0,
//                                                                                                           ),
//                                                                                                         ),
//                                                                                                       if (ride.modeOfTransport == 'Train')
//                                                                                                         Padding(
//                                                                                                           padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
//                                                                                                           child: Icon(
//                                                                                                             Icons.train,
//                                                                                                             color: Color(0xFF929090),
//                                                                                                             size: 20.0,
//                                                                                                           ),
//                                                                                                         ),
//                                                                                                       if (ride.modeOfTransport == 'Car')
//                                                                                                         Padding(
//                                                                                                           padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
//                                                                                                           child: FaIcon(
//                                                                                                             FontAwesomeIcons.carSide,
//                                                                                                             color: Color(0xFF8F9192),
//                                                                                                             size: 15.0,
//                                                                                                           ),
//                                                                                                         ),
//                                                                                                       if (ride.modeOfTransport == 'Bus')
//                                                                                                         FaIcon(
//                                                                                                           FontAwesomeIcons.bus,
//                                                                                                           color: Color(0xFF919191),
//                                                                                                           size: 15.0,
//                                                                                                         ),
//                                                                                                       Align(
//                                                                                                         alignment: AlignmentDirectional(0.0, 0.0),
//                                                                                                         child: Text(
//                                                                                                           ride.travelTime.isNotEmpty ? ride.travelTime : 'No time',
//                                                                                                           style: FlutterFlowTheme.of(context).labelMedium.override(
//                                                                                                                 font: GoogleFonts.inter(
//                                                                                                                   fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
//                                                                                                                   fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
//                                                                                                                 ),
//                                                                                                                 color: FlutterFlowTheme.of(context).secondaryText,
//                                                                                                                 fontSize: 12.0,
//                                                                                                                 letterSpacing: 0.0,
//                                                                                                                 fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
//                                                                                                                 fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
//                                                                                                               ),
//                                                                                                         ),
//                                                                                                       ),
//                                                                                                     ].divide(SizedBox(width: 5.0)),
//                                                                                                   ),
//                                                                                                 ),
//                                                                                               ),
//                                                                                             ),
//                                                                                             Row(
//                                                                                               mainAxisSize: MainAxisSize.max,
//                                                                                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                                                               children: [
//                                                                                                 Row(
//                                                                                                   mainAxisSize: MainAxisSize.min,
//                                                                                                   children: [
//                                                                                                     Icon(
//                                                                                                       Icons.location_on_outlined,
//                                                                                                       color: FlutterFlowTheme.of(context).primary,
//                                                                                                       size: 24.0,
//                                                                                                     ),
//                                                                                                     Container(
//                                                                                                       width: 170.0,
//                                                                                                       decoration: BoxDecoration(
//                                                                                                         color: Color(0xFFE3E6E0),
//                                                                                                         borderRadius: BorderRadius.circular(15.0),
//                                                                                                       ),
//                                                                                                       child: Padding(
//                                                                                                         padding: EdgeInsetsDirectional.fromSTEB(15.0, 5.0, 10.0, 5.0),
//                                                                                                         child: Text(
//                                                                                                           ride.rideEndLocation,
//                                                                                                           style: FlutterFlowTheme.of(context).bodyMedium.override(
//                                                                                                                 font: GoogleFonts.inter(
//                                                                                                                   fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
//                                                                                                                   fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
//                                                                                                                 ),
//                                                                                                                 fontSize: 12.0,
//                                                                                                                 letterSpacing: 0.0,
//                                                                                                                 fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
//                                                                                                                 fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
//                                                                                                               ),
//                                                                                                         ),
//                                                                                                       ),
//                                                                                                     ),
//                                                                                                   ],
//                                                                                                 ),
//                                                                                               ].divide(SizedBox(width: 5.0)),
//                                                                                             ),
//                                                                                             if (ride.creatorID != null)
//                                                                                               Padding(
//                                                                                                 padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
//                                                                                                 child: StreamBuilder<UsersRecord>(
//                                                                                                   stream: UsersRecord.getDocument(ride.creatorID!),
//                                                                                                   builder: (context, snapshot) {
//                                                                                                     // Customize what your widget looks like when it's loading.
//                                                                                                     if (!snapshot.hasData) {
//                                                                                                       return Center(
//                                                                                                         child: SizedBox(
//                                                                                                           width: 50.0,
//                                                                                                           height: 50.0,
//                                                                                                           child: SpinKitFadingCircle(
//                                                                                                             color: Color(0xFF2B3C58),
//                                                                                                             size: 50.0,
//                                                                                                           ),
//                                                                                                         ),
//                                                                                                       );
//                                                                                                     }
//
//                                                                                                     final rowUsersRecord = snapshot.data!;
//
//                                                                                                     return Row(
//                                                                                                       mainAxisSize: MainAxisSize.max,
//                                                                                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                                                                       children: [
//                                                                                                         Align(
//                                                                                                           alignment: AlignmentDirectional(-1.0, 0.0),
//                                                                                                           child: Container(
//                                                                                                             width: 180.0,
//                                                                                                             decoration: BoxDecoration(),
//                                                                                                             child: Row(
//                                                                                                               mainAxisSize: MainAxisSize.min,
//                                                                                                               mainAxisAlignment: MainAxisAlignment.start,
//                                                                                                               children: [
//                                                                                                                 InkWell(
//                                                                                                                   splashColor: Colors.transparent,
//                                                                                                                   focusColor: Colors.transparent,
//                                                                                                                   hoverColor: Colors.transparent,
//                                                                                                                   highlightColor: Colors.transparent,
//                                                                                                                   onTap: () async {
//                                                                                                                     context.pushNamed(
//                                                                                                                       DriverReviewWidget.routeName,
//                                                                                                                       queryParameters: {
//                                                                                                                         'userRef': serializeParam(
//                                                                                                                           rowUsersRecord.reference,
//                                                                                                                           ParamType.DocumentReference,
//                                                                                                                         ),
//                                                                                                                       }.withoutNulls,
//                                                                                                                     );
//                                                                                                                   },
//                                                                                                                   child: Builder(
//                                                                                                                     builder: (context) {
//                                                                                                                       if (rowUsersRecord.photoUrl != null && rowUsersRecord.photoUrl != '') {
//                                                                                                                         return Container(
//                                                                                                                           width: 30.0,
//                                                                                                                           height: 30.0,
//                                                                                                                           clipBehavior: Clip.antiAlias,
//                                                                                                                           decoration: BoxDecoration(
//                                                                                                                             shape: BoxShape.circle,
//                                                                                                                           ),
//                                                                                                                           child: Image.network(
//                                                                                                                             rowUsersRecord.photoUrl,
//                                                                                                                             fit: BoxFit.cover,
//                                                                                                                           ),
//                                                                                                                         );
//                                                                                                                       } else {
//                                                                                                                         return InkWell(
//                                                                                                                           splashColor: Colors.transparent,
//                                                                                                                           focusColor: Colors.transparent,
//                                                                                                                           hoverColor: Colors.transparent,
//                                                                                                                           highlightColor: Colors.transparent,
//                                                                                                                           onTap: () async {
//                                                                                                                             context.pushNamed(
//                                                                                                                               DriverReviewWidget.routeName,
//                                                                                                                               queryParameters: {
//                                                                                                                                 'userRef': serializeParam(
//                                                                                                                                   rowUsersRecord.reference,
//                                                                                                                                   ParamType.DocumentReference,
//                                                                                                                                 ),
//                                                                                                                               }.withoutNulls,
//                                                                                                                             );
//                                                                                                                           },
//                                                                                                                           child: Container(
//                                                                                                                             width: 30.0,
//                                                                                                                             height: 30.0,
//                                                                                                                             clipBehavior: Clip.antiAlias,
//                                                                                                                             decoration: BoxDecoration(
//                                                                                                                               shape: BoxShape.circle,
//                                                                                                                             ),
//                                                                                                                             child: Image.asset(
//                                                                                                                               'assets/images/userIconTr.png',
//                                                                                                                               fit: BoxFit.cover,
//                                                                                                                             ),
//                                                                                                                           ),
//                                                                                                                         );
//                                                                                                                       }
//                                                                                                                     },
//                                                                                                                   ),
//                                                                                                                 ),
//                                                                                                                 Padding(
//                                                                                                                   padding: EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 5.0, 0.0),
//                                                                                                                   child: Column(
//                                                                                                                     mainAxisSize: MainAxisSize.min,
//                                                                                                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                                                                                                     children: [
//                                                                                                                       Text(
//                                                                                                                         rowUsersRecord.displayName != null && rowUsersRecord.displayName != '' ? rowUsersRecord.displayName : 'Driver',
//                                                                                                                         style: FlutterFlowTheme.of(context).bodyMedium.override(
//                                                                                                                               font: GoogleFonts.inter(
//                                                                                                                                 fontWeight: FontWeight.w600,
//                                                                                                                                 fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
//                                                                                                                               ),
//                                                                                                                               fontSize: 12.0,
//                                                                                                                               letterSpacing: 0.0,
//                                                                                                                               fontWeight: FontWeight.w600,
//                                                                                                                               fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
//                                                                                                                             ),
//                                                                                                                       ),
//                                                                                                                     ],
//                                                                                                                   ),
//                                                                                                                 ),
//                                                                                                               ],
//                                                                                                             ),
//                                                                                                           ),
//                                                                                                         ),
//                                                                                                         Align(
//                                                                                                           alignment: AlignmentDirectional(0.0, 0.0),
//                                                                                                           child: Container(
//                                                                                                             width: 30.0,
//                                                                                                             decoration: BoxDecoration(),
//                                                                                                             child: Padding(
//                                                                                                               padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 5.0, 0.0),
//                                                                                                               child: Stack(
//                                                                                                                 alignment: AlignmentDirectional(0.0, 0.0),
//                                                                                                                 children: [
//                                                                                                                   ClipRRect(
//                                                                                                                     borderRadius: BorderRadius.circular(8.0),
//                                                                                                                     child: Image.asset(
//                                                                                                                       'assets/images/Ride_Search_Icons.png',
//                                                                                                                       width: 25.0,
//                                                                                                                       height: 30.0,
//                                                                                                                       fit: BoxFit.cover,
//                                                                                                                     ),
//                                                                                                                   ),
//                                                                                                                   Text(
//                                                                                                                     valueOrDefault<String>(
//                                                                                                                       formatNumber(
//                                                                                                                         functions.averageRating(rowUsersRecord.ratings.toList()),
//                                                                                                                         formatType: FormatType.compact,
//                                                                                                                       ),
//                                                                                                                       '0',
//                                                                                                                     ),
//                                                                                                                     style: FlutterFlowTheme.of(context).bodyMedium.override(
//                                                                                                                           font: GoogleFonts.inter(
//                                                                                                                             fontWeight: FontWeight.w900,
//                                                                                                                             fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
//                                                                                                                           ),
//                                                                                                                           color: FlutterFlowTheme.of(context).primaryBackground,
//                                                                                                                           fontSize: 9.0,
//                                                                                                                           letterSpacing: 0.0,
//                                                                                                                           fontWeight: FontWeight.w900,
//                                                                                                                           fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
//                                                                                                                         ),
//                                                                                                                   ),
//                                                                                                                 ],
//                                                                                                               ),
//                                                                                                             ),
//                                                                                                           ),
//                                                                                                         ),
//                                                                                                       ].divide(SizedBox(width: 1.0)),
//                                                                                                     );
//                                                                                                   },
//                                                                                                 ),
//                                                                                               ),
//                                                                                           ].divide(SizedBox(height: 12.0)),
//                                                                                         ),
//                                                                                       ),
//                                                                                     ),
//                                                                                   ),
//                                                                                 ),
//                                                                               ),
//                                                                               Align(
//                                                                                 alignment: AlignmentDirectional(0.97, -0.96),
//                                                                                 child: Padding(
//                                                                                   padding: EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 5.0, 0.0),
//                                                                                   child: Container(
//                                                                                     // ✅ RESPONSIVE SIZING
//                                                                                     width: MediaQuery.sizeOf(context).width * 0.12, // 12% of screen width
//                                                                                     constraints: BoxConstraints(
//                                                                                       minWidth: 55.0, // Minimum width
//                                                                                       maxWidth: 70.0, // Maximum width
//                                                                                       minHeight: 85.0, // Minimum height
//                                                                                       maxHeight: 100.0, // Maximum height
//                                                                                     ),
//                                                                                     decoration: BoxDecoration(
//                                                                                       color: Color(0xFFF97E4C),
//                                                                                       borderRadius: BorderRadius.circular(12.0),
//                                                                                     ),
//                                                                                     child: Column(
//                                                                                       mainAxisSize: MainAxisSize.min,
//                                                                                       mainAxisAlignment: MainAxisAlignment.center,
//                                                                                       children: [
//                                                                                         Padding(
//                                                                                           padding: EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
//                                                                                           child: Text(
//                                                                                             'Ride',
//                                                                                             style: FlutterFlowTheme.of(context).bodyMedium.override(
//                                                                                                   font: GoogleFonts.inter(
//                                                                                                     fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
//                                                                                                     fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
//                                                                                                   ),
//                                                                                                   color: FlutterFlowTheme.of(context).info,
//                                                                                                   fontSize: 12.0,
//                                                                                                   letterSpacing: 0.0,
//                                                                                                 ),
//                                                                                           ),
//                                                                                         ),
//                                                                                         Padding(
//                                                                                           padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 4.0),
//                                                                                           child: AutoSizeText(
//                                                                                             '₹${formatNumber(ride.rideCost, formatType: FormatType.custom, format: '', locale: '')}',
//                                                                                             style: FlutterFlowTheme.of(context).bodyMedium.override(
//                                                                                                   font: GoogleFonts.inter(
//                                                                                                     fontWeight: FontWeight.bold,
//                                                                                                     fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
//                                                                                                   ),
//                                                                                                   color: FlutterFlowTheme.of(context).info,
//                                                                                                   fontSize: 15.0,
//                                                                                                   letterSpacing: 0.0,
//                                                                                                   fontWeight: FontWeight.bold,
//                                                                                                 ),
//                                                                                             maxLines: 1,
//                                                                                             minFontSize: 12,
//                                                                                           ),
//                                                                                         ),
//                                                                                         // ✅ Parcel section also responsive
//                                                                                         Container(
//                                                                                           width: double.infinity,
//                                                                                           // ✅ Flexible height
//                                                                                           constraints: BoxConstraints(minHeight: 48.0, maxHeight: 55.0),
//                                                                                           decoration: BoxDecoration(
//                                                                                             color: Color(0xFFFF9561),
//                                                                                             borderRadius: BorderRadius.circular(10.0),
//                                                                                           ),
//                                                                                           child: Column(
//                                                                                             mainAxisSize: MainAxisSize.min,
//                                                                                             mainAxisAlignment: MainAxisAlignment.center,
//                                                                                             children: [
//                                                                                               Padding(
//                                                                                                 padding: EdgeInsetsDirectional.fromSTEB(0.0, 3.0, 0.0, 0.0),
//                                                                                                 child: Text(
//                                                                                                   'Parcel',
//                                                                                                   textAlign: TextAlign.center,
//                                                                                                   style: FlutterFlowTheme.of(context).labelSmall.override(
//                                                                                                         font: GoogleFonts.inter(
//                                                                                                           fontWeight: FontWeight.w500,
//                                                                                                           fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
//                                                                                                         ),
//                                                                                                         color: FlutterFlowTheme.of(context).info,
//                                                                                                         fontSize: 11.0,
//                                                                                                         letterSpacing: 0.0,
//                                                                                                       ),
//                                                                                                 ),
//                                                                                               ),
//                                                                                               AutoSizeText(
//                                                                                                 '₹${ride.totalDeliveryCost}',
//                                                                                                 textAlign: TextAlign.center,
//                                                                                                 style: FlutterFlowTheme.of(context).labelSmall.override(
//                                                                                                       font: GoogleFonts.inter(
//                                                                                                         fontWeight: FontWeight.bold,
//                                                                                                         fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
//                                                                                                       ),
//                                                                                                       color: FlutterFlowTheme.of(context).info,
//                                                                                                       fontSize: 14.0,
//                                                                                                       letterSpacing: 0.0,
//                                                                                                     ),
//                                                                                                 maxLines: 1,
//                                                                                                 minFontSize: 11,
//                                                                                               ),
//                                                                                             ],
//                                                                                           ),
//                                                                                         ),
//                                                                                       ],
//                                                                                     ),
//                                                                                   ),
//                                                                                 ),
//                                                                               ),
//                                                                             ],
//                                                                           );
//                                                                         },
//                                                                       ).animateOnPageLoad(animationsMap['listViewOnPageLoadAnimation']!);
//                                                                     } else {
//                                                                       return ListView.separated(
//                                                                         padding: EdgeInsets.zero,
//                                                                         primary: false,
//                                                                         shrinkWrap: true,
//                                                                         scrollDirection: Axis.vertical,
//                                                                         itemCount: listViewRidesNewRecordList.length,
//                                                                         separatorBuilder: (_, __) => SizedBox(height: 10.0),
//                                                                         itemBuilder: (context, listViewIndex) {
//                                                                           final listViewRidesNewRecord = listViewRidesNewRecordList[listViewIndex];
//                                                                           return Stack(
//                                                                             children: [
//                                                                               InkWell(
//                                                                                 splashColor: Colors.transparent,
//                                                                                 focusColor: Colors.transparent,
//                                                                                 hoverColor: Colors.transparent,
//                                                                                 highlightColor: Colors.transparent,
//                                                                                 onTap: () async {
//                                                                                   context.pushNamed(
//                                                                                     RideDetailsCustomerWidget.routeName,
//                                                                                     queryParameters: {
//                                                                                       'rideDetails': serializeParam(
//                                                                                         listViewRidesNewRecord.reference,
//                                                                                         ParamType.DocumentReference,
//                                                                                       ),
//                                                                                     }.withoutNulls,
//                                                                                   );
//                                                                                 },
//                                                                                 child: Material(
//                                                                                   color: Colors.transparent,
//                                                                                   elevation: 10.0,
//                                                                                   shape: RoundedRectangleBorder(
//                                                                                     borderRadius: BorderRadius.circular(12.0),
//                                                                                   ),
//                                                                                   child: ClipRRect(
//                                                                                     borderRadius: BorderRadius.circular(12.0),
//                                                                                     child: Container(
//                                                                                       width: double.infinity,
//                                                                                       decoration: BoxDecoration(
//                                                                                         color: FlutterFlowTheme.of(context).primaryBackground,
//                                                                                         boxShadow: [
//                                                                                           BoxShadow(
//                                                                                             blurRadius: 4.0,
//                                                                                             color: Color(0x1A000000),
//                                                                                             offset: Offset(
//                                                                                               0.0,
//                                                                                               2.0,
//                                                                                             ),
//                                                                                           )
//                                                                                         ],
//                                                                                         borderRadius: BorderRadius.circular(12.0),
//                                                                                         border: Border.all(
//                                                                                           color: FlutterFlowTheme.of(context).tertiary,
//                                                                                         ),
//                                                                                       ),
//                                                                                       alignment: AlignmentDirectional(1.0, 0.0),
//                                                                                       child: Padding(
//                                                                                         padding: EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 5.0, 10.0),
//                                                                                         child: SizedBox(
//                                                                                           child: Column(
//                                                                                             mainAxisSize: MainAxisSize.min,
//                                                                                             mainAxisAlignment: MainAxisAlignment.center,
//                                                                                             crossAxisAlignment: CrossAxisAlignment.center,
//                                                                                             children: [
//                                                                                               Row(
//                                                                                                 mainAxisSize: MainAxisSize.max,
//                                                                                                 mainAxisAlignment: MainAxisAlignment.start,
//                                                                                                 children: [
//                                                                                                   Row(
//                                                                                                     mainAxisSize: MainAxisSize.max,
//                                                                                                     children: [
//                                                                                                       Icon(
//                                                                                                         Icons.location_on_outlined,
//                                                                                                         color: FlutterFlowTheme.of(context).primary,
//                                                                                                         size: 24.0,
//                                                                                                       ),
//                                                                                                       ClipRRect(
//                                                                                                         borderRadius: BorderRadius.circular(15.0),
//                                                                                                         child: Container(
//                                                                                                           width: 170.0,
//                                                                                                           decoration: BoxDecoration(
//                                                                                                             color: Color(0xFFE3E6E0),
//                                                                                                             borderRadius: BorderRadius.circular(15.0),
//                                                                                                           ),
//                                                                                                           child: Padding(
//                                                                                                             padding: EdgeInsetsDirectional.fromSTEB(15.0, 5.0, 10.0, 5.0),
//                                                                                                             child: Text(
//                                                                                                               listViewRidesNewRecord.rideStartLocation,
//                                                                                                               style: FlutterFlowTheme.of(context).bodyMedium.override(
//                                                                                                                     font: GoogleFonts.inter(
//                                                                                                                       fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
//                                                                                                                       fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
//                                                                                                                     ),
//                                                                                                                     fontSize: 12.0,
//                                                                                                                     letterSpacing: 0.0,
//                                                                                                                     fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
//                                                                                                                     fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
//                                                                                                                   ),
//                                                                                                             ),
//                                                                                                           ),
//                                                                                                         ),
//                                                                                                       ),
//                                                                                                     ],
//                                                                                                   ),
//                                                                                                 ].divide(SizedBox(width: 5.0)),
//                                                                                               ),
//                                                                                               Align(
//                                                                                                 alignment: AlignmentDirectional(-1.0, 0.0),
//                                                                                                 child: Padding(
//                                                                                                   padding: EdgeInsetsDirectional.fromSTEB(25.0, 0.0, 0.0, 0.0),
//                                                                                                   child: Container(
//                                                                                                     width: 184.9,
//                                                                                                     height: 16.8,
//                                                                                                     decoration: BoxDecoration(),
//                                                                                                     child: Row(
//                                                                                                       mainAxisSize: MainAxisSize.min,  // 👈 CRITICAL: min not max!
//                                                                                                       mainAxisAlignment: MainAxisAlignment.start,
//                                                                                                       children: [
//                                                                                                         // 👈 TRANSPORT ICONS (only ONE shows)
//                                                                                                         if (listViewRidesNewRecord.modeOfTransport == 'Bike')
//                                                                                                           Padding(
//                                                                                                             padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 8.0, 0.0),  // 👈 Reduced padding
//                                                                                                             child: Icon(Icons.motorcycle_sharp, color: Color(0xFF8A8888), size: 18.0),  // 👈 Smaller
//                                                                                                           ),
//                                                                                                         if (listViewRidesNewRecord.modeOfTransport == 'Train')
//                                                                                                           Padding(
//                                                                                                             padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 8.0, 0.0),
//                                                                                                             child: Icon(Icons.train, color: Color(0xFF929090), size: 18.0),
//                                                                                                           ),
//                                                                                                         if (listViewRidesNewRecord.modeOfTransport == 'Car')
//                                                                                                           Padding(
//                                                                                                             padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 8.0, 0.0),
//                                                                                                             child: FaIcon(FontAwesomeIcons.carSide, color: Color(0xFF8F9192), size: 14.0),  // 👈 Smaller
//                                                                                                           ),
//                                                                                                         if (listViewRidesNewRecord.modeOfTransport == 'Bus')
//                                                                                                           Padding(
//                                                                                                             padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 8.0, 0.0),
//                                                                                                             child: FaIcon(FontAwesomeIcons.bus, color: Color(0xFF919191), size: 14.0),
//                                                                                                           ),
//
//                                                                                                         // 👈 FLEXIBLE TIME TEXT
//                                                                                                         Flexible(
//                                                                                                           child: Text(
//                                                                                                             '${dateTimeFormat("jm", listViewRidesNewRecord.pickupTime)} । ${dateTimeFormat("yMMMd", listViewRidesNewRecord.pickupTime)}',
//                                                                                                             style: FlutterFlowTheme.of(context).labelMedium.override(
//                                                                                                               fontSize: 11.5,  // 👈 0.5px smaller = fixes 0.421px!
//                                                                                                               color: FlutterFlowTheme.of(context).secondaryText,
//                                                                                                             ),
//                                                                                                             maxLines: 1,
//                                                                                                             overflow: TextOverflow.ellipsis,  // 👈 Truncate if needed
//                                                                                                           ),
//                                                                                                         ),
//                                                                                                       ],
//                                                                                                     ),
//
//                                                                                                   ),
//                                                                                                 ),
//                                                                                               ),
//                                                                                               Row(
//                                                                                                 mainAxisSize: MainAxisSize.max,
//                                                                                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                                                                 children: [
//                                                                                                   Row(
//                                                                                                     mainAxisSize: MainAxisSize.min,
//                                                                                                     children: [
//                                                                                                       Icon(
//                                                                                                         Icons.location_on_outlined,
//                                                                                                         color: FlutterFlowTheme.of(context).primary,
//                                                                                                         size: 24.0,
//                                                                                                       ),
//                                                                                                       Container(
//                                                                                                         width: 170.0,
//                                                                                                         decoration: BoxDecoration(
//                                                                                                           color: Color(0xFFE3E6E0),
//                                                                                                           borderRadius: BorderRadius.circular(15.0),
//                                                                                                         ),
//                                                                                                         child: Padding(
//                                                                                                           padding: EdgeInsetsDirectional.fromSTEB(15.0, 5.0, 10.0, 5.0),
//                                                                                                           child: Text(
//                                                                                                             listViewRidesNewRecord.rideEndLocation,
//                                                                                                             style: FlutterFlowTheme.of(context).bodyMedium.override(
//                                                                                                                   font: GoogleFonts.inter(
//                                                                                                                     fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
//                                                                                                                     fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
//                                                                                                                   ),
//                                                                                                                   fontSize: 12.0,
//                                                                                                                   letterSpacing: 0.0,
//                                                                                                                   fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
//                                                                                                                   fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
//                                                                                                                 ),
//                                                                                                           ),
//                                                                                                         ),
//                                                                                                       ),
//                                                                                                     ],
//                                                                                                   ),
//                                                                                                 ].divide(SizedBox(width: 5.0)),
//                                                                                               ),
//                                                                                               if (listViewRidesNewRecord.creatorID != null)
//                                                                                                 Padding(
//                                                                                                   padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
//                                                                                                   child: StreamBuilder<UsersRecord>(
//                                                                                                     stream: UsersRecord.getDocument(listViewRidesNewRecord.creatorID!),
//                                                                                                     builder: (context, snapshot) {
//                                                                                                       // Customize what your widget looks like when it's loading.
//                                                                                                       if (!snapshot.hasData) {
//                                                                                                         return Center(
//                                                                                                           child: SizedBox(
//                                                                                                             width: 50.0,
//                                                                                                             height: 50.0,
//                                                                                                             child: SpinKitFadingCircle(
//                                                                                                               color: Color(0xFF2B3C58),
//                                                                                                               size: 50.0,
//                                                                                                             ),
//                                                                                                           ),
//                                                                                                         );
//                                                                                                       }
//
//                                                                                                       final rowUsersRecord = snapshot.data!;
//
//                                                                                                       return Row(
//                                                                                                         mainAxisSize: MainAxisSize.max,
//                                                                                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                                                                         children: [
//                                                                                                           // Left section with profile image and name
//                                                                                                           Expanded(  // 👈 CHANGED: Use Expanded to take available space
//                                                                                                             child: Align(
//                                                                                                               alignment: AlignmentDirectional(-1.0, 0.0),
//                                                                                                               child: Container(
//                                                                                                                 constraints: BoxConstraints(maxWidth: double.infinity),  // 👈 CHANGED: Allow full width
//                                                                                                                 decoration: BoxDecoration(),
//                                                                                                                 child: Row(
//                                                                                                                   mainAxisSize: MainAxisSize.min,
//                                                                                                                   mainAxisAlignment: MainAxisAlignment.start,
//                                                                                                                   children: [
//                                                                                                                     InkWell(
//                                                                                                                       splashColor: Colors.transparent,
//                                                                                                                       focusColor: Colors.transparent,
//                                                                                                                       hoverColor: Colors.transparent,
//                                                                                                                       highlightColor: Colors.transparent,
//                                                                                                                       onTap: () => context.pushNamed(
//                                                                                                                         DriverReviewWidget.routeName,
//                                                                                                                         queryParameters: {
//                                                                                                                           'userRef': serializeParam(rowUsersRecord.reference, ParamType.DocumentReference),
//                                                                                                                         }.withoutNulls,
//                                                                                                                       ),
//                                                                                                                       child: Builder(
//                                                                                                                         builder: (context) {
//                                                                                                                           if (rowUsersRecord.photoUrl != null && rowUsersRecord.photoUrl!.isNotEmpty) {
//                                                                                                                             return Container(
//                                                                                                                               width: 30.0,
//                                                                                                                               height: 30.0,
//                                                                                                                               clipBehavior: Clip.antiAlias,
//                                                                                                                               decoration: const BoxDecoration(shape: BoxShape.circle),
//                                                                                                                               child: Image.network(
//                                                                                                                                 rowUsersRecord.photoUrl!,
//                                                                                                                                 fit: BoxFit.cover,
//                                                                                                                                 errorBuilder: (context, error, stackTrace) => Container(
//                                                                                                                                   width: 30.0,
//                                                                                                                                   height: 30.0,
//                                                                                                                                   decoration: BoxDecoration(
//                                                                                                                                     shape: BoxShape.circle,
//                                                                                                                                     color: Colors.grey.shade300,
//                                                                                                                                   ),
//                                                                                                                                   child: Icon(Icons.person, size: 16, color: Colors.grey),
//                                                                                                                                 ),
//                                                                                                                               ),
//                                                                                                                             );
//                                                                                                                           }
//                                                                                                                           return Container(
//                                                                                                                             width: 30.0,
//                                                                                                                             height: 30.0,
//                                                                                                                             clipBehavior: Clip.antiAlias,
//                                                                                                                             decoration: const BoxDecoration(shape: BoxShape.circle),
//                                                                                                                             child: Image.asset('assets/images/userIconTr.png', fit: BoxFit.cover),
//                                                                                                                           );
//                                                                                                                         },
//                                                                                                                       ),
//                                                                                                                     ),
//                                                                                                                     SizedBox(width: 12.0),
//                                                                                                                     // 👈 CHANGED: Use Expanded here too for the name
//                                                                                                                     Expanded(
//                                                                                                                       child: Column(
//                                                                                                                         mainAxisSize: MainAxisSize.min,
//                                                                                                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                                                                                                         children: [
//                                                                                                                           Text(
//                                                                                                                             rowUsersRecord.displayName?.isNotEmpty == true
//                                                                                                                                 ? rowUsersRecord.displayName!
//                                                                                                                                 : 'Driver',
//                                                                                                                             style: FlutterFlowTheme.of(context).bodyMedium.override(
//                                                                                                                               fontFamily: GoogleFonts.inter().fontFamily,
//                                                                                                                               fontWeight: FontWeight.w600,
//                                                                                                                               fontSize: 12.0,  // 👈 CHANGED: Slightly larger font
//                                                                                                                             ),
//                                                                                                                             maxLines: 2,  // 👈 CHANGED: Allow 2 lines if needed
//                                                                                                                             softWrap: true,  // 👈 ADDED: Allow text to wrap
//                                                                                                                             overflow: TextOverflow.visible,  // 👈 CHANGED: No ellipsis
//                                                                                                                           ),
//                                                                                                                         ],
//                                                                                                                       ),
//                                                                                                                     ),
//                                                                                                                   ],
//                                                                                                                 ),
//                                                                                                               ),
//                                                                                                             ),
//                                                                                                           ),
//
//                                                                                                           // Right section with rating
//                                                                                                           Align(
//                                                                                                             alignment: AlignmentDirectional(0.0, 0.0),
//                                                                                                             child: Container(
//                                                                                                               width: 40.0,  // 👈 CHANGED: Slightly wider
//                                                                                                               decoration: BoxDecoration(),
//                                                                                                               child: Padding(
//                                                                                                                 padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 5.0, 0.0),
//                                                                                                                 child: Stack(
//                                                                                                                   alignment: AlignmentDirectional(0.0, 0.0),
//                                                                                                                   children: [
//                                                                                                                     ClipRRect(
//                                                                                                                       borderRadius: BorderRadius.circular(8.0),
//                                                                                                                       child: Image.asset(
//                                                                                                                         'assets/images/Ride_Search_Icons.png',
//                                                                                                                         width: 30.0,  // 👈 CHANGED: Slightly larger
//                                                                                                                         height: 30.0,
//                                                                                                                         fit: BoxFit.cover,
//                                                                                                                       ),
//                                                                                                                     ),
//                                                                                                                     Text(
//                                                                                                                       valueOrDefault<String>(
//                                                                                                                         formatNumber(
//                                                                                                                           functions.averageRating(rowUsersRecord.ratings.toList()),
//                                                                                                                           formatType: FormatType.compact,
//                                                                                                                         ),
//                                                                                                                         '0',
//                                                                                                                       ),
//                                                                                                                       style: FlutterFlowTheme.of(context).bodyMedium.override(
//                                                                                                                         font: GoogleFonts.inter(
//                                                                                                                           fontWeight: FontWeight.w900,
//                                                                                                                         ),
//                                                                                                                         color: FlutterFlowTheme.of(context).primaryBackground,
//                                                                                                                         fontSize: 10.0,  // 👈 CHANGED: Slightly larger
//                                                                                                                         letterSpacing: 0.0,
//                                                                                                                         fontWeight: FontWeight.w900,
//                                                                                                                       ),
//                                                                                                                     ),
//                                                                                                                   ],
//                                                                                                                 ),
//                                                                                                               ),
//                                                                                                             ),
//                                                                                                           ),
//                                                                                                         ],
//                                                                                                       );
//                                                                                                     },
//                                                                                                   ),
//                                                                                                 ),
//                                                                                             ].divide(SizedBox(height: 12.0)),
//                                                                                           ),
//                                                                                         ),
//                                                                                       ),
//                                                                                     ),
//                                                                                   ),
//                                                                                 ),
//                                                                               ).animateOnPageLoad(animationsMap['containerOnPageLoadAnimation2']!),
//                                                                               Align(
//                                                                                 alignment: AlignmentDirectional(0.97, -0.96),
//                                                                                 child: Padding(
//                                                                                   padding: EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 5.0, 0.0),
//                                                                                   child: Container(
//                                                                                     // ✅ RESPONSIVE SIZING
//                                                                                     width: MediaQuery.sizeOf(context).width * 0.12, // 12% of screen width
//                                                                                     constraints: BoxConstraints(
//                                                                                       minWidth: 55.0, // Minimum width
//                                                                                       maxWidth: 70.0, // Maximum width
//                                                                                       minHeight: 85.0, // Minimum height
//                                                                                       maxHeight: 100.0, // Maximum height
//                                                                                     ),
//                                                                                     decoration: BoxDecoration(
//                                                                                       color: Color(0xFFF97E4C),
//                                                                                       borderRadius: BorderRadius.circular(12.0),
//                                                                                     ),
//                                                                                     child: Column(
//                                                                                       mainAxisSize: MainAxisSize.min,
//                                                                                       mainAxisAlignment: MainAxisAlignment.center,
//                                                                                       children: [
//                                                                                         Padding(
//                                                                                           padding: EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
//                                                                                           child: Text(
//                                                                                             'Ride',
//                                                                                             style: FlutterFlowTheme.of(context).bodyMedium.override(
//                                                                                                   font: GoogleFonts.inter(
//                                                                                                     fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
//                                                                                                     fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
//                                                                                                   ),
//                                                                                                   color: FlutterFlowTheme.of(context).info,
//                                                                                                   fontSize: 12.0,
//                                                                                                   letterSpacing: 0.0,
//                                                                                                 ),
//                                                                                           ),
//                                                                                         ),
//                                                                                         Padding(
//                                                                                           padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 4.0),
//                                                                                           child: AutoSizeText(
//                                                                                             '₹${formatNumber(listViewRidesNewRecord.pricePerPassengers, formatType: FormatType.custom, format: '', locale: '')}',
//                                                                                             style: FlutterFlowTheme.of(context).bodyMedium.override(
//                                                                                                   font: GoogleFonts.inter(
//                                                                                                     fontWeight: FontWeight.bold,
//                                                                                                     fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
//                                                                                                   ),
//                                                                                                   color: FlutterFlowTheme.of(context).info,
//                                                                                                   fontSize: 15.0,
//                                                                                                   letterSpacing: 0.0,
//                                                                                                   fontWeight: FontWeight.bold,
//                                                                                                 ),
//                                                                                             maxLines: 1,
//                                                                                             minFontSize: 12,
//                                                                                           ),
//                                                                                         ),
//                                                                                         // ✅ Parcel section also responsive
//                                                                                         Container(
//                                                                                           width: double.infinity,
//                                                                                           // ✅ Flexible height
//                                                                                           constraints: BoxConstraints(minHeight: 48.0, maxHeight: 55.0),
//                                                                                           decoration: BoxDecoration(
//                                                                                             color: Color(0xFFFF9561),
//                                                                                             borderRadius: BorderRadius.circular(10.0),
//                                                                                           ),
//                                                                                           child: Column(
//                                                                                             mainAxisSize: MainAxisSize.min,
//                                                                                             mainAxisAlignment: MainAxisAlignment.center,
//                                                                                             children: [
//                                                                                               Padding(
//                                                                                                 padding: EdgeInsetsDirectional.fromSTEB(0.0, 3.0, 0.0, 0.0),
//                                                                                                 child: Text(
//                                                                                                   'Parcel',
//                                                                                                   textAlign: TextAlign.center,
//                                                                                                   style: FlutterFlowTheme.of(context).labelSmall.override(
//                                                                                                         font: GoogleFonts.inter(
//                                                                                                           fontWeight: FontWeight.w500,
//                                                                                                           fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
//                                                                                                         ),
//                                                                                                         color: FlutterFlowTheme.of(context).info,
//                                                                                                         fontSize: 11.0,
//                                                                                                         letterSpacing: 0.0,
//                                                                                                       ),
//                                                                                                 ),
//                                                                                               ),
//                                                                                               AutoSizeText(
//                                                                                                 '₹${listViewRidesNewRecord.totalDeliveryCost}',
//                                                                                                 textAlign: TextAlign.center,
//                                                                                                 style: FlutterFlowTheme.of(context).labelSmall.override(
//                                                                                                       font: GoogleFonts.inter(
//                                                                                                         fontWeight: FontWeight.bold,
//                                                                                                         fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
//                                                                                                       ),
//                                                                                                       color: FlutterFlowTheme.of(context).info,
//                                                                                                       fontSize: 14.0,
//                                                                                                       letterSpacing: 0.0,
//                                                                                                     ),
//                                                                                                 maxLines: 1,
//                                                                                                 minFontSize: 11,
//                                                                                               ),
//                                                                                             ],
//                                                                                           ),
//                                                                                         ),
//                                                                                       ],
//                                                                                     ),
//                                                                                   ),
//                                                                                 ),
//                                                                               ),
//                                                                             ],
//                                                                           );
//                                                                         },
//                                                                       ).animateOnPageLoad(animationsMap['listViewOnPageLoadAnimation']!);
//                                                                     }
//                                                                   },
//                                                                 ),
//                                                               ].divide(SizedBox(height: 16.0)).addToEnd(SizedBox(height: 15.0)),
//                                                             ),
//                                                           ),
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ],
//                                       ),
                                      SingleChildScrollView(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                children: [
                                                  Text(
                                                    'Check By Status',
                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                          font: GoogleFonts.inter(
                                                            fontWeight: FontWeight.w600,
                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                          ),
                                                          fontSize: 16.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight: FontWeight.w600,
                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                        ),
                                                  ),
                                                  FlutterFlowDropDown<String>(
                                                    controller: _model.bookingDropDownValueController ??= FormFieldController<String>(
                                                      _model.bookingDropDownValue ??= _model.myBookingStatus,
                                                    ),
                                                    options: ['All Bookings', 'Pending', 'Accepted', 'Completed', 'Rejected'],
                                                    onChanged: (val) async {
                                                      safeSetState(() => _model.bookingDropDownValue = val);
                                                      _model.myBookingStatus = _model.bookingDropDownValue!;
                                                      safeSetState(() {});
                                                    },
                                                    width: 200.0,
                                                    height: 40.0,
                                                    textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                                          font: GoogleFonts.inter(
                                                            fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                          ),
                                                          letterSpacing: 0.0,
                                                          fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                        ),
                                                    hintText: 'Select Status...',
                                                    icon: Icon(
                                                      Icons.keyboard_arrow_down_rounded,
                                                      color: FlutterFlowTheme.of(context).secondaryText,
                                                      size: 24.0,
                                                    ),
                                                    fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                                                    elevation: 2.0,
                                                    borderColor: FlutterFlowTheme.of(context).primaryText,
                                                    borderWidth: 0.0,
                                                    borderRadius: 8.0,
                                                    margin: EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 12.0, 0.0),
                                                    hidesUnderline: true,
                                                    isOverButton: false,
                                                    isSearchable: false,
                                                    isMultiSelect: false,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            if (_model.myBookingStatus == 'All Bookings')
                                              SizedBox(
                                                child: Padding(
                                                  padding: EdgeInsets.all(10.0),
                                                  child: StreamBuilder<List<BookingsRecord>>(
                                                    stream: queryBookingsRecord(
                                                      queryBuilder: (bookingsRecord) => bookingsRecord.where(
                                                        'creator',
                                                        isEqualTo: currentUserReference,
                                                      ),
                                                    ),
                                                    builder: (context, snapshot) {
                                                      // Customize what your widget looks like when it's loading.
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
                                                      List<BookingsRecord> allBookingsBookingsRecordList = snapshot.data!;
                                                      if (allBookingsBookingsRecordList.isEmpty) {
                                                        return NoAnyBidsByUsersWidget();
                                                      }

                                                      return ListView.separated(
                                                        padding: EdgeInsets.zero,
                                                        primary: false,
                                                        shrinkWrap: true,
                                                        scrollDirection: Axis.vertical,
                                                        itemCount: allBookingsBookingsRecordList.length,
                                                        separatorBuilder: (_, __) => SizedBox(height: 15.0),
                                                        itemBuilder: (context, allBookingsIndex) {
                                                          final allBookingsBookingsRecord = allBookingsBookingsRecordList[allBookingsIndex];
                                                          return StreamBuilder<RidesNewRecord>(
                                                            stream: RidesNewRecord.getDocument(allBookingsBookingsRecord.rideID!),
                                                            builder: (context, snapshot) {
                                                              // Customize what your widget looks like when it's loading.
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

                                                              final containerRidesNewRecord = snapshot.data!;

                                                              return StreamBuilder<UsersRecord>(
                                                                stream: UsersRecord.getDocument(containerRidesNewRecord.creatorID ?? allBookingsBookingsRecord.creator!),
                                                                builder: (context, snapshot) {
                                                                  if (!snapshot.hasData) {
                                                                    return Center(
                                                                      child: SizedBox(
                                                                        width: 50.0,
                                                                        height: 50.0,
                                                                        child: SpinKitFadingCircle(
                                                                          color: const Color(0xFF2B3C58),
                                                                          size: 50.0,
                                                                        ),
                                                                      ),
                                                                    );
                                                                  }
                                                                  final columnUsersRecord = snapshot.data!;
                                                                  return _buildBookingCard(
                                                                    allBookingsBookingsRecord,
                                                                    containerRidesNewRecord,
                                                                    columnUsersRecord,
                                                                  );
                                                                },
                                                              );
                                                            },
                                                          );
                                                        },
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ),
                                            if (_model.myBookingStatus == 'Pending')
                                              SizedBox(
                                                child: Padding(
                                                  padding: EdgeInsets.all(10.0),
                                                  child: StreamBuilder<List<BookingsRecord>>(
                                                    stream: queryBookingsRecord(
                                                      queryBuilder: (bookingsRecord) => bookingsRecord
                                                          .where(
                                                            'creator',
                                                            isEqualTo: currentUserReference,
                                                          )
                                                          .where(
                                                            'status',
                                                            isEqualTo: 'Pending',
                                                          ),
                                                    ),
                                                    builder: (context, snapshot) {
                                                      // Customize what your widget looks like when it's loading.
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
                                                      List<BookingsRecord> pendingBookingsRecordList = snapshot.data!;
                                                      if (pendingBookingsRecordList.isEmpty) {
                                                        return NoAnyBidsByUsersWidget();
                                                      }

                                                      return ListView.separated(
                                                        padding: EdgeInsets.zero,
                                                        primary: false,
                                                        shrinkWrap: true,
                                                        scrollDirection: Axis.vertical,
                                                        itemCount: pendingBookingsRecordList.length,
                                                        separatorBuilder: (_, __) => SizedBox(height: 15.0),
                                                        itemBuilder: (context, pendingIndex) {
                                                          final pendingBookingsRecord = pendingBookingsRecordList[pendingIndex];
                                                          return StreamBuilder<RidesNewRecord>(
                                                            stream: RidesNewRecord.getDocument(pendingBookingsRecord.rideID!),
                                                            builder: (context, snapshot) {
                                                              // Customize what your widget looks like when it's loading.
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

                                                              final containerRidesNewRecord = snapshot.data!;

                                                              return StreamBuilder<UsersRecord>(
                                                                stream: UsersRecord.getDocument(containerRidesNewRecord.creatorID ?? pendingBookingsRecord.creator!),
                                                                builder: (context, snapshot) {
                                                                  if (!snapshot.hasData) {
                                                                    return Center(
                                                                      child: SizedBox(
                                                                        width: 50.0,
                                                                        height: 50.0,
                                                                        child: SpinKitFadingCircle(
                                                                          color: const Color(0xFF2B3C58),
                                                                          size: 50.0,
                                                                        ),
                                                                      ),
                                                                    );
                                                                  }
                                                                  final columnUsersRecord = snapshot.data!;
                                                                  return _buildBookingCard(
                                                                    pendingBookingsRecord,
                                                                    containerRidesNewRecord,
                                                                    columnUsersRecord,
                                                                  );
                                                                },
                                                              );
                                                            },
                                                          );
                                                        },
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ),
                                            if (_model.myBookingStatus == 'Accepted')
                                              SizedBox(
                                                child: Padding(
                                                  padding: EdgeInsets.all(10.0),
                                                  child: StreamBuilder<List<BookingsRecord>>(
                                                    stream: queryBookingsRecord(
                                                      queryBuilder: (bookingsRecord) => bookingsRecord
                                                          .where(
                                                            'creator',
                                                            isEqualTo: currentUserReference,
                                                          )
                                                          .where(
                                                            'status',
                                                            isEqualTo: 'Accepted',
                                                          ),
                                                    ),
                                                    builder: (context, snapshot) {
                                                      // Customize what your widget looks like when it's loading.
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
                                                      List<BookingsRecord> acceptedBookingsRecordList = snapshot.data!;
                                                      if (acceptedBookingsRecordList.isEmpty) {
                                                        return NoAnyBidsByUsersWidget();
                                                      }

                                                      return ListView.separated(
                                                        padding: EdgeInsets.zero,
                                                        primary: false,
                                                        shrinkWrap: true,
                                                        scrollDirection: Axis.vertical,
                                                        itemCount: acceptedBookingsRecordList.length,
                                                        separatorBuilder: (_, __) => SizedBox(height: 15.0),
                                                        itemBuilder: (context, acceptedIndex) {
                                                          final acceptedBookingsRecord = acceptedBookingsRecordList[acceptedIndex];
                                                          return StreamBuilder<RidesNewRecord>(
                                                            stream: RidesNewRecord.getDocument(acceptedBookingsRecord.rideID!),
                                                            builder: (context, snapshot) {
                                                              // Customize what your widget looks like when it's loading.
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

                                                              final containerRidesNewRecord = snapshot.data!;

                                                              return StreamBuilder<UsersRecord>(
                                                                stream: UsersRecord.getDocument(containerRidesNewRecord.creatorID ?? acceptedBookingsRecord.creator!),
                                                                builder: (context, snapshot) {
                                                                  if (!snapshot.hasData) {
                                                                    return Center(
                                                                      child: SizedBox(
                                                                        width: 50.0,
                                                                        height: 50.0,
                                                                        child: SpinKitFadingCircle(
                                                                          color: const Color(0xFF2B3C58),
                                                                          size: 50.0,
                                                                        ),
                                                                      ),
                                                                    );
                                                                  }
                                                                  final columnUsersRecord = snapshot.data!;
                                                                  return _buildBookingCard(
                                                                    acceptedBookingsRecord,
                                                                    containerRidesNewRecord,
                                                                    columnUsersRecord,
                                                                  );
                                                                },
                                                              );
                                                            },
                                                          );
                                                        },
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ),
                                            if (_model.myBookingStatus == 'Completed')
                                              SizedBox(
                                                child: Padding(
                                                  padding: EdgeInsets.all(10.0),
                                                  child: StreamBuilder<List<BookingsRecord>>(
                                                    stream: queryBookingsRecord(
                                                      queryBuilder: (bookingsRecord) => bookingsRecord
                                                          .where(
                                                            'creator',
                                                            isEqualTo: currentUserReference,
                                                          )
                                                          .where(
                                                            'status',
                                                            isEqualTo: 'Completed',
                                                          ),
                                                    ),
                                                    builder: (context, snapshot) {
                                                      // Customize what your widget looks like when it's loading.
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
                                                      List<BookingsRecord> completedBookingsRecordList = snapshot.data!;
                                                      if (completedBookingsRecordList.isEmpty) {
                                                        return NoAnyBidsByUsersWidget();
                                                      }

                                                      return ListView.separated(
                                                        padding: EdgeInsets.zero,
                                                        primary: false,
                                                        shrinkWrap: true,
                                                        scrollDirection: Axis.vertical,
                                                        itemCount: completedBookingsRecordList.length,
                                                        separatorBuilder: (_, __) => SizedBox(height: 15.0),
                                                        itemBuilder: (context, completedIndex) {
                                                          final completedBookingsRecord = completedBookingsRecordList[completedIndex];
                                                          return StreamBuilder<RidesNewRecord>(
                                                            stream: RidesNewRecord.getDocument(completedBookingsRecord.rideID!),
                                                            builder: (context, snapshot) {
                                                              // Customize what your widget looks like when it's loading.
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

                                                              final containerRidesNewRecord = snapshot.data!;

                                                              return StreamBuilder<UsersRecord>(
                                                                stream: UsersRecord.getDocument(containerRidesNewRecord.creatorID ?? completedBookingsRecord.creator!),
                                                                builder: (context, snapshot) {
                                                                  if (!snapshot.hasData) {
                                                                    return Center(
                                                                      child: SizedBox(
                                                                        width: 50.0,
                                                                        height: 50.0,
                                                                        child: SpinKitFadingCircle(
                                                                          color: const Color(0xFF2B3C58),
                                                                          size: 50.0,
                                                                        ),
                                                                      ),
                                                                    );
                                                                  }
                                                                  final columnUsersRecord = snapshot.data!;
                                                                  return _buildBookingCard(
                                                                    completedBookingsRecord,
                                                                    containerRidesNewRecord,
                                                                    columnUsersRecord,
                                                                  );
                                                                },
                                                              );
                                                            },
                                                          );
                                                        },
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ),
                                            if (_model.myBookingStatus == 'Rejected')
                                              SizedBox(
                                                child: Padding(
                                                  padding: EdgeInsets.all(10.0),
                                                  child: StreamBuilder<List<BookingsRecord>>(
                                                    stream: queryBookingsRecord(
                                                      queryBuilder: (bookingsRecord) => bookingsRecord
                                                          .where(
                                                            'creator',
                                                            isEqualTo: currentUserReference,
                                                          )
                                                          .where(
                                                            'status',
                                                            isEqualTo: 'Rejected',
                                                          ),
                                                    ),
                                                    builder: (context, snapshot) {
                                                      // Customize what your widget looks like when it's loading.
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
                                                      List<BookingsRecord> rejectedBookingsRecordList = snapshot.data!;
                                                      if (rejectedBookingsRecordList.isEmpty) {
                                                        return NoAnyBidsByUsersWidget();
                                                      }

                                                      return ListView.separated(
                                                        padding: EdgeInsets.zero,
                                                        primary: false,
                                                        shrinkWrap: true,
                                                        scrollDirection: Axis.vertical,
                                                        itemCount: rejectedBookingsRecordList.length,
                                                        separatorBuilder: (_, __) => SizedBox(height: 15.0),
                                                        itemBuilder: (context, rejectedIndex) {
                                                          final rejectedBookingsRecord = rejectedBookingsRecordList[rejectedIndex];
                                                          return StreamBuilder<RidesNewRecord>(
                                                            stream: RidesNewRecord.getDocument(rejectedBookingsRecord.rideID!),
                                                            builder: (context, snapshot) {
                                                              // Customize what your widget looks like when it's loading.
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

                                                              final containerRidesNewRecord = snapshot.data!;

                                                              return StreamBuilder<UsersRecord>(
                                                                stream: UsersRecord.getDocument(containerRidesNewRecord.creatorID ?? rejectedBookingsRecord.creator!),
                                                                builder: (context, snapshot) {
                                                                  if (!snapshot.hasData) {
                                                                    return Center(
                                                                      child: SizedBox(
                                                                        width: 50.0,
                                                                        height: 50.0,
                                                                        child: SpinKitFadingCircle(
                                                                          color: const Color(0xFF2B3C58),
                                                                          size: 50.0,
                                                                        ),
                                                                      ),
                                                                    );
                                                                  }
                                                                  final columnUsersRecord = snapshot.data!;
                                                                  return _buildBookingCard(
                                                                    rejectedBookingsRecord,
                                                                    containerRidesNewRecord,
                                                                    columnUsersRecord,
                                                                  );
                                                                },
                                                              );
                                                            },
                                                          );
                                                        },
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                      SingleChildScrollView(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                children: [
                                                  Text(
                                                    'Check By Status',
                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                          font: GoogleFonts.inter(
                                                            fontWeight: FontWeight.w600,
                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                          ),
                                                          fontSize: 16.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight: FontWeight.w600,
                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                        ),
                                                  ),
                                                  FlutterFlowDropDown<String>(
                                                    controller: _model.postedRidesDropDownValueController ??= FormFieldController<String>(
                                                      _model.postedRidesDropDownValue ??= _model.myBookingStatus,
                                                    ),
                                                    options: ['All', 'Live', 'Under Review', 'Rejected'],
                                                    onChanged: (val) async {
                                                      safeSetState(() {
                                                        _model.postedRidesDropDownValue = val;
                                                        _model.myRidesStatus = val == 'All' ? 'All Rides' : (val ?? 'All Rides');
                                                      });
                                                    },
                                                    width: 200.0,
                                                    height: 40.0,
                                                    textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                                          font: GoogleFonts.inter(
                                                            fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                          ),
                                                          letterSpacing: 0.0,
                                                          fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                        ),
                                                    hintText: 'Select Status...',
                                                    icon: Icon(
                                                      Icons.keyboard_arrow_down_rounded,
                                                      color: FlutterFlowTheme.of(context).secondaryText,
                                                      size: 24.0,
                                                    ),
                                                    fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                                                    elevation: 2.0,
                                                    borderColor: FlutterFlowTheme.of(context).primaryText,
                                                    borderWidth: 0.0,
                                                    borderRadius: 8.0,
                                                    margin: EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 12.0, 0.0),
                                                    hidesUnderline: true,
                                                    isOverButton: false,
                                                    isSearchable: false,
                                                    isMultiSelect: false,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            if (_model.myRidesStatus == 'All Rides')
                                              SizedBox(
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional.fromSTEB(5.0, 10.0, 5.0, 10.0),
                                                  child: StreamBuilder<List<RidesNewRecord>>(
                                                    stream: queryRidesNewRecord(
                                                      queryBuilder: (ridesNewRecord) {
                                                        final now = DateTime.now();
                                                        final today = DateTime(now.year, now.month, now.day);

                                                        return ridesNewRecord
                                                            .where(
                                                          'creatorID',
                                                          isEqualTo: currentUserReference,
                                                        )
                                                            .where('pickupTime', isGreaterThanOrEqualTo: today)  // 👈 ADD THIS LINE
                                                            .orderBy('pickupTime', descending: false);  // 👈 MODIFY THIS (false = nearest first)
                                                      },
                                                    ),
                                                    builder: (context, snapshot) {
                                                      // Customize what your widget looks like when it's loading.
                                                      if (!snapshot.hasData) {
                                                        return Image.asset(
                                                          'assets/images/Car_Gif.gif',
                                                        );
                                                      }
                                                      List<RidesNewRecord> allRidesRidesNewRecordList = snapshot.data!;
                                                      if (allRidesRidesNewRecordList.isEmpty) {
                                                        return NoRidePostedWidget();
                                                      }

                                                      // return ListView.separated(
                                                      //   padding: EdgeInsets.zero,
                                                      //   primary: false,
                                                      //   shrinkWrap: true,
                                                      //   scrollDirection: Axis.vertical,
                                                      //   itemCount: allRidesRidesNewRecordList.length,
                                                      //   separatorBuilder: (_, __) => SizedBox(height: 15.0),
                                                      //   itemBuilder: (context, allRidesIndex) {
                                                      //     final allRidesRidesNewRecord = allRidesRidesNewRecordList[allRidesIndex];
                                                      //     return StreamBuilder<UsersRecord>(
                                                      //       stream: UsersRecord.getDocument(allRidesRidesNewRecord.creatorID!),
                                                      //       builder: (context, snapshot) {
                                                      //         // Customize what your widget looks like when it's loading.
                                                      //         if (!snapshot.hasData) {
                                                      //           return Center(
                                                      //             child: SizedBox(
                                                      //               width: 50.0,
                                                      //               height: 50.0,
                                                      //               child: SpinKitFadingCircle(
                                                      //                 color: Color(0xFF2B3C58),
                                                      //                 size: 50.0,
                                                      //               ),
                                                      //             ),
                                                      //           );
                                                      //         }
                                                      //
                                                      //         final containerUsersRecord = snapshot.data!;
                                                      //
                                                      //         return InkWell(
                                                      //           splashColor: Colors.transparent,
                                                      //           focusColor: Colors.transparent,
                                                      //           hoverColor: Colors.transparent,
                                                      //           highlightColor: Colors.transparent,
                                                      //           onTap: () async {
                                                      //             context.pushNamed(
                                                      //               RideDetailsCustomerWidget.routeName,
                                                      //               queryParameters: {
                                                      //                 'rideDetails': serializeParam(
                                                      //                   allRidesRidesNewRecord.reference,
                                                      //                   ParamType.DocumentReference,
                                                      //                 ),
                                                      //               }.withoutNulls,
                                                      //             );
                                                      //           },
                                                      //           child: Container(
                                                      //             width: double.infinity,
                                                      //             decoration: BoxDecoration(
                                                      //               color: Color(0xFFF4F4F4),
                                                      //               boxShadow: [
                                                      //                 BoxShadow(
                                                      //                   blurRadius: 4.0,
                                                      //                   color: Color(0x1A000000),
                                                      //                   offset: Offset(
                                                      //                     0.0,
                                                      //                     2.0,
                                                      //                   ),
                                                      //                 )
                                                      //               ],
                                                      //               borderRadius: BorderRadius.circular(12.0),
                                                      //               border: Border.all(
                                                      //                 color: Color(0xFF4DABF7),
                                                      //               ),
                                                      //             ),
                                                      //             child: Padding(
                                                      //               padding: EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 5.0, 10.0),
                                                      //               child: Column(
                                                      //                 mainAxisSize: MainAxisSize.min,
                                                      //                 crossAxisAlignment: CrossAxisAlignment.start,
                                                      //                 children: [
                                                      //                   Row(
                                                      //                     mainAxisSize: MainAxisSize.max,
                                                      //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      //                     children: [
                                                      //                       Row(
                                                      //                         mainAxisSize: MainAxisSize.max,
                                                      //                         children: [
                                                      //                           Icon(
                                                      //                             Icons.location_on_outlined,
                                                      //                             color: FlutterFlowTheme.of(context).primary,
                                                      //                             size: 24.0,
                                                      //                           ),
                                                      //                           Container(
                                                      //                             width: 200.0,
                                                      //                             decoration: BoxDecoration(
                                                      //                               color: Color(0xFFE3E6E0),
                                                      //                               borderRadius: BorderRadius.circular(15.0),
                                                      //                             ),
                                                      //                             child: Padding(
                                                      //                               padding: EdgeInsetsDirectional.fromSTEB(15.0, 5.0, 10.0, 5.0),
                                                      //                               child: Text(
                                                      //                                 _truncateAddress(allRidesRidesNewRecord.rideStartLocation),
                                                      //                                 style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                      //                                       font: GoogleFonts.inter(
                                                      //                                         fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                      //                                         fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                      //                                       ),
                                                      //                                       fontSize: 12.0,
                                                      //                                       letterSpacing: 0.0,
                                                      //                                       fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                      //                                       fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                      //                                     ),
                                                      //                               ),
                                                      //                             ),
                                                      //                           ),
                                                      //                         ],
                                                      //                       ),
                                                      //                       if (allRidesRidesNewRecord.modeOfTransport == 'Car')
                                                      //                         Padding(
                                                      //                           padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
                                                      //                           child: FaIcon(
                                                      //                             FontAwesomeIcons.carSide,
                                                      //                             color: Color(0xFF8F9192),
                                                      //                             size: 20.0,
                                                      //                           ),
                                                      //                         ),
                                                      //                       if (allRidesRidesNewRecord.modeOfTransport == 'Train')
                                                      //                         Padding(
                                                      //                           padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
                                                      //                           child: Icon(
                                                      //                             Icons.train,
                                                      //                             color: Color(0xFF929090),
                                                      //                             size: 30.0,
                                                      //                           ),
                                                      //                         ),
                                                      //                       if (allRidesRidesNewRecord.modeOfTransport == 'Bike')
                                                      //                         Padding(
                                                      //                           padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
                                                      //                           child: Icon(
                                                      //                             Icons.motorcycle_sharp,
                                                      //                             color: Color(0xFF8A8888),
                                                      //                             size: 30.0,
                                                      //                           ),
                                                      //                         ),
                                                      //                       if (allRidesRidesNewRecord.modeOfTransport == 'Bus')
                                                      //                         Padding(
                                                      //                           padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
                                                      //                           child: FaIcon(
                                                      //                             FontAwesomeIcons.bus,
                                                      //                             color: Color(0xFF919191),
                                                      //                             size: 20.0,
                                                      //                           ),
                                                      //                         ),
                                                      //                     ].divide(SizedBox(width: 5.0)),
                                                      //                   ),
                                                      //                   Align(
                                                      //                     alignment: AlignmentDirectional(0.0, 0.0),
                                                      //                     child: Row(
                                                      //                       mainAxisSize: MainAxisSize.max,
                                                      //                       mainAxisAlignment: MainAxisAlignment.center,
                                                      //                       children: [
                                                      //                         Align(
                                                      //                           alignment: AlignmentDirectional(0.0, 0.0),
                                                      //                           child: Text(
                                                      //                             'Travel time: ',
                                                      //                             style: FlutterFlowTheme.of(context).labelMedium.override(
                                                      //                                   font: GoogleFonts.inter(
                                                      //                                     fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
                                                      //                                     fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                      //                                   ),
                                                      //                                   color: FlutterFlowTheme.of(context).secondaryText,
                                                      //                                   fontSize: 12.0,
                                                      //                                   letterSpacing: 0.0,
                                                      //                                   fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
                                                      //                                   fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                      //                                 ),
                                                      //                           ),
                                                      //                         ),
                                                      //                         Align(
                                                      //                           alignment: AlignmentDirectional(0.0, 0.0),
                                                      //                           child: Text(
                                                      //                             allRidesRidesNewRecord.travelTime,
                                                      //                             style: FlutterFlowTheme.of(context).labelMedium.override(
                                                      //                                   font: GoogleFonts.inter(
                                                      //                                     fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
                                                      //                                     fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                      //                                   ),
                                                      //                                   color: FlutterFlowTheme.of(context).secondaryText,
                                                      //                                   fontSize: 12.0,
                                                      //                                   letterSpacing: 0.0,
                                                      //                                   fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
                                                      //                                   fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                      //                                 ),
                                                      //                           ),
                                                      //                         ),
                                                      //                       ],
                                                      //                     ),
                                                      //                   ),
                                                      //                   Row(
                                                      //                     mainAxisSize: MainAxisSize.max,
                                                      //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      //                     children: [
                                                      //                       Row(
                                                      //                         mainAxisSize: MainAxisSize.max,
                                                      //                         children: [
                                                      //                           Icon(
                                                      //                             Icons.location_on_outlined,
                                                      //                             color: FlutterFlowTheme.of(context).primary,
                                                      //                             size: 24.0,
                                                      //                           ),
                                                      //                           Container(
                                                      //                             width: 200.0,
                                                      //                             decoration: BoxDecoration(
                                                      //                               color: Color(0xFFE3E6E0),
                                                      //                               borderRadius: BorderRadius.circular(15.0),
                                                      //                             ),
                                                      //                             child: Padding(
                                                      //                               padding: EdgeInsetsDirectional.fromSTEB(15.0, 5.0, 10.0, 5.0),
                                                      //                               child: Text(
                                                      //                                 _truncateAddress(allRidesRidesNewRecord.rideEndLocation),
                                                      //                                 style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                      //                                       font: GoogleFonts.inter(
                                                      //                                         fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                      //                                         fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                      //                                       ),
                                                      //                                       fontSize: 12.0,
                                                      //                                       letterSpacing: 0.0,
                                                      //                                       fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                      //                                       fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                      //                                     ),
                                                      //                               ),
                                                      //                             ),
                                                      //                           ),
                                                      //                         ],
                                                      //                       ),
                                                      //                     ].divide(SizedBox(width: 5.0)),
                                                      //                   ),
                                                      //                   Row(
                                                      //                     mainAxisSize: MainAxisSize.max,
                                                      //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      //                     children: [
                                                      //                       Row(
                                                      //                         mainAxisSize: MainAxisSize.max,
                                                      //                         children: [
                                                      //                           Container(
                                                      //                             width: 40.0,
                                                      //                             height: 40.0,
                                                      //                             decoration: BoxDecoration(
                                                      //                               color: FlutterFlowTheme.of(context).secondaryBackground,
                                                      //                               // image:
                                                      //                               //     DecorationImage(
                                                      //                               //   fit: BoxFit.cover,
                                                      //                               //   image: Image.asset(
                                                      //                               //     "assets/images/profileIcon.png",
                                                      //                               //   ).image,
                                                      //                               // ),
                                                      //                               shape: BoxShape.circle,
                                                      //                               border: Border.all(
                                                      //                                 color: Color(0xFF4DABF7),
                                                      //                                 width: 2.0,
                                                      //                               ),
                                                      //                             ),
                                                      //                             child: Container(
                                                      //                                 width: 200.0,
                                                      //                                 height: 200.0,
                                                      //                                 clipBehavior: Clip.antiAlias,
                                                      //                                 decoration: BoxDecoration(
                                                      //                                   shape: BoxShape.circle,
                                                      //                                 ),
                                                      //                                 child: CachedNetworkImage(
                                                      //                                     imageUrl: containerUsersRecord.photoUrl ?? '',
                                                      //                                     fit: BoxFit.cover,
                                                      //                                     fadeInDuration: const Duration(milliseconds: 500),
                                                      //                                     fadeOutDuration: const Duration(milliseconds: 500),
                                                      //                                     placeholder: (context, url) => const Center(
                                                      //                                           child: CircularProgressIndicator(),
                                                      //                                         ),
                                                      //                                     errorWidget: (context, url, error) => SizedBox.shrink())),
                                                      //                           ),
                                                      //                           Padding(
                                                      //                             padding: EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 12.0, 0.0),
                                                      //                             child: Column(
                                                      //                               mainAxisSize: MainAxisSize.min,
                                                      //                               crossAxisAlignment: CrossAxisAlignment.start,
                                                      //                               children: [
                                                      //                                 Text(
                                                      //                                   containerUsersRecord.displayName,
                                                      //                                   style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                      //                                         font: GoogleFonts.inter(
                                                      //                                           fontWeight: FontWeight.w600,
                                                      //                                           fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                      //                                         ),
                                                      //                                         letterSpacing: 0.0,
                                                      //                                         fontWeight: FontWeight.w600,
                                                      //                                         fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                      //                                       ),
                                                      //                                 ),
                                                      //                               ],
                                                      //                             ),
                                                      //                           ),
                                                      //                           Stack(
                                                      //                             alignment: AlignmentDirectional(0.0, 0.0),
                                                      //                             children: [
                                                      //                               ClipRRect(
                                                      //                                 borderRadius: BorderRadius.circular(8.0),
                                                      //                                 child: Image.asset(
                                                      //                                   'assets/images/Ride_Search_Icons.png',
                                                      //                                   width: 34.0,
                                                      //                                   height: 35.8,
                                                      //                                   fit: BoxFit.cover,
                                                      //                                 ),
                                                      //                               ),
                                                      //                               Text(
                                                      //                                 '4.8',
                                                      //                                 style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                      //                                       font: GoogleFonts.inter(
                                                      //                                         fontWeight: FontWeight.w900,
                                                      //                                         fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                      //                                       ),
                                                      //                                       color: FlutterFlowTheme.of(context).accent4,
                                                      //                                       fontSize: 10.0,
                                                      //                                       letterSpacing: 0.0,
                                                      //                                       fontWeight: FontWeight.w900,
                                                      //                                       fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                      //                                     ),
                                                      //                               ),
                                                      //                             ],
                                                      //                           ),
                                                      //                         ],
                                                      //                       ),
                                                      //                       Padding(
                                                      //                         padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 15.0, 0.0),
                                                      //                         child: Container(
                                                      //                           width: 50.0,
                                                      //                           height: 50.0,
                                                      //                           decoration: BoxDecoration(
                                                      //                             color: Color(0xFFF77F4A),
                                                      //                             shape: BoxShape.circle,
                                                      //                           ),
                                                      //                           child: Align(
                                                      //                             alignment: AlignmentDirectional(0.0, 0.0),
                                                      //                             child: Text(
                                                      //                               allRidesRidesNewRecord.totalDeliveryCost,
                                                      //                               textAlign: TextAlign.center,
                                                      //                               style: FlutterFlowTheme.of(context).titleMedium.override(
                                                      //                                     font: GoogleFonts.interTight(
                                                      //                                       fontWeight: FontWeight.w500,
                                                      //                                       fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                      //                                     ),
                                                      //                                     color: Colors.white,
                                                      //                                     fontSize: 14.0,
                                                      //                                     letterSpacing: 0.0,
                                                      //                                     fontWeight: FontWeight.w500,
                                                      //                                     fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                      //                                   ),
                                                      //                             ),
                                                      //                           ),
                                                      //                         ),
                                                      //                       ),
                                                      //                     ],
                                                      //                   ),
                                                      //                   Row(
                                                      //                     mainAxisSize: MainAxisSize.max,
                                                      //                     mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                      //                     children: [
                                                      //                       Text(
                                                      //                         'Current Status:',
                                                      //                         style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                      //                               font: GoogleFonts.inter(
                                                      //                                 fontWeight: FontWeight.w600,
                                                      //                                 fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                      //                               ),
                                                      //                               fontSize: 16.0,
                                                      //                               letterSpacing: 0.0,
                                                      //                               fontWeight: FontWeight.w600,
                                                      //                               fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                      //                             ),
                                                      //                       ),
                                                      //                       Text(
                                                      //                         allRidesRidesNewRecord.rideStatus,
                                                      //                         style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                      //                               font: GoogleFonts.inter(
                                                      //                                 fontWeight: FontWeight.w600,
                                                      //                                 fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                      //                               ),
                                                      //                               fontSize: 16.0,
                                                      //                               letterSpacing: 0.0,
                                                      //                               fontWeight: FontWeight.w600,
                                                      //                               fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                      //                             ),
                                                      //                       ),
                                                      //                     ],
                                                      //                   ),
                                                      //                   if (allRidesRidesNewRecord.rideStatus != 'Under Review')
                                                      //                     Row(
                                                      //                       mainAxisSize: MainAxisSize.max,
                                                      //                       mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                      //                       children: [
                                                      //                         InkWell(
                                                      //                           splashColor: Colors.transparent,
                                                      //                           focusColor: Colors.transparent,
                                                      //                           hoverColor: Colors.transparent,
                                                      //                           highlightColor: Colors.transparent,
                                                      //                           onTap: () async {
                                                      //                             await allRidesRidesNewRecord.reference.delete();
                                                      //                           },
                                                      //                           child: Icon(
                                                      //                             Icons.delete,
                                                      //                             color: Color(0xFFDC0A46),
                                                      //                             size: 24.0,
                                                      //                           ),
                                                      //                         ),
                                                      //                         FFButtonWidget(
                                                      //                           onPressed: () async {
                                                      //                             context.pushNamed(
                                                      //                               RideEditPageWidget.routeName,
                                                      //                               queryParameters: {
                                                      //                                 'rideEdit': serializeParam(
                                                      //                                   allRidesRidesNewRecord.reference,
                                                      //                                   ParamType.DocumentReference,
                                                      //                                 ),
                                                      //                               }.withoutNulls,
                                                      //                             );
                                                      //                           },
                                                      //                           text: 'Edit',
                                                      //                           options: FFButtonOptions(
                                                      //                             width: 80.5,
                                                      //                             height: 26.2,
                                                      //                             padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                                                      //                             iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                      //                             color: FlutterFlowTheme.of(context).accent3,
                                                      //                             textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                                      //                                   font: GoogleFonts.inter(
                                                      //                                     fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                      //                                     fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                      //                                   ),
                                                      //                                   color: FlutterFlowTheme.of(context).primaryText,
                                                      //                                   letterSpacing: 0.0,
                                                      //                                   fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                      //                                   fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                      //                                 ),
                                                      //                             elevation: 0.0,
                                                      //                             borderSide: BorderSide(
                                                      //                               color: FlutterFlowTheme.of(context).accent3,
                                                      //                               width: 1.0,
                                                      //                             ),
                                                      //                             borderRadius: BorderRadius.circular(8.0),
                                                      //                           ),
                                                      //                         ),
                                                      //                       ],
                                                      //                     ),
                                                      //                 ].divide(SizedBox(height: 12.0)),
                                                      //               ),
                                                      //             ),
                                                      //           ),
                                                      //         );
                                                      //       },
                                                      //     );
                                                      //   },
                                                      // );

                                                      return ListView.separated(
                                                        padding: EdgeInsets.zero,
                                                        primary: false,
                                                        shrinkWrap: true,
                                                        scrollDirection: Axis.vertical,
                                                        itemCount: allRidesRidesNewRecordList.length,
                                                        separatorBuilder: (_, __) => SizedBox(height: 10.0),
                                                        itemBuilder: (context, allRidesIndex) {
                                                          final allRidesRidesNewRecord = allRidesRidesNewRecordList[allRidesIndex];
                                                             return _buildMyListedRideCard(allRidesRidesNewRecord);
                                                        },
                                                      ).animateOnPageLoad(animationsMap['listViewOnPageLoadAnimation']!);
                                                    },
                                                  ),
                                                ),
                                              ),
                                            if (_model.myRidesStatus == 'Live')
                                              SizedBox(
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional.fromSTEB(5.0, 10.0, 5.0, 10.0),
                                                  child: StreamBuilder<List<RidesNewRecord>>(
                                                    stream: queryRidesNewRecord(
                                                      queryBuilder: (ridesNewRecord) => ridesNewRecord
                                                          .where(
                                                            'rideStatus',
                                                            isEqualTo: 'Live',
                                                          )
                                                          .where(
                                                            'creatorID',
                                                            isEqualTo: currentUserReference,
                                                          )
                                                          .orderBy('pickupTime'),
                                                    ),
                                                    builder: (context, snapshot) {
                                                      // Customize what your widget looks like when it's loading.
                                                      if (!snapshot.hasData) {
                                                        return Image.asset(
                                                          'assets/images/Car_Gif.gif',
                                                        );
                                                      }
                                                      List<RidesNewRecord> liveRidesRidesNewRecordList = snapshot.data!;
                                                      if (liveRidesRidesNewRecordList.isEmpty) {
                                                        return NoRidePostedWidget();
                                                      }

                                                      return ListView.separated(
                                                        padding: EdgeInsets.zero,
                                                        primary: false,
                                                        shrinkWrap: true,
                                                        scrollDirection: Axis.vertical,
                                                        itemCount: liveRidesRidesNewRecordList.length,
                                                        separatorBuilder: (_, __) => SizedBox(height: 15.0),
                                                        itemBuilder: (context, liveRidesIndex) {
                                                          final liveRidesRidesNewRecord = liveRidesRidesNewRecordList[liveRidesIndex];
                                                             return _buildMyListedRideCard(liveRidesRidesNewRecord);
                                                        },
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ),
                                            if (_model.myRidesStatus == 'Under Review')
                                              SizedBox(
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional.fromSTEB(5.0, 10.0, 5.0, 10.0),
                                                  child: StreamBuilder<List<RidesNewRecord>>(
                                                    stream: queryRidesNewRecord(
                                                      queryBuilder: (ridesNewRecord) => ridesNewRecord
                                                          .where(
                                                            'rideStatus',
                                                            isEqualTo: 'Under Review',
                                                          )
                                                          .where(
                                                            'creatorID',
                                                            isEqualTo: currentUserReference,
                                                          )
                                                          .orderBy('pickupTime'),
                                                    ),
                                                    builder: (context, snapshot) {
                                                      // Customize what your widget looks like when it's loading.
                                                      if (!snapshot.hasData) {
                                                        return Image.asset(
                                                          'assets/images/Car_Gif.gif',
                                                        );
                                                      }
                                                      List<RidesNewRecord> underReviewRidesNewRecordList = snapshot.data!;
                                                      if (underReviewRidesNewRecordList.isEmpty) {
                                                        return NoRidePostedWidget();
                                                      }

                                                      return ListView.separated(
                                                        padding: EdgeInsets.zero,
                                                        primary: false,
                                                        shrinkWrap: true,
                                                        scrollDirection: Axis.vertical,
                                                        itemCount: underReviewRidesNewRecordList.length,
                                                        separatorBuilder: (_, __) => SizedBox(height: 15.0),
                                                        itemBuilder: (context, underReviewIndex) {
                                                          final underReviewRidesNewRecord = underReviewRidesNewRecordList[underReviewIndex];
                                                             return _buildMyListedRideCard(underReviewRidesNewRecord);
                                                        },
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ),
                                            if (_model.myRidesStatus == 'Rejected')
                                              SizedBox(
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional.fromSTEB(5.0, 10.0, 5.0, 10.0),
                                                  child: StreamBuilder<List<RidesNewRecord>>(
                                                    stream: queryRidesNewRecord(
                                                      queryBuilder: (ridesNewRecord) => ridesNewRecord
                                                          .where(
                                                            'rideStatus',
                                                            isEqualTo: 'Rejected',
                                                          )
                                                          .where(
                                                            'creatorID',
                                                            isEqualTo: currentUserReference,
                                                          )
                                                          .orderBy('pickupTime'),
                                                    ),
                                                    builder: (context, snapshot) {
                                                      // Customize what your widget looks like when it's loading.
                                                      if (!snapshot.hasData) {
                                                        return Image.asset(
                                                          'assets/images/Car_Gif.gif',
                                                        );
                                                      }
                                                      List<RidesNewRecord> rejectedRidesNewRecordList = snapshot.data!;
                                                      if (rejectedRidesNewRecordList.isEmpty) {
                                                        return NoRidePostedWidget();
                                                      }

                                                      return ListView.separated(
                                                        padding: EdgeInsets.zero,
                                                        primary: false,
                                                        shrinkWrap: true,
                                                        scrollDirection: Axis.vertical,
                                                        itemCount: rejectedRidesNewRecordList.length,
                                                        separatorBuilder: (_, __) => SizedBox(height: 15.0),
                                                        itemBuilder: (context, rejectedIndex) {
                                                          final rejectedRidesNewRecord = rejectedRidesNewRecordList[rejectedIndex];
                                                             return _buildMyListedRideCard(rejectedRidesNewRecord);
                                                        },
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                wrapWithModel(
                  model: _model.mainFooterModel,
                  updateCallback: () => safeSetState(() {}),
                  child: MainFooterWidget(),
                ).animateOnPageLoad(animationsMap['mainFooterOnPageLoadAnimation']!),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
