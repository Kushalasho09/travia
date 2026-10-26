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

  bool _locationsMatch(String routeLoc, String queryLoc) {
    final r = routeLoc.trim().toLowerCase();
    final q = queryLoc.trim().toLowerCase();
    if (r.isEmpty || q.isEmpty) return false;

    // 1. Direct contains in either direction
    // e.g. "bulandshahr, uttar pradesh, india".contains("bulandshahr") -> true
    // or "bulandshahr".contains("bulandshahr") -> true
    if (r.contains(q) || q.contains(r)) return true;

    // 2. Primary place/city name (first segment before comma)
    final rCity = r.split(',').first.trim();
    final qCity = q.split(',').first.trim();
    if (rCity.isNotEmpty && qCity.isNotEmpty) {
      if (rCity.contains(qCity) || qCity.contains(rCity)) return true;
    }

    // 3. Significant word token matching (min 3 chars, ignores commas/spaces)
    final rTokens = r
        .split(RegExp(r'[\s,.-]+'))
        .map((w) => w.trim())
        .where((w) => w.length >= 3)
        .toSet();
    final qTokens = q
        .split(RegExp(r'[\s,.-]+'))
        .map((w) => w.trim())
        .where((w) => w.length >= 3)
        .toSet();
    if (rTokens.intersection(qTokens).isNotEmpty) return true;

    return false;
  }

  double _calculateHomeSegmentPrice(RidesNewRecord ride) {
    if (!_model.isSearchActive ||
        _model.searchStartLocation == null ||
        _model.searchEndLocation == null) {
      return ride.pricePerPassengers.toDouble();
    }
    final startQuery = _model.searchStartLocation!.trim();
    final endQuery = _model.searchEndLocation!.trim();
    if (startQuery.isEmpty || endQuery.isEmpty) return ride.pricePerPassengers.toDouble();

    final route = [
      ride.rideStartLocation ?? '',
      if (ride.googleStartAddress != null && ride.googleStartAddress!.isNotEmpty) ride.googleStartAddress!,
      ...ride.stoppages,
      ride.rideEndLocation ?? '',
      if (ride.googleEndAddress != null && ride.googleEndAddress!.isNotEmpty) ride.googleEndAddress!,
    ];

    int sIdx = -1;
    for (int i = 0; i < route.length; i++) {
      if (_locationsMatch(route[i], startQuery)) {
        sIdx = i;
        break;
      }
    }
    int eIdx = -1;
    for (int i = route.length - 1; i >= 0; i--) {
      if (_locationsMatch(route[i], endQuery)) {
        eIdx = i;
        break;
      }
    }

    if (sIdx != -1 && eIdx != -1 && sIdx < eIdx) {
      int totalSegments = route.length - 1;
      if (totalSegments <= 0) return ride.pricePerPassengers.toDouble();
      double fraction = (eIdx - sIdx) / totalSegments;
      final fullPrice = ride.pricePerPassengers.toDouble();
      return (fullPrice * fraction).clamp(1.0, fullPrice).roundToDouble();
    }
    return ride.pricePerPassengers.toDouble();
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

  Widget _buildDetailPill({
    required IconData icon,
    required String label,
    required Color color,
    Color? backgroundColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      decoration: BoxDecoration(
        color: backgroundColor ?? const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(
          color: backgroundColor != null ? color.withOpacity(0.2) : const Color(0xFFE5E7EB),
          width: 0.8,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12.5, color: color),
          const SizedBox(width: 5.0),
          Flexible(
            child: Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 11.5,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF374151),
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _confirmDeleteRide(BuildContext context, RidesNewRecord ride) async {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFFEE2E2),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: const Icon(Icons.delete_outline_rounded, color: Color(0xFFDC2626), size: 22.0),
              ),
              const SizedBox(width: 10.0),
              Text(
                'Delete Ride?',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w700,
                  fontSize: 18.0,
                  color: const Color(0xFF1E293B),
                ),
              ),
            ],
          ),
          content: Text(
            'Are you sure you want to permanently delete this ride? This action cannot be undone.',
            style: GoogleFonts.inter(
              fontSize: 14.0,
              color: const Color(0xFF64748B),
              height: 1.4,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text(
                'Cancel',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF64748B),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.of(dialogContext).pop();
                await ride.reference.delete();
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Ride deleted!'),
                      backgroundColor: Color(0xFFFF9561),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFDC2626),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10.0),
                elevation: 0,
              ),
              child: Text(
                'Delete',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                  fontSize: 14.0,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildMyListedRideCard(RidesNewRecord ride) {
    final rawStatus = ride.rideStatus.trim();
    final statusText = rawStatus.isEmpty ? 'Under Review' : rawStatus;

    Color statusBg;
    Color statusBorder;
    Color statusFg;
    IconData statusIcon;

    if (statusText == 'Live') {
      statusBg = const Color(0xFFECFDF5);
      statusBorder = const Color(0xFFA7F3D0);
      statusFg = const Color(0xFF059669);
      statusIcon = Icons.check_circle_rounded;
    } else if (statusText == 'Rejected') {
      statusBg = const Color(0xFFFEF2F2);
      statusBorder = const Color(0xFFFECACA);
      statusFg = const Color(0xFFDC2626);
      statusIcon = Icons.cancel_rounded;
    } else {
      statusBg = const Color(0xFFFFFBEB);
      statusBorder = const Color(0xFFFDE68A);
      statusFg = const Color(0xFFD97706);
      statusIcon = Icons.schedule_rounded;
    }

    final departureStr = ride.pickupTime != null
        ? dateTimeFormat("hh:mm a", ride.pickupTime).toLowerCase()
        : 'N/A';
    final arrivalStr = ride.dropTime != null
        ? dateTimeFormat("hh:mm a", ride.dropTime).toLowerCase()
        : 'N/A';
    final dateStr = ride.pickupTime != null
        ? dateTimeFormat("yMMMd", ride.pickupTime)
        : '';

    Widget modeIcon;
    if (ride.modeOfTransport == 'Bike') {
      modeIcon = const Icon(Icons.two_wheeler_rounded, color: Color(0xFFEE7B4D), size: 18.0);
    } else if (ride.modeOfTransport == 'Train') {
      modeIcon = const Icon(Icons.train_rounded, color: Color(0xFFEE7B4D), size: 18.0);
    } else if (ride.modeOfTransport == 'Bus') {
      modeIcon = const FaIcon(FontAwesomeIcons.bus, color: Color(0xFFEE7B4D), size: 16.0);
    } else {
      modeIcon = const FaIcon(FontAwesomeIcons.carSide, color: Color(0xFFEE7B4D), size: 16.0);
    }

    return InkWell(
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
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22.0),
          border: Border.all(color: const Color(0xFFE5E7EB), width: 1.0),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0C2C3550),
              blurRadius: 16.0,
              offset: Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Header: Circular Mode Icon + Mode Name/Departure + Status Badge
            Row(
              children: [
                Container(
                  width: 40.0,
                  height: 40.0,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFFF0E9),
                    shape: BoxShape.circle,
                  ),
                  child: Center(child: modeIcon),
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        ride.modeOfTransport.isNotEmpty ? ride.modeOfTransport : 'Ride Share',
                        style: GoogleFonts.inter(
                          fontSize: 14.5,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF1F2937),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2.0),
                      Text(
                        dateStr.isNotEmpty
                            ? '$dateStr • Dep $departureStr'
                            : 'Dep $departureStr ${arrivalStr != 'N/A' ? "• Arr $arrivalStr" : ""}',
                        style: GoogleFonts.inter(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF6B7280),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8.0),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                  decoration: BoxDecoration(
                    color: statusBg,
                    borderRadius: BorderRadius.circular(30.0),
                    border: Border.all(color: statusBorder, width: 0.8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(statusIcon, size: 12.0, color: statusFg),
                      const SizedBox(width: 4.0),
                      Text(
                        statusText,
                        style: GoogleFonts.inter(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w600,
                          color: statusFg,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14.0),

            // Route Card Container
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: const Color(0xFFF9FAFB),
                borderRadius: BorderRadius.circular(14.0),
                border: Border.all(color: const Color(0xFFF1F5F9), width: 1.0),
              ),
              child: Column(
                children: [
                  // Origin
                  Row(
                    children: [
                      Container(
                        width: 9.0,
                        height: 9.0,
                        decoration: const BoxDecoration(
                          color: Color(0xFF10B981),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      Expanded(
                        child: Text(
                          _truncateAddress(ride.rideStartLocation),
                          style: GoogleFonts.inter(
                            fontSize: 13.5,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF1F2937),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 3.5),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        width: 2.0,
                        height: 14.0,
                        color: const Color(0xFFE5E7EB),
                      ),
                    ),
                  ),
                  // Destination
                  Row(
                    children: [
                      Container(
                        width: 9.0,
                        height: 9.0,
                        decoration: const BoxDecoration(
                          color: Color(0xFFEE7B4D),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      Expanded(
                        child: Text(
                          _truncateAddress(ride.rideEndLocation),
                          style: GoogleFonts.inter(
                            fontSize: 13.5,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF1F2937),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12.0),

            // Specs & Pricing Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Wrap(
                    spacing: 6.0,
                    runSpacing: 4.0,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 9.0, vertical: 4.0),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF3F4F6),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.event_seat_rounded, size: 12.5, color: Color(0xFF4B5563)),
                            const SizedBox(width: 4.0),
                            Text(
                              '${ride.numPassengers} seats',
                              style: GoogleFonts.inter(
                                fontSize: 11.5,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF374151),
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (ride.numBagAllowed > 0)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 9.0, vertical: 4.0),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF3F4F6),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.luggage_rounded, size: 12.5, color: Color(0xFF4B5563)),
                              const SizedBox(width: 4.0),
                              Text(
                                '${ride.numBagAllowed} bags',
                                style: GoogleFonts.inter(
                                  fontSize: 11.5,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF374151),
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(width: 8.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          '₹${formatNumber(ride.pricePerPassengers, formatType: FormatType.custom, format: '', locale: '')}',
                          style: GoogleFonts.inter(
                            fontSize: 16.5,
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFF111827),
                          ),
                        ),
                        Text(
                          ' /seat',
                          style: GoogleFonts.inter(
                            fontSize: 11.0,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF6B7280),
                          ),
                        ),
                      ],
                    ),
                    if (ride.totalDeliveryCost.isNotEmpty && ride.totalDeliveryCost != '0')
                      Text(
                        'Parcel: ₹${ride.totalDeliveryCost}',
                        style: GoogleFonts.inter(
                          fontSize: 11.0,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFFEE7B4D),
                        ),
                      ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 12.0),
            const Divider(height: 1.0, thickness: 0.8, color: Color(0xFFF1F5F9)),
            const SizedBox(height: 10.0),

            // Action Toolbar Footer
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 28.0,
                      height: 28.0,
                      decoration: const BoxDecoration(
                        color: Color(0xFFFFF0E9),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 11.0,
                        color: Color(0xFFEE7B4D),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Text(
                      'View Ride Details',
                      style: GoogleFonts.inter(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFFEE7B4D),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    // Edit Button
                    InkWell(
                      onTap: () async {
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
                      borderRadius: BorderRadius.circular(10.0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF3F4F6),
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(color: const Color(0xFFE5E7EB), width: 0.8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.edit_outlined, size: 14.0, color: Color(0xFF374151)),
                            const SizedBox(width: 4.0),
                            Text(
                              'Edit',
                              style: GoogleFonts.inter(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF374151),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    // Delete Button
                    InkWell(
                      onTap: () => _confirmDeleteRide(context, ride),
                      borderRadius: BorderRadius.circular(10.0),
                      child: Container(
                        padding: const EdgeInsets.all(7.0),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFEF2F2),
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(color: const Color(0xFFFECACA), width: 0.8),
                        ),
                        child: const Icon(
                          Icons.delete_outline_rounded,
                          size: 16.0,
                          color: Color(0xFFDC2626),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBookingCard(BookingsRecord booking, RidesNewRecord ride, UsersRecord creator) {
    final bookingStatus = (booking.status.isNotEmpty ? booking.status : 'Pending').trim();
    Color statusBg;
    Color statusBorder;
    Color statusFg;
    IconData statusIcon;

    if (bookingStatus == 'Accepted') {
      statusBg = const Color(0xFFECFDF5);
      statusBorder = const Color(0xFFA7F3D0);
      statusFg = const Color(0xFF059669);
      statusIcon = Icons.check_circle_rounded;
    } else if (bookingStatus == 'Completed') {
      statusBg = const Color(0xFFEFF6FF);
      statusBorder = const Color(0xFFBFDBFE);
      statusFg = const Color(0xFF2563EB);
      statusIcon = Icons.task_alt_rounded;
    } else if (bookingStatus == 'Rejected') {
      statusBg = const Color(0xFFFEF2F2);
      statusBorder = const Color(0xFFFECACA);
      statusFg = const Color(0xFFDC2626);
      statusIcon = Icons.cancel_rounded;
    } else {
      statusBg = const Color(0xFFFFFBEB);
      statusBorder = const Color(0xFFFDE68A);
      statusFg = const Color(0xFFD97706);
      statusIcon = Icons.schedule_rounded;
    }

    final creatorName = creator.displayName.trim().isNotEmpty
        ? creator.displayName.trim()
        : (creator.userName.trim().isNotEmpty
            ? creator.userName.trim()
            : 'Ride Host');

    final itemName = booking.itemName.trim();
    final bookingType = booking.bookingType.trim();
    final receiverName = booking.receiverName.trim();
    final passengerName = booking.rideNameOfPerson.trim();
    final phoneNum = booking.phoneNumber.isNotEmpty
        ? booking.phoneNumber
        : booking.ridePersonContactNumber;
    final meetupAddr = booking.meetupLocation.isNotEmpty
        ? booking.meetupLocation
        : booking.rideMeetupAddress;
    final addInfo = booking.additionalInformation.isNotEmpty
        ? booking.additionalInformation
        : booking.rideAdditionalInformation;
    final isParcel = bookingType.toLowerCase().contains('parcel') || itemName.isNotEmpty;

    final hasRideRoute = ride.rideStartLocation.isNotEmpty;
    final startLoc = _truncateAddress(ride.rideStartLocation);
    final endLoc = _truncateAddress(ride.rideEndLocation);
    final ridePickupTimeStr = ride.pickupTime != null
        ? '${dateTimeFormat("hh:mm a", ride.pickupTime)} • ${dateTimeFormat("yMMMd", ride.pickupTime)}'
        : '';

    final requestedTimeStr = booking.createdTime != null
        ? '${dateTimeFormat("hh:mm a", booking.createdTime)} • ${dateTimeFormat("dd MMM yyyy", booking.createdTime)}'
        : '';

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22.0),
        border: Border.all(color: const Color(0xFFE5E7EB), width: 1.0),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0C2C3550),
            blurRadius: 16.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Creator Bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            decoration: const BoxDecoration(
              color: Color(0xFFF9FAFB),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(22.0),
                topRight: Radius.circular(22.0),
              ),
              border: Border(bottom: BorderSide(color: Color(0xFFF1F5F9), width: 1.0)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        width: 38.0,
                        height: 38.0,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: const Color(0xFFE5E7EB), width: 1.5),
                        ),
                        child: creator.photoUrl.trim().isNotEmpty
                            ? CachedNetworkImage(
                                imageUrl: creator.photoUrl,
                                fit: BoxFit.cover,
                                placeholder: (_, __) => const SizedBox(),
                                errorWidget: (_, __, ___) => Image.asset('assets/images/userIconTr.png', fit: BoxFit.cover),
                              )
                            : Image.asset('assets/images/userIconTr.png', fit: BoxFit.cover),
                      ),
                      const SizedBox(width: 10.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              creatorName,
                              style: GoogleFonts.inter(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF1E293B),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 2.0),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.verified_user_rounded,
                                  size: 12.0,
                                  color: Color(0xFFEE7B4D),
                                ),
                                const SizedBox(width: 3.0),
                                Text(
                                  'Ride Host',
                                  style: GoogleFonts.inter(
                                    fontSize: 11.5,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFF64748B),
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
                const SizedBox(width: 8.0),
                // Status Pill
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                  decoration: BoxDecoration(
                    color: statusBg,
                    borderRadius: BorderRadius.circular(30.0),
                    border: Border.all(color: statusBorder, width: 0.8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(statusIcon, size: 12.0, color: statusFg),
                      const SizedBox(width: 4.0),
                      Text(
                        bookingStatus,
                        style: GoogleFonts.inter(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w600,
                          color: statusFg,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Card Content Body
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Route Card (if ride route exists)
                if (hasRideRoute) ...[
                  Container(
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF9FAFB),
                      borderRadius: BorderRadius.circular(14.0),
                      border: Border.all(color: const Color(0xFFF1F5F9), width: 1.0),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 9.0,
                              height: 9.0,
                              decoration: const BoxDecoration(
                                color: Color(0xFF10B981),
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 10.0),
                            Expanded(
                              child: Text(
                                startLoc,
                                style: GoogleFonts.inter(
                                  fontSize: 13.5,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF1F2937),
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 3.5),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              width: 2.0,
                              height: 14.0,
                              color: const Color(0xFFE5E7EB),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              width: 9.0,
                              height: 9.0,
                              decoration: const BoxDecoration(
                                color: Color(0xFFEE7B4D),
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 10.0),
                            Expanded(
                              child: Text(
                                endLoc,
                                style: GoogleFonts.inter(
                                  fontSize: 13.5,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF1F2937),
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12.0),
                ],

                // Detail pills
                Wrap(
                  spacing: 6.0,
                  runSpacing: 6.0,
                  children: [
                    if (bookingType.isNotEmpty)
                      _buildDetailPill(
                        icon: isParcel ? Icons.inventory_2_outlined : FontAwesomeIcons.carSide,
                        label: bookingType,
                        color: const Color(0xFFEE7B4D),
                        backgroundColor: const Color(0xFFFFF0E9),
                      ),
                    if (itemName.isNotEmpty)
                      _buildDetailPill(
                        icon: Icons.local_shipping_outlined,
                        label: 'Parcel: $itemName',
                        color: const Color(0xFF4B5563),
                      ),
                    if (passengerName.isNotEmpty)
                      _buildDetailPill(
                        icon: Icons.person_outline_rounded,
                        label: 'Passenger: $passengerName',
                        color: const Color(0xFF4B5563),
                      )
                    else if (receiverName.isNotEmpty)
                      _buildDetailPill(
                        icon: Icons.person_outline_rounded,
                        label: 'Recipient: $receiverName',
                        color: const Color(0xFF4B5563),
                      ),
                    if (phoneNum.isNotEmpty)
                      _buildDetailPill(
                        icon: Icons.phone_outlined,
                        label: phoneNum,
                        color: const Color(0xFF4B5563),
                      ),
                  ],
                ),

                if (meetupAddr.isNotEmpty || addInfo.isNotEmpty) ...[
                  const SizedBox(height: 10.0),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF9FAFB),
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(color: const Color(0xFFE5E7EB), width: 0.6),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (meetupAddr.isNotEmpty)
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(Icons.place_outlined, size: 14.0, color: Color(0xFF6B7280)),
                              const SizedBox(width: 6.0),
                              Expanded(
                                child: Text(
                                  'Meetup: $meetupAddr',
                                  style: GoogleFonts.inter(
                                    fontSize: 12.0,
                                    color: const Color(0xFF374151),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        if (meetupAddr.isNotEmpty && addInfo.isNotEmpty)
                          const SizedBox(height: 4.0),
                        if (addInfo.isNotEmpty)
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(Icons.notes_rounded, size: 14.0, color: Color(0xFF6B7280)),
                              const SizedBox(width: 6.0),
                              Expanded(
                                child: Text(
                                  'Note: $addInfo',
                                  style: GoogleFonts.inter(
                                    fontSize: 12.0,
                                    color: const Color(0xFF4B5563),
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ],

                if (requestedTimeStr.isNotEmpty) ...[
                  const SizedBox(height: 10.0),
                  Row(
                    children: [
                      const Icon(Icons.access_time_rounded, size: 12.5, color: Color(0xFF9CA3AF)),
                      const SizedBox(width: 4.0),
                      Expanded(
                        child: Text(
                          'Booked on $requestedTimeStr',
                          style: GoogleFonts.inter(
                            fontSize: 11.5,
                            color: const Color(0xFF9CA3AF),
                            fontWeight: FontWeight.w400,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],

                const SizedBox(height: 12.0),
                const Divider(height: 1.0, thickness: 0.8, color: Color(0xFFF1F5F9)),
                const SizedBox(height: 12.0),

                // Responsive Action Buttons Row (NEVER OVERFLOWS)
                Row(
                  children: [
                    // Primary Action: View Ride
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
                        borderRadius: BorderRadius.circular(12.0),
                        child: Container(
                          height: 38.0,
                          decoration: BoxDecoration(
                            color: const Color(0xFFEE7B4D),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          alignment: Alignment.center,
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.remove_red_eye_outlined,
                                    size: 15.0,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(width: 5.0),
                                  Text(
                                    'View Ride',
                                    style: GoogleFonts.inter(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Add Review button (Only for completed or accepted rides)
                    if (booking.status == 'Completed' || booking.status == 'Accepted') ...[
                      const SizedBox(width: 8.0),
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
                          borderRadius: BorderRadius.circular(12.0),
                          child: Container(
                            height: 38.0,
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFFBEB),
                              borderRadius: BorderRadius.circular(12.0),
                              border: Border.all(color: const Color(0xFFFDE68A), width: 1.0),
                            ),
                            alignment: Alignment.center,
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.star_rounded, size: 15.0, color: Color(0xFFD97706)),
                                    const SizedBox(width: 4.0),
                                    Text(
                                      'Add Review',
                                      style: GoogleFonts.inter(
                                        color: const Color(0xFFD97706),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12.5,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],

                    // Edit button (If Pending)
                    if (booking.status == 'Pending') ...[
                      const SizedBox(width: 8.0),
                      InkWell(
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
                        borderRadius: BorderRadius.circular(12.0),
                        child: Container(
                          height: 38.0,
                          padding: const EdgeInsets.symmetric(horizontal: 14.0),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF3F4F6),
                            borderRadius: BorderRadius.circular(12.0),
                            border: Border.all(color: const Color(0xFFE5E7EB), width: 0.8),
                          ),
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.edit_outlined, size: 14.0, color: Color(0xFF374151)),
                              const SizedBox(width: 4.0),
                              Text(
                                'Edit',
                                style: GoogleFonts.inter(
                                  color: const Color(0xFF374151),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],

                    // Delete button (If can be deleted)
                    if (booking.status != 'Accepted' && booking.status != 'Completed' && booking.status != 'Rejected') ...[
                      const SizedBox(width: 8.0),
                      InkWell(
                        onTap: () async {
                          final confirm = await showDialog<bool>(
                            context: context,
                            builder: (context) => AlertDialog(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                              title: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFFEE2E2),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: const Icon(Icons.delete_outline_rounded, color: Color(0xFFDC2626), size: 20.0),
                                  ),
                                  const SizedBox(width: 10.0),
                                  Text(
                                    'Delete Booking',
                                    style: GoogleFonts.inter(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 17.0,
                                      color: const Color(0xFF1E293B),
                                    ),
                                  ),
                                ],
                              ),
                              content: Text(
                                'Are you sure you want to delete this booking?',
                                style: GoogleFonts.inter(fontSize: 14.0, color: const Color(0xFF64748B)),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context, false),
                                  child: Text('Cancel', style: GoogleFonts.inter(fontWeight: FontWeight.w600, color: const Color(0xFF64748B))),
                                ),
                                ElevatedButton(
                                  onPressed: () => Navigator.pop(context, true),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFFDC2626),
                                    foregroundColor: Colors.white,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                                  ),
                                  child: Text('Delete', style: GoogleFonts.inter(fontWeight: FontWeight.w600, color: Colors.white)),
                                ),
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
                        borderRadius: BorderRadius.circular(12.0),
                        child: Container(
                          width: 38.0,
                          height: 38.0,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFEF2F2),
                            borderRadius: BorderRadius.circular(12.0),
                            border: Border.all(color: const Color(0xFFFECACA), width: 0.8),
                          ),
                          alignment: Alignment.center,
                          child: const Icon(Icons.delete_outline_rounded, size: 16.0, color: Color(0xFFDC2626)),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
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
                                  color: Colors.black.withOpacity(0.06),
                                  blurRadius: 10.0,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(14.0),
                              onTap: () async {
                                context.pushNamed(PageNotificationWidget.routeName);
                              },
                              child: const Center(
                                child: Icon(
                                  Icons.notifications_none_rounded,
                                  color: Color(0xFF1E293B),
                                  size: 24.0,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            right: -1,
                            top: -1,
                            child: Container(
                              constraints: const BoxConstraints(
                                minWidth: 18.0,
                                minHeight: 18.0,
                              ),
                              padding: const EdgeInsets.all(3.0),
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).tertiary,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2.0,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: FlutterFlowTheme.of(context).tertiary.withOpacity(0.3),
                                    blurRadius: 4.0,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  unreadCount > 9 ? '9+' : unreadCount.toString(),
                                  style: GoogleFonts.inter(
                                    color: Colors.white,
                                    fontSize: unreadCount > 9 ? 8.0 : 9.5,
                                    fontWeight: FontWeight.bold,
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

                  const SizedBox(width: 10.0),

                  // Orange Crown Icon (Plans)
                  Container(
                    width: 44.0,
                    height: 44.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.06),
                          blurRadius: 10.0,
                          offset: const Offset(0, 3),
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
                          color: FlutterFlowTheme.of(context).tertiary,
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
                            labelColor: FlutterFlowTheme.of(context).tertiary,
                            unselectedLabelColor: const Color(0xFF64748B),
                            labelStyle: FlutterFlowTheme.of(context).titleMedium.override(
                                  font: GoogleFonts.interTight(
                                    fontWeight: FontWeight.w700,
                                    fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                  ),
                                  fontSize: 15.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w700,
                                  fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                ),
                            unselectedLabelStyle: FlutterFlowTheme.of(context).titleMedium.override(
                                  font: GoogleFonts.interTight(
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                  ),
                                  fontSize: 15.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                ),
                            indicatorColor: FlutterFlowTheme.of(context).tertiary,
                            indicatorWeight: 3.0,
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
                                              height: 46,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.circular(16),
                                                border: Border.all(color: const Color(0xFFE2E8F0), width: 1),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black.withOpacity(0.04),
                                                    blurRadius: 8,
                                                    offset: const Offset(0, 2),
                                                  ),
                                                ],
                                              ),
                                              child: StatefulBuilder(
                                                builder: (context, setStateLocal) {
                                                  return GooglePlaceAutoCompleteTextField(
                                                    focusNode: _model.startLocationFocusNode,
                                                    textEditingController: _model.startLocationTextController,
                                                    googleAPIKey: "AIzaSyDZkxRpoy0BOIAPwMaMIvAd5xpCe-6ZYvs",
                                                    inputDecoration: InputDecoration(
                                                      hintText: 'Start From...',
                                                      hintStyle: GoogleFonts.inter(
                                                        fontSize: 13.5,
                                                        fontWeight: FontWeight.w400,
                                                        color: const Color(0xFF94A3B8),
                                                      ),
                                                      prefixIcon: const Padding(
                                                        padding: EdgeInsets.only(left: 12.0, right: 6.0),
                                                        child: Icon(
                                                          Icons.location_on_rounded,
                                                          color: Color(0xFF0F9D58),
                                                          size: 20.0,
                                                        ),
                                                      ),
                                                      prefixIconConstraints: const BoxConstraints(minWidth: 36, minHeight: 20),
                                                      isDense: true,
                                                      filled: false,
                                                      contentPadding: const EdgeInsets.symmetric(vertical: 12),
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
                                              height: 46,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.circular(16),
                                                border: Border.all(
                                                  color: const Color(0xFFE2E8F0),
                                                  width: 1,
                                                ),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black.withOpacity(0.04),
                                                    blurRadius: 8,
                                                    offset: const Offset(0, 2),
                                                  ),
                                                ],
                                              ),
                                              child: GooglePlaceAutoCompleteTextField(
                                                focusNode: _model.endLocationFocusNode,
                                                textEditingController: _model.endLocationTextController,
                                                googleAPIKey: "AIzaSyDZkxRpoy0BOIAPwMaMIvAd5xpCe-6ZYvs",
                                                inputDecoration: InputDecoration(
                                                  hintText: 'End to...',
                                                  hintStyle: GoogleFonts.inter(
                                                    fontSize: 13.5,
                                                    fontWeight: FontWeight.w400,
                                                    color: const Color(0xFF94A3B8),
                                                  ),
                                                  prefixIcon: Icon(
                                                    Icons.location_on_rounded,
                                                    color: FlutterFlowTheme.of(context).tertiary,
                                                    size: 20.0,
                                                  ),
                                                  prefixIconConstraints: const BoxConstraints(minWidth: 36, minHeight: 20),
                                                  isDense: true,
                                                  filled: false,
                                                  contentPadding: const EdgeInsets.symmetric(vertical: 12),

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
                                              width: 44.0,
                                              height: 44.0,
                                              decoration: BoxDecoration(
                                                color: FlutterFlowTheme.of(context).tertiary,
                                                shape: BoxShape.circle,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: FlutterFlowTheme.of(context).tertiary.withOpacity(0.35),
                                                    blurRadius: 8.0,
                                                    offset: const Offset(0, 3),
                                                  ),
                                                ],
                                              ),
                                              child: const Center(
                                                child: Icon(
                                                  Icons.arrow_forward_rounded,
                                                  color: Colors.white,
                                                  size: 22.0,
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
                                                        final startDate = DateTime(now.year, now.month, now.day);
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

                                                          // Filter out past rides (< today)
                                                          final nowFilter = DateTime.now();
                                                          final todayFilter = DateTime(nowFilter.year, nowFilter.month, nowFilter.day);
                                                          listViewRidesNewRecordList = listViewRidesNewRecordList.where((ride) {
                                                            if (ride.pickupTime == null) return false;
                                                            return !ride.pickupTime!.isBefore(todayFilter);
                                                          }).toList();

                                                          // If a specific date is selected in calendar, filter by that date
                                                          if (!_model.isSearchActive && _model.pageState != null) {
                                                            final startOfDay = DateTime(_model.pageState!.year, _model.pageState!.month, _model.pageState!.day);
                                                            final endOfDay = startOfDay.add(const Duration(days: 1));
                                                            listViewRidesNewRecordList = listViewRidesNewRecordList.where((ride) {
                                                              if (ride.pickupTime == null) return false;
                                                              return !ride.pickupTime!.isBefore(startOfDay) && ride.pickupTime!.isBefore(endOfDay);
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

                                                          // Client-side filter: if search is active, filter by start/end location including stoppages
                                                          if (_model.isSearchActive && _model.searchStartLocation != null && _model.searchEndLocation != null) {
                                                            final startSearch = _model.searchStartLocation!.trim();
                                                            final endSearch = _model.searchEndLocation!.trim();

                                                            listViewRidesNewRecordList = listViewRidesNewRecordList.where((ride) {
                                                              final startAddress = ride.rideStartLocation ?? '';
                                                              final googleStart = ride.googleStartAddress ?? '';
                                                              final endAddress = ride.rideEndLocation ?? '';
                                                              final googleEnd = ride.googleEndAddress ?? '';

                                                              final routeSequence = [
                                                                startAddress,
                                                                if (googleStart.isNotEmpty) googleStart,
                                                                ...ride.stoppages,
                                                                endAddress,
                                                                if (googleEnd.isNotEmpty) googleEnd,
                                                              ];

                                                              int startIndex = -1;
                                                              for (int i = 0; i < routeSequence.length; i++) {
                                                                if (_locationsMatch(routeSequence[i], startSearch)) {
                                                                  startIndex = i;
                                                                  break;
                                                                }
                                                              }

                                                              int endIndex = -1;
                                                              for (int i = routeSequence.length - 1; i >= 0; i--) {
                                                                if (_locationsMatch(routeSequence[i], endSearch)) {
                                                                  endIndex = i;
                                                                  break;
                                                                }
                                                              }

                                                              return startIndex != -1 && endIndex != -1 && startIndex < endIndex;
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
                                                                  return Padding(
                                                                    padding: const EdgeInsets.only(bottom: 10.0),
                                                                    child: InkWell(
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
                                                                      child: Container(
                                                                        width: double.infinity,
                                                                        padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
                                                                        decoration: BoxDecoration(
                                                                          color: Colors.white,
                                                                          borderRadius: BorderRadius.circular(18.0),
                                                                          boxShadow: const [
                                                                            BoxShadow(
                                                                              color: Color(0x0E000000),
                                                                              blurRadius: 12.0,
                                                                              offset: Offset(0.0, 3.0),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        child: Row(
                                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                                          children: [
                                                                            // Left Content Column
                                                                            Expanded(
                                                                              child: Column(
                                                                                mainAxisSize: MainAxisSize.min,
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  // Start Location Row
                                                                                  Row(
                                                                                    children: [
                                                                                      const Icon(
                                                                                        Icons.location_on_rounded,
                                                                                        color: Color(0xFF0F9D58),
                                                                                        size: 20.0,
                                                                                      ),
                                                                                      const SizedBox(width: 8.0),
                                                                                      Expanded(
                                                                                        child: Text(
                                                                                          _truncateAddress(listViewRidesNewRecord.rideStartLocation),
                                                                                          style: GoogleFonts.inter(
                                                                                            fontSize: 14.0,
                                                                                            fontWeight: FontWeight.w600,
                                                                                            color: const Color(0xFF1E293B),
                                                                                          ),
                                                                                          maxLines: 1,
                                                                                          overflow: TextOverflow.ellipsis,
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                  const SizedBox(height: 6.0),

                                                                                  // Transport Mode & Date/Time Row
                                                                                  Row(
                                                                                    children: [
                                                                                      if (listViewRidesNewRecord.modeOfTransport == 'Bike')
                                                                                        const Icon(Icons.two_wheeler_rounded, color: Color(0xFF9CA3AF), size: 18.0)
                                                                                      else if (listViewRidesNewRecord.modeOfTransport == 'Train')
                                                                                        const Icon(Icons.train_rounded, color: Color(0xFF9CA3AF), size: 18.0)
                                                                                      else if (listViewRidesNewRecord.modeOfTransport == 'Car')
                                                                                        const FaIcon(FontAwesomeIcons.carSide, color: Color(0xFF9CA3AF), size: 15.0)
                                                                                      else
                                                                                        const FaIcon(FontAwesomeIcons.bus, color: Color(0xFF9CA3AF), size: 15.0),
                                                                                      const SizedBox(width: 8.0),
                                                                                      Expanded(
                                                                                        child: Text(
                                                                                          '${dateTimeFormat("hh:mm a", listViewRidesNewRecord.pickupTime)} | ${dateTimeFormat("yMMMd", listViewRidesNewRecord.pickupTime)}',
                                                                                          style: GoogleFonts.inter(
                                                                                            fontSize: 12.5,
                                                                                            fontWeight: FontWeight.w400,
                                                                                            color: const Color(0xFF64748B),
                                                                                          ),
                                                                                          maxLines: 1,
                                                                                          overflow: TextOverflow.ellipsis,
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                  const SizedBox(height: 6.0),

                                                                                  // End Location Row
                                                                                  Row(
                                                                                    children: [
                                                                                      Icon(
                                                                                        Icons.location_on_rounded,
                                                                                        color: FlutterFlowTheme.of(context).tertiary,
                                                                                        size: 20.0,
                                                                                      ),
                                                                                      const SizedBox(width: 8.0),
                                                                                      Expanded(
                                                                                        child: Text(
                                                                                          _truncateAddress(listViewRidesNewRecord.rideEndLocation),
                                                                                          style: GoogleFonts.inter(
                                                                                            fontSize: 14.0,
                                                                                            fontWeight: FontWeight.w600,
                                                                                            color: const Color(0xFF1E293B),
                                                                                          ),
                                                                                          maxLines: 1,
                                                                                          overflow: TextOverflow.ellipsis,
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                  const SizedBox(height: 10.0),

                                                                                  // Driver Avatar, Name & Rating Star
                                                                                  if (listViewRidesNewRecord.creatorID != null)
                                                                                    StreamBuilder<UsersRecord>(
                                                                                      stream: UsersRecord.getDocument(listViewRidesNewRecord.creatorID!),
                                                                                      builder: (context, snapshot) {
                                                                                        final rowUsersRecord = snapshot.data;
                                                                                        final driverName = (rowUsersRecord?.displayName != null && rowUsersRecord!.displayName.trim().isNotEmpty)
                                                                                            ? rowUsersRecord.displayName.trim()
                                                                                            : (rowUsersRecord?.userName != null && rowUsersRecord!.userName.trim().isNotEmpty)
                                                                                                ? rowUsersRecord.userName.trim()
                                                                                                : (rowUsersRecord?.phoneNumber != null && rowUsersRecord!.phoneNumber.trim().isNotEmpty)
                                                                                                    ? rowUsersRecord.phoneNumber.trim()
                                                                                                    : 'Driver';

                                                                                        final driverRatings = rowUsersRecord?.ratings.toList() ?? [];
                                                                                        final double driverAvgRating = functions.averageRating(driverRatings) ?? 0.0;
                                                                                        final String driverRatingStr = driverAvgRating > 0 ? driverAvgRating.toStringAsFixed(1) : '5.0';

                                                                                        return Row(
                                                                                          children: [
                                                                                            InkWell(
                                                                                              onTap: () {
                                                                                                if (rowUsersRecord != null) {
                                                                                                  context.pushNamed(
                                                                                                    DriverReviewWidget.routeName,
                                                                                                    queryParameters: {
                                                                                                      'userRef': serializeParam(
                                                                                                        rowUsersRecord.reference,
                                                                                                        ParamType.DocumentReference,
                                                                                                      ),
                                                                                                    }.withoutNulls,
                                                                                                  );
                                                                                                }
                                                                                              },
                                                                                              child: Container(
                                                                                                width: 32.0,
                                                                                                height: 32.0,
                                                                                                clipBehavior: Clip.antiAlias,
                                                                                                decoration: const BoxDecoration(shape: BoxShape.circle),
                                                                                                child: rowUsersRecord?.photoUrl != null && rowUsersRecord!.photoUrl.trim().isNotEmpty
                                                                                                    ? Image.network(
                                                                                                        rowUsersRecord.photoUrl,
                                                                                                        fit: BoxFit.cover,
                                                                                                        errorBuilder: (_, __, ___) => Image.asset(
                                                                                                          'assets/images/userIconTr.png',
                                                                                                          fit: BoxFit.cover,
                                                                                                        ),
                                                                                                      )
                                                                                                    : Image.asset(
                                                                                                        'assets/images/userIconTr.png',
                                                                                                        fit: BoxFit.cover,
                                                                                                      ),
                                                                                              ),
                                                                                            ),
                                                                                            const SizedBox(width: 8.0),
                                                                                            Expanded(
                                                                                              child: InkWell(
                                                                                                onTap: () {
                                                                                                  if (rowUsersRecord != null) {
                                                                                                    context.pushNamed(
                                                                                                      DriverReviewWidget.routeName,
                                                                                                      queryParameters: {
                                                                                                        'userRef': serializeParam(
                                                                                                          rowUsersRecord.reference,
                                                                                                          ParamType.DocumentReference,
                                                                                                        ),
                                                                                                      }.withoutNulls,
                                                                                                    );
                                                                                                  }
                                                                                                },
                                                                                                child: Text(
                                                                                                  driverName,
                                                                                                  style: GoogleFonts.inter(
                                                                                                    fontSize: 13.5,
                                                                                                    fontWeight: FontWeight.w600,
                                                                                                    color: const Color(0xFF1E293B),
                                                                                                  ),
                                                                                                  maxLines: 1,
                                                                                                  overflow: TextOverflow.ellipsis,
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                            InkWell(
                                                                                              onTap: () {
                                                                                                if (rowUsersRecord != null) {
                                                                                                  context.pushNamed(
                                                                                                    DriverReviewWidget.routeName,
                                                                                                    queryParameters: {
                                                                                                      'userRef': serializeParam(
                                                                                                        rowUsersRecord.reference,
                                                                                                        ParamType.DocumentReference,
                                                                                                      ),
                                                                                                    }.withoutNulls,
                                                                                                  );
                                                                                                }
                                                                                              },
                                                                                              child: Row(
                                                                                                mainAxisSize: MainAxisSize.min,
                                                                                                children: [
                                                                                                  const Icon(
                                                                                                    Icons.star_rounded,
                                                                                                    color: Color(0xFFF59E0B),
                                                                                                    size: 17.0,
                                                                                                  ),
                                                                                                  const SizedBox(width: 2.0),
                                                                                                  Text(
                                                                                                    driverRatingStr,
                                                                                                    style: GoogleFonts.inter(
                                                                                                      fontSize: 12.0,
                                                                                                      fontWeight: FontWeight.w600,
                                                                                                      color: const Color(0xFF475569),
                                                                                                    ),
                                                                                                  ),
                                                                                                ],
                                                                                              ),
                                                                                            ),
                                                                                          ],
                                                                                        );
                                                                                      },
                                                                                    ),
                                                                                ],
                                                                              ),
                                                                            ),

                                                                            const SizedBox(width: 12.0),

                                                                            // Right Price Pillar Badge
                                                                            Container(
                                                                              width: 80.0,
                                                                              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 6.0),
                                                                              decoration: BoxDecoration(
                                                                                color: FlutterFlowTheme.of(context).tertiary,
                                                                                borderRadius: BorderRadius.circular(16.0),
                                                                              ),
                                                                              child: Column(
                                                                                mainAxisSize: MainAxisSize.min,
                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                children: [
                                                                                  Text(
                                                                                    'Ride',
                                                                                    style: GoogleFonts.inter(
                                                                                      fontSize: 11.5,
                                                                                      fontWeight: FontWeight.w400,
                                                                                      color: Colors.white.withOpacity(0.95),
                                                                                    ),
                                                                                  ),
                                                                                  const SizedBox(height: 1.0),
                                                                                  AutoSizeText(
                                                                                    '₹${formatNumber(_calculateHomeSegmentPrice(listViewRidesNewRecord), formatType: FormatType.custom, format: '', locale: '')}',
                                                                                    style: GoogleFonts.inter(
                                                                                      fontSize: 18.0,
                                                                                      fontWeight: FontWeight.w700,
                                                                                      color: Colors.white,
                                                                                    ),
                                                                                    maxLines: 1,
                                                                                    minFontSize: 11,
                                                                                  ),
                                                                                  Padding(
                                                                                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                                                                                    child: Container(
                                                                                      height: 0.8,
                                                                                      width: double.infinity,
                                                                                      color: Colors.white.withOpacity(0.3),
                                                                                    ),
                                                                                  ),
                                                                                  Text(
                                                                                    'Parcel',
                                                                                    style: GoogleFonts.inter(
                                                                                      fontSize: 11.5,
                                                                                      fontWeight: FontWeight.w400,
                                                                                      color: Colors.white.withOpacity(0.95),
                                                                                    ),
                                                                                  ),
                                                                                  const SizedBox(height: 1.0),
                                                                                  AutoSizeText(
                                                                                    '₹${listViewRidesNewRecord.totalDeliveryCost}',
                                                                                    style: GoogleFonts.inter(
                                                                                      fontSize: 18.0,
                                                                                      fontWeight: FontWeight.w700,
                                                                                      color: Colors.white,
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
                                                                  ).animateOnPageLoad(animationsMap['containerOnPageLoadAnimation2']!);
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
//                                                               final startDate = DateTime(now.year, now.month, now.day);
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
                                              padding: const EdgeInsetsDirectional.fromSTEB(12.0, 12.0, 12.0, 4.0),
                                              child: SingleChildScrollView(
                                                scrollDirection: Axis.horizontal,
                                                child: Row(
                                                  children: ['All Bookings', 'Pending', 'Accepted', 'Completed', 'Rejected'].map((status) {
                                                    final isSelected = _model.myBookingStatus == status;
                                                    return Padding(
                                                      padding: const EdgeInsets.only(right: 8.0),
                                                      child: InkWell(
                                                        splashColor: Colors.transparent,
                                                        focusColor: Colors.transparent,
                                                        hoverColor: Colors.transparent,
                                                        highlightColor: Colors.transparent,
                                                        onTap: () {
                                                          safeSetState(() {
                                                            _model.myBookingStatus = status;
                                                            _model.bookingDropDownValue = status;
                                                          });
                                                        },
                                                        child: AnimatedContainer(
                                                          duration: const Duration(milliseconds: 200),
                                                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                                                          decoration: BoxDecoration(
                                                            color: isSelected ? const Color(0xFFEE7B4D) : Colors.white,
                                                            borderRadius: BorderRadius.circular(30.0),
                                                            border: Border.all(
                                                              color: isSelected
                                                                  ? const Color(0xFFEE7B4D)
                                                                  : const Color(0xFFE5E7EB),
                                                              width: 1.0,
                                                            ),
                                                            boxShadow: isSelected
                                                                ? [
                                                                    BoxShadow(
                                                                      color: const Color(0xFFEE7B4D).withOpacity(0.25),
                                                                      blurRadius: 8.0,
                                                                      offset: const Offset(0.0, 2.0),
                                                                    ),
                                                                  ]
                                                                : const [
                                                                    BoxShadow(
                                                                      color: Color(0x06000000),
                                                                      blurRadius: 4.0,
                                                                      offset: Offset(0.0, 1.0),
                                                                    ),
                                                                  ],
                                                          ),
                                                          child: Text(
                                                            status,
                                                            style: GoogleFonts.inter(
                                                              fontSize: 13.0,
                                                              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                                                              color: isSelected ? Colors.white : const Color(0xFF4B5563),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  }).toList(),
                                                ),
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
                                              padding: const EdgeInsetsDirectional.fromSTEB(12.0, 12.0, 12.0, 4.0),
                                              child: SingleChildScrollView(
                                                scrollDirection: Axis.horizontal,
                                                child: Row(
                                                  children: [
                                                    {'label': 'All Rides', 'value': 'All Rides', 'ddVal': 'All'},
                                                    {'label': 'Live', 'value': 'Live', 'ddVal': 'Live'},
                                                    {'label': 'Under Review', 'value': 'Under Review', 'ddVal': 'Under Review'},
                                                    {'label': 'Rejected', 'value': 'Rejected', 'ddVal': 'Rejected'},
                                                  ].map((item) {
                                                    final val = item['value']!;
                                                    final isSelected = _model.myRidesStatus == val;
                                                    return Padding(
                                                      padding: const EdgeInsets.only(right: 8.0),
                                                      child: InkWell(
                                                        splashColor: Colors.transparent,
                                                        focusColor: Colors.transparent,
                                                        hoverColor: Colors.transparent,
                                                        highlightColor: Colors.transparent,
                                                        onTap: () {
                                                          safeSetState(() {
                                                            _model.myRidesStatus = val;
                                                            _model.postedRidesDropDownValue = item['ddVal'];
                                                          });
                                                        },
                                                        child: AnimatedContainer(
                                                          duration: const Duration(milliseconds: 200),
                                                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                                                          decoration: BoxDecoration(
                                                            color: isSelected ? const Color(0xFFEE7B4D) : Colors.white,
                                                            borderRadius: BorderRadius.circular(30.0),
                                                            border: Border.all(
                                                              color: isSelected
                                                                  ? const Color(0xFFEE7B4D)
                                                                  : const Color(0xFFE5E7EB),
                                                              width: 1.0,
                                                            ),
                                                            boxShadow: isSelected
                                                                ? [
                                                                    BoxShadow(
                                                                      color: const Color(0xFFEE7B4D).withOpacity(0.25),
                                                                      blurRadius: 8.0,
                                                                      offset: const Offset(0.0, 2.0),
                                                                    ),
                                                                  ]
                                                                : const [
                                                                    BoxShadow(
                                                                      color: Color(0x06000000),
                                                                      blurRadius: 4.0,
                                                                      offset: Offset(0.0, 1.0),
                                                                    ),
                                                                  ],
                                                          ),
                                                          child: Text(
                                                            item['label']!,
                                                            style: GoogleFonts.inter(
                                                              fontSize: 13.0,
                                                              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                                                              color: isSelected ? Colors.white : const Color(0xFF4B5563),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  }).toList(),
                                                ),
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
