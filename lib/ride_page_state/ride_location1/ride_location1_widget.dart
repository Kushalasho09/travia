import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

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
            'Ride Location',
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
                controller: _scrollController,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(
                  left: 20.0,
                  right: 20.0,
                  top: 18.0,
                  bottom: 260.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // =================== 1. 10% PROGRESS INDICATOR ===================
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: CircularPercentIndicator(
                          percent: 0.1,
                          radius: 56.0,
                          lineWidth: 11.0,
                          animation: true,
                          animateFromLastPercent: true,
                          progressColor: const Color(0xFFF57C3B),
                          backgroundColor: const Color(0xFFE2E8F0),
                          center: Text(
                            '10%',
                            style: GoogleFonts.interTight(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF0F172A),
                            ),
                          ),
                        ),
                      ),
                    )
                        .animate()
                        .fadeIn(duration: 400.ms)
                        .scale(begin: const Offset(0.85, 0.85), end: const Offset(1.0, 1.0), curve: Curves.easeOutBack),

                    // =================== 2. SECTION HEADER ===================
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 4.0, bottom: 6.0),
                        child: Text(
                          'Where are you going?',
                          style: GoogleFonts.interTight(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                      ),
                    )
                        .animate()
                        .fadeIn(duration: 400.ms, delay: 100.ms)
                        .slideY(begin: 0.15, end: 0.0, curve: Curves.easeOutQuad),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 4.0, bottom: 18.0),
                        child: Text(
                          'Enter your pickup and drop-off locations below.',
                          style: GoogleFonts.inter(
                            fontSize: 13.0,
                            color: const Color(0xFF64748B),
                          ),
                        ),
                      ),
                    )
                        .animate()
                        .fadeIn(duration: 400.ms, delay: 150.ms)
                        .slideY(begin: 0.15, end: 0.0, curve: Curves.easeOutQuad),

                    // =================== 3. ROUTE LOCATION CARD ===================
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18.0),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.03),
                            blurRadius: 10.0,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Left Route Indicator Visuals (Green Dot -> Line -> Red Pin)
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
                                    border: Border.all(color: const Color(0xFFD1FAE5), width: 3.0),
                                  ),
                                )
                                    .animate()
                                    .fadeIn(duration: 350.ms, delay: 300.ms)
                                    .scale(begin: const Offset(0.5, 0.5), end: const Offset(1.0, 1.0), curve: Curves.easeOutBack),
                                Container(
                                  width: 2.0,
                                  height: 52.0,
                                  color: const Color(0xFFCBD5E1),
                                ).animate().fadeIn(duration: 350.ms, delay: 350.ms),
                                Container(
                                  width: 14.0,
                                  height: 14.0,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFEF4444),
                                    shape: BoxShape.circle,
                                    border: Border.all(color: const Color(0xFFFEE2E2), width: 3.0),
                                  ),
                                )
                                    .animate()
                                    .fadeIn(duration: 350.ms, delay: 400.ms)
                                    .scale(begin: const Offset(0.5, 0.5), end: const Offset(1.0, 1.0), curve: Curves.easeOutBack),
                              ],
                            ),
                          ),

                          // Right Inputs (Start Location & End Location)
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // START LOCATION INPUT
                                Text(
                                  'PICKUP LOCATION',
                                  style: GoogleFonts.inter(
                                    fontSize: 10.5,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF64748B),
                                    letterSpacing: 0.5,
                                  ),
                                ),
                                const SizedBox(height: 4.0),
                                Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF8FAFC),
                                    borderRadius: BorderRadius.circular(10.0),
                                    border: Border.all(color: const Color(0xFFE2E8F0)),
                                  ),
                                  child: GooglePlaceAutoCompleteTextField(
                                    focusNode: _model.rideStartLocationFocusNode,
                                    textEditingController: _model.rideStartLocationTextController,
                                    googleAPIKey: 'AIzaSyDZkxRpoy0BOIAPwMaMIvAd5xpCe-6ZYvs',
                                    inputDecoration: InputDecoration(
                                      hintText: 'Enter pickup address / city...',
                                      hintStyle: GoogleFonts.inter(
                                        color: const Color(0xFF94A3B8),
                                        fontSize: 13.5,
                                      ),
                                      border: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 12.0,
                                        vertical: 10.0,
                                      ),
                                      isDense: true,
                                    ),
                                    textStyle: GoogleFonts.inter(
                                      fontSize: 13.5,
                                      color: const Color(0xFF0F172A),
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
                                              color: Color(0xFFF57C3B),
                                            ),
                                            const SizedBox(width: 10.0),
                                            Expanded(
                                              child: Text(
                                                prediction.description ?? '',
                                                style: GoogleFonts.inter(fontSize: 13.0),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    seperatedBuilder: const Divider(height: 1.0, thickness: 0.5),
                                    isCrossBtnShown: true,
                                  ),
                                ),

                                const SizedBox(height: 16.0),

                                // END LOCATION INPUT
                                Text(
                                  'DESTINATION',
                                  style: GoogleFonts.inter(
                                    fontSize: 10.5,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF64748B),
                                    letterSpacing: 0.5,
                                  ),
                                ),
                                const SizedBox(height: 4.0),
                                Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF8FAFC),
                                    borderRadius: BorderRadius.circular(10.0),
                                    border: Border.all(color: const Color(0xFFE2E8F0)),
                                  ),
                                  child: GooglePlaceAutoCompleteTextField(
                                    focusNode: _model.rideEndLocationFocusNode,
                                    textEditingController: _model.rideEndLocationTextController,
                                    googleAPIKey: 'AIzaSyDZkxRpoy0BOIAPwMaMIvAd5xpCe-6ZYvs',
                                    inputDecoration: InputDecoration(
                                      hintText: 'Enter drop-off destination...',
                                      hintStyle: GoogleFonts.inter(
                                        color: const Color(0xFF94A3B8),
                                        fontSize: 13.5,
                                      ),
                                      border: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 12.0,
                                        vertical: 10.0,
                                      ),
                                      isDense: true,
                                    ),
                                    textStyle: GoogleFonts.inter(
                                      fontSize: 13.5,
                                      color: const Color(0xFF0F172A),
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
                                              color: Color(0xFFF57C3B),
                                            ),
                                            const SizedBox(width: 10.0),
                                            Expanded(
                                              child: Text(
                                                prediction.description ?? '',
                                                style: GoogleFonts.inter(fontSize: 13.0),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    seperatedBuilder: const Divider(height: 1.0, thickness: 0.5),
                                    isCrossBtnShown: true,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                        .animate()
                        .fadeIn(duration: 450.ms, delay: 200.ms)
                        .slideY(begin: 0.1, end: 0.0, curve: Curves.easeOutQuad),

                    const SizedBox(height: 20.0),

                    // =================== 4. HELPFUL TIP BOX ===================
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(14.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF7ED),
                        borderRadius: BorderRadius.circular(14.0),
                        border: Border.all(color: const Color(0xFFFFEDD5)),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.lightbulb_outline_rounded,
                            color: Color(0xFFF57C3B),
                            size: 20.0,
                          ),
                          const SizedBox(width: 10.0),
                          Expanded(
                            child: Text(
                              'Select clear landmark or city locations to help passengers discover and book your ride easily.',
                              style: GoogleFonts.inter(
                                color: const Color(0xFF9A3412),
                                fontSize: 12.5,
                                height: 1.35,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                        .animate()
                        .fadeIn(duration: 450.ms, delay: 350.ms)
                        .slideY(begin: 0.1, end: 0.0, curve: Curves.easeOutQuad),
                  ],
                ),
              ),

              // =================== FLOATING ORANGE NEXT BUTTON ===================
              Positioned(
                bottom: 24.0,
                right: 20.0,
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
                          title: const Text('Attention'),
                          content: const Text(
                            'Please select both pickup and destination locations.',
                          ),
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
                  borderRadius: BorderRadius.circular(35.0),
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
                )
                    .animate()
                    .fadeIn(duration: 400.ms, delay: 450.ms)
                    .scale(begin: const Offset(0.7, 0.7), end: const Offset(1.0, 1.0), curve: Curves.elasticOut),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/* ==========================================================================
   PREVIOUS RIDE LOCATION 1 CODE (SAVED AS BACKUP FOR FUTURE REFERENCE)
   ==========================================================================

class _PreviousRideLocation1Backup extends StatefulWidget {
  const _PreviousRideLocation1Backup();

  @override
  State<_PreviousRideLocation1Backup> createState() => _PreviousRideLocation1BackupState();
}

class _PreviousRideLocation1BackupState extends State<_PreviousRideLocation1Backup> {
  late RideLocation1Model _model;
  bool _showImage = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (_showImage)
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              'assets/images/appploucg.gif',
              width: double.infinity,
              height: 280.0,
              fit: BoxFit.cover,
            ),
          ),
        Row(
          children: [
            Container(
              width: MediaQuery.sizeOf(context).width * 0.85,
              child: GooglePlaceAutoCompleteTextField(
                focusNode: _model.rideStartLocationFocusNode,
                textEditingController: _model.rideStartLocationTextController,
                googleAPIKey: "AIzaSyDZkxRpoy0BOIAPwMaMIvAd5xpCe-6ZYvs",
              ),
            ),
          ],
        ),
        Row(
          children: [
            Container(
              width: MediaQuery.sizeOf(context).width * 0.85,
              child: GooglePlaceAutoCompleteTextField(
                focusNode: _model.rideEndLocationFocusNode,
                textEditingController: _model.rideEndLocationTextController,
                googleAPIKey: "AIzaSyDZkxRpoy0BOIAPwMaMIvAd5xpCe-6ZYvs",
              ),
            ),
          ],
        ),
      ],
    );
  }
}
========================================================================== */
