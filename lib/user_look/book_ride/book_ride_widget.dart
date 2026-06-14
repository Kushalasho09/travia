import 'package:travia/compotement/termsconditions11/termsconditions11_widget.dart';
import 'package:google_places_flutter/google_places_flutter.dart';

import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:math';
import 'dart:ui';
import '/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'book_ride_model.dart';
export 'book_ride_model.dart';

class BookRideWidget extends StatefulWidget {
  const BookRideWidget({
    super.key,
    required this.rideID,
  });

  final DocumentReference? rideID;

  static String routeName = 'BookRide';
  static String routePath = '/bookRide';

  @override
  State<BookRideWidget> createState() => _BookRideWidgetState();
}

class _BookRideWidgetState extends State<BookRideWidget>
    with TickerProviderStateMixin {
  late BookRideModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BookRideModel());

    _model.nameTextController ??= TextEditingController();
    _model.nameFocusNode ??= FocusNode();

    _model.contactNumberTextController ??= TextEditingController();
    _model.contactNumberFocusNode ??= FocusNode();

    _model.contactNumberMask = MaskTextInputFormatter(mask: '+91 ###### #####');
    _model.meetupAddressTextController ??= TextEditingController();
    _model.meetupAddressFocusNode ??= FocusNode();

    _model.additionalInformationTextController ??= TextEditingController();
    _model.additionalInformationFocusNode ??= FocusNode();

    animationsMap.addAll({
      'containerOnPageLoadAnimation': AnimationInfo(
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

    super.dispose();
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
            'Book Your Ride',
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
          child: Align(
            alignment: AlignmentDirectional(0.0, 0.0),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16.0, 24.0, 16.0, 24.0),
              child: SingleChildScrollView(
                primary: false,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Material(
                      color: Colors.transparent,
                      elevation: 2.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).containerColour,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 8.0,
                              color: Color(0x1A000000),
                              offset: Offset(
                                0.0,
                                2.0,
                              ),
                            )
                          ],
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                'Booking for?',
                                textAlign: TextAlign.center,
                                style: FlutterFlowTheme.of(context)
                                    .headlineMedium
                                    .override(
                                      font: GoogleFonts.interTight(
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .headlineMedium
                                            .fontStyle,
                                      ),
                                      fontSize: 16.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .headlineMedium
                                          .fontStyle,
                                    ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        _model.bookingFor = 'Self';
                                        safeSetState(() {});
                                      },
                                      child: Container(
                                        height: 48.0,
                                        decoration: BoxDecoration(
                                          color: _model.bookingFor == 'Self'
                                              ? Color(0xFFFF6B35)
                                              : FlutterFlowTheme.of(context)
                                                  .containerBG,
                                          borderRadius:
                                              BorderRadius.circular(24.0),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(12.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'SELF',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .titleMedium
                                                        .override(
                                                          font: GoogleFonts
                                                              .interTight(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleMedium
                                                                    .fontStyle,
                                                          ),
                                                          color: Colors.white,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .titleMedium
                                                                  .fontStyle,
                                                        ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        _model.bookingFor = 'Friend';
                                        safeSetState(() {});
                                      },
                                      child: Container(
                                        height: 48.0,
                                        decoration: BoxDecoration(
                                          color: _model.bookingFor == 'Friend'
                                              ? Colors.blue
                                              : FlutterFlowTheme.of(context)
                                                  .containerBG,
                                          borderRadius:
                                              BorderRadius.circular(24.0),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(12.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'FRIEND',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .titleMedium
                                                        .override(
                                                          font: GoogleFonts
                                                              .interTight(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleMedium
                                                                    .fontStyle,
                                                          ),
                                                          color: Colors.white,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .titleMedium
                                                                  .fontStyle,
                                                        ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ].divide(SizedBox(width: 8.0)),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    width: double.infinity,
                                    child: TextFormField(
                                      controller: _model.nameTextController,
                                      focusNode: _model.nameFocusNode,
                                      autofocus: false,
                                      textInputAction: TextInputAction.next,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        hintText: 'Name of the person',
                                        hintStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              font: GoogleFonts.inter(
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                              letterSpacing: 0.0,
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .alternate,
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0x00000000),
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0x00000000),
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        filled: true,
                                        fillColor: FlutterFlowTheme.of(context)
                                            .primaryBackground,
                                        contentPadding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                16.0, 16.0, 16.0, 16.0),
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.inter(
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                            letterSpacing: 0.0,
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                      keyboardType: TextInputType.name,
                                      cursorColor:
                                          FlutterFlowTheme.of(context).primary,
                                      validator: _model
                                          .nameTextControllerValidator
                                          .asValidator(context),
                                    ),
                                  ),
                                  Container(
                                    width: double.infinity,
                                    child: TextFormField(
                                      controller:
                                          _model.contactNumberTextController,
                                      focusNode: _model.contactNumberFocusNode,
                                      autofocus: false,
                                      textInputAction: TextInputAction.next,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        hintText:
                                            'Travel person\'s Contact Number',
                                        hintStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              font: GoogleFonts.inter(
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                              letterSpacing: 0.0,
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .alternate,
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0x00000000),
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0x00000000),
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        filled: true,
                                        fillColor: FlutterFlowTheme.of(context)
                                            .primaryBackground,
                                        contentPadding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                16.0, 16.0, 16.0, 16.0),
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.inter(
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                            letterSpacing: 0.0,
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                      keyboardType: TextInputType.phone,
                                      cursorColor:
                                          FlutterFlowTheme.of(context).primary,
                                      validator: _model
                                          .contactNumberTextControllerValidator
                                          .asValidator(context),
                                      inputFormatters: [
                                        _model.contactNumberMask
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: double.infinity,
                                    child: GooglePlaceAutoCompleteTextField(
                                      focusNode: _model.meetupAddressFocusNode,
                                      textEditingController: _model.meetupAddressTextController!,
                                      googleAPIKey: "AIzaSyDZkxRpoy0BOIAPwMaMIvAd5xpCe-6ZYvs",
                                      inputDecoration: InputDecoration(
                                        hintText: 'Address of meetup',
                                        hintStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              font: GoogleFonts.inter(
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                              letterSpacing: 0.0,
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .alternate,
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0x00000000),
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0x00000000),
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        filled: true,
                                        fillColor: FlutterFlowTheme.of(context)
                                            .primaryBackground,
                                        contentPadding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                16.0, 16.0, 16.0, 16.0),
                                      ),
                                      textStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.inter(
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                            letterSpacing: 0.0,
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                      debounceTime: 600,
                                      countries: ["in"],
                                      isLatLngRequired: true,
                                      getPlaceDetailWithLatLng: (prediction) {
                                        if (prediction.lat != null && prediction.lng != null) {
                                          _model.meetupLocationMap = LatLng(
                                            double.parse(prediction.lat!),
                                            double.parse(prediction.lng!),
                                          );
                                        }
                                      },
                                      itemClick: (prediction) {
                                        _model.meetupAddressTextController!.text = prediction.description ?? "";
                                        _model.meetupAddressTextController!.selection = TextSelection.fromPosition(
                                          TextPosition(offset: prediction.description?.length ?? 0),
                                        );
                                      },
                                      itemBuilder: (context, index, prediction) {
                                        return Container(
                                          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                                          child: Row(
                                            children: [
                                              Icon(Icons.location_on_outlined, size: 18.0, color: Color(0xFF4DABF7)),
                                              SizedBox(width: 10.0),
                                              Expanded(
                                                child: Text(
                                                  prediction.description ?? "",
                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(fontSize: 14.0),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                      seperatedBuilder: Divider(height: 1.0, thickness: 0.5),
                                      isCrossBtnShown: true,
                                    ),
                                  ),
                                  Container(
                                    width: double.infinity,
                                    child: TextFormField(
                                      controller: _model
                                          .additionalInformationTextController,
                                      focusNode:
                                          _model.additionalInformationFocusNode,
                                      autofocus: false,
                                      textInputAction: TextInputAction.done,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        hintText: 'Additional Information (Optional)',
                                        hintStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              font: GoogleFonts.inter(
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                              letterSpacing: 0.0,
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .alternate,
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0x00000000),
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0x00000000),
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        filled: true,
                                        fillColor: FlutterFlowTheme.of(context)
                                            .primaryBackground,
                                        contentPadding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                16.0, 16.0, 16.0, 16.0),
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.inter(
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                            letterSpacing: 0.0,
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                      maxLines: 3,
                                      keyboardType: TextInputType.multiline,
                                      cursorColor:
                                          FlutterFlowTheme.of(context).primary,
                                      validator: _model
                                          .additionalInformationTextControllerValidator
                                          .asValidator(context),
                                    ),
                                  ),
                                ].divide(SizedBox(height: 20.0)),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Theme(
                                    data: ThemeData(
                                      checkboxTheme: CheckboxThemeData(
                                        visualDensity: VisualDensity.compact,
                                        materialTapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(4.0),
                                        ),
                                      ),
                                      unselectedWidgetColor:
                                          FlutterFlowTheme.of(context)
                                              .alternate,
                                    ),
                                    child: Checkbox(
                                      value: _model.checkboxValue ??= true,
                                      onChanged: (newValue) async {
                                        safeSetState(() =>
                                            _model.checkboxValue = newValue!);
                                      },
                                      side: (FlutterFlowTheme.of(context)
                                                  .alternate !=
                                              null)
                                          ? BorderSide(
                                              width: 2,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .alternate!,
                                            )
                                          : null,
                                      activeColor:
                                          FlutterFlowTheme.of(context).primary,
                                      checkColor:
                                          FlutterFlowTheme.of(context).info,
                                    ),
                                  ),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return Dialog(
                                              insetPadding: EdgeInsets.all(16),
                                              child: NewTermsconditions11Widget(),
                                            );
                                          },
                                        );
                                      },
                                      child: Text(
                                        'Please Read our terms and conditions',
                                        style: FlutterFlowTheme.of(context)
                                            .bodySmall
                                            .override(
                                          font: GoogleFonts.inter(
                                            decoration: TextDecoration.underline, // Add underline
                                            fontWeight:
                                            FlutterFlowTheme.of(context)
                                                .bodySmall
                                                .fontWeight,
                                            fontStyle:
                                            FlutterFlowTheme.of(context)
                                                .bodySmall
                                                .fontStyle,
                                          ),
                                          color: FlutterFlowTheme.of(context)
                                              .primary, // Change color to indicate it's clickable
                                          letterSpacing: 0.0,
                                          fontWeight:
                                          FlutterFlowTheme.of(context)
                                              .bodySmall
                                              .fontWeight,
                                          fontStyle:
                                          FlutterFlowTheme.of(context)
                                              .bodySmall
                                              .fontStyle,
                                        ),
                                      ),
                                    ),
                                  ),                                ].divide(SizedBox(width: 12.0)),
                              ),
                              /// OLD CODE HERE !!
                              // FFButtonWidget(
                              //   onPressed: () async {
                              //     if (_model.bookingFor != null &&
                              //         _model.bookingFor != '') {
                              //       await showDialog(
                              //         context: context,
                              //         builder: (alertDialogContext) {
                              //           return AlertDialog(
                              //             title: Text('Attention Required'),
                              //             content: Text(
                              //                 'Please select the people you are booking the trip for. Such as yourself, your friends and family.'),
                              //             actions: [
                              //               TextButton(
                              //                 onPressed: () => Navigator.pop(
                              //                     alertDialogContext),
                              //                 child: Text('Ok'),
                              //               ),
                              //             ],
                              //           );
                              //         },
                              //       );
                              //     } else if (_model.nameTextController.text !=
                              //             null &&
                              //         _model.nameTextController.text != '') {
                              //       await showDialog(
                              //         context: context,
                              //         builder: (alertDialogContext) {
                              //           return AlertDialog(
                              //             title: Text('Attention Required'),
                              //             content: Text(
                              //                 'Please enter the full name of the passenger.'),
                              //             actions: [
                              //               TextButton(
                              //                 onPressed: () => Navigator.pop(
                              //                     alertDialogContext),
                              //                 child: Text('Ok'),
                              //               ),
                              //             ],
                              //           );
                              //         },
                              //       );
                              //     } else if (_model
                              //                 .contactNumberTextController.text !=
                              //             null &&
                              //         _model
                              //                 .contactNumberTextController.text !=
                              //             '') {
                              //       await showDialog(
                              //         context: context,
                              //         builder: (alertDialogContext) {
                              //           return AlertDialog(
                              //             title: Text('Attention Required'),
                              //             content: Text(
                              //                 'Please enter passenger mobile number.'),
                              //             actions: [
                              //               TextButton(
                              //                 onPressed: () => Navigator.pop(
                              //                     alertDialogContext),
                              //                 child: Text('Ok'),
                              //               ),
                              //             ],
                              //           );
                              //         },
                              //       );
                              //     } else if (_model.meetupAddressTextController
                              //                 .text !=
                              //             null &&
                              //         _model.meetupAddressTextController
                              //                 .text !=
                              //             '') {
                              //       await showDialog(
                              //         context: context,
                              //         builder: (alertDialogContext) {
                              //           return AlertDialog(
                              //             title: Text('Attention Required'),
                              //             content: Text(
                              //                 'Please enter the meetup address where passenger will meet the driver.'),
                              //             actions: [
                              //               TextButton(
                              //                 onPressed: () => Navigator.pop(
                              //                     alertDialogContext),
                              //                 child: Text('Ok'),
                              //               ),
                              //             ],
                              //           );
                              //         },
                              //       );
                              //     } else if (_model.checkboxValue == true) {
                              //       await showDialog(
                              //         context: context,
                              //         builder: (alertDialogContext) {
                              //           return AlertDialog(
                              //             title: Text('Attention Required'),
                              //             content: Text(
                              //                 'Please accept the Terms of Service and Privacy Policy.'),
                              //             actions: [
                              //               TextButton(
                              //                 onPressed: () => Navigator.pop(
                              //                     alertDialogContext),
                              //                 child: Text('Ok'),
                              //               ),
                              //             ],
                              //           );
                              //         },
                              //       );
                              //     } else if (_model.bookingFor == 'NotSet') {
                              //       ScaffoldMessenger.of(context).showSnackBar(
                              //         SnackBar(
                              //           content: Text(
                              //             'Select whether you are booking for yourself or a friend.',
                              //             style: TextStyle(
                              //               color: FlutterFlowTheme.of(context)
                              //                   .primaryText,
                              //             ),
                              //           ),
                              //           duration: Duration(milliseconds: 4000),
                              //           backgroundColor:
                              //               FlutterFlowTheme.of(context)
                              //                   .secondary,
                              //         ),
                              //       );
                              //     } else if ((_model
                              //                     .bookingFor !=
                              //                 null &&
                              //             _model.bookingFor != '') &&
                              //         (_model
                              //                     .nameTextController.text !=
                              //                 null &&
                              //             _model
                              //                     .nameTextController.text !=
                              //                 '') &&
                              //         (_model
                              //                     .contactNumberTextController.text !=
                              //                 null &&
                              //             _model.contactNumberTextController
                              //                     .text !=
                              //                 '') &&
                              //         (_model.meetupAddressTextController
                              //                     .text !=
                              //                 null &&
                              //             _model.meetupAddressTextController
                              //                     .text !=
                              //                 '') &&
                              //         (_model.checkboxValue == true)) {
                              //       await BookingsRecord.collection
                              //           .doc()
                              //           .set(createBookingsRecordData(
                              //             bookingType: 'Ride',
                              //             rideNameOfPerson:
                              //                 _model.nameTextController.text,
                              //             ridePersonContactNumber: _model
                              //                 .contactNumberTextController.text,
                              //             rideMeetupAddress: _model
                              //                 .meetupAddressTextController.text,
                              //             rideAdditionalInformation: _model
                              //                 .additionalInformationTextController
                              //                 .text,
                              //             status: 'Pending',
                              //             rideBookFor: _model.bookingFor,
                              //             createdTime: getCurrentTimestamp,
                              //             creator: currentUserReference,
                              //             rideID: widget!.rideID,
                              //             bookingFor: _model.bookingFor,
                              //           ));
                              //
                              //       context.goNamed(
                              //           RideBookingSentWidget.routeName);
                              //     } else {
                              //       await showDialog(
                              //         context: context,
                              //         builder: (alertDialogContext) {
                              //           return AlertDialog(
                              //             title: Text('Attention Required'),
                              //             content: Text(
                              //                 'Please fill in all the required details to book a ride.'),
                              //             actions: [
                              //               TextButton(
                              //                 onPressed: () => Navigator.pop(
                              //                     alertDialogContext),
                              //                 child: Text('Ok'),
                              //               ),
                              //             ],
                              //           );
                              //         },
                              //       );
                              //     }
                              //   },
                              //   text: 'Book Now',
                              //   options: FFButtonOptions(
                              //     width: double.infinity,
                              //     height: 56.0,
                              //     padding: EdgeInsets.all(8.0),
                              //     iconPadding: EdgeInsetsDirectional.fromSTEB(
                              //         0.0, 0.0, 0.0, 0.0),
                              //     color: Color(0xFFFF6B35),
                              //     textStyle: FlutterFlowTheme.of(context)
                              //         .titleMedium
                              //         .override(
                              //           font: GoogleFonts.interTight(
                              //             fontWeight: FontWeight.w600,
                              //             fontStyle:
                              //                 FlutterFlowTheme.of(context)
                              //                     .titleMedium
                              //                     .fontStyle,
                              //           ),
                              //           color: Colors.white,
                              //           letterSpacing: 0.0,
                              //           fontWeight: FontWeight.w600,
                              //           fontStyle: FlutterFlowTheme.of(context)
                              //               .titleMedium
                              //               .fontStyle,
                              //         ),
                              //     elevation: 0.0,
                              //     borderSide: BorderSide(
                              //       color: Colors.transparent,
                              //       width: 1.0,
                              //     ),
                              //     borderRadius: BorderRadius.circular(12.0),
                              //   ),
                              // ),
                              /// NEW CODE HERE !!
                              FFButtonWidget(
                                onPressed: () async {
                                  // ✅ 1. Check if bookingFor is NOT selected
                                  if (_model.bookingFor == null || _model.bookingFor!.isEmpty) {
                                    await showDialog(context: context, builder: (_) => AlertDialog(
                                      title: Text('Attention Required'),
                                      content: Text('Please select the people you are booking the trip for.'),
                                      actions: [TextButton(onPressed: () => Navigator.pop(_), child: Text('Ok'))],
                                    ));
                                    return;  // ✅ STOP HERE
                                  }

                                  // ✅ 2. Check name empty
                                  if (_model.nameTextController.text.isEmpty) {
                                    await showDialog(context: context, builder: (_) => AlertDialog(
                                      title: Text('Attention Required'),
                                      content: Text('Please enter the full name of the passenger.'),
                                      actions: [TextButton(onPressed: () => Navigator.pop(_), child: Text('Ok'))],
                                    ));
                                    return;
                                  }

                                  // ✅ 3. Check contact empty
                                  if (_model.contactNumberTextController.text.isEmpty) {
                                    await showDialog(context: context, builder: (_) => AlertDialog(
                                      title: Text('Attention Required'),
                                      content: Text('Please enter passenger mobile number.'),
                                      actions: [TextButton(onPressed: () => Navigator.pop(_), child: Text('Ok'))],
                                    ));
                                    return;
                                  }

                                  // ✅ 4. Check address empty
                                  if (_model.meetupAddressTextController.text.isEmpty) {
                                    await showDialog(context: context, builder: (_) => AlertDialog(
                                      title: Text('Attention Required'),
                                      content: Text('Please enter the meetup address.'),
                                      actions: [TextButton(onPressed: () => Navigator.pop(_), child: Text('Ok'))],
                                    ));
                                    return;
                                  }

                                  // ✅ 5. Check checkbox NOT checked
                                  if (_model.checkboxValue != true) {
                                    await showDialog(context: context, builder: (_) => AlertDialog(
                                      title: Text('Attention Required'),
                                      content: Text('Please accept Terms & Conditions.'),
                                      actions: [TextButton(onPressed: () => Navigator.pop(_), child: Text('Ok'))],
                                    ));
                                    return;
                                  }

                                  // ✅ ALL VALID → BOOK RIDE!
                                  await BookingsRecord.collection.doc().set(createBookingsRecordData(
                                    bookingType: 'Ride',
                                    rideNameOfPerson: _model.nameTextController.text,
                                    ridePersonContactNumber: _model.contactNumberTextController.text,
                                    rideMeetupAddress: _model.meetupAddressTextController.text,
                                    meetupLocationMap: _model.meetupLocationMap,
                                    rideAdditionalInformation: _model.additionalInformationTextController.text,
                                    status: 'Pending',
                                    rideBookFor: _model.bookingFor,
                                    createdTime: getCurrentTimestamp,
                                    creator: currentUserReference,
                                    rideID: widget.rideID,
                                    bookingFor: _model.bookingFor,
                                  ));

                                  // Send push notification to driver
                                  try {
                                    final rideRef = widget.rideID;
                                    if (rideRef != null) {
                                      final rideSnapshot = await rideRef.get();
                                      if (rideSnapshot.exists) {
                                        final rideData = rideSnapshot.data() as Map<String, dynamic>?;
                                        final DocumentReference? driverRef = rideData?['creatorID'] as DocumentReference?;
                                        if (driverRef != null) {
                                          final driverSnapshot = await driverRef.get();
                                          if (driverSnapshot.exists) {
                                            final driverData = driverSnapshot.data() as Map<String, dynamic>?;
                                            String? fcmToken;
                                            if (driverData?['fcmToken'] != null) {
                                              fcmToken = driverData!['fcmToken'] as String?;
                                            } else if (driverData?['fcmTokens'] is List && (driverData!['fcmTokens'] as List).isNotEmpty) {
                                              fcmToken = (driverData['fcmTokens'] as List).first as String?;
                                            }

                                            if (fcmToken != null && fcmToken.isNotEmpty) {
                                              await FirebaseFunctions.instance.httpsCallable('sendChatNotification').call({
                                                'token': fcmToken,
                                                'senderName': currentUserDisplayName.isNotEmpty ? currentUserDisplayName : 'Travia Customer',
                                                'message': 'A passenger wants to book a seat on your ride!',
                                                'chatId': '',
                                              });
                                              print('✅ Ride booking push notification sent to driver: ${driverRef.id}');
                                            } else {
                                              print('⚠️ Driver has no FCM token for ride notification');
                                            }
                                          }
                                        }
                                      }
                                    }
                                  } catch (e) {
                                    print('❌ Non-fatal ride booking notification error: $e');
                                  }

                                  context.goNamed(RideBookingSentWidget.routeName);
                                },
                                text: 'Book Now',
                                options: FFButtonOptions(
                                  width: double.infinity,
                                  height: 56.0,
                                  padding: EdgeInsets.all(8.0),
                                  color: Color(0xFFFF6B35),
                                  textStyle: FlutterFlowTheme.of(context).titleMedium.override(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                              ),

                            ].divide(SizedBox(height: 24.0)),
                          ),
                        ),
                      ),
                    ).animateOnPageLoad(
                        animationsMap['containerOnPageLoadAnimation']!),
                  ].divide(SizedBox(height: 24.0)),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
