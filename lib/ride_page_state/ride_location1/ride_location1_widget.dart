import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:provider/provider.dart';

import '/components/publish_ride_progress_header.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'ride_location1_model.dart';
export 'ride_location1_model.dart';

class RideLocation1Widget extends StatefulWidget {
  const RideLocation1Widget({super.key});

  static String routeName = 'RideLocation1';
  static String routePath = '/rideLocation1';

  @override
  State<RideLocation1Widget> createState() => _RideLocation1WidgetState();
}

class _RideLocation1WidgetState extends State<RideLocation1Widget> {
  late RideLocation1Model _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => RideLocation1Model());
    _scrollController = ScrollController();

    _model.rideStartLocationTextController = TextEditingController(
      text: FFAppState().RideStartLocaction,
    );
    _model.rideEndLocationTextController = TextEditingController(
      text: FFAppState().RideEndLocaction,
    );

    _model.rideStartLocationFocusNode = FocusNode();
    _model.rideEndLocationFocusNode = FocusNode();

    _model.rideEndLocationFocusNode?.addListener(() {
      if (_model.rideEndLocationFocusNode?.hasFocus ?? false) {
        Future.delayed(const Duration(milliseconds: 250), () {
          if (_scrollController.hasClients) {
            _scrollController.animateTo(
              160.0,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutCubic,
            );
          }
        });
      }
    });

    _model.rideStartLocationFocusNode?.addListener(() {
      if (_model.rideStartLocationFocusNode?.hasFocus ?? false) {
        Future.delayed(const Duration(milliseconds: 250), () {
          if (_scrollController.hasClients) {
            _scrollController.animateTo(
              60.0,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutCubic,
            );
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _model.dispose();
    super.dispose();
  }

  void _swapLocations() {
    final tempText = _model.rideStartLocationTextController.text;
    _model.rideStartLocationTextController.text = _model.rideEndLocationTextController.text;
    _model.rideEndLocationTextController.text = tempText;

    final tempGoogle = FFAppState().rideStartLocationGoogle;
    final tempAddress = FFAppState().GoogleStartAddress;

    FFAppState().rideStartLocationGoogle = FFAppState().rideEndLocationGoogle;
    FFAppState().GoogleStartAddress = FFAppState().GoogleEndAddress;

    FFAppState().rideEndLocationGoogle = tempGoogle;
    FFAppState().GoogleEndAddress = tempAddress;

    FFAppState().RideStartLocaction = _model.rideStartLocationTextController.text;
    FFAppState().RideEndLocaction = _model.rideEndLocationTextController.text;

    safeSetState(() {});
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        resizeToAvoidBottomInset: false,
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
                  controller: _scrollController,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Step Progress Header
                      const PublishRideProgressHeader(
                        currentStep: 1,
                        totalSteps: 8,
                        title: 'Where are you going?',
                        subtitle: 'Enter your pickup origin and destination drop-off point.',
                        badgeText: 'STEP 1 OF 8',
                      ),

                      // Main Location Card
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(
                            color: const Color(0xFFEAECEF),
                            width: 1.0,
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x0A000000),
                              blurRadius: 16.0,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(18.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Header Row with Swap Button
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(6.0),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFEEF7F2),
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                      child: const Icon(
                                        Icons.alt_route_rounded,
                                        color: Color(0xFF10B981),
                                        size: 16.0,
                                      ),
                                    ),
                                    const SizedBox(width: 8.0),
                                    Text(
                                      'Route Details',
                                      style: GoogleFonts.inter(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w700,
                                        color: const Color(0xFF111827),
                                      ),
                                    ),
                                  ],
                                ),
                                InkWell(
                                  onTap: _swapLocations,
                                  borderRadius: BorderRadius.circular(20.0),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFFFF6EE),
                                      borderRadius: BorderRadius.circular(20.0),
                                      border: Border.all(
                                        color: const Color(0xFFFFD9C2),
                                        width: 1.0,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(
                                          Icons.swap_vert_rounded,
                                          color: Color(0xFFEE7B4D),
                                          size: 16.0,
                                        ),
                                        const SizedBox(width: 4.0),
                                        Text(
                                          'Swap',
                                          style: GoogleFonts.inter(
                                            fontSize: 11.5,
                                            fontWeight: FontWeight.w600,
                                            color: const Color(0xFFEE7B4D),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 16.0),

                            // Pickup & Dropoff Inputs Container
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Left Route Visual Indicator
                                Padding(
                                  padding: const EdgeInsets.only(top: 14.0, right: 12.0),
                                  child: Column(
                                    children: [
                                      Container(
                                        width: 14.0,
                                        height: 14.0,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF10B981),
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: const Color(0xFFD1FAE5),
                                            width: 3.0,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 2.0,
                                        height: 54.0,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFE2E8F0),
                                          borderRadius: BorderRadius.circular(1.0),
                                        ),
                                      ),
                                      Container(
                                        width: 14.0,
                                        height: 14.0,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFEE7B4D),
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: const Color(0xFFFFE2CC),
                                            width: 3.0,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                // Text Fields
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // Pickup Location
                                      Text(
                                        'PICKUP LOCATION',
                                        style: GoogleFonts.inter(
                                          fontSize: 10.5,
                                          fontWeight: FontWeight.w700,
                                          color: const Color(0xFF6B7280),
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                      const SizedBox(height: 4.0),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFF9FAFB),
                                          borderRadius: BorderRadius.circular(12.0),
                                          border: Border.all(
                                            color: const Color(0xFFE5E7EB),
                                          ),
                                        ),
                                        child: GooglePlaceAutoCompleteTextField(
                                          focusNode: _model.rideStartLocationFocusNode,
                                          textEditingController: _model.rideStartLocationTextController,
                                          googleAPIKey: 'AIzaSyDZkxRpoy0BOIAPwMaMIvAd5xpCe-6ZYvs',
                                          inputDecoration: InputDecoration(
                                            hintText: 'Enter pickup address / city...',
                                            hintStyle: GoogleFonts.inter(
                                              color: const Color(0xFF9CA3AF),
                                              fontSize: 13.5,
                                            ),
                                            border: InputBorder.none,
                                            enabledBorder: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                            contentPadding: const EdgeInsets.symmetric(
                                              horizontal: 12.0,
                                              vertical: 11.0,
                                            ),
                                            isDense: true,
                                          ),
                                          textStyle: GoogleFonts.inter(
                                            fontSize: 13.5,
                                            color: const Color(0xFF111827),
                                            fontWeight: FontWeight.w500,
                                          ),
                                          debounceTime: 500,
                                          countries: const ['in'],
                                          isLatLngRequired: true,
                                          getPlaceDetailWithLatLng: (prediction) {
                                            if (prediction.lat != null && prediction.lng != null) {
                                              FFAppState().rideStartLocationGoogle = LatLng(
                                                double.parse(prediction.lat!),
                                                double.parse(prediction.lng!),
                                              );
                                              FFAppState().GoogleStartAddress =
                                                  prediction.description ?? '';
                                              safeSetState(() {});
                                            }
                                          },
                                          itemClick: (prediction) {
                                            _model.rideStartLocationTextController.text =
                                                prediction.description ?? '';
                                            _model.rideStartLocationTextController.selection =
                                                TextSelection.fromPosition(
                                              TextPosition(
                                                offset: prediction.description?.length ?? 0,
                                              ),
                                            );
                                          },
                                          itemBuilder: (context, index, prediction) {
                                            return Container(
                                              padding: const EdgeInsets.symmetric(
                                                horizontal: 14.0,
                                                vertical: 10.0,
                                              ),
                                              child: Row(
                                                children: [
                                                  const Icon(
                                                    Icons.location_on_outlined,
                                                    size: 18.0,
                                                    color: Color(0xFF10B981),
                                                  ),
                                                  const SizedBox(width: 10.0),
                                                  Expanded(
                                                    child: Text(
                                                      prediction.description ?? '',
                                                      style: GoogleFonts.inter(
                                                        fontSize: 13.0,
                                                        color: const Color(0xFF111827),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                          seperatedBuilder: const Divider(
                                            height: 1.0,
                                            thickness: 0.5,
                                            color: Color(0xFFF3F4F6),
                                          ),
                                          isCrossBtnShown: true,
                                        ),
                                      ),

                                      const SizedBox(height: 16.0),

                                      // Dropoff Destination
                                      Text(
                                        'DESTINATION',
                                        style: GoogleFonts.inter(
                                          fontSize: 10.5,
                                          fontWeight: FontWeight.w700,
                                          color: const Color(0xFF6B7280),
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                      const SizedBox(height: 4.0),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFF9FAFB),
                                          borderRadius: BorderRadius.circular(12.0),
                                          border: Border.all(
                                            color: const Color(0xFFE5E7EB),
                                          ),
                                        ),
                                        child: GooglePlaceAutoCompleteTextField(
                                          focusNode: _model.rideEndLocationFocusNode,
                                          textEditingController: _model.rideEndLocationTextController,
                                          googleAPIKey: 'AIzaSyDZkxRpoy0BOIAPwMaMIvAd5xpCe-6ZYvs',
                                          inputDecoration: InputDecoration(
                                            hintText: 'Enter drop-off destination...',
                                            hintStyle: GoogleFonts.inter(
                                              color: const Color(0xFF9CA3AF),
                                              fontSize: 13.5,
                                            ),
                                            border: InputBorder.none,
                                            enabledBorder: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                            contentPadding: const EdgeInsets.symmetric(
                                              horizontal: 12.0,
                                              vertical: 11.0,
                                            ),
                                            isDense: true,
                                          ),
                                          textStyle: GoogleFonts.inter(
                                            fontSize: 13.5,
                                            color: const Color(0xFF111827),
                                            fontWeight: FontWeight.w500,
                                          ),
                                          debounceTime: 500,
                                          countries: const ['in'],
                                          isLatLngRequired: true,
                                          getPlaceDetailWithLatLng: (prediction) {
                                            if (prediction.lat != null && prediction.lng != null) {
                                              FFAppState().rideEndLocationGoogle = LatLng(
                                                double.parse(prediction.lat!),
                                                double.parse(prediction.lng!),
                                              );
                                              FFAppState().GoogleEndAddress =
                                                  prediction.description ?? '';
                                              safeSetState(() {});
                                            }
                                          },
                                          itemClick: (prediction) {
                                            _model.rideEndLocationTextController.text =
                                                prediction.description ?? '';
                                            _model.rideEndLocationTextController.selection =
                                                TextSelection.fromPosition(
                                              TextPosition(
                                                offset: prediction.description?.length ?? 0,
                                              ),
                                            );
                                          },
                                          itemBuilder: (context, index, prediction) {
                                            return Container(
                                              padding: const EdgeInsets.symmetric(
                                                horizontal: 14.0,
                                                vertical: 10.0,
                                              ),
                                              child: Row(
                                                children: [
                                                  const Icon(
                                                    Icons.location_on_outlined,
                                                    size: 18.0,
                                                    color: Color(0xFFEE7B4D),
                                                  ),
                                                  const SizedBox(width: 10.0),
                                                  Expanded(
                                                    child: Text(
                                                      prediction.description ?? '',
                                                      style: GoogleFonts.inter(
                                                        fontSize: 13.0,
                                                        color: const Color(0xFF111827),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                          seperatedBuilder: const Divider(
                                            height: 1.0,
                                            thickness: 0.5,
                                            color: Color(0xFFF3F4F6),
                                          ),
                                          isCrossBtnShown: true,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 18.0),

                      // Helpful Tip Card
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(14.0),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFF7ED),
                          borderRadius: BorderRadius.circular(16.0),
                          border: Border.all(
                            color: const Color(0xFFFFEDD5),
                            width: 1.0,
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(6.0),
                              decoration: const BoxDecoration(
                                color: Color(0xFFFFEDD5),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.lightbulb_rounded,
                                color: Color(0xFFEA580C),
                                size: 16.0,
                              ),
                            ),
                            const SizedBox(width: 10.0),
                            Expanded(
                              child: Text(
                                'Select specific landmarks, metro stations, or popular areas to make pickup effortless for your co-travellers.',
                                style: GoogleFonts.inter(
                                  color: const Color(0xFF9A3412),
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.w400,
                                  height: 1.35,
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
                    final startLoc = _model.rideStartLocationTextController.text.trim();
                    final endLoc = _model.rideEndLocationTextController.text.trim();

                    if (startLoc.isNotEmpty && endLoc.isNotEmpty) {
                      FFAppState().RideStartLocaction = startLoc;
                      FFAppState().RideEndLocaction = endLoc;
                      safeSetState(() {});

                      context.pushNamed(RideStartDateTime2Widget.routeName);
                    } else {
                      await showDialog(
                        context: context,
                        builder: (alertDialogContext) => AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          title: Text(
                            'Missing Locations',
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w700,
                              fontSize: 17.0,
                            ),
                          ),
                          content: Text(
                            'Please select both pickup and destination locations to continue.',
                            style: GoogleFonts.inter(
                              fontSize: 13.5,
                              color: const Color(0xFF4B5563),
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(alertDialogContext),
                              child: Text(
                                'Got It',
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
                          'Continue to Start Date',
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
