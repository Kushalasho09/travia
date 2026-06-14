import 'package:auto_size_text/auto_size_text.dart';

import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/compotement/main_footer/main_footer_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_google_map.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:math';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:map_launcher/map_launcher.dart' as $ml;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'ride_details_customer_model.dart';
export 'ride_details_customer_model.dart';

class RideDetailsCustomerWidget extends StatefulWidget {
  const RideDetailsCustomerWidget({
    super.key,
    required this.rideDetails,
  });

  /// for driver who posted this ride
  final DocumentReference? rideDetails;

  static String routeName = 'RideDetailsCustomer';
  static String routePath = '/rideDetailsCustomer';

  @override
  State<RideDetailsCustomerWidget> createState() => _RideDetailsCustomerWidgetState();
}

class _RideDetailsCustomerWidgetState extends State<RideDetailsCustomerWidget> with TickerProviderStateMixin {
  late RideDetailsCustomerModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => RideDetailsCustomerModel());

    animationsMap.addAll({
      'columnOnPageLoadAnimation': AnimationInfo(
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
      'containerOnPageLoadAnimation': AnimationInfo(
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
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<RidesNewRecord>(
      stream: RidesNewRecord.getDocument(widget!.rideDetails!),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
            body: Center(
              child: SizedBox(
                width: 50.0,
                height: 50.0,
                child: SpinKitFadingCircle(
                  color: Color(0xFF2B3C58),
                  size: 50.0,
                ),
              ),
            ),
          );
        }

        final rideDetailsCustomerRidesNewRecord = snapshot.data!;

        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            resizeToAvoidBottomInset: false,
            backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
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
                'View Ride Details',
                style: FlutterFlowTheme.of(context).headlineMedium.override(
                      font: GoogleFonts.interTight(
                        fontWeight: FlutterFlowTheme.of(context).headlineMedium.fontWeight,
                        fontStyle: FlutterFlowTheme.of(context).headlineMedium.fontStyle,
                      ),
                      color: FlutterFlowTheme.of(context).primaryText,
                      fontSize: 22.0,
                      letterSpacing: 0.0,
                      fontWeight: FlutterFlowTheme.of(context).headlineMedium.fontWeight,
                      fontStyle: FlutterFlowTheme.of(context).headlineMedium.fontStyle,
                    ),
              ),
              actions: [],
              centerTitle: true,
              elevation: 2.0,
            ),
            body: SafeArea(
              top: true,
              child: StreamBuilder<UsersRecord>(
                stream: UsersRecord.getDocument(rideDetailsCustomerRidesNewRecord.creatorID!),
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

                  final columnUsersRecord = snapshot.data!;

                  return Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: ListView(
                          padding: EdgeInsets.zero,
                          primary: false,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          children: [
                            SingleChildScrollView(
                              primary: false,
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(10.0, 15.0, 10.0, 0.0),
                                    child: SingleChildScrollView(
                                      primary: false,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  InkWell(
                                                    splashColor: Colors.transparent,
                                                    focusColor: Colors.transparent,
                                                    hoverColor: Colors.transparent,
                                                    highlightColor: Colors.transparent,
                                                    onTap: () async {
                                                      context.pushNamed(
                                                        DriverReviewWidget.routeName,
                                                        queryParameters: {
                                                          'userRef': serializeParam(
                                                            columnUsersRecord.reference,
                                                            ParamType.DocumentReference,
                                                          ),
                                                        }.withoutNulls,
                                                      );
                                                    },
                                                    child: Builder(
                                                      builder: (context) {
                                                        if (columnUsersRecord.photoUrl != null && columnUsersRecord.photoUrl != '') {
                                                          return Container(
                                                            width: 80.0,
                                                            height: 80.0,
                                                            clipBehavior: Clip.antiAlias,
                                                            decoration: BoxDecoration(
                                                              shape: BoxShape.circle,
                                                            ),
                                                            child: Image.network(
                                                              columnUsersRecord.photoUrl,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          );
                                                        } else {
                                                          return InkWell(
                                                            splashColor: Colors.transparent,
                                                            focusColor: Colors.transparent,
                                                            hoverColor: Colors.transparent,
                                                            highlightColor: Colors.transparent,
                                                            onTap: () async {
                                                              context.pushNamed(
                                                                DriverReviewWidget.routeName,
                                                                queryParameters: {
                                                                  'userRef': serializeParam(
                                                                    columnUsersRecord.reference,
                                                                    ParamType.DocumentReference,
                                                                  ),
                                                                }.withoutNulls,
                                                              );
                                                            },
                                                            child: Container(
                                                              width: 80.0,
                                                              height: 80.0,
                                                              clipBehavior: Clip.antiAlias,
                                                              decoration: BoxDecoration(
                                                                shape: BoxShape.circle,
                                                              ),
                                                              child: Image.asset(
                                                                'assets/images/userIconTr.png',
                                                                fit: BoxFit.cover,
                                                              ),
                                                            ),
                                                          );
                                                        }
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Expanded(
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.max,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    InkWell(
                                                      splashColor: Colors.transparent,
                                                      focusColor: Colors.transparent,
                                                      hoverColor: Colors.transparent,
                                                      highlightColor: Colors.transparent,
                                                      onTap: () async {
                                                        context.pushNamed(
                                                          DriverReviewWidget.routeName,
                                                          queryParameters: {
                                                            'userRef': serializeParam(
                                                              columnUsersRecord.reference,
                                                              ParamType.DocumentReference,
                                                            ),
                                                          }.withoutNulls,
                                                        );
                                                      },
                                                      child: Text(
                                                        columnUsersRecord.displayName,
                                                        textAlign: TextAlign.center,
                                                        style: FlutterFlowTheme.of(context).headlineSmall.override(
                                                              font: GoogleFonts.interTight(
                                                                fontWeight: FontWeight.bold,
                                                                fontStyle: FlutterFlowTheme.of(context).headlineSmall.fontStyle,
                                                              ),
                                                              color: FlutterFlowTheme.of(context).primaryText,
                                                              fontSize: 16.0,
                                                              letterSpacing: 0.0,
                                                              fontWeight: FontWeight.bold,
                                                              fontStyle: FlutterFlowTheme.of(context).headlineSmall.fontStyle,
                                                            ),
                                                      ),
                                                    ),
                                                    Row(
                                                      mainAxisSize: MainAxisSize.max,
                                                      children: [
                                                        Align(
                                                          alignment: AlignmentDirectional(0.0, 0.0),
                                                          child: Container(
                                                            width: 30.0,
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
                                                                      width: 25.0,
                                                                      height: 30.0,
                                                                      fit: BoxFit.cover,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    valueOrDefault<String>(
                                                                      formatNumber(
                                                                        functions.averageRating(columnUsersRecord.ratings.toList()),
                                                                        formatType: FormatType.compact,
                                                                      ),
                                                                      '0',
                                                                    ),
                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                          font: GoogleFonts.inter(
                                                                            fontWeight: FontWeight.w900,
                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                          color: FlutterFlowTheme.of(context).primaryBackground,
                                                                          fontSize: 9.0,
                                                                          letterSpacing: 0.0,
                                                                          fontWeight: FontWeight.w900,
                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                        ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Text(
                                                          'Verified Profile',
                                                          style: FlutterFlowTheme.of(context).labelMedium.override(
                                                                font: GoogleFonts.inter(
                                                                  fontWeight: FontWeight.w600,
                                                                  fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                                ),
                                                                color: Color(0xFF5BB97E),
                                                                fontSize: 10.0,
                                                                letterSpacing: 0.0,
                                                                fontWeight: FontWeight.w600,
                                                                fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                              ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisSize: MainAxisSize.max,
                                                      children: [
                                                        if (rideDetailsCustomerRidesNewRecord.modeOfTransport == 'Car')
                                                          Padding(
                                                            padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
                                                            child: FaIcon(
                                                              FontAwesomeIcons.carSide,
                                                              color: FlutterFlowTheme.of(context).iconColours,
                                                              size: 20.0,
                                                            ),
                                                          ),
                                                        if (rideDetailsCustomerRidesNewRecord.modeOfTransport == 'Train')
                                                          Padding(
                                                            padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
                                                            child: Icon(
                                                              Icons.train,
                                                              color: FlutterFlowTheme.of(context).iconColours,
                                                              size: 30.0,
                                                            ),
                                                          ),
                                                        if (rideDetailsCustomerRidesNewRecord.modeOfTransport == 'Bike')
                                                          Padding(
                                                            padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
                                                            child: Icon(
                                                              Icons.motorcycle_sharp,
                                                              color: FlutterFlowTheme.of(context).iconColours,
                                                              size: 30.0,
                                                            ),
                                                          ),
                                                        if (rideDetailsCustomerRidesNewRecord.modeOfTransport == 'Bus')
                                                          Padding(
                                                            padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
                                                            child: FaIcon(
                                                              FontAwesomeIcons.bus,
                                                              color: FlutterFlowTheme.of(context).iconColours,
                                                              size: 20.0,
                                                            ),
                                                          ),
                                                      ].divide(SizedBox(width: 8.0)),
                                                    ),
                                                  ].divide(SizedBox(height: 7.0)),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
                                                child: Container(
                                                  width: 50.0,
                                                  height: 50.0,
                                                  clipBehavior: Clip.antiAlias,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: Image.asset(
                                                    'assets/images/verofy.png',
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            ].divide(SizedBox(width: 10.0)),
                                          ),
                                          Divider(
                                            thickness: 0.5,
                                            color: FlutterFlowTheme.of(context).secondaryText,
                                          ),
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(12.0),
                                            child: Container(
                                              width: double.infinity,
                                              height: 45.0,
                                              decoration: BoxDecoration(
                                                color: Colors.grey[300],
                                                borderRadius: BorderRadius.circular(12.0),
                                              ),
                                              child: Row(
                                                children: [
                                                  // RIDE ON on left
                                                  Expanded(
                                                    flex: 1,
                                                    child: Center(
                                                      child: Text(
                                                        'RIDE ON',
                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                          font: GoogleFonts.inter(fontWeight: FontWeight.w600),
                                                          color: Colors.grey[800],
                                                          fontSize: 14.0,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  // Orange container touching right end - NO right radius
                                                  Expanded(
                                                    flex: 2,
                                                    child: Container(
                                                      height: double.infinity,
                                                      decoration: BoxDecoration(
                                                        color: Color(0xFFF97E4C),
                                                        borderRadius: BorderRadiusDirectional.only(
                                                          topStart: Radius.circular(12.0),  // ✅ Only left corners curved
                                                          bottomStart: Radius.circular(12.0),
                                                        ),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          dateTimeFormat("EEEE, MMM d", rideDetailsCustomerRidesNewRecord.pickupTime!),
                                                          textAlign: TextAlign.center,
                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                            font: GoogleFonts.inter(fontWeight: FontWeight.bold),
                                                            color: Colors.white,
                                                            fontSize: 14.0,
                                                          ),
                                                        ),

                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Material(
                                            color: Colors.transparent,
                                            elevation: 10.0,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(16.0),
                                            ),
                                            child: Container(
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                color: FlutterFlowTheme.of(context).containerBG,
                                                boxShadow: [
                                                  BoxShadow(
                                                    blurRadius: 4.0,
                                                    color: Color(0x33000000),
                                                    offset: Offset(
                                                      0.0,
                                                      2.0,
                                                    ),
                                                  )
                                                ],
                                                borderRadius: BorderRadius.circular(16.0),
                                                border: Border.all(
                                                  color: FlutterFlowTheme.of(context).accent2,
                                                ),
                                              ),
                                              child: Stack(
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 10.0),
                                                    child: Column(
                                                      mainAxisSize: MainAxisSize.max,
                                                      children: [
                                                        Row(
                                                          mainAxisSize: MainAxisSize.max,
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Padding(
                                                              padding: EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 5.0, 10.0),
                                                              child: Column(
                                                                mainAxisSize: MainAxisSize.max,
                                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                children: [
                                                                  SingleChildScrollView(
                                                                    scrollDirection: Axis.horizontal,
                                                                    child: Row(
                                                                      mainAxisSize: MainAxisSize.max,
                                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                      children: [
                                                                        Row(
                                                                          mainAxisSize: MainAxisSize.max,
                                                                          children: [
                                                                            Icon(
                                                                              Icons.location_on_outlined,
                                                                              color: FlutterFlowTheme.of(context).primary,
                                                                              size: 24.0,
                                                                            ),
                                                                            Container(
                                                                              width: 200.0,
                                                                              decoration: BoxDecoration(
                                                                                color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                borderRadius: BorderRadius.circular(15.0),
                                                                              ),
                                                                              child: Padding(
                                                                                padding: EdgeInsetsDirectional.fromSTEB(15.0, 5.0, 10.0, 5.0),
                                                                                child: Column(
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  children: [
                                                                                    Text(
                                                                                      rideDetailsCustomerRidesNewRecord.googleStartAddress != null && rideDetailsCustomerRidesNewRecord.googleStartAddress != '' ? rideDetailsCustomerRidesNewRecord.googleStartAddress! : rideDetailsCustomerRidesNewRecord.rideStartLocation,
                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                            font: GoogleFonts.inter(
                                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                            ),
                                                                                            fontSize: 13.0,
                                                                                            letterSpacing: 0.0,
                                                                                            fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                          ),
                                                                                    ),
                                                                                    if (rideDetailsCustomerRidesNewRecord.pickupTime != null)
                                                                                      Padding(
                                                                                        padding: EdgeInsets.only(top: 4.0),
                                                                                        child: Text(
                                                                                          'Departure: ${dateTimeFormat("hh:mm a", rideDetailsCustomerRidesNewRecord.pickupTime).toLowerCase()}',
                                                                                          style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                                font: GoogleFonts.inter(
                                                                                                  fontWeight: FontWeight.w500,
                                                                                                ),
                                                                                                color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                fontSize: 11.0,
                                                                                              ),
                                                                                        ),
                                                                                      ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ].divide(SizedBox(width: 5.0)),
                                                                    ),
                                                                  ),
                                                                  if (rideDetailsCustomerRidesNewRecord.travelTime != null && rideDetailsCustomerRidesNewRecord.travelTime != '')
                                                                    Align(
                                                                      alignment: AlignmentDirectional(0.0, 0.0),
                                                                      child: Row(
                                                                        mainAxisSize: MainAxisSize.max,
                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                        children: [
                                                                          Align(
                                                                            alignment: AlignmentDirectional(0.0, 0.0),
                                                                            child: Text(
                                                                              'Travel time: ',
                                                                              style: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                    font: GoogleFonts.inter(
                                                                                      fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
                                                                                      fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                                                    ),
                                                                                    color: FlutterFlowTheme.of(context).secondaryText,
                                                                                    fontSize: 12.0,
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
                                                                                    fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                                                  ),
                                                                            ),
                                                                          ),
                                                                          Align(
                                                                            alignment: AlignmentDirectional(0.0, 0.0),
                                                                            child: Text(
                                                                              rideDetailsCustomerRidesNewRecord.travelTime,
                                                                              style: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                    font: GoogleFonts.inter(
                                                                                      fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
                                                                                      fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                                                    ),
                                                                                    color: FlutterFlowTheme.of(context).secondaryText,
                                                                                    fontSize: 12.0,
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
                                                                                    fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                                                  ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  Row(
                                                                    mainAxisSize: MainAxisSize.max,
                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                    children: [
                                                                      Row(
                                                                        mainAxisSize: MainAxisSize.max,
                                                                        children: [
                                                                          Icon(
                                                                            Icons.location_on_outlined,
                                                                            color: FlutterFlowTheme.of(context).primary,
                                                                            size: 24.0,
                                                                          ),
                                                                          Container(
                                                                            width: 200.0,
                                                                            decoration: BoxDecoration(
                                                                              color: FlutterFlowTheme.of(context).primaryBackground,
                                                                              borderRadius: BorderRadius.circular(15.0),
                                                                            ),
                                                                            child: Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(15.0, 5.0, 10.0, 5.0),
                                                                              child: Column(
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  Text(
                                                                                    rideDetailsCustomerRidesNewRecord.googleEndAddress != null && rideDetailsCustomerRidesNewRecord.googleEndAddress != '' ? rideDetailsCustomerRidesNewRecord.googleEndAddress! : rideDetailsCustomerRidesNewRecord.rideEndLocation,
                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                          font: GoogleFonts.inter(
                                                                                            fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                          ),
                                                                                          fontSize: 13.0,
                                                                                          letterSpacing: 0.0,
                                                                                          fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                        ),
                                                                                  ),
                                                                                  if (rideDetailsCustomerRidesNewRecord.dropTime != null)
                                                                                    Padding(
                                                                                      padding: EdgeInsets.only(top: 4.0),
                                                                                      child: Text(
                                                                                        'Arrival: ${dateTimeFormat("hh:mm a", rideDetailsCustomerRidesNewRecord.dropTime).toLowerCase()}',
                                                                                        style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                              font: GoogleFonts.inter(
                                                                                                fontWeight: FontWeight.w500,
                                                                                              ),
                                                                                              color: FlutterFlowTheme.of(context).secondaryText,
                                                                                              fontSize: 11.0,
                                                                                            ),
                                                                                      ),
                                                                                    ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ].divide(SizedBox(width: 5.0)),
                                                                  ),
                                                                ].divide(SizedBox(height: 12.0)),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        // Padding(
                                                        //   padding: EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 5.0),
                                                        //   child: Row(
                                                        //     mainAxisSize: MainAxisSize.max,
                                                        //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                        //     children: [
                                                        //       Column(
                                                        //         mainAxisSize: MainAxisSize.max,
                                                        //         children: [
                                                        //           Text(
                                                        //             'Start At',
                                                        //             textAlign: TextAlign.start,
                                                        //             style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                        //                   font: GoogleFonts.inter(
                                                        //                     fontWeight: FontWeight.w500,
                                                        //                     fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                        //                   ),
                                                        //                   fontSize: 15.0,
                                                        //                   letterSpacing: 0.0,
                                                        //                   fontWeight: FontWeight.w500,
                                                        //                   fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                        //                 ),
                                                        //           ),
                                                        //           Text(
                                                        //             dateTimeFormat("d/M h:mm a", rideDetailsCustomerRidesNewRecord.pickupTime!),
                                                        //             textAlign: TextAlign.start,
                                                        //             style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                        //                   font: GoogleFonts.inter(
                                                        //                     fontWeight: FontWeight.w500,
                                                        //                     fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                        //                   ),
                                                        //                   fontSize: 15.0,
                                                        //                   letterSpacing: 0.0,
                                                        //                   fontWeight: FontWeight.w500,
                                                        //                   fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                        //                 ),
                                                        //           ),
                                                        //         ],
                                                        //       ),
                                                        //       Column(
                                                        //         mainAxisSize: MainAxisSize.max,
                                                        //         children: [
                                                        //           Text(
                                                        //             'End At',
                                                        //             textAlign: TextAlign.start,
                                                        //             style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                        //                   font: GoogleFonts.inter(
                                                        //                     fontWeight: FontWeight.w500,
                                                        //                     fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                        //                   ),
                                                        //                   fontSize: 15.0,
                                                        //                   letterSpacing: 0.0,
                                                        //                   fontWeight: FontWeight.w500,
                                                        //                   fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                        //                 ),
                                                        //           ),
                                                        //           Padding(
                                                        //             padding: EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 0.0, 0.0),
                                                        //             child: Text(
                                                        //               dateTimeFormat("d/M h:mm a", rideDetailsCustomerRidesNewRecord.dropTime!),
                                                        //               textAlign: TextAlign.start,
                                                        //               style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                        //                     font: GoogleFonts.inter(
                                                        //                       fontWeight: FontWeight.w500,
                                                        //                       fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                        //                     ),
                                                        //                     fontSize: 15.0,
                                                        //                     letterSpacing: 0.0,
                                                        //                     fontWeight: FontWeight.w500,
                                                        //                     fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                        //                   ),
                                                        //             ),
                                                        //           ),
                                                        //         ],
                                                        //       ),
                                                        //     ].divide(SizedBox(width: 5.0)),
                                                        //   ),
                                                        // ),
                                                      ].divide(SizedBox(height: 5.0)),
                                                    ),
                                                  ),
                                                  // Align(
                                                  //   alignment: AlignmentDirectional(0.97, 0.96),
                                                  //   child: Padding(
                                                  //     padding: EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 5.0, 0.0),
                                                  //     child: Container(
                                                  //       width: 80.0,
                                                  //       height: 90.0,
                                                  //       decoration: BoxDecoration(
                                                  //         color: Color(0xFFF97E4C),
                                                  //         borderRadius: BorderRadius.circular(12.0),
                                                  //       ),
                                                  //       child: Column(
                                                  //         mainAxisSize: MainAxisSize.max,
                                                  //         children: [
                                                  //           Padding(
                                                  //             padding: EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
                                                  //             child: Text(
                                                  //               'Ride',
                                                  //               style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                  //                     font: GoogleFonts.inter(
                                                  //                       fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                  //                       fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                  //                     ),
                                                  //                     color: FlutterFlowTheme.of(context).info,
                                                  //                     fontSize: 12.0,
                                                  //                     letterSpacing: 0.0,
                                                  //                     fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                  //                     fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                  //                   ),
                                                  //             ),
                                                  //           ),
                                                  //           Padding(
                                                  //             padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 4.0),
                                                  //             child: Text(
                                                  //               '₹${valueOrDefault<String>(
                                                  //                 rideDetailsCustomerRidesNewRecord.rideCost.toString(),
                                                  //                 '0',
                                                  //               )}',
                                                  //               style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                  //                     font: GoogleFonts.inter(
                                                  //                       fontWeight: FontWeight.bold,
                                                  //                       fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                  //                     ),
                                                  //                     color: FlutterFlowTheme.of(context).info,
                                                  //                     fontSize: 15.0,
                                                  //                     letterSpacing: 0.0,
                                                  //                     fontWeight: FontWeight.bold,
                                                  //                     fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                  //                   ),
                                                  //             ),
                                                  //           ),
                                                  //           Container(
                                                  //             width: double.infinity,
                                                  //             height: 50.0,
                                                  //             decoration: BoxDecoration(
                                                  //               color: Color(0xFFFF9561),
                                                  //               borderRadius: BorderRadius.only(
                                                  //                 bottomLeft: Radius.circular(10.0),
                                                  //                 bottomRight: Radius.circular(10.0),
                                                  //                 topLeft: Radius.circular(10.0),
                                                  //                 topRight: Radius.circular(10.0),
                                                  //               ),
                                                  //             ),
                                                  //             child: Column(
                                                  //               mainAxisSize: MainAxisSize.max,
                                                  //               mainAxisAlignment: MainAxisAlignment.start,
                                                  //               children: [
                                                  //                 Padding(
                                                  //                   padding: EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
                                                  //                   child: Text(
                                                  //                     'Parcel',
                                                  //                     textAlign: TextAlign.center,
                                                  //                     style: FlutterFlowTheme.of(context).labelSmall.override(
                                                  //                           font: GoogleFonts.inter(
                                                  //                             fontWeight: FontWeight.w500,
                                                  //                             fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
                                                  //                           ),
                                                  //                           color: FlutterFlowTheme.of(context).info,
                                                  //                           fontSize: 12.0,
                                                  //                           letterSpacing: 0.0,
                                                  //                           fontWeight: FontWeight.w500,
                                                  //                           fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
                                                  //                         ),
                                                  //                   ),
                                                  //                 ),
                                                  //                 Text(
                                                  //                   '₹${rideDetailsCustomerRidesNewRecord.totalDeliveryCost}',
                                                  //                   textAlign: TextAlign.center,
                                                  //                   style: FlutterFlowTheme.of(context).labelSmall.override(
                                                  //                         font: GoogleFonts.inter(
                                                  //                           fontWeight: FontWeight.bold,
                                                  //                           fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
                                                  //                         ),
                                                  //                         color: FlutterFlowTheme.of(context).info,
                                                  //                         fontSize: 15.0,
                                                  //                         letterSpacing: 0.0,
                                                  //                         fontWeight: FontWeight.bold,
                                                  //                         fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
                                                  //                       ),
                                                  //                 ),
                                                  //               ].divide(SizedBox(height: 4.0)),
                                                  //             ),
                                                  //           ),
                                                  //         ],
                                                  //       ),
                                                  //     ),
                                                  //   ),
                                                  // ),
                                                  Align(
                                                    alignment: AlignmentDirectional(0.97, -0.96),
                                                    child: Padding(
                                                      padding: EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 5.0, 0.0),
                                                      child: Container(
                                                        // ✅ RESPONSIVE SIZING
                                                        width: MediaQuery.sizeOf(context).width * 0.12,  // 12% of screen width
                                                        constraints: BoxConstraints(
                                                          minWidth: 65.0,    // Minimum width
                                                          maxWidth: 70.0,    // Maximum width
                                                          minHeight: 85.0,   // Minimum height
                                                          maxHeight: 100.0,  // Maximum height
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
                                                                  // '₹${rideDetailsCustomerRidesNewRecord.pricePerPassengers.toString()}',

                                                                '₹${formatNumber(rideDetailsCustomerRidesNewRecord.pricePerPassengers, formatType: FormatType.custom, format: '', locale: '')}',
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
                                                                    '₹${rideDetailsCustomerRidesNewRecord.totalDeliveryCost}',
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
                                              ),
                                            ),
                                          ).animateOnPageLoad(animationsMap['containerOnPageLoadAnimation']!),
                                          
                                          Divider(
                                            thickness: 0.5,
                                            color: FlutterFlowTheme.of(context).secondaryText,
                                          ),
                                          Material(
                                            color: Colors.transparent,
                                            elevation: 10.0,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(16.0),
                                            ),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: FlutterFlowTheme.of(context).primaryBackground,
                                                borderRadius: BorderRadius.circular(16.0),
                                                border: Border.all(
                                                  color: FlutterFlowTheme.of(context).accent2,
                                                ),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 10.0),
                                                child: SingleChildScrollView(
                                                  primary: false,
                                                  child: Column(
                                                    mainAxisSize: MainAxisSize.max,
                                                    children: [
                                                      if (rideDetailsCustomerRidesNewRecord.modeOfTransport == 'Car')
                                                        Padding(
                                                          padding: EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 10.0),
                                                          child: Column(
                                                            children: [
                                                              // Row 1: Passengers allowed
                                                              Row(
                                                                mainAxisSize: MainAxisSize.max,
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                children: [
                                                                  Text(
                                                                    'Passengers allowed?',
                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                      font: GoogleFonts.inter(fontWeight: FontWeight.w500),
                                                                      fontSize: 15.0,
                                                                      color: FlutterFlowTheme.of(context).primaryText,
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    width: 80.0,  // ✅ Fixed width for all containers
                                                                    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                                                                    alignment: Alignment.center,
                                                                    decoration: BoxDecoration(
                                                                      color: Color(0xFF4DABF7).withOpacity(0.1),
                                                                      borderRadius: BorderRadius.circular(20.0),
                                                                      border: Border.all(color: Color(0xFF4DABF7), width: 1.0),
                                                                    ),
                                                                    child: Text(
                                                                      rideDetailsCustomerRidesNewRecord.isPassangerAllowedinCar,
                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                        font: GoogleFonts.inter(fontWeight: FontWeight.w600),
                                                                        fontSize: 14.0,
                                                                        color: Color(0xFF4DABF7),
                                                                      ),
                                                                      textAlign: TextAlign.center,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(height: 12.0),  // ✅ Consistent spacing

                                                              // Row 2: Passengers limit
                                                              Row(
                                                                mainAxisSize: MainAxisSize.max,
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                children: [
                                                                  Text(
                                                                    'Passengers limit',
                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                      font: GoogleFonts.inter(fontWeight: FontWeight.w500),
                                                                      fontSize: 15.0,
                                                                      color: FlutterFlowTheme.of(context).primaryText,
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    width: 80.0,  // ✅ Fixed width
                                                                    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                                                                    alignment: Alignment.center,
                                                                    decoration: BoxDecoration(
                                                                      color: Color(0xFF4DABF7).withOpacity(0.1),
                                                                      borderRadius: BorderRadius.circular(20.0),
                                                                      border: Border.all(color: Color(0xFF4DABF7), width: 1.0),
                                                                    ),
                                                                    child: Text(
                                                                      rideDetailsCustomerRidesNewRecord.numPassengers.toString(),
                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                        font: GoogleFonts.inter(fontWeight: FontWeight.w600),
                                                                        fontSize: 14.0,
                                                                        color: Color(0xFF4DABF7),
                                                                      ),
                                                                      textAlign: TextAlign.center,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(height: 12.0),  // ✅ Consistent spacing

                                                              // Row 3: Price per passenger
                                                              Row(
                                                                mainAxisSize: MainAxisSize.max,
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                children: [
                                                                  Text(
                                                                    'Price per passenger',
                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                      font: GoogleFonts.inter(fontWeight: FontWeight.w500),
                                                                      fontSize: 15.0,
                                                                      color: FlutterFlowTheme.of(context).primaryText,
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    width: 80.0,  // ✅ Fixed width
                                                                    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                                                                    alignment: Alignment.center,
                                                                    decoration: BoxDecoration(
                                                                      color: Color(0xFFFF8C00).withOpacity(0.1),
                                                                      borderRadius: BorderRadius.circular(20.0),
                                                                      border: Border.all(color: Color(0xFFFF8C00), width: 1.0),
                                                                    ),
                                                                    child: Text(
                                                                      '₹${rideDetailsCustomerRidesNewRecord.pricePerPassengers.toString()}',
                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                        font: GoogleFonts.inter(fontWeight: FontWeight.w600),
                                                                        fontSize: 14.0,
                                                                        color: Color(0xFFFF8C00),
                                                                      ),
                                                                      textAlign: TextAlign.center,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(height: 12.0),  // ✅ Consistent spacing

                                                              // Row 4: Bags allowed
                                                              Row(
                                                                mainAxisSize: MainAxisSize.max,
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                children: [
                                                                  Text(
                                                                    'No. of bags allowed',
                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                      font: GoogleFonts.inter(fontWeight: FontWeight.w500),
                                                                      fontSize: 15.0,
                                                                      color: FlutterFlowTheme.of(context).primaryText,
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    width: 80.0,  // ✅ Fixed width
                                                                    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                                                                    alignment: Alignment.center,
                                                                    decoration: BoxDecoration(
                                                                      color: Color(0xFF4DABF7).withOpacity(0.1),
                                                                      borderRadius: BorderRadius.circular(20.0),
                                                                      border: Border.all(color: Color(0xFF4DABF7), width: 1.0),
                                                                    ),
                                                                    child: Text(
                                                                      rideDetailsCustomerRidesNewRecord.numBagAllowed == 0
                                                                          ? "1"
                                                                          : rideDetailsCustomerRidesNewRecord.numBagAllowed.toString(),
                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                        font: GoogleFonts.inter(fontWeight: FontWeight.w600),
                                                                        fontSize: 14.0,
                                                                        color: Color(0xFF4DABF7),
                                                                      ),
                                                                      textAlign: TextAlign.center,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),

                                                      Padding(
                                                        padding: EdgeInsetsDirectional.fromSTEB(5.0, 15.0, 0.0, 0.0),
                                                        child: Text(
                                                          'What parcel you can send?',
                                                          textAlign: TextAlign.start,
                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                font: GoogleFonts.inter(
                                                                  fontWeight: FontWeight.w500,
                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                ),
                                                                color: Color(0xFF2B3E60),
                                                                fontSize: 15.0,
                                                                letterSpacing: 0.0,
                                                                fontWeight: FontWeight.w500,
                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                              ),
                                                        ),
                                                      ),
                                                      if (rideDetailsCustomerRidesNewRecord.isPredefinedItems == true)
                                                        Align(
                                                          alignment: AlignmentDirectional(0.0, 0.0),
                                                          child: Padding(
                                                            padding: EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 32.0),
                                                            child: Wrap(
                                                              spacing: 10.0,
                                                              runSpacing: 10.0,
                                                              alignment: WrapAlignment.start,
                                                              crossAxisAlignment: WrapCrossAlignment.start,
                                                              direction: Axis.horizontal,
                                                              runAlignment: WrapAlignment.start,
                                                              verticalDirection: VerticalDirection.down,
                                                              clipBehavior: Clip.none,
                                                              children: [
                                                                Container(
                                                                  decoration: BoxDecoration(
                                                                    color: Color(0xFFF4F4F4),
                                                                    borderRadius: BorderRadius.circular(20.0),
                                                                  ),
                                                                  child: Padding(
                                                                    padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
                                                                    child: InkWell(
                                                                      splashColor: Colors.transparent,
                                                                      focusColor: Colors.transparent,
                                                                      hoverColor: Colors.transparent,
                                                                      highlightColor: Colors.transparent,
                                                                      onTap: () async {
                                                                        safeSetState(() {});
                                                                      },
                                                                      child: Text(
                                                                        'Food Item',
                                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                              font: GoogleFonts.inter(
                                                                                fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                              ),
                                                                              color: Color(0xFF333333),
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  decoration: BoxDecoration(
                                                                    color: Color(0xFFF4F4F4),
                                                                    borderRadius: BorderRadius.circular(20.0),
                                                                  ),
                                                                  child: Padding(
                                                                    padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
                                                                    child: Text(
                                                                      'Sweets',
                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                            font: GoogleFonts.inter(
                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                            color: Color(0xFF333333),
                                                                            letterSpacing: 0.0,
                                                                            fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  decoration: BoxDecoration(
                                                                    color: Color(0xFFF4F4F4),
                                                                    borderRadius: BorderRadius.circular(20.0),
                                                                  ),
                                                                  child: Padding(
                                                                    padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
                                                                    child: Text(
                                                                      'Spices',
                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                            font: GoogleFonts.inter(
                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                            color: Color(0xFF333333),
                                                                            letterSpacing: 0.0,
                                                                            fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  decoration: BoxDecoration(
                                                                    color: Color(0xFFF4F4F4),
                                                                    borderRadius: BorderRadius.circular(20.0),
                                                                  ),
                                                                  child: Padding(
                                                                    padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
                                                                    child: Text(
                                                                      'Crockery',
                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                            font: GoogleFonts.inter(
                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                            color: Color(0xFF333333),
                                                                            letterSpacing: 0.0,
                                                                            fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  decoration: BoxDecoration(
                                                                    color: Color(0xFFF4F4F4),
                                                                    borderRadius: BorderRadius.circular(20.0),
                                                                  ),
                                                                  child: Padding(
                                                                    padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
                                                                    child: Text(
                                                                      'Small Appliances',
                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                            font: GoogleFonts.inter(
                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                            color: Color(0xFF333333),
                                                                            letterSpacing: 0.0,
                                                                            fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  decoration: BoxDecoration(
                                                                    color: Color(0xFFF4F4F4),
                                                                    borderRadius: BorderRadius.circular(20.0),
                                                                  ),
                                                                  child: Padding(
                                                                    padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
                                                                    child: Text(
                                                                      'Kitchen Items',
                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                            font: GoogleFonts.inter(
                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                            color: Color(0xFF333333),
                                                                            letterSpacing: 0.0,
                                                                            fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  decoration: BoxDecoration(
                                                                    color: Color(0xFFF4F4F4),
                                                                    borderRadius: BorderRadius.circular(20.0),
                                                                  ),
                                                                  child: Padding(
                                                                    padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
                                                                    child: Text(
                                                                      'Festival goodies',
                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                            font: GoogleFonts.inter(
                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                            color: Color(0xFF333333),
                                                                            letterSpacing: 0.0,
                                                                            fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  decoration: BoxDecoration(
                                                                    color: Color(0xFFF4F4F4),
                                                                    borderRadius: BorderRadius.circular(20.0),
                                                                  ),
                                                                  child: Padding(
                                                                    padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
                                                                    child: Text(
                                                                      'Clothing & Accessories',
                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                            font: GoogleFonts.inter(
                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                            color: Color(0xFF333333),
                                                                            letterSpacing: 0.0,
                                                                            fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  decoration: BoxDecoration(
                                                                    color: Color(0xFFF4F4F4),
                                                                    borderRadius: BorderRadius.circular(20.0),
                                                                  ),
                                                                  child: Padding(
                                                                    padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
                                                                    child: Text(
                                                                      'Tech & Electronics',
                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                            font: GoogleFonts.inter(
                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                            color: Color(0xFF333333),
                                                                            letterSpacing: 0.0,
                                                                            fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  decoration: BoxDecoration(
                                                                    color: Color(0xFFF4F4F4),
                                                                    borderRadius: BorderRadius.circular(20.0),
                                                                  ),
                                                                  child: Padding(
                                                                    padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
                                                                    child: Text(
                                                                      'Homemade Food & Snacks',
                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                            font: GoogleFonts.inter(
                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                            color: Color(0xFF333333),
                                                                            letterSpacing: 0.0,
                                                                            fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  decoration: BoxDecoration(
                                                                    color: Color(0xFFF4F4F4),
                                                                    borderRadius: BorderRadius.circular(20.0),
                                                                  ),
                                                                  child: Padding(
                                                                    padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
                                                                    child: Text(
                                                                      'Documents',
                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                            font: GoogleFonts.inter(
                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                            color: Color(0xFF333333),
                                                                            letterSpacing: 0.0,
                                                                            fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  decoration: BoxDecoration(
                                                                    color: Color(0xFFF4F4F4),
                                                                    borderRadius: BorderRadius.circular(20.0),
                                                                  ),
                                                                  child: Padding(
                                                                    padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
                                                                    child: Text(
                                                                      'Child-related Items',
                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                            font: GoogleFonts.inter(
                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                            color: Color(0xFF333333),
                                                                            letterSpacing: 0.0,
                                                                            fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  decoration: BoxDecoration(
                                                                    color: Color(0xFFF4F4F4),
                                                                    borderRadius: BorderRadius.circular(20.0),
                                                                  ),
                                                                  child: Padding(
                                                                    padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
                                                                    child: Text(
                                                                      'Discuss over call',
                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                            font: GoogleFonts.inter(
                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                            color: Color(0xFF333333),
                                                                            letterSpacing: 0.0,
                                                                            fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  decoration: BoxDecoration(
                                                                    color: Color(0xFFF4F4F4),
                                                                    borderRadius: BorderRadius.circular(20.0),
                                                                  ),
                                                                  child: Padding(
                                                                    padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
                                                                    child: Text(
                                                                      'Others',
                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                            font: GoogleFonts.inter(
                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                            color: Color(0xFF333333),
                                                                            letterSpacing: 0.0,
                                                                            fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      if (rideDetailsCustomerRidesNewRecord.isPredefinedItems == false)
                                                        Align(
                                                          alignment: AlignmentDirectional(0.0, 0.0),
                                                          child: Padding(
                                                            padding: EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 32.0),
                                                            child: Builder(
                                                              builder: (context) {
                                                                final carryItems = rideDetailsCustomerRidesNewRecord.caryyItems.toList();

                                                                return Wrap(
                                                                  spacing: 10.0,
                                                                  runSpacing: 10.0,
                                                                  alignment: WrapAlignment.start,
                                                                  crossAxisAlignment: WrapCrossAlignment.start,
                                                                  direction: Axis.horizontal,
                                                                  runAlignment: WrapAlignment.start,
                                                                  verticalDirection: VerticalDirection.down,
                                                                  clipBehavior: Clip.none,
                                                                  children: List.generate(carryItems.length, (carryItemsIndex) {
                                                                    final carryItemsItem = carryItems[carryItemsIndex];
                                                                    return Container(
                                                                      decoration: BoxDecoration(
                                                                        color: FlutterFlowTheme.of(context).boxColour,
                                                                        borderRadius: BorderRadius.circular(20.0),
                                                                        border: Border.all(
                                                                          color: FlutterFlowTheme.of(context).containerBG,
                                                                        ),
                                                                      ),
                                                                      child: Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
                                                                        child: InkWell(
                                                                          splashColor: Colors.transparent,
                                                                          focusColor: Colors.transparent,
                                                                          hoverColor: Colors.transparent,
                                                                          highlightColor: Colors.transparent,
                                                                          onTap: () async {
                                                                            safeSetState(() {});
                                                                          },
                                                                          child: Text(
                                                                            carryItemsItem,
                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                  font: GoogleFonts.inter(
                                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                  ),
                                                                                  color: Color(0xFF333333),
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    );
                                                                  }),
                                                                );
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                    ].divide(SizedBox(height: 15.0)),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          if (rideDetailsCustomerRidesNewRecord.stoppages.length > 0)
                                            Padding(
                                              padding: EdgeInsetsDirectional.fromSTEB(5.0, 10.0, 0.0, 0.0),
                                              child: Text(
                                                'Stoppage',
                                                textAlign: TextAlign.start,
                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                      font: GoogleFonts.inter(
                                                        fontWeight: FontWeight.w500,
                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                      ),
                                                      color: Color(0xFF2B3E60),
                                                      fontSize: 15.0,
                                                      letterSpacing: 0.0,
                                                      fontWeight: FontWeight.w500,
                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                    ),
                                              ),
                                            ),
                                          if (rideDetailsCustomerRidesNewRecord.stoppages.length > 0)
                                            Align(
                                              alignment: AlignmentDirectional(0.0, 0.0),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 32.0),
                                                child: Builder(
                                                  builder: (context) {
                                                    final stoppages = rideDetailsCustomerRidesNewRecord.stoppages.toList();

                                                    return Wrap(
                                                      spacing: 10.0,
                                                      runSpacing: 10.0,
                                                      alignment: WrapAlignment.start,
                                                      crossAxisAlignment: WrapCrossAlignment.start,
                                                      direction: Axis.horizontal,
                                                      runAlignment: WrapAlignment.start,
                                                      verticalDirection: VerticalDirection.down,
                                                      clipBehavior: Clip.none,
                                                      children: List.generate(stoppages.length, (stoppagesIndex) {
                                                        final stoppagesItem = stoppages[stoppagesIndex];
                                                        return Container(
                                                          decoration: BoxDecoration(
                                                            color: FlutterFlowTheme.of(context).boxColour,
                                                            borderRadius: BorderRadius.circular(20.0),
                                                            border: Border.all(
                                                              color: FlutterFlowTheme.of(context).containerBG,
                                                            ),
                                                          ),
                                                          child: Padding(
                                                            padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
                                                            child: InkWell(
                                                              splashColor: Colors.transparent,
                                                              focusColor: Colors.transparent,
                                                              hoverColor: Colors.transparent,
                                                              highlightColor: Colors.transparent,
                                                              onTap: () async {
                                                                safeSetState(() {});
                                                              },
                                                              child: Text(
                                                                stoppagesItem,
                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                      font: GoogleFonts.inter(
                                                                        fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                      ),
                                                                      color: Color(0xFF333333),
                                                                      letterSpacing: 0.0,
                                                                      fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                    ),
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      }),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                          if (rideDetailsCustomerRidesNewRecord.rideStartLocationGoogle != null)
                                            Column(
                                              children: [
                                                Container(
                                                  width: double.infinity,
                                                  height: 220.0,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(16.0),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        blurRadius: 8.0,
                                                        color: Colors.black.withOpacity(0.1),
                                                        offset: const Offset(0, 4),
                                                      ),
                                                    ],
                                                  ),
                                                  child: ClipRRect(
                                                    borderRadius: BorderRadius.circular(16.0),
                                                    child: FlutterFlowGoogleMap(
                                                      controller: _model.googleMapsController,
                                                      onCameraIdle: (latLng) => _model.googleMapsCenter = latLng,
                                                      initialLocation: _model.googleMapsCenter ??=
                                                      rideDetailsCustomerRidesNewRecord.rideStartLocationGoogle!,
                                                      markerColor: GoogleMarkerColor.violet,
                                                      mapType: MapType.normal,
                                                      style: GoogleMapStyle.standard,
                                                      initialZoom: 15.0,
                                                      allowInteraction: true,
                                                      allowZoom: true,
                                                      showZoomControls: true, // Keep default controls
                                                      showLocation: true,
                                                      showCompass: true,
                                                      showMapToolbar: false,
                                                      showTraffic: false,
                                                      centerMapOnMarkerTap: true,
                                                    ),
                                                  ),
                                                ),

                                                const SizedBox(height: 12),

                                                SizedBox(
                                                  width: double.infinity,
                                                  child: FFButtonWidget(
                                                    onPressed: () async {
                                                      await launchMap(
                                                        location: rideDetailsCustomerRidesNewRecord.rideStartLocationGoogle,
                                                        title: rideDetailsCustomerRidesNewRecord.rideStartLocation,
                                                      );
                                                    },
                                                    text: 'Check Google Map',
                                                    icon: FaIcon(
                                                      FontAwesomeIcons.google,
                                                      size: 15.0,
                                                    ),
                                                    options: FFButtonOptions(
                                                      height: 40.0,
                                                      padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                                                      iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                      color: FlutterFlowTheme.of(context).primary,
                                                      textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                        font: GoogleFonts.interTight(
                                                          fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
                                                          fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                        ),
                                                        color: Colors.white,
                                                        letterSpacing: 0.0,
                                                        fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
                                                        fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                      ),
                                                      elevation: 10.0,
                                                      borderRadius: BorderRadius.circular(8.0),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          // if (rideDetailsCustomerRidesNewRecord.rideStartLocationGoogle != null)
                                          //   Align(
                                          //     alignment: AlignmentDirectional(0.0, 0.0),
                                          //     child: FFButtonWidget(
                                          //       onPressed: () async {
                                          //         await launchMap(
                                          //           location: rideDetailsCustomerRidesNewRecord.rideStartLocationGoogle,
                                          //           title: rideDetailsCustomerRidesNewRecord.rideStartLocation,
                                          //         );
                                          //       },
                                          //       text: 'Check Google Map',
                                          //       icon: FaIcon(
                                          //         FontAwesomeIcons.google,
                                          //         size: 15.0,
                                          //       ),
                                          //       options: FFButtonOptions(
                                          //         height: 40.0,
                                          //         padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                                          //         iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                          //         color: FlutterFlowTheme.of(context).primary,
                                          //         textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                          //               font: GoogleFonts.interTight(
                                          //                 fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
                                          //                 fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                          //               ),
                                          //               color: Colors.white,
                                          //               letterSpacing: 0.0,
                                          //               fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
                                          //               fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                          //             ),
                                          //         elevation: 10.0,
                                          //         borderRadius: BorderRadius.circular(8.0),
                                          //       ),
                                          //     ),
                                          //   ),
                                          Divider(
                                            thickness: 0.5,
                                            color: FlutterFlowTheme.of(context).secondaryText,
                                          ),
                                          Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Ride Rules',
                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                      font: GoogleFonts.inter(
                                                        fontWeight: FontWeight.w600,
                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                      ),
                                                      fontSize: 18.0,
                                                      letterSpacing: 0.0,
                                                      fontWeight: FontWeight.w600,
                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                    ),
                                              ),
                                              if (rideDetailsCustomerRidesNewRecord.isRideRulesAccepted == true)
                                                Padding(
                                                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 32.0),
                                                  child: Wrap(
                                                    spacing: 10.0,
                                                    runSpacing: 10.0,
                                                    alignment: WrapAlignment.start,
                                                    crossAxisAlignment: WrapCrossAlignment.start,
                                                    direction: Axis.horizontal,
                                                    runAlignment: WrapAlignment.start,
                                                    verticalDirection: VerticalDirection.down,
                                                    clipBehavior: Clip.none,
                                                    children: [
                                                      Container(
                                                        decoration: BoxDecoration(
                                                          color: FlutterFlowTheme.of(context).boxColour,
                                                          borderRadius: BorderRadius.circular(20.0),
                                                          border: Border.all(
                                                            color: FlutterFlowTheme.of(context).containerBG,
                                                          ),
                                                        ),
                                                        child: Padding(
                                                          padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
                                                          child: InkWell(
                                                            splashColor: Colors.transparent,
                                                            focusColor: Colors.transparent,
                                                            hoverColor: Colors.transparent,
                                                            highlightColor: Colors.transparent,
                                                            onTap: () async {
                                                              safeSetState(() {});
                                                            },
                                                            child: Text(
                                                              'We accept only legal parcels—no prohibited or illegal items allowed.',
                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                    font: GoogleFonts.inter(
                                                                      fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                    ),
                                                                    color: FlutterFlowTheme.of(context).primaryText,
                                                                    letterSpacing: 0.0,
                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                  ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        decoration: BoxDecoration(
                                                          color: FlutterFlowTheme.of(context).boxColour,
                                                          borderRadius: BorderRadius.circular(20.0),
                                                          border: Border.all(
                                                            color: FlutterFlowTheme.of(context).containerBG,
                                                          ),
                                                        ),
                                                        child: Padding(
                                                          padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
                                                          child: Text(
                                                            'Customers must arrive with the parcel at least 10 minutes before the vehicle arrives.',
                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                  font: GoogleFonts.inter(
                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                  ),
                                                                  color: FlutterFlowTheme.of(context).primaryText,
                                                                  letterSpacing: 0.0,
                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        decoration: BoxDecoration(
                                                          color: FlutterFlowTheme.of(context).boxColour,
                                                          borderRadius: BorderRadius.circular(20.0),
                                                          border: Border.all(
                                                            color: FlutterFlowTheme.of(context).containerBG,
                                                          ),
                                                        ),
                                                        child: Padding(
                                                          padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
                                                          child: Text(
                                                            'Complete receiver information is required at the time of booking.',
                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                  font: GoogleFonts.inter(
                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                  ),
                                                                  color: Color(0xFF333333),
                                                                  letterSpacing: 0.0,
                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        decoration: BoxDecoration(
                                                          color: FlutterFlowTheme.of(context).boxColour,
                                                          borderRadius: BorderRadius.circular(20.0),
                                                          border: Border.all(
                                                            color: FlutterFlowTheme.of(context).containerBG,
                                                          ),
                                                        ),
                                                        child: Padding(
                                                          padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
                                                          child: Text(
                                                            'Unacceptable items found during the ride may lead to cancellation or being reported.',
                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                  font: GoogleFonts.inter(
                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                  ),
                                                                  color: Color(0xFF333333),
                                                                  letterSpacing: 0.0,
                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        decoration: BoxDecoration(
                                                          color: FlutterFlowTheme.of(context).boxColour,
                                                          borderRadius: BorderRadius.circular(20.0),
                                                          border: Border.all(
                                                            color: FlutterFlowTheme.of(context).containerBG,
                                                          ),
                                                        ),
                                                        child: Padding(
                                                          padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
                                                          child: Text(
                                                            'Parcels must be securely packed to avoid damage during transit.',
                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                  font: GoogleFonts.inter(
                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                  ),
                                                                  color: Color(0xFF333333),
                                                                  letterSpacing: 0.0,
                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        decoration: BoxDecoration(
                                                          color: FlutterFlowTheme.of(context).boxColour,
                                                          borderRadius: BorderRadius.circular(20.0),
                                                          border: Border.all(
                                                            color: FlutterFlowTheme.of(context).containerBG,
                                                          ),
                                                        ),
                                                        child: Padding(
                                                          padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
                                                          child: Text(
                                                            'Fragile or high-value items should be declared beforehand.',
                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                  font: GoogleFonts.inter(
                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                  ),
                                                                  color: Color(0xFF333333),
                                                                  letterSpacing: 0.0,
                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        decoration: BoxDecoration(
                                                          color: FlutterFlowTheme.of(context).boxColour,
                                                          borderRadius: BorderRadius.circular(20.0),
                                                          border: Border.all(
                                                            color: FlutterFlowTheme.of(context).containerBG,
                                                          ),
                                                        ),
                                                        child: Padding(
                                                          padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
                                                          child: Text(
                                                            'We are not responsible for delays caused by incomplete or incorrect information.',
                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                  font: GoogleFonts.inter(
                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                  ),
                                                                  color: Color(0xFF333333),
                                                                  letterSpacing: 0.0,
                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              if (rideDetailsCustomerRidesNewRecord.isRideRulesAccepted == false)
                                                Padding(
                                                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 32.0),
                                                  child: Wrap(
                                                    spacing: 10.0,
                                                    runSpacing: 10.0,
                                                    alignment: WrapAlignment.start,
                                                    crossAxisAlignment: WrapCrossAlignment.start,
                                                    direction: Axis.horizontal,
                                                    runAlignment: WrapAlignment.start,
                                                    verticalDirection: VerticalDirection.down,
                                                    clipBehavior: Clip.none,
                                                    children: [
                                                      Container(
                                                        decoration: BoxDecoration(
                                                          color: FlutterFlowTheme.of(context).boxColour,
                                                          borderRadius: BorderRadius.circular(20.0),
                                                          border: Border.all(
                                                            color: FlutterFlowTheme.of(context).containerBG,
                                                          ),
                                                        ),
                                                        child: Padding(
                                                          padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
                                                          child: InkWell(
                                                            splashColor: Colors.transparent,
                                                            focusColor: Colors.transparent,
                                                            hoverColor: Colors.transparent,
                                                            highlightColor: Colors.transparent,
                                                            onTap: () async {
                                                              safeSetState(() {});
                                                            },
                                                            child: Text(
                                                              rideDetailsCustomerRidesNewRecord.rideRule1,
                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                    font: GoogleFonts.inter(
                                                                      fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                    ),
                                                                    color: Color(0xFF333333),
                                                                    letterSpacing: 0.0,
                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                  ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        decoration: BoxDecoration(
                                                          color: FlutterFlowTheme.of(context).boxColour,
                                                          borderRadius: BorderRadius.circular(20.0),
                                                          border: Border.all(
                                                            color: FlutterFlowTheme.of(context).containerBG,
                                                          ),
                                                        ),
                                                        child: Padding(
                                                          padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
                                                          child: Text(
                                                            rideDetailsCustomerRidesNewRecord.rideRule2,
                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                  font: GoogleFonts.inter(
                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                  ),
                                                                  color: Color(0xFF333333),
                                                                  letterSpacing: 0.0,
                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        decoration: BoxDecoration(
                                                          color: FlutterFlowTheme.of(context).boxColour,
                                                          borderRadius: BorderRadius.circular(20.0),
                                                          border: Border.all(
                                                            color: FlutterFlowTheme.of(context).containerBG,
                                                          ),
                                                        ),
                                                        child: Padding(
                                                          padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
                                                          child: Text(
                                                            rideDetailsCustomerRidesNewRecord.rideRule3,
                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                  font: GoogleFonts.inter(
                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                  ),
                                                                  color: Color(0xFF333333),
                                                                  letterSpacing: 0.0,
                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        decoration: BoxDecoration(
                                                          color: FlutterFlowTheme.of(context).boxColour,
                                                          borderRadius: BorderRadius.circular(20.0),
                                                          border: Border.all(
                                                            color: FlutterFlowTheme.of(context).containerBG,
                                                          ),
                                                        ),
                                                        child: Padding(
                                                          padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
                                                          child: Text(
                                                            rideDetailsCustomerRidesNewRecord.rideRule4,
                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                  font: GoogleFonts.inter(
                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                  ),
                                                                  color: Color(0xFF333333),
                                                                  letterSpacing: 0.0,
                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        decoration: BoxDecoration(
                                                          color: FlutterFlowTheme.of(context).boxColour,
                                                          borderRadius: BorderRadius.circular(20.0),
                                                          border: Border.all(
                                                            color: FlutterFlowTheme.of(context).containerBG,
                                                          ),
                                                        ),
                                                        child: Padding(
                                                          padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
                                                          child: Text(
                                                            rideDetailsCustomerRidesNewRecord.rideRule5,
                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                  font: GoogleFonts.inter(
                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                  ),
                                                                  color: Color(0xFF333333),
                                                                  letterSpacing: 0.0,
                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        decoration: BoxDecoration(
                                                          color: FlutterFlowTheme.of(context).boxColour,
                                                          borderRadius: BorderRadius.circular(20.0),
                                                          border: Border.all(
                                                            color: FlutterFlowTheme.of(context).containerBG,
                                                          ),
                                                        ),
                                                        child: Padding(
                                                          padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
                                                          child: Text(
                                                            rideDetailsCustomerRidesNewRecord.rideRule6,
                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                  font: GoogleFonts.inter(
                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                  ),
                                                                  color: Color(0xFF333333),
                                                                  letterSpacing: 0.0,
                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              if ((rideDetailsCustomerRidesNewRecord.creatorID != currentUserReference) || (rideDetailsCustomerRidesNewRecord.bidCustomerID != currentUserReference))
                                                ClipRRect(
                                                  borderRadius: BorderRadius.circular(16.0),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: FlutterFlowTheme.of(context).containerBG,
                                                      borderRadius: BorderRadius.circular(16.0),
                                                      border: Border.all(
                                                        color: FlutterFlowTheme.of(context).accent2,
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding: EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 10.0),
                                                      child: Row(
                                                        mainAxisSize: MainAxisSize.max,
                                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                        children: [
                                                          FFButtonWidget(
                                                            onPressed: () async {
                                                              context.pushNamed(
                                                                SendParcelWidget.routeName,
                                                                queryParameters: {
                                                                  'bookingKarnaHai': serializeParam(
                                                                    rideDetailsCustomerRidesNewRecord.reference,
                                                                    ParamType.DocumentReference,
                                                                  ),
                                                                }.withoutNulls,
                                                              );
                                                            },
                                                            text: 'Send Parcel',
                                                            options: FFButtonOptions(
                                                              width: 100.0,
                                                              height: 50.0,
                                                              padding: EdgeInsets.all(8.0),
                                                              iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                              color: Color(0xFFF77F4A),
                                                              textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                                    font: GoogleFonts.interTight(
                                                                      fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                    ),
                                                                    color: FlutterFlowTheme.of(context).primaryBackground,
                                                                    letterSpacing: 0.0,
                                                                    fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                  ),
                                                              elevation: 10.0,
                                                              borderRadius: BorderRadius.circular(10.0),
                                                            ),
                                                          ),
                                                          FFButtonWidget(
                                                            onPressed: () async {
                                                              context.pushNamed(
                                                                BookRideWidget.routeName,
                                                                queryParameters: {
                                                                  'rideID': serializeParam(
                                                                    rideDetailsCustomerRidesNewRecord.reference,
                                                                    ParamType.DocumentReference,
                                                                  ),
                                                                }.withoutNulls,
                                                              );
                                                            },
                                                            text: 'Book Ride',
                                                            options: FFButtonOptions(
                                                              width: 100.0,
                                                              height: 50.0,
                                                              padding: EdgeInsets.all(8.0),
                                                              iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                              color: Color(0xFF0099FF),
                                                              textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                                    font: GoogleFonts.interTight(
                                                                      fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                    ),
                                                                    color: FlutterFlowTheme.of(context).primaryBackground,
                                                                    letterSpacing: 0.0,
                                                                    fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                  ),
                                                              elevation: 10.0,
                                                              borderRadius: BorderRadius.circular(10.0),
                                                            ),
                                                          ),
                                                          InkWell(
                                                            splashColor: Colors.transparent,
                                                            focusColor: Colors.transparent,
                                                            hoverColor: Colors.transparent,
                                                            highlightColor: Colors.transparent,
                                                            onTap: () async {
                                                              if (columnUsersRecord.chatConnected.contains(currentUserReference) == false) {
                                                                await ChatsRecord.collection.doc().set({
                                                                  ...createChatsRecordData(
                                                                    lastMessage: 'Hey, ',
                                                                    lastMessageTime: getCurrentTimestamp,
                                                                  ),
                                                                  ...mapToFirestore(
                                                                    {
                                                                      'userIDs': functions.generateListOfUsers(currentUserReference!, columnUsersRecord.reference),
                                                                      'userNames': functions.generateListOfNames(currentUserDisplayName, columnUsersRecord.displayName),
                                                                    },
                                                                  ),
                                                                });

                                                                await columnUsersRecord.reference.update({
                                                                  ...mapToFirestore(
                                                                    {
                                                                      'chatConnected': FieldValue.arrayUnion([currentUserReference]),
                                                                    },
                                                                  ),
                                                                });
                                                              }

                                                              context.pushNamed(ChatUsersWidget.routeName);
                                                            },
                                                            child: Container(
                                                              width: 50.0,
                                                              height: 50.0,
                                                              decoration: BoxDecoration(
                                                                color: FlutterFlowTheme.of(context).primaryBackground,
                                                                borderRadius: BorderRadius.circular(10.0),
                                                                border: Border.all(
                                                                  color: FlutterFlowTheme.of(context).alternate,
                                                                  width: 1.0,
                                                                ),
                                                              ),
                                                              child: Center(
                                                                child: Icon(
                                                                  Icons.chat_bubble_outline,
                                                                  color: FlutterFlowTheme.of(context).primaryText,
                                                                  size: 24.0,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          InkWell(
                                                            splashColor: Colors.transparent,
                                                            focusColor: Colors.transparent,
                                                            hoverColor: Colors.transparent,
                                                            highlightColor: Colors.transparent,
                                                            onTap: () async {
                                                              if (rideDetailsCustomerRidesNewRecord.rideSavedByUser != currentUserReference) {
                                                                await rideDetailsCustomerRidesNewRecord.reference.update(createRidesNewRecordData(
                                                                  rideSavedByUser: currentUserReference,
                                                                ));
                                                                // Issue 4: Tell user where saved ride goes
                                                                if (context.mounted) {
                                                                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                                    SnackBar(
                                                                      content: const Text(
                                                                        'Ride saved! Tap View to see your saved rides.',
                                                                        style: TextStyle(color: Colors.white),
                                                                      ),
                                                                      backgroundColor: const Color(0xFFF77F4A),
                                                                      duration: const Duration(seconds: 4),
                                                                      action: SnackBarAction(
                                                                        label: 'View',
                                                                        textColor: Colors.white,
                                                                        onPressed: () {
                                                                          context.pushNamed(SavedRidesWidget.routeName);
                                                                        },
                                                                      ),
                                                                    ),
                                                                  );
                                                                }
                                                              } else {
                                                                await rideDetailsCustomerRidesNewRecord.reference.update(createRidesNewRecordData(
                                                                  rideSavedByUser: columnUsersRecord.reference,
                                                                ));
                                                                // Unsaved feedback
                                                                if (context.mounted) {
                                                                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                                    const SnackBar(
                                                                      content: Text('Ride removed from saved rides.'),
                                                                      duration: Duration(seconds: 2),
                                                                    ),
                                                                  );
                                                                }
                                                              }
                                                            },
                                                            child: Container(
                                                              width: 50.0,
                                                              height: 50.0,
                                                              decoration: BoxDecoration(
                                                                color: FlutterFlowTheme.of(context).primaryBackground,
                                                                borderRadius: BorderRadius.circular(10.0),
                                                                border: Border.all(
                                                                  color: FlutterFlowTheme.of(context).alternate,
                                                                  width: 1.0,
                                                                ),
                                                              ),
                                                              child: Center(
                                                                child: Icon(
                                                                  rideDetailsCustomerRidesNewRecord.rideSavedByUser == currentUserReference
                                                                      ? Icons.bookmark
                                                                      : Icons.bookmark_border,
                                                                  color: rideDetailsCustomerRidesNewRecord.rideSavedByUser == currentUserReference
                                                                      ? Color(0xFFF77F4A)
                                                                      : Color(0xFFB5B5B5),
                                                                  size: 24.0,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ].divide(SizedBox(width: 12.0)),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                            ].divide(SizedBox(height: 5.0)),
                                          ),
                                        ].divide(SizedBox(height: 10.0)),
                                      ),
                                    ),
                                  ),
                                ].divide(SizedBox(height: 10.0)).addToEnd(SizedBox(height: 20.0)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      wrapWithModel(
                        model: _model.mainFooterModel,
                        updateCallback: () => safeSetState(() {}),
                        child: MainFooterWidget(),
                      ),
                    ],
                  )


                      .animateOnPageLoad(animationsMap['columnOnPageLoadAnimation']!);
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
