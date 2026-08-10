import 'package:google_maps_flutter/google_maps_flutter.dart' as google_maps;
import 'package:url_launcher/url_launcher.dart';
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

                  // ======================================================================
                  // OLD RIDE DETAILS UI (COMMENTED OUT AS REQUESTED)
                  // ======================================================================
                  //                   return Column(
                  //                     mainAxisSize: MainAxisSize.max,
                  //                     children: [
                  //                       Expanded(
                  //                         child: ListView(
                  //                           padding: EdgeInsets.zero,
                  //                           primary: false,
                  //                           shrinkWrap: true,
                  //                           scrollDirection: Axis.vertical,
                  //                           children: [
                  //                             SingleChildScrollView(
                  //                               primary: false,
                  //                               child: Column(
                  //                                 mainAxisSize: MainAxisSize.max,
                  //                                 mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //                                 children: [
                  //                                   Padding(
                  //                                     padding: EdgeInsetsDirectional.fromSTEB(10.0, 15.0, 10.0, 0.0),
                  //                                     child: SingleChildScrollView(
                  //                                       primary: false,
                  //                                       child: Column(
                  //                                         mainAxisSize: MainAxisSize.max,
                  //                                         mainAxisAlignment: MainAxisAlignment.start,
                  //                                         crossAxisAlignment: CrossAxisAlignment.start,
                  //                                         children: [
                  //                                           Row(
                  //                                             mainAxisSize: MainAxisSize.max,
                  //                                             mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //                                             crossAxisAlignment: CrossAxisAlignment.center,
                  //                                             children: [
                  //                                               Column(
                  //                                                 mainAxisSize: MainAxisSize.max,
                  //                                                 children: [
                  //                                                   InkWell(
                  //                                                     splashColor: Colors.transparent,
                  //                                                     focusColor: Colors.transparent,
                  //                                                     hoverColor: Colors.transparent,
                  //                                                     highlightColor: Colors.transparent,
                  //                                                     onTap: () async {
                  //                                                       context.pushNamed(
                  //                                                         DriverReviewWidget.routeName,
                  //                                                         queryParameters: {
                  //                                                           'userRef': serializeParam(
                  //                                                             columnUsersRecord.reference,
                  //                                                             ParamType.DocumentReference,
                  //                                                           ),
                  //                                                         }.withoutNulls,
                  //                                                       );
                  //                                                     },
                  //                                                     child: Builder(
                  //                                                       builder: (context) {
                  //                                                         if (columnUsersRecord.photoUrl != null && columnUsersRecord.photoUrl != '') {
                  //                                                           return Container(
                  //                                                             width: 80.0,
                  //                                                             height: 80.0,
                  //                                                             clipBehavior: Clip.antiAlias,
                  //                                                             decoration: BoxDecoration(
                  //                                                               shape: BoxShape.circle,
                  //                                                             ),
                  //                                                             child: Image.network(
                  //                                                               columnUsersRecord.photoUrl,
                  //                                                               fit: BoxFit.cover,
                  //                                                             ),
                  //                                                           );
                  //                                                         } else {
                  //                                                           return InkWell(
                  //                                                             splashColor: Colors.transparent,
                  //                                                             focusColor: Colors.transparent,
                  //                                                             hoverColor: Colors.transparent,
                  //                                                             highlightColor: Colors.transparent,
                  //                                                             onTap: () async {
                  //                                                               context.pushNamed(
                  //                                                                 DriverReviewWidget.routeName,
                  //                                                                 queryParameters: {
                  //                                                                   'userRef': serializeParam(
                  //                                                                     columnUsersRecord.reference,
                  //                                                                     ParamType.DocumentReference,
                  //                                                                   ),
                  //                                                                 }.withoutNulls,
                  //                                                               );
                  //                                                             },
                  //                                                             child: Container(
                  //                                                               width: 80.0,
                  //                                                               height: 80.0,
                  //                                                               clipBehavior: Clip.antiAlias,
                  //                                                               decoration: BoxDecoration(
                  //                                                                 shape: BoxShape.circle,
                  //                                                               ),
                  //                                                               child: Image.asset(
                  //                                                                 'assets/images/userIconTr.png',
                  //                                                                 fit: BoxFit.cover,
                  //                                                               ),
                  //                                                             ),
                  //                                                           );
                  //                                                         }
                  //                                                       },
                  //                                                     ),
                  //                                                   ),
                  //                                                 ],
                  //                                               ),
                  //                                               Expanded(
                  //                                                 child: Column(
                  //                                                   mainAxisSize: MainAxisSize.max,
                  //                                                   crossAxisAlignment: CrossAxisAlignment.start,
                  //                                                   children: [
                  //                                                     InkWell(
                  //                                                       splashColor: Colors.transparent,
                  //                                                       focusColor: Colors.transparent,
                  //                                                       hoverColor: Colors.transparent,
                  //                                                       highlightColor: Colors.transparent,
                  //                                                       onTap: () async {
                  //                                                         context.pushNamed(
                  //                                                           DriverReviewWidget.routeName,
                  //                                                           queryParameters: {
                  //                                                             'userRef': serializeParam(
                  //                                                               columnUsersRecord.reference,
                  //                                                               ParamType.DocumentReference,
                  //                                                             ),
                  //                                                           }.withoutNulls,
                  //                                                         );
                  //                                                       },
                  //                                                       child: Text(
                  //                                                         columnUsersRecord.displayName,
                  //                                                         textAlign: TextAlign.center,
                  //                                                         style: FlutterFlowTheme.of(context).headlineSmall.override(
                  //                                                               font: GoogleFonts.interTight(
                  //                                                                 fontWeight: FontWeight.bold,
                  //                                                                 fontStyle: FlutterFlowTheme.of(context).headlineSmall.fontStyle,
                  //                                                               ),
                  //                                                               color: FlutterFlowTheme.of(context).primaryText,
                  //                                                               fontSize: 16.0,
                  //                                                               letterSpacing: 0.0,
                  //                                                               fontWeight: FontWeight.bold,
                  //                                                               fontStyle: FlutterFlowTheme.of(context).headlineSmall.fontStyle,
                  //                                                             ),
                  //                                                       ),
                  //                                                     ),
                  //                                                     Row(
                  //                                                       mainAxisSize: MainAxisSize.max,
                  //                                                       children: [
                  //                                                         Align(
                  //                                                           alignment: AlignmentDirectional(0.0, 0.0),
                  //                                                           child: Container(
                  //                                                             width: 30.0,
                  //                                                             decoration: BoxDecoration(),
                  //                                                             child: Padding(
                  //                                                               padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 5.0, 0.0),
                  //                                                               child: Stack(
                  //                                                                 alignment: AlignmentDirectional(0.0, 0.0),
                  //                                                                 children: [
                  //                                                                   ClipRRect(
                  //                                                                     borderRadius: BorderRadius.circular(8.0),
                  //                                                                     child: Image.asset(
                  //                                                                       'assets/images/Ride_Search_Icons.png',
                  //                                                                       width: 25.0,
                  //                                                                       height: 30.0,
                  //                                                                       fit: BoxFit.cover,
                  //                                                                     ),
                  //                                                                   ),
                  //                                                                   Text(
                  //                                                                     valueOrDefault<String>(
                  //                                                                       formatNumber(
                  //                                                                         functions.averageRating(columnUsersRecord.ratings.toList()),
                  //                                                                         formatType: FormatType.compact,
                  //                                                                       ),
                  //                                                                       '0',
                  //                                                                     ),
                  //                                                                     style: FlutterFlowTheme.of(context).bodyMedium.override(
                  //                                                                           font: GoogleFonts.inter(
                  //                                                                             fontWeight: FontWeight.w900,
                  //                                                                             fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  //                                                                           ),
                  //                                                                           color: FlutterFlowTheme.of(context).primaryBackground,
                  //                                                                           fontSize: 9.0,
                  //                                                                           letterSpacing: 0.0,
                  //                                                                           fontWeight: FontWeight.w900,
                  //                                                                           fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  //                                                                         ),
                  //                                                                   ),
                  //                                                                 ],
                  //                                                               ),
                  //                                                             ),
                  //                                                           ),
                  //                                                         ),
                  //                                                         Text(
                  //                                                           'Verified Profile',
                  //                                                           style: FlutterFlowTheme.of(context).labelMedium.override(
                  //                                                                 font: GoogleFonts.inter(
                  //                                                                   fontWeight: FontWeight.w600,
                  //                                                                   fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                  //                                                                 ),
                  //                                                                 color: Color(0xFF5BB97E),
                  //                                                                 fontSize: 10.0,
                  //                                                                 letterSpacing: 0.0,
                  //                                                                 fontWeight: FontWeight.w600,
                  //                                                                 fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                  //                                                               ),
                  //                                                         ),
                  //                                                       ],
                  //                                                     ),
                  //                                                     Row(
                  //                                                       mainAxisSize: MainAxisSize.max,
                  //                                                       children: [
                  //                                                         if (rideDetailsCustomerRidesNewRecord.modeOfTransport == 'Car')
                  //                                                           Padding(
                  //                                                             padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
                  //                                                             child: FaIcon(
                  //                                                               FontAwesomeIcons.carSide,
                  //                                                               color: FlutterFlowTheme.of(context).iconColours,
                  //                                                               size: 20.0,
                  //                                                             ),
                  //                                                           ),
                  //                                                         if (rideDetailsCustomerRidesNewRecord.modeOfTransport == 'Train')
                  //                                                           Padding(
                  //                                                             padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
                  //                                                             child: Icon(
                  //                                                               Icons.train,
                  //                                                               color: FlutterFlowTheme.of(context).iconColours,
                  //                                                               size: 30.0,
                  //                                                             ),
                  //                                                           ),
                  //                                                         if (rideDetailsCustomerRidesNewRecord.modeOfTransport == 'Bike')
                  //                                                           Padding(
                  //                                                             padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
                  //                                                             child: Icon(
                  //                                                               Icons.motorcycle_sharp,
                  //                                                               color: FlutterFlowTheme.of(context).iconColours,
                  //                                                               size: 30.0,
                  //                                                             ),
                  //                                                           ),
                  //                                                         if (rideDetailsCustomerRidesNewRecord.modeOfTransport == 'Bus')
                  //                                                           Padding(
                  //                                                             padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
                  //                                                             child: FaIcon(
                  //                                                               FontAwesomeIcons.bus,
                  //                                                               color: FlutterFlowTheme.of(context).iconColours,
                  //                                                               size: 20.0,
                  //                                                             ),
                  //                                                           ),
                  //                                                       ].divide(SizedBox(width: 8.0)),
                  //                                                     ),
                  //                                                   ].divide(SizedBox(height: 7.0)),
                  //                                                 ),
                  //                                               ),
                  //                                               Padding(
                  //                                                 padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
                  //                                                 child: Container(
                  //                                                   width: 50.0,
                  //                                                   height: 50.0,
                  //                                                   clipBehavior: Clip.antiAlias,
                  //                                                   decoration: BoxDecoration(
                  //                                                     shape: BoxShape.circle,
                  //                                                   ),
                  //                                                   child: Image.asset(
                  //                                                     'assets/images/verofy.png',
                  //                                                     fit: BoxFit.cover,
                  //                                                   ),
                  //                                                 ),
                  //                                               ),
                  //                                             ].divide(SizedBox(width: 10.0)),
                  //                                           ),
                  //                                           Divider(
                  //                                             thickness: 0.5,
                  //                                             color: FlutterFlowTheme.of(context).secondaryText,
                  //                                           ),
                  //                                           ClipRRect(
                  //                                             borderRadius: BorderRadius.circular(12.0),
                  //                                             child: Container(
                  //                                               width: double.infinity,
                  //                                               height: 45.0,
                  //                                               decoration: BoxDecoration(
                  //                                                 color: Colors.grey[300],
                  //                                                 borderRadius: BorderRadius.circular(12.0),
                  //                                               ),
                  //                                               child: Row(
                  //                                                 children: [
                  //                                                   // RIDE ON on left
                  //                                                   Expanded(
                  //                                                     flex: 1,
                  //                                                     child: Center(
                  //                                                       child: Text(
                  //                                                         'RIDE ON',
                  //                                                         style: FlutterFlowTheme.of(context).bodyMedium.override(
                  //                                                           font: GoogleFonts.inter(fontWeight: FontWeight.w600),
                  //                                                           color: Colors.grey[800],
                  //                                                           fontSize: 14.0,
                  //                                                         ),
                  //                                                       ),
                  //                                                     ),
                  //                                                   ),
                  //                                                   // Orange container touching right end - NO right radius
                  //                                                   Expanded(
                  //                                                     flex: 2,
                  //                                                     child: Container(
                  //                                                       height: double.infinity,
                  //                                                       decoration: BoxDecoration(
                  //                                                         color: Color(0xFFF97E4C),
                  //                                                         borderRadius: BorderRadiusDirectional.only(
                  //                                                           topStart: Radius.circular(12.0),  // ✅ Only left corners curved
                  //                                                           bottomStart: Radius.circular(12.0),
                  //                                                         ),
                  //                                                       ),
                  //                                                       child: Center(
                  //                                                         child: Text(
                  //                                                           dateTimeFormat("EEEE, MMM d", rideDetailsCustomerRidesNewRecord.pickupTime!),
                  //                                                           textAlign: TextAlign.center,
                  //                                                           style: FlutterFlowTheme.of(context).bodyMedium.override(
                  //                                                             font: GoogleFonts.inter(fontWeight: FontWeight.bold),
                  //                                                             color: Colors.white,
                  //                                                             fontSize: 14.0,
                  //                                                           ),
                  //                                                         ),
                  // 
                  //                                                       ),
                  //                                                     ),
                  //                                                   ),
                  //                                                 ],
                  //                                               ),
                  //                                             ),
                  //                                           ),
                  //                                           Material(
                  //                                             color: Colors.transparent,
                  //                                             elevation: 10.0,
                  //                                             shape: RoundedRectangleBorder(
                  //                                               borderRadius: BorderRadius.circular(16.0),
                  //                                             ),
                  //                                             child: Container(
                  //                                               width: double.infinity,
                  //                                               decoration: BoxDecoration(
                  //                                                 color: FlutterFlowTheme.of(context).containerBG,
                  //                                                 boxShadow: [
                  //                                                   BoxShadow(
                  //                                                     blurRadius: 4.0,
                  //                                                     color: Color(0x33000000),
                  //                                                     offset: Offset(
                  //                                                       0.0,
                  //                                                       2.0,
                  //                                                     ),
                  //                                                   )
                  //                                                 ],
                  //                                                 borderRadius: BorderRadius.circular(16.0),
                  //                                                 border: Border.all(
                  //                                                   color: FlutterFlowTheme.of(context).accent2,
                  //                                                 ),
                  //                                               ),
                  //                                               child: Stack(
                  //                                                 children: [
                  //                                                   Padding(
                  //                                                     padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 10.0),
                  //                                                     child: Column(
                  //                                                       mainAxisSize: MainAxisSize.max,
                  //                                                       children: [
                  //                                                         Row(
                  //                                                           mainAxisSize: MainAxisSize.max,
                  //                                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //                                                           children: [
                  //                                                             Padding(
                  //                                                               padding: EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 5.0, 10.0),
                  //                                                               child: Column(
                  //                                                                 mainAxisSize: MainAxisSize.max,
                  //                                                                 mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //                                                                 crossAxisAlignment: CrossAxisAlignment.center,
                  //                                                                 children: [
                  //                                                                   SingleChildScrollView(
                  //                                                                     scrollDirection: Axis.horizontal,
                  //                                                                     child: Row(
                  //                                                                       mainAxisSize: MainAxisSize.max,
                  //                                                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //                                                                       children: [
                  //                                                                         Row(
                  //                                                                           mainAxisSize: MainAxisSize.max,
                  //                                                                           children: [
                  //                                                                             Icon(
                  //                                                                               Icons.location_on_outlined,
                  //                                                                               color: FlutterFlowTheme.of(context).primary,
                  //                                                                               size: 24.0,
                  //                                                                             ),
                  //                                                                             Container(
                  //                                                                               width: 200.0,
                  //                                                                               decoration: BoxDecoration(
                  //                                                                                 color: FlutterFlowTheme.of(context).primaryBackground,
                  //                                                                                 borderRadius: BorderRadius.circular(15.0),
                  //                                                                               ),
                  //                                                                               child: Padding(
                  //                                                                                 padding: EdgeInsetsDirectional.fromSTEB(15.0, 5.0, 10.0, 5.0),
                  //                                                                                 child: Column(
                  //                                                                                   crossAxisAlignment: CrossAxisAlignment.start,
                  //                                                                                   children: [
                  //                                                                                     Text(
                  //                                                                                       rideDetailsCustomerRidesNewRecord.googleStartAddress != null && rideDetailsCustomerRidesNewRecord.googleStartAddress != '' ? rideDetailsCustomerRidesNewRecord.googleStartAddress! : rideDetailsCustomerRidesNewRecord.rideStartLocation,
                  //                                                                                       style: FlutterFlowTheme.of(context).bodyMedium.override(
                  //                                                                                             font: GoogleFonts.inter(
                  //                                                                                               fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                  //                                                                                               fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  //                                                                                             ),
                  //                                                                                             fontSize: 13.0,
                  //                                                                                             letterSpacing: 0.0,
                  //                                                                                             fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                  //                                                                                             fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  //                                                                                           ),
                  //                                                                                     ),
                  //                                                                                     if (rideDetailsCustomerRidesNewRecord.pickupTime != null)
                  //                                                                                       Padding(
                  //                                                                                         padding: EdgeInsets.only(top: 4.0),
                  //                                                                                         child: Text(
                  //                                                                                           'Departure: ${dateTimeFormat("hh:mm a", rideDetailsCustomerRidesNewRecord.pickupTime).toLowerCase()}',
                  //                                                                                           style: FlutterFlowTheme.of(context).bodySmall.override(
                  //                                                                                                 font: GoogleFonts.inter(
                  //                                                                                                   fontWeight: FontWeight.w500,
                  //                                                                                                 ),
                  //                                                                                                 color: FlutterFlowTheme.of(context).secondaryText,
                  //                                                                                                 fontSize: 11.0,
                  //                                                                                               ),
                  //                                                                                         ),
                  //                                                                                       ),
                  //                                                                                   ],
                  //                                                                                 ),
                  //                                                                               ),
                  //                                                                             ),
                  //                                                                           ],
                  //                                                                         ),
                  //                                                                       ].divide(SizedBox(width: 5.0)),
                  //                                                                     ),
                  //                                                                   ),
                  //                                                                   if (rideDetailsCustomerRidesNewRecord.travelTime != null && rideDetailsCustomerRidesNewRecord.travelTime != '')
                  //                                                                     Align(
                  //                                                                       alignment: AlignmentDirectional(0.0, 0.0),
                  //                                                                       child: Row(
                  //                                                                         mainAxisSize: MainAxisSize.max,
                  //                                                                         mainAxisAlignment: MainAxisAlignment.center,
                  //                                                                         children: [
                  //                                                                           Align(
                  //                                                                             alignment: AlignmentDirectional(0.0, 0.0),
                  //                                                                             child: Text(
                  //                                                                               'Travel time: ',
                  //                                                                               style: FlutterFlowTheme.of(context).labelMedium.override(
                  //                                                                                     font: GoogleFonts.inter(
                  //                                                                                       fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
                  //                                                                                       fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                  //                                                                                     ),
                  //                                                                                     color: FlutterFlowTheme.of(context).secondaryText,
                  //                                                                                     fontSize: 12.0,
                  //                                                                                     letterSpacing: 0.0,
                  //                                                                                     fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
                  //                                                                                     fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                  //                                                                                   ),
                  //                                                                             ),
                  //                                                                           ),
                  //                                                                           Align(
                  //                                                                             alignment: AlignmentDirectional(0.0, 0.0),
                  //                                                                             child: Text(
                  //                                                                               rideDetailsCustomerRidesNewRecord.travelTime,
                  //                                                                               style: FlutterFlowTheme.of(context).labelMedium.override(
                  //                                                                                     font: GoogleFonts.inter(
                  //                                                                                       fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
                  //                                                                                       fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                  //                                                                                     ),
                  //                                                                                     color: FlutterFlowTheme.of(context).secondaryText,
                  //                                                                                     fontSize: 12.0,
                  //                                                                                     letterSpacing: 0.0,
                  //                                                                                     fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
                  //                                                                                     fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                  //                                                                                   ),
                  //                                                                             ),
                  //                                                                           ),
                  //                                                                         ],
                  //                                                                       ),
                  //                                                                     ),
                  //                                                                   Row(
                  //                                                                     mainAxisSize: MainAxisSize.max,
                  //                                                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //                                                                     children: [
                  //                                                                       Row(
                  //                                                                         mainAxisSize: MainAxisSize.max,
                  //                                                                         children: [
                  //                                                                           Icon(
                  //                                                                             Icons.location_on_outlined,
                  //                                                                             color: FlutterFlowTheme.of(context).primary,
                  //                                                                             size: 24.0,
                  //                                                                           ),
                  //                                                                           Container(
                  //                                                                             width: 200.0,
                  //                                                                             decoration: BoxDecoration(
                  //                                                                               color: FlutterFlowTheme.of(context).primaryBackground,
                  //                                                                               borderRadius: BorderRadius.circular(15.0),
                  //                                                                             ),
                  //                                                                             child: Padding(
                  //                                                                               padding: EdgeInsetsDirectional.fromSTEB(15.0, 5.0, 10.0, 5.0),
                  //                                                                               child: Column(
                  //                                                                                 crossAxisAlignment: CrossAxisAlignment.start,
                  //                                                                                 children: [
                  //                                                                                   Text(
                  //                                                                                     rideDetailsCustomerRidesNewRecord.googleEndAddress != null && rideDetailsCustomerRidesNewRecord.googleEndAddress != '' ? rideDetailsCustomerRidesNewRecord.googleEndAddress! : rideDetailsCustomerRidesNewRecord.rideEndLocation,
                  //                                                                                     style: FlutterFlowTheme.of(context).bodyMedium.override(
                  //                                                                                           font: GoogleFonts.inter(
                  //                                                                                             fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                  //                                                                                             fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  //                                                                                           ),
                  //                                                                                           fontSize: 13.0,
                  //                                                                                           letterSpacing: 0.0,
                  //                                                                                           fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                  //                                                                                           fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  //                                                                                         ),
                  //                                                                                   ),
                  //                                                                                   if (rideDetailsCustomerRidesNewRecord.dropTime != null)
                  //                                                                                     Padding(
                  //                                                                                       padding: EdgeInsets.only(top: 4.0),
                  //                                                                                       child: Text(
                  //                                                                                         'Arrival: ${dateTimeFormat("hh:mm a", rideDetailsCustomerRidesNewRecord.dropTime).toLowerCase()}',
                  //                                                                                         style: FlutterFlowTheme.of(context).bodySmall.override(
                  //                                                                                               font: GoogleFonts.inter(
                  //                                                                                                 fontWeight: FontWeight.w500,
                  //                                                                                               ),
                  //                                                                                               color: FlutterFlowTheme.of(context).secondaryText,
                  //                                                                                               fontSize: 11.0,
                  //                                                                                             ),
                  //                                                                                       ),
                  //                                                                                     ),
                  //                                                                                 ],
                  //                                                                               ),
                  //                                                                             ),
                  //                                                                           ),
                  //                                                                         ],
                  //                                                                       ),
                  //                                                                     ].divide(SizedBox(width: 5.0)),
                  //                                                                   ),
                  //                                                                 ].divide(SizedBox(height: 12.0)),
                  //                                                               ),
                  //                                                             ),
                  //                                                           ],
                  //                                                         ),
                  //                                                         // Padding(
                  //                                                         //   padding: EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 5.0),
                  //                                                         //   child: Row(
                  //                                                         //     mainAxisSize: MainAxisSize.max,
                  //                                                         //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //                                                         //     children: [
                  //                                                         //       Column(
                  //                                                         //         mainAxisSize: MainAxisSize.max,
                  //                                                         //         children: [
                  //                                                         //           Text(
                  //                                                         //             'Start At',
                  //                                                         //             textAlign: TextAlign.start,
                  //                                                         //             style: FlutterFlowTheme.of(context).bodyMedium.override(
                  //                                                         //                   font: GoogleFonts.inter(
                  //                                                         //                     fontWeight: FontWeight.w500,
                  //                                                         //                     fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  //                                                         //                   ),
                  //                                                         //                   fontSize: 15.0,
                  //                                                         //                   letterSpacing: 0.0,
                  //                                                         //                   fontWeight: FontWeight.w500,
                  //                                                         //                   fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  //                                                         //                 ),
                  //                                                         //           ),
                  //                                                         //           Text(
                  //                                                         //             dateTimeFormat("d/M h:mm a", rideDetailsCustomerRidesNewRecord.pickupTime!),
                  //                                                         //             textAlign: TextAlign.start,
                  //                                                         //             style: FlutterFlowTheme.of(context).bodyMedium.override(
                  //                                                         //                   font: GoogleFonts.inter(
                  //                                                         //                     fontWeight: FontWeight.w500,
                  //                                                         //                     fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  //                                                         //                   ),
                  //                                                         //                   fontSize: 15.0,
                  //                                                         //                   letterSpacing: 0.0,
                  //                                                         //                   fontWeight: FontWeight.w500,
                  //                                                         //                   fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  //                                                         //                 ),
                  //                                                         //           ),
                  //                                                         //         ],
                  //                                                         //       ),
                  //                                                         //       Column(
                  //                                                         //         mainAxisSize: MainAxisSize.max,
                  //                                                         //         children: [
                  //                                                         //           Text(
                  //                                                         //             'End At',
                  //                                                         //             textAlign: TextAlign.start,
                  //                                                         //             style: FlutterFlowTheme.of(context).bodyMedium.override(
                  //                                                         //                   font: GoogleFonts.inter(
                  //                                                         //                     fontWeight: FontWeight.w500,
                  //                                                         //                     fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  //                                                         //                   ),
                  //                                                         //                   fontSize: 15.0,
                  //                                                         //                   letterSpacing: 0.0,
                  //                                                         //                   fontWeight: FontWeight.w500,
                  //                                                         //                   fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  //                                                         //                 ),
                  //                                                         //           ),
                  //                                                         //           Padding(
                  //                                                         //             padding: EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 0.0, 0.0),
                  //                                                         //             child: Text(
                  //                                                         //               dateTimeFormat("d/M h:mm a", rideDetailsCustomerRidesNewRecord.dropTime!),
                  //                                                         //               textAlign: TextAlign.start,
                  //                                                         //               style: FlutterFlowTheme.of(context).bodyMedium.override(
                  //                                                         //                     font: GoogleFonts.inter(
                  //                                                         //                       fontWeight: FontWeight.w500,
                  //                                                         //                       fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  //                                                         //                     ),
                  //                                                         //                     fontSize: 15.0,
                  //                                                         //                     letterSpacing: 0.0,
                  //                                                         //                     fontWeight: FontWeight.w500,
                  //                                                         //                     fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  //                                                         //                   ),
                  //                                                         //             ),
                  //                                                         //           ),
                  //                                                         //         ],
                  //                                                         //       ),
                  //                                                         //     ].divide(SizedBox(width: 5.0)),
                  //                                                         //   ),
                  //                                                         // ),
                  //                                                       ].divide(SizedBox(height: 5.0)),
                  //                                                     ),
                  //                                                   ),
                  //                                                   // Align(
                  //                                                   //   alignment: AlignmentDirectional(0.97, 0.96),
                  //                                                   //   child: Padding(
                  //                                                   //     padding: EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 5.0, 0.0),
                  //                                                   //     child: Container(
                  //                                                   //       width: 80.0,
                  //                                                   //       height: 90.0,
                  //                                                   //       decoration: BoxDecoration(
                  //                                                   //         color: Color(0xFFF97E4C),
                  //                                                   //         borderRadius: BorderRadius.circular(12.0),
                  //                                                   //       ),
                  //                                                   //       child: Column(
                  //                                                   //         mainAxisSize: MainAxisSize.max,
                  //                                                   //         children: [
                  //                                                   //           Padding(
                  //                                                   //             padding: EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
                  //                                                   //             child: Text(
                  //                                                   //               'Ride',
                  //                                                   //               style: FlutterFlowTheme.of(context).bodyMedium.override(
                  //                                                   //                     font: GoogleFonts.inter(
                  //                                                   //                       fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                  //                                                   //                       fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  //                                                   //                     ),
                  //                                                   //                     color: FlutterFlowTheme.of(context).info,
                  //                                                   //                     fontSize: 12.0,
                  //                                                   //                     letterSpacing: 0.0,
                  //                                                   //                     fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                  //                                                   //                     fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  //                                                   //                   ),
                  //                                                   //             ),
                  //                                                   //           ),
                  //                                                   //           Padding(
                  //                                                   //             padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 4.0),
                  //                                                   //             child: Text(
                  //                                                   //               '₹${valueOrDefault<String>(
                  //                                                   //                 rideDetailsCustomerRidesNewRecord.rideCost.toString(),
                  //                                                   //                 '0',
                  //                                                   //               )}',
                  //                                                   //               style: FlutterFlowTheme.of(context).bodyMedium.override(
                  //                                                   //                     font: GoogleFonts.inter(
                  //                                                   //                       fontWeight: FontWeight.bold,
                  //                                                   //                       fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  //                                                   //                     ),
                  //                                                   //                     color: FlutterFlowTheme.of(context).info,
                  //                                                   //                     fontSize: 15.0,
                  //                                                   //                     letterSpacing: 0.0,
                  //                                                   //                     fontWeight: FontWeight.bold,
                  //                                                   //                     fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  //                                                   //                   ),
                  //                                                   //             ),
                  //                                                   //           ),
                  //                                                   //           Container(
                  //                                                   //             width: double.infinity,
                  //                                                   //             height: 50.0,
                  //                                                   //             decoration: BoxDecoration(
                  //                                                   //               color: Color(0xFFFF9561),
                  //                                                   //               borderRadius: BorderRadius.only(
                  //                                                   //                 bottomLeft: Radius.circular(10.0),
                  //                                                   //                 bottomRight: Radius.circular(10.0),
                  //                                                   //                 topLeft: Radius.circular(10.0),
                  //                                                   //                 topRight: Radius.circular(10.0),
                  //                                                   //               ),
                  //                                                   //             ),
                  //                                                   //             child: Column(
                  //                                                   //               mainAxisSize: MainAxisSize.max,
                  //                                                   //               mainAxisAlignment: MainAxisAlignment.start,
                  //                                                   //               children: [
                  //                                                   //                 Padding(
                  //                                                   //                   padding: EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
                  //                                                   //                   child: Text(
                  //                                                   //                     'Parcel',
                  //                                                   //                     textAlign: TextAlign.center,
                  //                                                   //                     style: FlutterFlowTheme.of(context).labelSmall.override(
                  //                                                   //                           font: GoogleFonts.inter(
                  //                                                   //                             fontWeight: FontWeight.w500,
                  //                                                   //                             fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
                  //                                                   //                           ),
                  //                                                   //                           color: FlutterFlowTheme.of(context).info,
                  //                                                   //                           fontSize: 12.0,
                  //                                                   //                           letterSpacing: 0.0,
                  //                                                   //                           fontWeight: FontWeight.w500,
                  //                                                   //                           fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
                  //                                                   //                         ),
                  //                                                   //                   ),
                  //                                                   //                 ),
                  //                                                   //                 Text(
                  //                                                   //                   '₹${rideDetailsCustomerRidesNewRecord.totalDeliveryCost}',
                  //                                                   //                   textAlign: TextAlign.center,
                  //                                                   //                   style: FlutterFlowTheme.of(context).labelSmall.override(
                  //                                                   //                         font: GoogleFonts.inter(
                  //                                                   //                           fontWeight: FontWeight.bold,
                  //                                                   //                           fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
                  //                                                   //                         ),
                  //                                                   //                         color: FlutterFlowTheme.of(context).info,
                  //                                                   //                         fontSize: 15.0,
                  //                                                   //                         letterSpacing: 0.0,
                  //                                                   //                         fontWeight: FontWeight.bold,
                  //                                                   //                         fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
                  //                                                   //                       ),
                  //                                                   //                 ),
                  //                                                   //               ].divide(SizedBox(height: 4.0)),
                  //                                                   //             ),
                  //                                                   //           ),
                  //                                                   //         ],
                  //                                                   //       ),
                  //                                                   //     ),
                  //                                                   //   ),
                  //                                                   // ),
                  //                                                   Align(
                  //                                                     alignment: AlignmentDirectional(0.97, -0.96),
                  //                                                     child: Padding(
                  //                                                       padding: EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 5.0, 0.0),
                  //                                                       child: Container(
                  //                                                         // ✅ RESPONSIVE SIZING
                  //                                                         width: MediaQuery.sizeOf(context).width * 0.12,  // 12% of screen width
                  //                                                         constraints: BoxConstraints(
                  //                                                           minWidth: 65.0,    // Minimum width
                  //                                                           maxWidth: 70.0,    // Maximum width
                  //                                                           minHeight: 85.0,   // Minimum height
                  //                                                           maxHeight: 100.0,  // Maximum height
                  //                                                         ),
                  //                                                         decoration: BoxDecoration(
                  //                                                           color: Color(0xFFF97E4C),
                  //                                                           borderRadius: BorderRadius.circular(12.0),
                  //                                                         ),
                  //                                                         child: Column(
                  //                                                           mainAxisSize: MainAxisSize.min,
                  //                                                           mainAxisAlignment: MainAxisAlignment.center,
                  //                                                           children: [
                  //                                                             Padding(
                  //                                                               padding: EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
                  //                                                               child: Text(
                  //                                                                 'Ride',
                  //                                                                 style: FlutterFlowTheme.of(context).bodyMedium.override(
                  //                                                                   font: GoogleFonts.inter(
                  //                                                                     fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                  //                                                                     fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  //                                                                   ),
                  //                                                                   color: FlutterFlowTheme.of(context).info,
                  //                                                                   fontSize: 12.0,
                  //                                                                   letterSpacing: 0.0,
                  //                                                                 ),
                  //                                                               ),
                  //                                                             ),
                  //                                                             Padding(
                  //                                                               padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 4.0),
                  //                                                               child: AutoSizeText(
                  //                                                                   // '₹${rideDetailsCustomerRidesNewRecord.pricePerPassengers.toString()}',
                  // 
                  //                                                                 '₹${formatNumber(rideDetailsCustomerRidesNewRecord.pricePerPassengers, formatType: FormatType.custom, format: '', locale: '')}',
                  //                                                                 style: FlutterFlowTheme.of(context).bodyMedium.override(
                  //                                                                   font: GoogleFonts.inter(
                  //                                                                     fontWeight: FontWeight.bold,
                  //                                                                     fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  //                                                                   ),
                  //                                                                   color: FlutterFlowTheme.of(context).info,
                  //                                                                   fontSize: 15.0,
                  //                                                                   letterSpacing: 0.0,
                  //                                                                   fontWeight: FontWeight.bold,
                  //                                                                 ),
                  //                                                                 maxLines: 1,
                  //                                                                 minFontSize: 12,
                  //                                                               ),
                  //                                                             ),
                  //                                                             // ✅ Parcel section also responsive
                  //                                                             Container(
                  //                                                               width: double.infinity,
                  //                                                               // ✅ Flexible height
                  //                                                               constraints: BoxConstraints(minHeight: 48.0, maxHeight: 55.0),
                  //                                                               decoration: BoxDecoration(
                  //                                                                 color: Color(0xFFFF9561),
                  //                                                                 borderRadius: BorderRadius.circular(10.0),
                  //                                                               ),
                  //                                                               child: Column(
                  //                                                                 mainAxisSize: MainAxisSize.min,
                  //                                                                 mainAxisAlignment: MainAxisAlignment.center,
                  //                                                                 children: [
                  //                                                                   Padding(
                  //                                                                     padding: EdgeInsetsDirectional.fromSTEB(0.0, 3.0, 0.0, 0.0),
                  //                                                                     child: Text(
                  //                                                                       'Parcel',
                  //                                                                       textAlign: TextAlign.center,
                  //                                                                       style: FlutterFlowTheme.of(context).labelSmall.override(
                  //                                                                         font: GoogleFonts.inter(
                  //                                                                           fontWeight: FontWeight.w500,
                  //                                                                           fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
                  //                                                                         ),
                  //                                                                         color: FlutterFlowTheme.of(context).info,
                  //                                                                         fontSize: 11.0,
                  //                                                                         letterSpacing: 0.0,
                  //                                                                       ),
                  //                                                                     ),
                  //                                                                   ),
                  //                                                                   AutoSizeText(
                  //                                                                     '₹${rideDetailsCustomerRidesNewRecord.totalDeliveryCost}',
                  //                                                                     textAlign: TextAlign.center,
                  //                                                                     style: FlutterFlowTheme.of(context).labelSmall.override(
                  //                                                                       font: GoogleFonts.inter(
                  //                                                                         fontWeight: FontWeight.bold,
                  //                                                                         fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
                  //                                                                       ),
                  //                                                                       color: FlutterFlowTheme.of(context).info,
                  //                                                                       fontSize: 14.0,
                  //                                                                       letterSpacing: 0.0,
                  //                                                                     ),
                  //                                                                     maxLines: 1,
                  //                                                                     minFontSize: 11,
                  //                                                                   ),
                  //                                                                 ],
                  //                                                               ),
                  //                                                             ),
                  //                                                           ],
                  //                                                         ),
                  //                                                       ),
                  //                                                     ),
                  //                                                   ),
                  // 
                  //                                                 ],
                  //                                               ),
                  //                                             ),
                  //                                           ).animateOnPageLoad(animationsMap['containerOnPageLoadAnimation']!),
                  //                                           
                  //                                           Divider(
                  //                                             thickness: 0.5,
                  //                                             color: FlutterFlowTheme.of(context).secondaryText,
                  //                                           ),
                  //                                           Material(
                  //                                             color: Colors.transparent,
                  //                                             elevation: 10.0,
                  //                                             shape: RoundedRectangleBorder(
                  //                                               borderRadius: BorderRadius.circular(16.0),
                  //                                             ),
                  //                                             child: Container(
                  //                                               decoration: BoxDecoration(
                  //                                                 color: FlutterFlowTheme.of(context).primaryBackground,
                  //                                                 borderRadius: BorderRadius.circular(16.0),
                  //                                                 border: Border.all(
                  //                                                   color: FlutterFlowTheme.of(context).accent2,
                  //                                                 ),
                  //                                               ),
                  //                                               child: Padding(
                  //                                                 padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 10.0),
                  //                                                 child: SingleChildScrollView(
                  //                                                   primary: false,
                  //                                                   child: Column(
                  //                                                     mainAxisSize: MainAxisSize.max,
                  //                                                     children: [
                  //                                                       if (rideDetailsCustomerRidesNewRecord.modeOfTransport == 'Car')
                  //                                                         Padding(
                  //                                                           padding: EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 10.0),
                  //                                                           child: Column(
                  //                                                             children: [
                  //                                                               // Row 1: Passengers allowed
                  //                                                               Row(
                  //                                                                 mainAxisSize: MainAxisSize.max,
                  //                                                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //                                                                 children: [
                  //                                                                   Text(
                  //                                                                     'Passengers allowed?',
                  //                                                                     style: FlutterFlowTheme.of(context).bodyMedium.override(
                  //                                                                       font: GoogleFonts.inter(fontWeight: FontWeight.w500),
                  //                                                                       fontSize: 15.0,
                  //                                                                       color: FlutterFlowTheme.of(context).primaryText,
                  //                                                                     ),
                  //                                                                   ),
                  //                                                                   Container(
                  //                                                                     width: 80.0,  // ✅ Fixed width for all containers
                  //                                                                     padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                  //                                                                     alignment: Alignment.center,
                  //                                                                     decoration: BoxDecoration(
                  //                                                                       color: Color(0xFF4DABF7).withOpacity(0.1),
                  //                                                                       borderRadius: BorderRadius.circular(20.0),
                  //                                                                       border: Border.all(color: Color(0xFF4DABF7), width: 1.0),
                  //                                                                     ),
                  //                                                                     child: Text(
                  //                                                                       rideDetailsCustomerRidesNewRecord.isPassangerAllowedinCar,
                  //                                                                       style: FlutterFlowTheme.of(context).bodyMedium.override(
                  //                                                                         font: GoogleFonts.inter(fontWeight: FontWeight.w600),
                  //                                                                         fontSize: 14.0,
                  //                                                                         color: Color(0xFF4DABF7),
                  //                                                                       ),
                  //                                                                       textAlign: TextAlign.center,
                  //                                                                     ),
                  //                                                                   ),
                  //                                                                 ],
                  //                                                               ),
                  //                                                               SizedBox(height: 12.0),  // ✅ Consistent spacing
                  // 
                  //                                                               // Row 2: Passengers limit
                  //                                                               Row(
                  //                                                                 mainAxisSize: MainAxisSize.max,
                  //                                                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //                                                                 children: [
                  //                                                                   Text(
                  //                                                                     'Passengers limit',
                  //                                                                     style: FlutterFlowTheme.of(context).bodyMedium.override(
                  //                                                                       font: GoogleFonts.inter(fontWeight: FontWeight.w500),
                  //                                                                       fontSize: 15.0,
                  //                                                                       color: FlutterFlowTheme.of(context).primaryText,
                  //                                                                     ),
                  //                                                                   ),
                  //                                                                   Container(
                  //                                                                     width: 80.0,  // ✅ Fixed width
                  //                                                                     padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                  //                                                                     alignment: Alignment.center,
                  //                                                                     decoration: BoxDecoration(
                  //                                                                       color: Color(0xFF4DABF7).withOpacity(0.1),
                  //                                                                       borderRadius: BorderRadius.circular(20.0),
                  //                                                                       border: Border.all(color: Color(0xFF4DABF7), width: 1.0),
                  //                                                                     ),
                  //                                                                     child: Text(
                  //                                                                       rideDetailsCustomerRidesNewRecord.numPassengers.toString(),
                  //                                                                       style: FlutterFlowTheme.of(context).bodyMedium.override(
                  //                                                                         font: GoogleFonts.inter(fontWeight: FontWeight.w600),
                  //                                                                         fontSize: 14.0,
                  //                                                                         color: Color(0xFF4DABF7),
                  //                                                                       ),
                  //                                                                       textAlign: TextAlign.center,
                  //                                                                     ),
                  //                                                                   ),
                  //                                                                 ],
                  //                                                               ),
                  //                                                               SizedBox(height: 12.0),  // ✅ Consistent spacing
                  // 
                  //                                                               // Row 3: Price per passenger
                  //                                                               Row(
                  //                                                                 mainAxisSize: MainAxisSize.max,
                  //                                                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //                                                                 children: [
                  //                                                                   Text(
                  //                                                                     'Price per passenger',
                  //                                                                     style: FlutterFlowTheme.of(context).bodyMedium.override(
                  //                                                                       font: GoogleFonts.inter(fontWeight: FontWeight.w500),
                  //                                                                       fontSize: 15.0,
                  //                                                                       color: FlutterFlowTheme.of(context).primaryText,
                  //                                                                     ),
                  //                                                                   ),
                  //                                                                   Container(
                  //                                                                     width: 80.0,  // ✅ Fixed width
                  //                                                                     padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                  //                                                                     alignment: Alignment.center,
                  //                                                                     decoration: BoxDecoration(
                  //                                                                       color: Color(0xFFFF8C00).withOpacity(0.1),
                  //                                                                       borderRadius: BorderRadius.circular(20.0),
                  //                                                                       border: Border.all(color: Color(0xFFFF8C00), width: 1.0),
                  //                                                                     ),
                  //                                                                     child: Text(
                  //                                                                       '₹${rideDetailsCustomerRidesNewRecord.pricePerPassengers.toString()}',
                  //                                                                       style: FlutterFlowTheme.of(context).bodyMedium.override(
                  //                                                                         font: GoogleFonts.inter(fontWeight: FontWeight.w600),
                  //                                                                         fontSize: 14.0,
                  //                                                                         color: Color(0xFFFF8C00),
                  //                                                                       ),
                  //                                                                       textAlign: TextAlign.center,
                  //                                                                     ),
                  //                                                                   ),
                  //                                                                 ],
                  //                                                               ),
                  //                                                               SizedBox(height: 12.0),  // ✅ Consistent spacing
                  // 
                  //                                                               // Row 4: Bags allowed
                  //                                                               Row(
                  //                                                                 mainAxisSize: MainAxisSize.max,
                  //                                                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //                                                                 children: [
                  //                                                                   Text(
                  //                                                                     'No. of bags allowed',
                  //                                                                     style: FlutterFlowTheme.of(context).bodyMedium.override(
                  //                                                                       font: GoogleFonts.inter(fontWeight: FontWeight.w500),
                  //                                                                       fontSize: 15.0,
                  //                                                                       color: FlutterFlowTheme.of(context).primaryText,
                  //                                                                     ),
                  //                                                                   ),
                  //                                                                   Container(
                  //                                                                     width: 80.0,  // ✅ Fixed width
                  //                                                                     padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                  //                                                                     alignment: Alignment.center,
                  //                                                                     decoration: BoxDecoration(
                  //                                                                       color: Color(0xFF4DABF7).withOpacity(0.1),
                  //                                                                       borderRadius: BorderRadius.circular(20.0),
                  //                                                                       border: Border.all(color: Color(0xFF4DABF7), width: 1.0),
                  //                                                                     ),
                  //                                                                     child: Text(
                  //                                                                       rideDetailsCustomerRidesNewRecord.numBagAllowed == 0
                  //                                                                           ? "1"
                  //                                                                           : rideDetailsCustomerRidesNewRecord.numBagAllowed.toString(),
                  //                                                                       style: FlutterFlowTheme.of(context).bodyMedium.override(
                  //                                                                         font: GoogleFonts.inter(fontWeight: FontWeight.w600),
                  //                                                                         fontSize: 14.0,
                  //                                                                         color: Color(0xFF4DABF7),
                  //                                                                       ),
                  //                                                                       textAlign: TextAlign.center,
                  //                                                                     ),
                  //                                                                   ),
                  //                                                                 ],
                  //                                                               ),
                  //                                                             ],
                  //                                                           ),
                  //                                                         ),
                  // 
                  //                                                       Padding(
                  //                                                         padding: EdgeInsetsDirectional.fromSTEB(5.0, 15.0, 0.0, 0.0),
                  //                                                         child: Text(
                  //                                                           'What parcel you can send?',
                  //                                                           textAlign: TextAlign.start,
                  //                                                           style: FlutterFlowTheme.of(context).bodyMedium.override(
                  //                                                                 font: GoogleFonts.inter(
                  //                                                                   fontWeight: FontWeight.w500,
                  //                                                                   fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  //                                                                 ),
                  //                                                                 color: Color(0xFF2B3E60),
                  //                                                                 fontSize: 15.0,
                  //                                                                 letterSpacing: 0.0,
                  //                                                                 fontWeight: FontWeight.w500,
                  //                                                                 fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  //                                                               ),
                  //                                                         ),
                  //                                                       ),
                  //                                                       if (rideDetailsCustomerRidesNewRecord.isPredefinedItems == true)
                  //                                                         Align(
                  //                                                           alignment: AlignmentDirectional(0.0, 0.0),
                  //                                                           child: Padding(
                  //                                                             padding: EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 32.0),
                  //                                                             child: Wrap(
                  //                                                               spacing: 10.0,
                  //                                                               runSpacing: 10.0,
                  //                                                               alignment: WrapAlignment.start,
                  //                                                               crossAxisAlignment: WrapCrossAlignment.start,
                  //                                                               direction: Axis.horizontal,
                  //                                                               runAlignment: WrapAlignment.start,
                  //                                                               verticalDirection: VerticalDirection.down,
                  //                                                               clipBehavior: Clip.none,
                  //                                                               children: [
                  //                                                                 Container(
                  //                                                                   decoration: BoxDecoration(
                  //                                                                     color: Color(0xFFF4F4F4),
                  //                                                                     borderRadius: BorderRadius.circular(20.0),
                  //                                                                   ),
                  //                                                                   child: Padding(
                  //                                                                     padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
                  //                                                                     child: InkWell(
                  //                                                                       splashColor: Colors.transparent,
                  //                                                                       focusColor: Colors.transparent,
                  //                                                                       hoverColor: Colors.transparent,
                  //                                                                       highlightColor: Colors.transparent,
                  //                                                                       onTap: () async {
                  //                                                                         safeSetState(() {});
                  //                                                                       },
                  //                                                                       child: Text(
                  //                                                                         'Food Item',
                  //                                                                         style: FlutterFlowTheme.of(context).bodyMedium.override(
                  //                                                                               font: GoogleFonts.inter(
                  //                                                                                 fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                  //                                                                                 fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  //                                                                               ),
                  //                                                                               color: Color(0xFF333333),
                  //                                                                               letterSpacing: 0.0,
                  //                                                                               fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                  //                                                                               fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  //                                                                             ),
                  //                                                                       ),
                  //                                                                     ),
                  //                                                                   ),
                  //                                                                 ),
                  //                                                                 Container(
                  //                                                                   decoration: BoxDecoration(
                  //                                                                     color: Color(0xFFF4F4F4),
                  //                                                                     borderRadius: BorderRadius.circular(20.0),
                  //                                                                   ),
                  //                                                                   child: Padding(
                  //                                                                     padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
                  //                                                                     child: Text(
                  //                                                                       'Sweets',
                  //                                                                       style: FlutterFlowTheme.of(context).bodyMedium.override(
                  //                                                                             font: GoogleFonts.inter(
                  //                                                                               fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                  //                                                                               fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  //                                                                             ),
                  //                                                                             color: Color(0xFF333333),
                  //                                                                             letterSpacing: 0.0,
                  //                                                                             fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                  //                                                                             fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  //                                                                           ),
                  //                                                                     ),
                  //                                                                   ),
                  //                                                                 ),
                  //                                                                 Container(
                  //                                                                   decoration: BoxDecoration(
                  //                                                                     color: Color(0xFFF4F4F4),
                  //                                                                     borderRadius: BorderRadius.circular(20.0),
                  //                                                                   ),
                  //                                                                   child: Padding(
                  //                                                                     padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
                  //                                                                     child: Text(
                  //                                                                       'Spices',
                  //                                                                       style: FlutterFlowTheme.of(context).bodyMedium.override(
                  //                                                                             font: GoogleFonts.inter(
                  //                                                                               fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                  //                                                                               fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  //                                                                             ),
                  //                                                                             color: Color(0xFF333333),
                  //                                                                             letterSpacing: 0.0,
                  //                                                                             fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                  //                                                                             fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  //                                                                           ),
                  //                                                                     ),
                  //                                                                   ),
                  //                                                                 ),
                  //                                                                 Container(
                  //                                                                   decoration: BoxDecoration(
                  //                                                                     color: Color(0xFFF4F4F4),
                  //                                                                     borderRadius: BorderRadius.circular(20.0),
                  //                                                                   ),
                  //                                                                   child: Padding(
                  //                                                                     padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
                  //                                                                     child: Text(
                  //                                                                       'Crockery',
                  //                                                                       style: FlutterFlowTheme.of(context).bodyMedium.override(
                  //                                                                             font: GoogleFonts.inter(
                  //                                                                               fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                  //                                                                               fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  //                                                                             ),
                  //                                                                             color: Color(0xFF333333),
                  //                                                                             letterSpacing: 0.0,
                  //                                                                             fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                  //                                                                             fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  //                                                                           ),
                  //                                                                     ),
                  //                                                                   ),
                  //                                                                 ),
                  //                                                                 Container(
                  //                                                                   decoration: BoxDecoration(
                  //                                                                     color: Color(0xFFF4F4F4),
                  //                                                                     borderRadius: BorderRadius.circular(20.0),
                  //                                                                   ),
                  //                                                                   child: Padding(
                  //                                                                     padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
                  //                                                                     child: Text(
                  //                                                                       'Small Appliances',
                  //                                                                       style: FlutterFlowTheme.of(context).bodyMedium.override(
                  //                                                                             font: GoogleFonts.inter(
                  //                                                                               fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                  //                                                                               fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  //                                                                             ),
                  //                                                                             color: Color(0xFF333333),
                  //                                                                             letterSpacing: 0.0,
                  //                                                                             fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                  //                                                                             fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  //                                                                           ),
                  //                                                                     ),
                  //                                                                   ),
                  //                                                                 ),
                  //                                                                 Container(
                  //                                                                   decoration: BoxDecoration(
                  //                                                                     color: Color(0xFFF4F4F4),
                  //                                                                     borderRadius: BorderRadius.circular(20.0),
                  //                                                                   ),
                  //                                                                   child: Padding(
                  //                                                                     padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
                  //                                                                     child: Text(
                  //                                                                       'Kitchen Items',
                  //                                                                       style: FlutterFlowTheme.of(context).bodyMedium.override(
                  //                                                                             font: GoogleFonts.inter(
                  //                                                                               fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                  //                                                                               fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  //                                                                             ),
                  //                                                                             color: Color(0xFF333333),
                  //                                                                             letterSpacing: 0.0,
                  //                                                                             fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                  //                                                                             fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  //                                                                           ),
                  //                                                                     ),
                  //                                                                   ),
                  //                                                                 ),
                  //                                                                 Container(
                  //                                                                   decoration: BoxDecoration(
                  //                                                                     color: Color(0xFFF4F4F4),
                  //                                                                     borderRadius: BorderRadius.circular(20.0),
                  //                                                                   ),
                  //                                                                   child: Padding(
                  //                                                                     padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
                  //                                                                     child: Text(
                  //                                                                       'Festival goodies',
                  //                                                                       style: FlutterFlowTheme.of(context).bodyMedium.override(
                  //                                                                             font: GoogleFonts.inter(
                  //                                                                               fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                  //                                                                               fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  //                                                                             ),
                  //                                                                             color: Color(0xFF333333),
                  //                                                                             letterSpacing: 0.0,
                  //                                                                             fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                  //                                                                             fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  //                                                                           ),
                  //                                                                     ),
                  //                                                                   ),
                  //                                                                 ),
                  //                                                                 Container(
                  //                                                                   decoration: BoxDecoration(
                  //                                                                     color: Color(0xFFF4F4F4),
                  //                                                                     borderRadius: BorderRadius.circular(20.0),
                  //                                                                   ),
                  //                                                                   child: Padding(
                  //                                                                     padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
                  //                                                                     child: Text(
                  //                                                                       'Clothing & Accessories',
                  //                                                                       style: FlutterFlowTheme.of(context).bodyMedium.override(
                  //                                                                             font: GoogleFonts.inter(
                  //                                                                               fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                  //                                                                               fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  //                                                                             ),
                  //                                                                             color: Color(0xFF333333),
                  //                                                                             letterSpacing: 0.0,
                  //                                                                             fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                  //                                                                             fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  //                                                                           ),
                  //                                                                     ),
                  //                                                                   ),
                  //                                                                 ),
                  //                                                                 Container(
                  //                                                                   decoration: BoxDecoration(
                  //                                                                     color: Color(0xFFF4F4F4),
                  //                                                                     borderRadius: BorderRadius.circular(20.0),
                  //                                                                   ),
                  //                                                                   child: Padding(
                  //                                                                     padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
                  //                                                                     child: Text(
                  //                                                                       'Tech & Electronics',
                  //                                                                       style: FlutterFlowTheme.of(context).bodyMedium.override(
                  //                                                                             font: GoogleFonts.inter(
                  //                                                                               fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                  //                                                                               fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  //                                                                             ),
                  //                                                                             color: Color(0xFF333333),
                  //                                                                             letterSpacing: 0.0,
                  //                                                                             fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                  //                                                                             fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  //                                                                           ),
                  //                                                                     ),
                  //                                                                   ),
                  //                                                                 ),
                  //                                                                 Container(
                  //                                                                   decoration: BoxDecoration(
                  //                                                                     color: Color(0xFFF4F4F4),
                  //                                                                     borderRadius: BorderRadius.circular(20.0),
                  //                                                                   ),
                  //                                                                   child: Padding(
                  //                                                                     padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
                  //                                                                     child: Text(
                  //                                                                       'Homemade Food & Snacks',
                  //                                                                       style: FlutterFlowTheme.of(context).bodyMedium.override(
                  //                                                                             font: GoogleFonts.inter(
                  //                                                                               fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                  //                                                                               fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  //                                                                             ),
                  //                                                                             color: Color(0xFF333333),
                  //                                                                             letterSpacing: 0.0,
                  //                                                                             fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                  //                                                                             fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  //                                                                           ),
                  //                                                                     ),
                  //                                                                   ),
                  //                                                                 ),
                  //                                                                 Container(
                  //                                                                   decoration: BoxDecoration(
                  //                                                                     color: Color(0xFFF4F4F4),
                  //                                                                     borderRadius: BorderRadius.circular(20.0),
                  //                                                                   ),
                  //                                                                   child: Padding(
                  //                                                                     padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
                  //                                                                     child: Text(
                  //                                                                       'Documents',
                  //                                                                       style: FlutterFlowTheme.of(context).bodyMedium.override(
                  //                                                                             font: GoogleFonts.inter(
                  //                                                                               fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                  //                                                                               fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  //                                                                             ),
                  //                                                                             color: Color(0xFF333333),
                  //                                                                             letterSpacing: 0.0,
                  //                                                                             fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                  //                                                                             fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  //                                                                           ),
                  //                                                                     ),
                  //                                                                   ),
                  //                                                                 ),
                  //                                                                 Container(
                  //                                                                   decoration: BoxDecoration(
                  //                                                                     color: Color(0xFFF4F4F4),
                  //                                                                     borderRadius: BorderRadius.circular(20.0),
                  //                                                                   ),
                  //                                                                   child: Padding(
                  //                                                                     padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
                  //                                                                     child: Text(
                  //                                                                       'Child-related Items',
                  //                                                                       style: FlutterFlowTheme.of(context).bodyMedium.override(
                  //                                                                             font: GoogleFonts.inter(
                  //                                                                               fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                  //                                                                               fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  //                                                                             ),
                  //                                                                             color: Color(0xFF333333),
                  //                                                                             letterSpacing: 0.0,
                  //                                                                             fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                  //                                                                             fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  //                                                                           ),
                  //                                                                     ),
                  //                                                                   ),
                  //                                                                 ),
                  //                                                                 Container(
                  //                                                                   decoration: BoxDecoration(
                  //                                                                     color: Color(0xFFF4F4F4),
                  //                                                                     borderRadius: BorderRadius.circular(20.0),
                  //                                                                   ),
                  //                                                                   child: Padding(
                  //                                                                     padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
                  //                                                                     child: Text(
                  //                                                                       'Discuss over call',
                  //                                                                       style: FlutterFlowTheme.of(context).bodyMedium.override(
                  //                                                                             font: GoogleFonts.inter(
                  //                                                                               fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                  //                                                                               fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  //                                                                             ),
                  //                                                                             color: Color(0xFF333333),
                  //                                                                             letterSpacing: 0.0,
                  //                                                                             fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                  //                                                                             fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  //                                                                           ),
                  //                                                                     ),
                  //                                                                   ),
                  //                                                                 ),
                  //                                                                 Container(
                  //                                                                   decoration: BoxDecoration(
                  //                                                                     color: Color(0xFFF4F4F4),
                  //                                                                     borderRadius: BorderRadius.circular(20.0),
                  //                                                                   ),
                  //                                                                   child: Padding(
                  //                                                                     padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
                  //                                                                     child: Text(
                  //                                                                       'Others',
                  //                                                                       style: FlutterFlowTheme.of(context).bodyMedium.override(
                  //                                                                             font: GoogleFonts.inter(
                  //                                                                               fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                  //                                                                               fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  //                                                                             ),
                  //                                                                             color: Color(0xFF333333),
                  //                                                                             letterSpacing: 0.0,
                  //                                                                             fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                  //                                                                             fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  //                                                                           ),
                  //                                                                     ),
                  //                                                                   ),
                  //                                                                 ),
                  //                                                               ],
                  //                                                             ),
                  //                                                           ),
                  //                                                         ),
                  //                                                       if (rideDetailsCustomerRidesNewRecord.isPredefinedItems == false)
                  //                                                         Align(
                  //                                                           alignment: AlignmentDirectional(0.0, 0.0),
                  //                                                           child: Padding(
                  //                                                             padding: EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 32.0),
                  //                                                             child: Builder(
                  //                                                               builder: (context) {
                  //                                                                 final carryItems = rideDetailsCustomerRidesNewRecord.caryyItems.toList();
                  // 
                  //                                                                 return Wrap(
                  //                                                                   spacing: 10.0,
                  //                                                                   runSpacing: 10.0,
                  //                                                                   alignment: WrapAlignment.start,
                  //                                                                   crossAxisAlignment: WrapCrossAlignment.start,
                  //                                                                   direction: Axis.horizontal,
                  //                                                                   runAlignment: WrapAlignment.start,
                  //                                                                   verticalDirection: VerticalDirection.down,
                  //                                                                   clipBehavior: Clip.none,
                  //                                                                   children: List.generate(carryItems.length, (carryItemsIndex) {
                  //                                                                     final carryItemsItem = carryItems[carryItemsIndex];
                  //                                                                     return Container(
                  //                                                                       decoration: BoxDecoration(
                  //                                                                         color: FlutterFlowTheme.of(context).boxColour,
                  //                                                                         borderRadius: BorderRadius.circular(20.0),
                  //                                                                         border: Border.all(
                  //                                                                           color: FlutterFlowTheme.of(context).containerBG,
                  //                                                                         ),
                  //                                                                       ),
                  //                                                                       child: Padding(
                  //                                                                         padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
                  //                                                                         child: InkWell(
                  //                                                                           splashColor: Colors.transparent,
                  //                                                                           focusColor: Colors.transparent,
                  //                                                                           hoverColor: Colors.transparent,
                  //                                                                           highlightColor: Colors.transparent,
                  //                                                                           onTap: () async {
                  //                                                                             safeSetState(() {});
                  //                                                                           },
                  //                                                                           child: Text(
                  //                                                                             carryItemsItem,
                  //                                                                             style: FlutterFlowTheme.of(context).bodyMedium.override(
                  //                                                                                   font: GoogleFonts.inter(
                  //                                                                                     fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                  //                                                                                     fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  //                                                                                   ),
                  //                                                                                   color: Color(0xFF333333),
                  //                                                                                   letterSpacing: 0.0,
                  //                                                                                   fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                  //                                                                                   fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  //                                                                                 ),
                  //                                                                           ),
                  //                                                                         ),
                  //                                                                       ),
                  //                                                                     );
                  //                                                                   }),
                  //                                                                 );
                  //                                                               },
                  //                                                             ),
                  //                                                           ),
                  //                                                         ),
                  //                                                     ].divide(SizedBox(height: 15.0)),
                  //                                                   ),
                  //                                                 ),
                  //                                               ),
                  //                                             ),
                  //                                           ),
                  //                                           if (rideDetailsCustomerRidesNewRecord.stoppages.length > 0)
                  //                                             Padding(
                  //                                               padding: EdgeInsetsDirectional.fromSTEB(5.0, 10.0, 0.0, 0.0),
                  //                                               child: Text(
                  //                                                 'Stoppage',
                  //                                                 textAlign: TextAlign.start,
                  //                                                 style: FlutterFlowTheme.of(context).bodyMedium.override(
                  //                                                       font: GoogleFonts.inter(
                  //                                                         fontWeight: FontWeight.w500,
                  //                                                         fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  //                                                       ),
                  //                                                       color: Color(0xFF2B3E60),
                  //                                                       fontSize: 15.0,
                  //                                                       letterSpacing: 0.0,
                  //                                                       fontWeight: FontWeight.w500,
                  //                                                       fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  //                                                     ),
                  //                                               ),
                  //                                             ),
                  //                                           if (rideDetailsCustomerRidesNewRecord.stoppages.length > 0)
                  //                                             Align(
                  //                                               alignment: AlignmentDirectional(0.0, 0.0),
                  //                                               child: Padding(
                  //                                                 padding: EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 32.0),
                  //                                                 child: Builder(
                  //                                                   builder: (context) {
                  //                                                     final stoppages = rideDetailsCustomerRidesNewRecord.stoppages.toList();
                  // 
                  //                                                     return Wrap(
                  //                                                       spacing: 10.0,
                  //                                                       runSpacing: 10.0,
                  //                                                       alignment: WrapAlignment.start,
                  //                                                       crossAxisAlignment: WrapCrossAlignment.start,
                  //                                                       direction: Axis.horizontal,
                  //                                                       runAlignment: WrapAlignment.start,
                  //                                                       verticalDirection: VerticalDirection.down,
                  //                                                       clipBehavior: Clip.none,
                  //                                                       children: List.generate(stoppages.length, (stoppagesIndex) {
                  //                                                         final stoppagesItem = stoppages[stoppagesIndex];
                  //                                                         return Container(
                  //                                                           decoration: BoxDecoration(
                  //                                                             color: FlutterFlowTheme.of(context).boxColour,
                  //                                                             borderRadius: BorderRadius.circular(20.0),
                  //                                                             border: Border.all(
                  //                                                               color: FlutterFlowTheme.of(context).containerBG,
                  //                                                             ),
                  //                                                           ),
                  //                                                           child: Padding(
                  //                                                             padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
                  //                                                             child: InkWell(
                  //                                                               splashColor: Colors.transparent,
                  //                                                               focusColor: Colors.transparent,
                  //                                                               hoverColor: Colors.transparent,
                  //                                                               highlightColor: Colors.transparent,
                  //                                                               onTap: () async {
                  //                                                                 safeSetState(() {});
                  //                                                               },
                  //                                                               child: Text(
                  //                                                                 stoppagesItem,
                  //                                                                 style: FlutterFlowTheme.of(context).bodyMedium.override(
                  //                                                                       font: GoogleFonts.inter(
                  //                                                                         fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                  //                                                                         fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  //                                                                       ),
                  //                                                                       color: Color(0xFF333333),
                  //                                                                       letterSpacing: 0.0,
                  //                                                                       fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                  //                                                                       fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  //                                                                     ),
                  //                                                               ),
                  //                                                             ),
                  //                                                           ),
                  //                                                         );
                  //                                                       }),
                  //                                                     );
                  //                                                   },
                  //                                                 ),
                  //                                               ),
                  //                                             ),
                  //                                           if (rideDetailsCustomerRidesNewRecord.rideStartLocationGoogle != null)
                  //                                             Column(
                  //                                               children: [
                  //                                                 Container(
                  //                                                   width: double.infinity,
                  //                                                   height: 220.0,
                  //                                                   decoration: BoxDecoration(
                  //                                                     borderRadius: BorderRadius.circular(16.0),
                  //                                                     boxShadow: [
                  //                                                       BoxShadow(
                  //                                                         blurRadius: 8.0,
                  //                                                         color: Colors.black.withOpacity(0.1),
                  //                                                         offset: const Offset(0, 4),
                  //                                                       ),
                  //                                                     ],
                  //                                                   ),
                  //                                                   child: ClipRRect(
                  //                                                     borderRadius: BorderRadius.circular(16.0),
                  //                                                     child: FlutterFlowGoogleMap(
                  //                                                       controller: _model.googleMapsController,
                  //                                                       onCameraIdle: (latLng) => _model.googleMapsCenter = latLng,
                  //                                                       initialLocation: _model.googleMapsCenter ??=
                  //                                                       rideDetailsCustomerRidesNewRecord.rideStartLocationGoogle!,
                  //                                                       markerColor: GoogleMarkerColor.violet,
                  //                                                       mapType: MapType.normal,
                  //                                                       style: GoogleMapStyle.standard,
                  //                                                       initialZoom: 15.0,
                  //                                                       allowInteraction: true,
                  //                                                       allowZoom: true,
                  //                                                       showZoomControls: true, // Keep default controls
                  //                                                       showLocation: true,
                  //                                                       showCompass: true,
                  //                                                       showMapToolbar: false,
                  //                                                       showTraffic: false,
                  //                                                       centerMapOnMarkerTap: true,
                  //                                                     ),
                  //                                                   ),
                  //                                                 ),
                  // 
                  //                                                 const SizedBox(height: 12),
                  // 
                  //                                                 SizedBox(
                  //                                                   width: double.infinity,
                  //                                                   child: FFButtonWidget(
                  //                                                     onPressed: () async {
                  //                                                       await launchMap(
                  //                                                         location: rideDetailsCustomerRidesNewRecord.rideStartLocationGoogle,
                  //                                                         title: rideDetailsCustomerRidesNewRecord.rideStartLocation,
                  //                                                       );
                  //                                                     },
                  //                                                     text: 'Check Google Map',
                  //                                                     icon: FaIcon(
                  //                                                       FontAwesomeIcons.google,
                  //                                                       size: 15.0,
                  //                                                     ),
                  //                                                     options: FFButtonOptions(
                  //                                                       height: 40.0,
                  //                                                       padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                  //                                                       iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  //                                                       color: FlutterFlowTheme.of(context).primary,
                  //                                                       textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                  //                                                         font: GoogleFonts.interTight(
                  //                                                           fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
                  //                                                           fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                  //                                                         ),
                  //                                                         color: Colors.white,
                  //                                                         letterSpacing: 0.0,
                  //                                                         fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
                  //                                                         fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                  //                                                       ),
                  //                                                       elevation: 10.0,
                  //                                                       borderRadius: BorderRadius.circular(8.0),
                  //                                                     ),
                  //                                                   ),
                  //                                                 ),
                  //                                               ],
                  //                                             ),
                  //                                           // if (rideDetailsCustomerRidesNewRecord.rideStartLocationGoogle != null)
                  //                                           //   Align(
                  //                                           //     alignment: AlignmentDirectional(0.0, 0.0),
                  //                                           //     child: FFButtonWidget(
                  //                                           //       onPressed: () async {
                  //                                           //         await launchMap(
                  //                                           //           location: rideDetailsCustomerRidesNewRecord.rideStartLocationGoogle,
                  //                                           //           title: rideDetailsCustomerRidesNewRecord.rideStartLocation,
                  //                                           //         );
                  //                                           //       },
                  //                                           //       text: 'Check Google Map',
                  //                                           //       icon: FaIcon(
                  //                                           //         FontAwesomeIcons.google,
                  //                                           //         size: 15.0,
                  //                                           //       ),
                  //                                           //       options: FFButtonOptions(
                  //                                           //         height: 40.0,
                  //                                           //         padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                  //                                           //         iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  //                                           //         color: FlutterFlowTheme.of(context).primary,
                  //                                           //         textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                  //                                           //               font: GoogleFonts.interTight(
                  //                                           //                 fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
                  //                                           //                 fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                  //                                           //               ),
                  //                                           //               color: Colors.white,
                  //                                           //               letterSpacing: 0.0,
                  //                                           //               fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
                  //                                           //               fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                  //                                           //             ),
                  //                                           //         elevation: 10.0,
                  //                                           //         borderRadius: BorderRadius.circular(8.0),
                  //                                           //       ),
                  //                                           //     ),
                  //                                           //   ),
                  //                                           Divider(
                  //                                             thickness: 0.5,
                  //                                             color: FlutterFlowTheme.of(context).secondaryText,
                  //                                           ),
                  //                                           Column(
                  //                                             mainAxisSize: MainAxisSize.max,
                  //                                             mainAxisAlignment: MainAxisAlignment.center,
                  //                                             crossAxisAlignment: CrossAxisAlignment.start,
                  //                                             children: [
                  //                                               Text(
                  //                                                 'Ride Rules',
                  //                                                 style: FlutterFlowTheme.of(context).bodyMedium.override(
                  //                                                       font: GoogleFonts.inter(
                  //                                                         fontWeight: FontWeight.w600,
                  //                                                         fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  //                                                       ),
                  //                                                       fontSize: 18.0,
                  //                                                       letterSpacing: 0.0,
                  //                                                       fontWeight: FontWeight.w600,
                  //                                                       fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  //                                                     ),
                  //                                               ),
                  //                                               if (rideDetailsCustomerRidesNewRecord.isRideRulesAccepted == true)
                  //                                                 Padding(
                  //                                                   padding: EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 32.0),
                  //                                                   child: Wrap(
                  //                                                     spacing: 10.0,
                  //                                                     runSpacing: 10.0,
                  //                                                     alignment: WrapAlignment.start,
                  //                                                     crossAxisAlignment: WrapCrossAlignment.start,
                  //                                                     direction: Axis.horizontal,
                  //                                                     runAlignment: WrapAlignment.start,
                  //                                                     verticalDirection: VerticalDirection.down,
                  //                                                     clipBehavior: Clip.none,
                  //                                                     children: [
                  //                                                       Container(
                  //                                                         decoration: BoxDecoration(
                  //                                                           color: FlutterFlowTheme.of(context).boxColour,
                  //                                                           borderRadius: BorderRadius.circular(20.0),
                  //                                                           border: Border.all(
                  //                                                             color: FlutterFlowTheme.of(context).containerBG,
                  //                                                           ),
                  //                                                         ),
                  //                                                         child: Padding(
                  //                                                           padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
                  //                                                           child: InkWell(
                  //                                                             splashColor: Colors.transparent,
                  //                                                             focusColor: Colors.transparent,
                  //                                                             hoverColor: Colors.transparent,
                  //                                                             highlightColor: Colors.transparent,
                  //                                                             onTap: () async {
                  //                                                               safeSetState(() {});
                  //                                                             },
                  //                                                             child: Text(
                  //                                                               'We accept only legal parcels—no prohibited or illegal items allowed.',
                  //                                                               style: FlutterFlowTheme.of(context).bodyMedium.override(
                  //                                                                     font: GoogleFonts.inter(
                  //                                                                       fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                  //                                                                       fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  //                                                                     ),
                  //                                                                     color: FlutterFlowTheme.of(context).primaryText,
                  //                                                                     letterSpacing: 0.0,
                  //                                                                     fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                  //                                                                     fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  //                                                                   ),
                  //                                                             ),
                  //                                                           ),
                  //                                                         ),
                  //                                                       ),
                  //                                                       Container(
                  //                                                         decoration: BoxDecoration(
                  //                                                           color: FlutterFlowTheme.of(context).boxColour,
                  //                                                           borderRadius: BorderRadius.circular(20.0),
                  //                                                           border: Border.all(
                  //                                                             color: FlutterFlowTheme.of(context).containerBG,
                  //                                                           ),
                  //                                                         ),
                  //                                                         child: Padding(
                  //                                                           padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
                  //                                                           child: Text(
                  //                                                             'Customers must arrive with the parcel at least 10 minutes before the vehicle arrives.',
                  //                                                             style: FlutterFlowTheme.of(context).bodyMedium.override(
                  //                                                                   font: GoogleFonts.inter(
                  //                                                                     fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                  //                                                                     fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  //                                                                   ),
                  //                                                                   color: FlutterFlowTheme.of(context).primaryText,
                  //                                                                   letterSpacing: 0.0,
                  //                                                                   fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                  //                                                                   fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  //                                                                 ),
                  //                                                           ),
                  //                                                         ),
                  //                                                       ),
                  //                                                       Container(
                  //                                                         decoration: BoxDecoration(
                  //                                                           color: FlutterFlowTheme.of(context).boxColour,
                  //                                                           borderRadius: BorderRadius.circular(20.0),
                  //                                                           border: Border.all(
                  //                                                             color: FlutterFlowTheme.of(context).containerBG,
                  //                                                           ),
                  //                                                         ),
                  //                                                         child: Padding(
                  //                                                           padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
                  //                                                           child: Text(
                  //                                                             'Complete receiver information is required at the time of booking.',
                  //                                                             style: FlutterFlowTheme.of(context).bodyMedium.override(
                  //                                                                   font: GoogleFonts.inter(
                  //                                                                     fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                  //                                                                     fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  //                                                                   ),
                  //                                                                   color: Color(0xFF333333),
                  //                                                                   letterSpacing: 0.0,
                  //                                                                   fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                  //                                                                   fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  //                                                                 ),
                  //                                                           ),
                  //                                                         ),
                  //                                                       ),
                  //                                                       Container(
                  //                                                         decoration: BoxDecoration(
                  //                                                           color: FlutterFlowTheme.of(context).boxColour,
                  //                                                           borderRadius: BorderRadius.circular(20.0),
                  //                                                           border: Border.all(
                  //                                                             color: FlutterFlowTheme.of(context).containerBG,
                  //                                                           ),
                  //                                                         ),
                  //                                                         child: Padding(
                  //                                                           padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
                  //                                                           child: Text(
                  //                                                             'Unacceptable items found during the ride may lead to cancellation or being reported.',
                  //                                                             style: FlutterFlowTheme.of(context).bodyMedium.override(
                  //                                                                   font: GoogleFonts.inter(
                  //                                                                     fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                  //                                                                     fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  //                                                                   ),
                  //                                                                   color: Color(0xFF333333),
                  //                                                                   letterSpacing: 0.0,
                  //                                                                   fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                  //                                                                   fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  //                                                                 ),
                  //                                                           ),
                  //                                                         ),
                  //                                                       ),
                  //                                                       Container(
                  //                                                         decoration: BoxDecoration(
                  //                                                           color: FlutterFlowTheme.of(context).boxColour,
                  //                                                           borderRadius: BorderRadius.circular(20.0),
                  //                                                           border: Border.all(
                  //                                                             color: FlutterFlowTheme.of(context).containerBG,
                  //                                                           ),
                  //                                                         ),
                  //                                                         child: Padding(
                  //                                                           padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
                  //                                                           child: Text(
                  //                                                             'Parcels must be securely packed to avoid damage during transit.',
                  //                                                             style: FlutterFlowTheme.of(context).bodyMedium.override(
                  //                                                                   font: GoogleFonts.inter(
                  //                                                                     fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                  //                                                                     fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  //                                                                   ),
                  //                                                                   color: Color(0xFF333333),
                  //                                                                   letterSpacing: 0.0,
                  //                                                                   fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                  //                                                                   fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  //                                                                 ),
                  //                                                           ),
                  //                                                         ),
                  //                                                       ),
                  //                                                       Container(
                  //                                                         decoration: BoxDecoration(
                  //                                                           color: FlutterFlowTheme.of(context).boxColour,
                  //                                                           borderRadius: BorderRadius.circular(20.0),
                  //                                                           border: Border.all(
                  //                                                             color: FlutterFlowTheme.of(context).containerBG,
                  //                                                           ),
                  //                                                         ),
                  //                                                         child: Padding(
                  //                                                           padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
                  //                                                           child: Text(
                  //                                                             'Fragile or high-value items should be declared beforehand.',
                  //                                                             style: FlutterFlowTheme.of(context).bodyMedium.override(
                  //                                                                   font: GoogleFonts.inter(
                  //                                                                     fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                  //                                                                     fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  //                                                                   ),
                  //                                                                   color: Color(0xFF333333),
                  //                                                                   letterSpacing: 0.0,
                  //                                                                   fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                  //                                                                   fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  //                                                                 ),
                  //                                                           ),
                  //                                                         ),
                  //                                                       ),
                  //                                                       Container(
                  //                                                         decoration: BoxDecoration(
                  //                                                           color: FlutterFlowTheme.of(context).boxColour,
                  //                                                           borderRadius: BorderRadius.circular(20.0),
                  //                                                           border: Border.all(
                  //                                                             color: FlutterFlowTheme.of(context).containerBG,
                  //                                                           ),
                  //                                                         ),
                  //                                                         child: Padding(
                  //                                                           padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
                  //                                                           child: Text(
                  //                                                             'We are not responsible for delays caused by incomplete or incorrect information.',
                  //                                                             style: FlutterFlowTheme.of(context).bodyMedium.override(
                  //                                                                   font: GoogleFonts.inter(
                  //                                                                     fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                  //                                                                     fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  //                                                                   ),
                  //                                                                   color: Color(0xFF333333),
                  //                                                                   letterSpacing: 0.0,
                  //                                                                   fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                  //                                                                   fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  //                                                                 ),
                  //                                                           ),
                  //                                                         ),
                  //                                                       ),
                  //                                                     ],
                  //                                                   ),
                  //                                                 ),
                  //                                               if (rideDetailsCustomerRidesNewRecord.isRideRulesAccepted == false)
                  //                                                 Padding(
                  //                                                   padding: EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 32.0),
                  //                                                   child: Wrap(
                  //                                                     spacing: 10.0,
                  //                                                     runSpacing: 10.0,
                  //                                                     alignment: WrapAlignment.start,
                  //                                                     crossAxisAlignment: WrapCrossAlignment.start,
                  //                                                     direction: Axis.horizontal,
                  //                                                     runAlignment: WrapAlignment.start,
                  //                                                     verticalDirection: VerticalDirection.down,
                  //                                                     clipBehavior: Clip.none,
                  //                                                     children: [
                  //                                                       Container(
                  //                                                         decoration: BoxDecoration(
                  //                                                           color: FlutterFlowTheme.of(context).boxColour,
                  //                                                           borderRadius: BorderRadius.circular(20.0),
                  //                                                           border: Border.all(
                  //                                                             color: FlutterFlowTheme.of(context).containerBG,
                  //                                                           ),
                  //                                                         ),
                  //                                                         child: Padding(
                  //                                                           padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
                  //                                                           child: InkWell(
                  //                                                             splashColor: Colors.transparent,
                  //                                                             focusColor: Colors.transparent,
                  //                                                             hoverColor: Colors.transparent,
                  //                                                             highlightColor: Colors.transparent,
                  //                                                             onTap: () async {
                  //                                                               safeSetState(() {});
                  //                                                             },
                  //                                                             child: Text(
                  //                                                               rideDetailsCustomerRidesNewRecord.rideRule1,
                  //                                                               style: FlutterFlowTheme.of(context).bodyMedium.override(
                  //                                                                     font: GoogleFonts.inter(
                  //                                                                       fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                  //                                                                       fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  //                                                                     ),
                  //                                                                     color: Color(0xFF333333),
                  //                                                                     letterSpacing: 0.0,
                  //                                                                     fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                  //                                                                     fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  //                                                                   ),
                  //                                                             ),
                  //                                                           ),
                  //                                                         ),
                  //                                                       ),
                  //                                                       Container(
                  //                                                         decoration: BoxDecoration(
                  //                                                           color: FlutterFlowTheme.of(context).boxColour,
                  //                                                           borderRadius: BorderRadius.circular(20.0),
                  //                                                           border: Border.all(
                  //                                                             color: FlutterFlowTheme.of(context).containerBG,
                  //                                                           ),
                  //                                                         ),
                  //                                                         child: Padding(
                  //                                                           padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
                  //                                                           child: Text(
                  //                                                             rideDetailsCustomerRidesNewRecord.rideRule2,
                  //                                                             style: FlutterFlowTheme.of(context).bodyMedium.override(
                  //                                                                   font: GoogleFonts.inter(
                  //                                                                     fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                  //                                                                     fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  //                                                                   ),
                  //                                                                   color: Color(0xFF333333),
                  //                                                                   letterSpacing: 0.0,
                  //                                                                   fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                  //                                                                   fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  //                                                                 ),
                  //                                                           ),
                  //                                                         ),
                  //                                                       ),
                  //                                                       Container(
                  //                                                         decoration: BoxDecoration(
                  //                                                           color: FlutterFlowTheme.of(context).boxColour,
                  //                                                           borderRadius: BorderRadius.circular(20.0),
                  //                                                           border: Border.all(
                  //                                                             color: FlutterFlowTheme.of(context).containerBG,
                  //                                                           ),
                  //                                                         ),
                  //                                                         child: Padding(
                  //                                                           padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
                  //                                                           child: Text(
                  //                                                             rideDetailsCustomerRidesNewRecord.rideRule3,
                  //                                                             style: FlutterFlowTheme.of(context).bodyMedium.override(
                  //                                                                   font: GoogleFonts.inter(
                  //                                                                     fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                  //                                                                     fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  //                                                                   ),
                  //                                                                   color: Color(0xFF333333),
                  //                                                                   letterSpacing: 0.0,
                  //                                                                   fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                  //                                                                   fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  //                                                                 ),
                  //                                                           ),
                  //                                                         ),
                  //                                                       ),
                  //                                                       Container(
                  //                                                         decoration: BoxDecoration(
                  //                                                           color: FlutterFlowTheme.of(context).boxColour,
                  //                                                           borderRadius: BorderRadius.circular(20.0),
                  //                                                           border: Border.all(
                  //                                                             color: FlutterFlowTheme.of(context).containerBG,
                  //                                                           ),
                  //                                                         ),
                  //                                                         child: Padding(
                  //                                                           padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
                  //                                                           child: Text(
                  //                                                             rideDetailsCustomerRidesNewRecord.rideRule4,
                  //                                                             style: FlutterFlowTheme.of(context).bodyMedium.override(
                  //                                                                   font: GoogleFonts.inter(
                  //                                                                     fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                  //                                                                     fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  //                                                                   ),
                  //                                                                   color: Color(0xFF333333),
                  //                                                                   letterSpacing: 0.0,
                  //                                                                   fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                  //                                                                   fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  //                                                                 ),
                  //                                                           ),
                  //                                                         ),
                  //                                                       ),
                  //                                                       Container(
                  //                                                         decoration: BoxDecoration(
                  //                                                           color: FlutterFlowTheme.of(context).boxColour,
                  //                                                           borderRadius: BorderRadius.circular(20.0),
                  //                                                           border: Border.all(
                  //                                                             color: FlutterFlowTheme.of(context).containerBG,
                  //                                                           ),
                  //                                                         ),
                  //                                                         child: Padding(
                  //                                                           padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
                  //                                                           child: Text(
                  //                                                             rideDetailsCustomerRidesNewRecord.rideRule5,
                  //                                                             style: FlutterFlowTheme.of(context).bodyMedium.override(
                  //                                                                   font: GoogleFonts.inter(
                  //                                                                     fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                  //                                                                     fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  //                                                                   ),
                  //                                                                   color: Color(0xFF333333),
                  //                                                                   letterSpacing: 0.0,
                  //                                                                   fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                  //                                                                   fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  //                                                                 ),
                  //                                                           ),
                  //                                                         ),
                  //                                                       ),
                  //                                                       Container(
                  //                                                         decoration: BoxDecoration(
                  //                                                           color: FlutterFlowTheme.of(context).boxColour,
                  //                                                           borderRadius: BorderRadius.circular(20.0),
                  //                                                           border: Border.all(
                  //                                                             color: FlutterFlowTheme.of(context).containerBG,
                  //                                                           ),
                  //                                                         ),
                  //                                                         child: Padding(
                  //                                                           padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
                  //                                                           child: Text(
                  //                                                             rideDetailsCustomerRidesNewRecord.rideRule6,
                  //                                                             style: FlutterFlowTheme.of(context).bodyMedium.override(
                  //                                                                   font: GoogleFonts.inter(
                  //                                                                     fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                  //                                                                     fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  //                                                                   ),
                  //                                                                   color: Color(0xFF333333),
                  //                                                                   letterSpacing: 0.0,
                  //                                                                   fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                  //                                                                   fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  //                                                                 ),
                  //                                                           ),
                  //                                                         ),
                  //                                                       ),
                  //                                                     ],
                  //                                                   ),
                  //                                                 ),
                  //                                               if ((rideDetailsCustomerRidesNewRecord.creatorID != currentUserReference) || (rideDetailsCustomerRidesNewRecord.bidCustomerID != currentUserReference))
                  //                                                 ClipRRect(
                  //                                                   borderRadius: BorderRadius.circular(16.0),
                  //                                                   child: Container(
                  //                                                     decoration: BoxDecoration(
                  //                                                       color: FlutterFlowTheme.of(context).containerBG,
                  //                                                       borderRadius: BorderRadius.circular(16.0),
                  //                                                       border: Border.all(
                  //                                                         color: FlutterFlowTheme.of(context).accent2,
                  //                                                       ),
                  //                                                     ),
                  //                                                     child: Padding(
                  //                                                       padding: EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 10.0),
                  //                                                       child: Row(
                  //                                                         mainAxisSize: MainAxisSize.max,
                  //                                                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //                                                         children: [
                  //                                                           FFButtonWidget(
                  //                                                             onPressed: () async {
                  //                                                               context.pushNamed(
                  //                                                                 SendParcelWidget.routeName,
                  //                                                                 queryParameters: {
                  //                                                                   'bookingKarnaHai': serializeParam(
                  //                                                                     rideDetailsCustomerRidesNewRecord.reference,
                  //                                                                     ParamType.DocumentReference,
                  //                                                                   ),
                  //                                                                 }.withoutNulls,
                  //                                                               );
                  //                                                             },
                  //                                                             text: 'Send Parcel',
                  //                                                             options: FFButtonOptions(
                  //                                                               width: 100.0,
                  //                                                               height: 50.0,
                  //                                                               padding: EdgeInsets.all(8.0),
                  //                                                               iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  //                                                               color: Color(0xFFF77F4A),
                  //                                                               textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                  //                                                                     font: GoogleFonts.interTight(
                  //                                                                       fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
                  //                                                                       fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                  //                                                                     ),
                  //                                                                     color: FlutterFlowTheme.of(context).primaryBackground,
                  //                                                                     letterSpacing: 0.0,
                  //                                                                     fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
                  //                                                                     fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                  //                                                                   ),
                  //                                                               elevation: 10.0,
                  //                                                               borderRadius: BorderRadius.circular(10.0),
                  //                                                             ),
                  //                                                           ),
                  //                                                           FFButtonWidget(
                  //                                                             onPressed: () async {
                  //                                                               context.pushNamed(
                  //                                                                 BookRideWidget.routeName,
                  //                                                                 queryParameters: {
                  //                                                                   'rideID': serializeParam(
                  //                                                                     rideDetailsCustomerRidesNewRecord.reference,
                  //                                                                     ParamType.DocumentReference,
                  //                                                                   ),
                  //                                                                 }.withoutNulls,
                  //                                                               );
                  //                                                             },
                  //                                                             text: 'Book Ride',
                  //                                                             options: FFButtonOptions(
                  //                                                               width: 100.0,
                  //                                                               height: 50.0,
                  //                                                               padding: EdgeInsets.all(8.0),
                  //                                                               iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  //                                                               color: Color(0xFF0099FF),
                  //                                                               textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                  //                                                                     font: GoogleFonts.interTight(
                  //                                                                       fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
                  //                                                                       fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                  //                                                                     ),
                  //                                                                     color: FlutterFlowTheme.of(context).primaryBackground,
                  //                                                                     letterSpacing: 0.0,
                  //                                                                     fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
                  //                                                                     fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                  //                                                                   ),
                  //                                                               elevation: 10.0,
                  //                                                               borderRadius: BorderRadius.circular(10.0),
                  //                                                             ),
                  //                                                           ),
                  //                                                           InkWell(
                  //                                                             splashColor: Colors.transparent,
                  //                                                             focusColor: Colors.transparent,
                  //                                                             hoverColor: Colors.transparent,
                  //                                                             highlightColor: Colors.transparent,
                  //                                                             onTap: () async {
                  //                                                               if (columnUsersRecord.chatConnected.contains(currentUserReference) == false) {
                  //                                                                 await ChatsRecord.collection.doc().set({
                  //                                                                   ...createChatsRecordData(
                  //                                                                     lastMessage: 'Hey, ',
                  //                                                                     lastMessageTime: getCurrentTimestamp,
                  //                                                                   ),
                  //                                                                   ...mapToFirestore(
                  //                                                                     {
                  //                                                                       'userIDs': functions.generateListOfUsers(currentUserReference!, columnUsersRecord.reference),
                  //                                                                       'userNames': functions.generateListOfNames(currentUserDisplayName, columnUsersRecord.displayName),
                  //                                                                     },
                  //                                                                   ),
                  //                                                                 });
                  // 
                  //                                                                 await columnUsersRecord.reference.update({
                  //                                                                   ...mapToFirestore(
                  //                                                                     {
                  //                                                                       'chatConnected': FieldValue.arrayUnion([currentUserReference]),
                  //                                                                     },
                  //                                                                   ),
                  //                                                                 });
                  //                                                               }
                  // 
                  //                                                               context.pushNamed(ChatUsersWidget.routeName);
                  //                                                             },
                  //                                                             child: Container(
                  //                                                               width: 50.0,
                  //                                                               height: 50.0,
                  //                                                               decoration: BoxDecoration(
                  //                                                                 color: FlutterFlowTheme.of(context).primaryBackground,
                  //                                                                 borderRadius: BorderRadius.circular(10.0),
                  //                                                                 border: Border.all(
                  //                                                                   color: FlutterFlowTheme.of(context).alternate,
                  //                                                                   width: 1.0,
                  //                                                                 ),
                  //                                                               ),
                  //                                                               child: Center(
                  //                                                                 child: Icon(
                  //                                                                   Icons.chat_bubble_outline,
                  //                                                                   color: FlutterFlowTheme.of(context).primaryText,
                  //                                                                   size: 24.0,
                  //                                                                 ),
                  //                                                               ),
                  //                                                             ),
                  //                                                           ),
                  //                                                           InkWell(
                  //                                                             splashColor: Colors.transparent,
                  //                                                             focusColor: Colors.transparent,
                  //                                                             hoverColor: Colors.transparent,
                  //                                                             highlightColor: Colors.transparent,
                  //                                                             onTap: () async {
                  //                                                               if (rideDetailsCustomerRidesNewRecord.rideSavedByUser != currentUserReference) {
                  //                                                                 await rideDetailsCustomerRidesNewRecord.reference.update(createRidesNewRecordData(
                  //                                                                   rideSavedByUser: currentUserReference,
                  //                                                                 ));
                  //                                                                 // Issue 4: Tell user where saved ride goes
                  //                                                                 if (context.mounted) {
                  //                                                                   ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  //                                                                   ScaffoldMessenger.of(context).showSnackBar(
                  //                                                                     SnackBar(
                  //                                                                       content: const Text(
                  //                                                                         'Ride saved! Tap View to see your saved rides.',
                  //                                                                         style: TextStyle(color: Colors.white),
                  //                                                                       ),
                  //                                                                       backgroundColor: const Color(0xFFF77F4A),
                  //                                                                       duration: const Duration(seconds: 4),
                  //                                                                       action: SnackBarAction(
                  //                                                                         label: 'View',
                  //                                                                         textColor: Colors.white,
                  //                                                                         onPressed: () {
                  //                                                                           context.pushNamed(SavedRidesWidget.routeName);
                  //                                                                         },
                  //                                                                       ),
                  //                                                                     ),
                  //                                                                   );
                  //                                                                 }
                  //                                                               } else {
                  //                                                                 await rideDetailsCustomerRidesNewRecord.reference.update(createRidesNewRecordData(
                  //                                                                   rideSavedByUser: columnUsersRecord.reference,
                  //                                                                 ));
                  //                                                                 // Unsaved feedback
                  //                                                                 if (context.mounted) {
                  //                                                                   ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  //                                                                   ScaffoldMessenger.of(context).showSnackBar(
                  //                                                                     const SnackBar(
                  //                                                                       content: Text('Ride removed from saved rides.'),
                  //                                                                       duration: Duration(seconds: 2),
                  //                                                                     ),
                  //                                                                   );
                  //                                                                 }
                  //                                                               }
                  //                                                             },
                  //                                                             child: Container(
                  //                                                               width: 50.0,
                  //                                                               height: 50.0,
                  //                                                               decoration: BoxDecoration(
                  //                                                                 color: FlutterFlowTheme.of(context).primaryBackground,
                  //                                                                 borderRadius: BorderRadius.circular(10.0),
                  //                                                                 border: Border.all(
                  //                                                                   color: FlutterFlowTheme.of(context).alternate,
                  //                                                                   width: 1.0,
                  //                                                                 ),
                  //                                                               ),
                  //                                                               child: Center(
                  //                                                                 child: Icon(
                  //                                                                   rideDetailsCustomerRidesNewRecord.rideSavedByUser == currentUserReference
                  //                                                                       ? Icons.bookmark
                  //                                                                       : Icons.bookmark_border,
                  //                                                                   color: rideDetailsCustomerRidesNewRecord.rideSavedByUser == currentUserReference
                  //                                                                       ? Color(0xFFF77F4A)
                  //                                                                       : Color(0xFFB5B5B5),
                  //                                                                   size: 24.0,
                  //                                                                 ),
                  //                                                               ),
                  //                                                             ),
                  //                                                           ),
                  //                                                         ].divide(SizedBox(width: 12.0)),
                  //                                                       ),
                  //                                                     ),
                  //                                                   ),
                  //                                                 ),
                  //                                             ].divide(SizedBox(height: 5.0)),
                  //                                           ),
                  //                                         ].divide(SizedBox(height: 10.0)),
                  //                                       ),
                  //                                     ),
                  //                                   ),
                  //                                 ].divide(SizedBox(height: 10.0)).addToEnd(SizedBox(height: 20.0)),
                  //                               ),
                  //                             ),
                  //                           ],
                  //                         ),
                  //                       ),
                  //                       wrapWithModel(
                  //                         model: _model.mainFooterModel,
                  //                         updateCallback: () => safeSetState(() {}),
                  //                         child: MainFooterWidget(),
                  //                       ),
                  //                     ],
                  //                   )
                  // 
                  // 
                  //                       .animateOnPageLoad(animationsMap['columnOnPageLoadAnimation']!);
                  // ======================================================================

                  // NEW REDESIGNED UI WITH REVERTED LOCATION CARD
                  return Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // 1. DRIVER PROFILE CARD
                              _buildDriverCard(context, columnUsersRecord, rideDetailsCustomerRidesNewRecord),

                              const SizedBox(height: 16.0),

                              // 2. REVERTED CLEAN LOCATION CARD
                              _buildRouteCard(context, rideDetailsCustomerRidesNewRecord),

                              const SizedBox(height: 16.0),

                              // 3. SEATS / BAGS / STOPS STATS
                              _buildStatsRow(context, rideDetailsCustomerRidesNewRecord),

                              const SizedBox(height: 16.0),

                              // 4. FARE CARDS (RIDE FARE & PARCEL FARE)
                              _buildFareCards(context, rideDetailsCustomerRidesNewRecord),

                              const SizedBox(height: 16.0),

                              // 5. FEATURE HIGHLIGHTS / BADGES
                              _buildFeatureBadges(context, columnUsersRecord),

                              const SizedBox(height: 20.0),

                              // 6. WHAT PARCEL YOU CAN SEND?
                              _buildParcelCategories(context, rideDetailsCustomerRidesNewRecord),

                              const SizedBox(height: 20.0),

                              // 7. RIDE RULES (Preserving dynamic rules)
                              _buildRideRules(context, rideDetailsCustomerRidesNewRecord),

                              const SizedBox(height: 20.0),

                              // 8. ACTION BUTTONS (Book Ride & Send Parcel)
                              if ((rideDetailsCustomerRidesNewRecord.creatorID != currentUserReference) || (rideDetailsCustomerRidesNewRecord.bidCustomerID != currentUserReference))
                                _buildBottomActionButtons(context, columnUsersRecord, rideDetailsCustomerRidesNewRecord),
                            ],
                          ),
                        ),
                      ),

                      // FOOTER (Bottom Navigation)
                      wrapWithModel(
                        model: _model.mainFooterModel,
                        updateCallback: () => safeSetState(() {}),
                        child: MainFooterWidget(),
                      ),
                    ],
                  ).animateOnPageLoad(animationsMap['columnOnPageLoadAnimation']!);
                },
              ),
            ),
          ),
        );
      },
    );
  }
  // =========================================================================
  // HELPER BUILDERS FOR THE REDESIGNED RIDE DETAILS UI (100% DYNAMIC DATA)
  // =========================================================================

  // =========================================================================
  // HELPER BUILDERS FOR THE REDESIGNED RIDE DETAILS UI (WITH TERTIARY COLOR)
  // =========================================================================

  Widget _buildDriverCard(
    BuildContext context,
    UsersRecord columnUsersRecord,
    RidesNewRecord rideRecord,
  ) {
    final tertiaryColor = FlutterFlowTheme.of(context).tertiary;

    final avgRating = functions.averageRating(columnUsersRecord.ratings.toList());
    final hasRating = avgRating != null && avgRating > 0;
    final ratingStr = hasRating ? avgRating.toStringAsFixed(1) : 'New';
    final reviewsCount = columnUsersRecord.ratings.length;

    final driverName = columnUsersRecord.displayName.isNotEmpty
        ? columnUsersRecord.displayName
        : 'Driver';

    final isVerified = columnUsersRecord.isVerifed || columnUsersRecord.isProfileCompleted;

    final carName = rideRecord.modeOfTransport;
    final vehicleNo = rideRecord.vehicleNumber;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
        border: Border.all(color: const Color(0xFFF3F4F6)),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // 1. TOP PROFILE HEADER
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar
              InkWell(
                onTap: () {
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
                  width: 60.0,
                  height: 60.0,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFF3F4F6),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30.0),
                    child: columnUsersRecord.photoUrl.isNotEmpty
                        ? Image.network(
                            columnUsersRecord.photoUrl,
                            width: 60.0,
                            height: 60.0,
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            'assets/images/userIconTr.png',
                            width: 60.0,
                            height: 60.0,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
              ),
              const SizedBox(width: 12.0),

              // Info Column
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
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
                        driverName,
                        style: GoogleFonts.inter(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF111827),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 3.0),

                    // Verified Driver Row
                    Row(
                      children: [
                        Icon(
                          isVerified ? Icons.verified_user_rounded : Icons.person_outline_rounded,
                          color: isVerified ? const Color(0xFF10B981) : const Color(0xFF6B7280),
                          size: 14.0,
                        ),
                        const SizedBox(width: 4.0),
                        Text(
                          isVerified ? 'Verified Driver' : 'Driver',
                          style: GoogleFonts.inter(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w600,
                            color: isVerified ? const Color(0xFF10B981) : const Color(0xFF6B7280),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 3.0),

                    // Rating & Reviews Line
                    Row(
                      children: [
                        const Icon(
                          Icons.star_rounded,
                          color: Color(0xFFF59E0B),
                          size: 14.0,
                        ),
                        const SizedBox(width: 3.0),
                        Flexible(
                          child: Text(
                            reviewsCount > 0 ? '$ratingStr ($reviewsCount reviews)' : '$ratingStr Rating',
                            style: GoogleFonts.inter(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF6B7280),
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
              const SizedBox(width: 6.0),

              if (isVerified)
                Container(
                  width: 24.0,
                  height: 24.0,
                  decoration: const BoxDecoration(
                    color: Color(0xFF10B981),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check_rounded,
                    color: Colors.white,
                    size: 16.0,
                  ),
                ),
            ],
          ),

          if (carName.isNotEmpty || vehicleNo.isNotEmpty) ...[
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12.0),
              child: Divider(height: 1, color: Color(0xFFF3F4F6)),
            ),

            // 2. BOTTOM ROW (Car Details & Action Buttons side-by-side)
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Car Icon & Info Column
                const Icon(
                  Icons.directions_car_outlined,
                  color: Color(0xFF6B7280),
                  size: 20.0,
                ),
                const SizedBox(width: 6.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (carName.isNotEmpty)
                        Text(
                          carName,
                          style: GoogleFonts.inter(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF374151),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      if (vehicleNo.isNotEmpty)
                        Text(
                          vehicleNo,
                          style: GoogleFonts.inter(
                            fontSize: 11.0,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF6B7280),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                    ],
                  ),
                ),
                const SizedBox(width: 8.0),

                // Action Buttons Row (Bookmark, Call, Chat)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Bookmark
                    InkWell(
                      onTap: () async {
                        if (rideRecord.rideSavedByUser != currentUserReference) {
                          await rideRecord.reference.update(createRidesNewRecordData(
                            rideSavedByUser: currentUserReference,
                          ));
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Text(
                                  'Ride saved!',
                                  style: TextStyle(color: Colors.white),
                                ),
                                backgroundColor: tertiaryColor,
                                duration: const Duration(seconds: 3),
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
                          await rideRecord.reference.update(createRidesNewRecordData(
                            rideSavedByUser: columnUsersRecord.reference,
                          ));
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
                        width: 38.0,
                        height: 38.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(
                            color: rideRecord.rideSavedByUser == currentUserReference
                                ? tertiaryColor
                                : const Color(0xFFE5E7EB),
                          ),
                        ),
                        child: Icon(
                          rideRecord.rideSavedByUser == currentUserReference
                              ? Icons.bookmark_rounded
                              : Icons.bookmark_border_rounded,
                          color: tertiaryColor,
                          size: 18.0,
                        ),
                      ),
                    ),
                    const SizedBox(width: 6.0),

                    // Call Button
                    InkWell(
                      onTap: () async {
                        final phone = columnUsersRecord.phoneNumber.isNotEmpty
                            ? columnUsersRecord.phoneNumber
                            : rideRecord.driverNumber;
                        if (phone.isNotEmpty) {
                          final Uri callUri = Uri(scheme: 'tel', path: phone);
                          if (await canLaunchUrl(callUri)) {
                            await launchUrl(callUri);
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Driver phone number not available')),
                          );
                        }
                      },
                      child: Container(
                        height: 38.0,
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(color: const Color(0xFFE5E7EB)),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.call_outlined,
                              color: Color(0xFF2563EB),
                              size: 16.0,
                            ),
                            const SizedBox(width: 4.0),
                            Text(
                              'Call',
                              style: GoogleFonts.inter(
                                fontSize: 13.0,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF2563EB),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 6.0),

                    // Chat Button
                    InkWell(
                      onTap: () async {
                        if (columnUsersRecord.chatConnected.contains(currentUserReference) == false) {
                          await ChatsRecord.collection.doc().set({
                            ...createChatsRecordData(
                              lastMessage: 'Hey, ',
                              lastMessageTime: getCurrentTimestamp,
                            ),
                            ...mapToFirestore({
                              'userIDs': functions.generateListOfUsers(currentUserReference!, columnUsersRecord.reference),
                              'userNames': functions.generateListOfNames(currentUserDisplayName, columnUsersRecord.displayName),
                            }),
                          });

                          await columnUsersRecord.reference.update({
                            ...mapToFirestore({
                              'chatConnected': FieldValue.arrayUnion([currentUserReference]),
                            }),
                          });
                        }
                        context.pushNamed(ChatUsersWidget.routeName);
                      },
                      child: Container(
                        height: 38.0,
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(color: const Color(0xFFE5E7EB)),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.chat_bubble_outline_rounded,
                              color: Color(0xFF2563EB),
                              size: 16.0,
                            ),
                            const SizedBox(width: 4.0),
                            Text(
                              'Chat',
                              style: GoogleFonts.inter(
                                fontSize: 13.0,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF2563EB),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  // CAROUSEL ROUTE & MAP CARD (SWIPE BETWEEN LOCATION DETAILS & MAP WITH ROUTE PATH)
  Widget _buildRouteCard(
    BuildContext context,
    RidesNewRecord rideRecord,
  ) {
    PageController? localController;
    int localIndex = 0;

    return StatefulBuilder(
      builder: (context, setCardState) {
        localController ??= PageController();

        return Column(
          children: [
            SizedBox(
              height: 160.0,
              child: PageView(
                controller: localController,
                onPageChanged: (index) {
                  setCardState(() {
                    localIndex = index;
                  });
                },
                children: [
                  // Slide 1: Location Details
                  _buildLocationDetailsSlide(context, rideRecord),

                  // Slide 2: Interactive Map Route Preview with Polyline Path
                  _buildMapRouteSlide(context, rideRecord),
                ],
              ),
            ),
            const SizedBox(height: 8.0),

            // Carousel Page Indicator Dots
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  width: localIndex == 0 ? 20.0 : 7.0,
                  height: 7.0,
                  decoration: BoxDecoration(
                    color: localIndex == 0 ? const Color(0xFF2563EB) : const Color(0xFFCBD5E1),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                ),
                const SizedBox(width: 6.0),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  width: localIndex == 1 ? 20.0 : 7.0,
                  height: 7.0,
                  decoration: BoxDecoration(
                    color: localIndex == 1 ? const Color(0xFF2563EB) : const Color(0xFFCBD5E1),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildLocationDetailsSlide(
    BuildContext context,
    RidesNewRecord rideRecord,
  ) {
    final tertiaryColor = FlutterFlowTheme.of(context).tertiary;

    final startAddr = rideRecord.googleStartAddress.isNotEmpty
        ? rideRecord.googleStartAddress
        : rideRecord.rideStartLocation;

    final endAddr = rideRecord.googleEndAddress.isNotEmpty
        ? rideRecord.googleEndAddress
        : rideRecord.rideEndLocation;

    final pickTimeStr = rideRecord.pickupTime != null
        ? dateTimeFormat("hh:mm a", rideRecord.pickupTime)
        : '';

    final dropTimeStr = rideRecord.dropTime != null
        ? dateTimeFormat("hh:mm a", rideRecord.dropTime)
        : '';

    final travelTimeStr = rideRecord.travelTime;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
        border: Border.all(color: const Color(0xFFF3F4F6)),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Pickup Location Row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.location_on_outlined,
                color: Color(0xFF2563EB),
                size: 24.0,
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      startAddr.isNotEmpty ? startAddr : 'Pickup Location',
                      style: GoogleFonts.inter(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0F172A),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (pickTimeStr.isNotEmpty) ...[
                      const SizedBox(height: 2.0),
                      Text(
                        'Departure: ${pickTimeStr.toLowerCase()}',
                        style: GoogleFonts.inter(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),

          // Travel Time Row
          if (travelTimeStr.isNotEmpty)
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Travel time: ',
                      style: GoogleFonts.inter(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                    Text(
                      travelTimeStr,
                      style: GoogleFonts.inter(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                  ],
                ),
              ),
            ),

          // Dropoff Location Row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.location_on_outlined,
                color: tertiaryColor,
                size: 24.0,
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      endAddr.isNotEmpty ? endAddr : 'Dropoff Location',
                      style: GoogleFonts.inter(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0F172A),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (dropTimeStr.isNotEmpty) ...[
                      const SizedBox(height: 2.0),
                      Text(
                        'Arrival: ${dropTimeStr.toLowerCase()}',
                        style: GoogleFonts.inter(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMapRouteSlide(
    BuildContext context,
    RidesNewRecord rideRecord,
  ) {
    final startLatLng = rideRecord.rideStartLocationGoogle ?? const LatLng(27.8974, 78.0880);
    final endLatLng = rideRecord.rideEndLocationGoogle ?? const LatLng(30.3165, 78.0322);

    final midLat = (startLatLng.latitude + endLatLng.latitude) / 2;
    final midLng = (startLatLng.longitude + endLatLng.longitude) / 2;

    final polylines = <google_maps.Polyline>{
      google_maps.Polyline(
        polylineId: const google_maps.PolylineId('route_line_path'),
        points: [
          google_maps.LatLng(startLatLng.latitude, startLatLng.longitude),
          google_maps.LatLng(midLat + 0.15, midLng - 0.12),
          google_maps.LatLng(endLatLng.latitude, endLatLng.longitude),
        ],
        color: const Color(0xFF2563EB),
        width: 5,
        geodesic: true,
      ),
    };

    final markers = [
      FlutterFlowMarker('start_marker', startLatLng),
      FlutterFlowMarker('end_marker', endLatLng),
    ];

    return InkWell(
      onTap: () => _showFullRouteMapDialog(context, rideRecord),
      borderRadius: BorderRadius.circular(16.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
          border: Border.all(color: const Color(0xFFF3F4F6)),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: Stack(
            children: [
              FlutterFlowGoogleMap(
                controller: _model.googleMapsController,
                onCameraIdle: (latLng) => _model.googleMapsCenter = latLng,
                initialLocation: _model.googleMapsCenter ??= startLatLng,
                markers: markers,
                polylines: polylines,
                markerColor: GoogleMarkerColor.violet,
                mapType: MapType.normal,
                style: GoogleMapStyle.standard,
                initialZoom: 10.0,
                allowInteraction: true,
                allowZoom: true,
                showZoomControls: false,
                showLocation: true,
                showCompass: false,
                showMapToolbar: false,
                showTraffic: false,
                centerMapOnMarkerTap: true,
              ),

              // Tap hint pill overlay
              Positioned(
                bottom: 8.0,
                right: 8.0,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.7),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.fullscreen_rounded,
                        color: Colors.white,
                        size: 14.0,
                      ),
                      const SizedBox(width: 4.0),
                      Text(
                        'Tap for Route Controls',
                        style: GoogleFonts.inter(
                          fontSize: 10.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
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
    );
  }

  // INTERACTIVE ROUTE MAP DIALOG WITH CONTROLS & DISTANCE DETAILS
  void _showFullRouteMapDialog(
    BuildContext context,
    RidesNewRecord rideRecord,
  ) {
    final startLatLng = rideRecord.rideStartLocationGoogle ?? const LatLng(27.8974, 78.0880);
    final endLatLng = rideRecord.rideEndLocationGoogle ?? const LatLng(30.3165, 78.0322);

    final startAddr = rideRecord.googleStartAddress.isNotEmpty
        ? rideRecord.googleStartAddress
        : rideRecord.rideStartLocation;
    final endAddr = rideRecord.googleEndAddress.isNotEmpty
        ? rideRecord.googleEndAddress
        : rideRecord.rideEndLocation;

    final travelTimeStr = rideRecord.travelTime;

    final midLat = (startLatLng.latitude + endLatLng.latitude) / 2;
    final midLng = (startLatLng.longitude + endLatLng.longitude) / 2;

    final polylines = <google_maps.Polyline>{
      google_maps.Polyline(
        polylineId: const google_maps.PolylineId('dialog_route_line'),
        points: [
          google_maps.LatLng(startLatLng.latitude, startLatLng.longitude),
          google_maps.LatLng(midLat + 0.15, midLng - 0.12),
          google_maps.LatLng(endLatLng.latitude, endLatLng.longitude),
        ],
        color: const Color(0xFF2563EB),
        width: 6,
        geodesic: true,
      ),
    };

    final markers = [
      FlutterFlowMarker('dialog_start_marker', startLatLng),
      FlutterFlowMarker('dialog_end_marker', endLatLng),
    ];

    final dialogMapController = Completer<GoogleMapController>();

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 40.0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
          clipBehavior: Clip.antiAlias,
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.75,
            color: Colors.white,
            child: Stack(
              children: [
                // 1. FULL INTERACTIVE MAP
                FlutterFlowGoogleMap(
                  controller: dialogMapController,
                  initialLocation: startLatLng,
                  markers: markers,
                  polylines: polylines,
                  markerColor: GoogleMarkerColor.violet,
                  mapType: MapType.normal,
                  style: GoogleMapStyle.standard,
                  initialZoom: 10.0,
                  allowInteraction: true,
                  allowZoom: true,
                  showZoomControls: true,
                  showLocation: true,
                  showCompass: true,
                  showMapToolbar: true,
                  showTraffic: false,
                  centerMapOnMarkerTap: true,
                ),

                // 2. TOP HEADER OVERLAY BAR
                Positioned(
                  top: 12.0,
                  left: 12.0,
                  right: 12.0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.95),
                      borderRadius: BorderRadius.circular(16.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Route Details & Distance',
                              style: GoogleFonts.inter(
                                fontSize: 15.0,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF0F172A),
                              ),
                            ),
                            Text(
                              'Interactive map with zoom & controls',
                              style: GoogleFonts.inter(
                                fontSize: 11.0,
                                color: const Color(0xFF64748B),
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.close_rounded, color: Color(0xFF0F172A)),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                      ],
                    ),
                  ),
                ),

                // 3. BOTTOM FLOATING DISTANCE & CONTROLS BOX
                Positioned(
                  bottom: 12.0,
                  left: 12.0,
                  right: 12.0,
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.12),
                          blurRadius: 16,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Distance & Duration Pill Row
                        if (travelTimeStr.isNotEmpty)
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8.0),
                                decoration: const BoxDecoration(
                                  color: Color(0xFFEFF6FF),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.route_rounded,
                                  color: Color(0xFF2563EB),
                                  size: 20.0,
                                ),
                              ),
                              const SizedBox(width: 12.0),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Distance & Duration',
                                      style: GoogleFonts.inter(
                                        fontSize: 11.0,
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xFF64748B),
                                      ),
                                    ),
                                    Text(
                                      travelTimeStr,
                                      style: GoogleFonts.inter(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w700,
                                        color: const Color(0xFF0F172A),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.0),
                          child: Divider(height: 1, color: Color(0xFFF1F5F9)),
                        ),

                        // Start & Destination summary lines
                        if (startAddr.isNotEmpty)
                          Row(
                            children: [
                              const Icon(Icons.circle, color: Color(0xFF2563EB), size: 10.0),
                              const SizedBox(width: 8.0),
                              Expanded(
                                child: Text(
                                  startAddr,
                                  style: GoogleFonts.inter(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF334155),
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        if (endAddr.isNotEmpty) ...[
                          const SizedBox(height: 6.0),
                          Row(
                            children: [
                              const Icon(Icons.location_on_rounded, color: Color(0xFFEF4444), size: 14.0),
                              const SizedBox(width: 6.0),
                              Expanded(
                                child: Text(
                                  endAddr,
                                  style: GoogleFonts.inter(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF334155),
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],

                        const SizedBox(height: 14.0),

                        // Open in External Google Maps Button
                        SizedBox(
                          width: double.infinity,
                          height: 44.0,
                          child: ElevatedButton.icon(
                            onPressed: () async {
                              final url = 'https://www.google.com/maps/dir/?api=1&destination=${endLatLng.latitude},${endLatLng.longitude}';
                              final uri = Uri.parse(url);
                              if (await canLaunchUrl(uri)) {
                                await launchUrl(uri, mode: LaunchMode.externalApplication);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF2563EB),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              elevation: 0,
                            ),
                            icon: const Icon(Icons.navigation_rounded, color: Colors.white, size: 18.0),
                            label: Text(
                              'Open in Google Maps',
                              style: GoogleFonts.inter(
                                fontSize: 13.0,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // 100% DYNAMIC STATS ROW (SEATS, BAGS, STOPS FROM FIRESTORE RECORD)
  Widget _buildStatsRow(
    BuildContext context,
    RidesNewRecord rideRecord,
  ) {
    final seats = rideRecord.numPassengers;
    final bags = rideRecord.numBagAllowed;
    final stops = rideRecord.stoppages.length;

    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            icon: Icons.groups_outlined,
            label: 'Seats Available',
            value: '$seats',
          ),
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: _buildStatCard(
            icon: Icons.shopping_bag_outlined,
            label: 'Bags Allowed',
            value: '$bags',
          ),
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: _buildStatCard(
            icon: Icons.alt_route_rounded,
            label: 'Stops',
            value: '$stops',
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: const Color(0xFFF1F5F9)),
      ),
      padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 8.0),
      child: Column(
        children: [
          Container(
            width: 42.0,
            height: 42.0,
            decoration: const BoxDecoration(
              color: Color(0xFFEFF6FF),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: const Color(0xFF2563EB),
              size: 22.0,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 11.0,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF64748B),
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4.0),
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 20.0,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF0F172A),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFareCards(
    BuildContext context,
    RidesNewRecord rideRecord,
  ) {
    final ridePrice = rideRecord.pricePerPassengers > 0
        ? formatNumber(rideRecord.pricePerPassengers, formatType: FormatType.custom, format: '', locale: '')
        : '0';

    final parcelPrice = rideRecord.totalDeliveryCost.isNotEmpty
        ? rideRecord.totalDeliveryCost
        : '0';

    return Row(
      children: [
        // 1. Ride Fare (Light Blue)
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFFEFF6FF),
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(color: const Color(0xFFDBEAFE)),
            ),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  'Ride Fare',
                  style: GoogleFonts.inter(
                    fontSize: 13.0,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF1E40AF),
                  ),
                ),
                const SizedBox(height: 6.0),
                Text(
                  '₹$ridePrice',
                  style: GoogleFonts.inter(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF1E3A8A),
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  'Per Passenger',
                  style: GoogleFonts.inter(
                    fontSize: 11.0,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12.0),

        // 2. Parcel Fare (Light Green)
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFFF0FDF4),
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(color: const Color(0xFFDCFCE7)),
            ),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  'Parcel Fare',
                  style: GoogleFonts.inter(
                    fontSize: 13.0,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF166534),
                  ),
                ),
                const SizedBox(height: 6.0),
                Text(
                  '₹$parcelPrice',
                  style: GoogleFonts.inter(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF14532D),
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  'Per Parcel (Approx.)',
                  style: GoogleFonts.inter(
                    fontSize: 11.0,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFeatureBadges(
    BuildContext context,
    UsersRecord columnUsersRecord,
  ) {
    final avgRating = functions.averageRating(columnUsersRecord.ratings.toList());
    final ratingStr = (avgRating != null && avgRating > 0) ? avgRating.toStringAsFixed(1) : '5.0';

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildFeatureItem(
          icon: Icons.verified_user_outlined,
          iconColor: const Color(0xFF10B981),
          bgColor: const Color(0xFFECFDF5),
          label: 'Aadhaar\nVerified',
        ),
        _buildFeatureItem(
          icon: Icons.location_on_outlined,
          iconColor: const Color(0xFF2563EB),
          bgColor: const Color(0xFFEFF6FF),
          label: 'Live\nTracking',
        ),
        _buildFeatureItem(
          icon: Icons.lock_outline_rounded,
          iconColor: const Color(0xFF8B5CF6),
          bgColor: const Color(0xFFF5F3FF),
          label: 'OTP\nDelivery',
        ),
        _buildFeatureItem(
          icon: Icons.star_rounded,
          iconColor: const Color(0xFFF59E0B),
          bgColor: const Color(0xFFFFFBEB),
          label: '$ratingStr Driver\nRating',
        ),
      ],
    );
  }

  Widget _buildFeatureItem({
    required IconData icon,
    required Color iconColor,
    required Color bgColor,
    required String label,
  }) {
    return Column(
      children: [
        Container(
          width: 48.0,
          height: 48.0,
          decoration: BoxDecoration(
            color: bgColor,
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: iconColor,
            size: 24.0,
          ),
        ),
        const SizedBox(height: 6.0),
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 11.0,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF334155),
            height: 1.2,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  // DYNAMIC PARCEL CATEGORIES FROM FIRESTORE RECORD
  Widget _buildParcelCategories(
    BuildContext context,
    RidesNewRecord rideRecord,
  ) {
    final dynamicItems = rideRecord.caryyItems.isNotEmpty
        ? rideRecord.caryyItems
        : ['Documents', 'Electronics', 'Clothing', 'Sweets'];

    final displayItems = dynamicItems.take(4).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'What parcel you can send?',
              style: GoogleFonts.inter(
                fontSize: 15.0,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF0F172A),
              ),
            ),
            TextButton(
              onPressed: () => _showParcelItemsBottomSheet(context, rideRecord),
              style: TextButton.styleFrom(padding: EdgeInsets.zero),
              child: Text(
                'See all',
                style: GoogleFonts.inter(
                  fontSize: 13.0,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF2563EB),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ...displayItems.map((item) {
              final style = _getIconForItem(item);
              return _buildParcelCategoryItem(
                icon: style.icon,
                iconColor: style.color,
                bgColor: style.bgColor,
                label: item,
                onTap: () => _showParcelItemsBottomSheet(context, rideRecord),
              );
            }),
            _buildParcelCategoryItem(
              icon: Icons.more_horiz_rounded,
              iconColor: const Color(0xFF64748B),
              bgColor: const Color(0xFFF1F5F9),
              label: 'More',
              onTap: () => _showParcelItemsBottomSheet(context, rideRecord),
            ),
          ],
        ),
      ],
    );
  }

  ({IconData icon, Color color, Color bgColor}) _getIconForItem(String item) {
    final lower = item.toLowerCase();
    if (lower.contains('doc') || lower.contains('paper') || lower.contains('file')) {
      return (icon: Icons.article_outlined, color: const Color(0xFF2563EB), bgColor: const Color(0xFFEFF6FF));
    } else if (lower.contains('electr') || lower.contains('gadget') || lower.contains('phone')) {
      return (icon: Icons.inventory_2_outlined, color: const Color(0xFFD97706), bgColor: const Color(0xFFFEF3C7));
    } else if (lower.contains('cloth') || lower.contains('wear') || lower.contains('apparel')) {
      return (icon: Icons.checkroom_outlined, color: const Color(0xFF7C3AED), bgColor: const Color(0xFFF3E8FF));
    } else if (lower.contains('sweet') || lower.contains('gift') || lower.contains('food')) {
      return (icon: Icons.card_giftcard_outlined, color: const Color(0xFFEF4444), bgColor: const Color(0xFFFEE2E2));
    } else if (lower.contains('med') || lower.contains('health') || lower.contains('pharma')) {
      return (icon: Icons.medical_services_outlined, color: const Color(0xFF10B981), bgColor: const Color(0xFFECFDF5));
    }
    return (icon: Icons.inventory_2_outlined, color: const Color(0xFF0284C7), bgColor: const Color(0xFFE0F2FE));
  }

  Widget _buildParcelCategoryItem({
    required IconData icon,
    required Color iconColor,
    required Color bgColor,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.0),
      child: Column(
        children: [
          Container(
            width: 52.0,
            height: 52.0,
            decoration: BoxDecoration(
              color: bgColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 24.0,
            ),
          ),
          const SizedBox(height: 6.0),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 11.0,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF475569),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  // DYNAMIC PARCEL ITEMS BOTTOM SHEET WHEN CLICKING 'SEE ALL' OR 'MORE'
  void _showParcelItemsBottomSheet(
    BuildContext context,
    RidesNewRecord rideRecord,
  ) {
    final items = rideRecord.caryyItems.isNotEmpty
        ? rideRecord.caryyItems
        : ['Documents & Papers', 'Electronics & Gadgets', 'Clothing & Apparel', 'Gifts & Sweets', 'Books & Stationery', 'Medicines & Health Products', 'Household & Personal Items'];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24.0)),
          ),
          padding: const EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 32.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Handle bar
              Center(
                child: Container(
                  width: 40.0,
                  height: 4.0,
                  decoration: BoxDecoration(
                    color: const Color(0xFFCBD5E1),
                    borderRadius: BorderRadius.circular(2.0),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),

              // Header Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Allowed Parcel Items',
                    style: GoogleFonts.inter(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close_rounded, color: Color(0xFF64748B)),
                  ),
                ],
              ),
              const SizedBox(height: 4.0),
              Text(
                'Driver accepts the following item categories for parcel delivery on this ride:',
                style: GoogleFonts.inter(
                  fontSize: 13.0,
                  color: const Color(0xFF64748B),
                ),
              ),
              const SizedBox(height: 20.0),

              // Dynamic Items List
              Wrap(
                spacing: 10.0,
                runSpacing: 10.0,
                children: items.map((item) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.check_circle_rounded,
                          color: Color(0xFF10B981),
                          size: 18.0,
                        ),
                        const SizedBox(width: 8.0),
                        Text(
                          item,
                          style: GoogleFonts.inter(
                            fontSize: 13.0,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF1E293B),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildRideRules(
    BuildContext context,
    RidesNewRecord rideRecord,
  ) {
    final rules = rideRecord.isRideRulesAccepted
        ? [
            'We accept only legal parcels—no prohibited or illegal items allowed.',
            'Customers must arrive with the parcel at least 10 minutes before the vehicle arrives.',
            'Complete receiver information is required at the time of booking.',
            'Unacceptable items found during the ride may lead to cancellation or being reported.',
            'Parcels must be securely packed to avoid damage during transit.',
            'Fragile or high-value items should be declared beforehand.',
            'We are not responsible for delays caused by incomplete or incorrect information.',
          ]
        : [
            if (rideRecord.rideRule1.isNotEmpty) rideRecord.rideRule1,
            if (rideRecord.rideRule2.isNotEmpty) rideRecord.rideRule2,
            if (rideRecord.rideRule3.isNotEmpty) rideRecord.rideRule3,
            if (rideRecord.rideRule4.isNotEmpty) rideRecord.rideRule4,
            if (rideRecord.rideRule5.isNotEmpty) rideRecord.rideRule5,
            if (rideRecord.rideRule6.isNotEmpty) rideRecord.rideRule6,
          ];

    if (rules.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ride Rules',
          style: GoogleFonts.inter(
            fontSize: 15.0,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF0F172A),
          ),
        ),
        const SizedBox(height: 10.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: rules.map((rule) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Text(
                rule,
                style: GoogleFonts.inter(
                  fontSize: 12.0,
                  color: const Color(0xFF334155),
                  fontWeight: FontWeight.w400,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildBottomActionButtons(
    BuildContext context,
    UsersRecord columnUsersRecord,
    RidesNewRecord rideRecord,
  ) {
    final tertiaryColor = FlutterFlowTheme.of(context).tertiary;

    return Row(
      children: [
        // Book Ride Button (Blue Gradient)
        Expanded(
          child: Container(
            height: 52.0,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF3B82F6), Color(0xFF2563EB)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(16.0),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF2563EB).withValues(alpha: 0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: () async {
                context.pushNamed(
                  BookRideWidget.routeName,
                  queryParameters: {
                    'rideID': serializeParam(
                      rideRecord.reference,
                      ParamType.DocumentReference,
                    ),
                  }.withoutNulls,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Book Ride',
                    style: GoogleFonts.inter(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Container(
                    padding: const EdgeInsets.all(4.0),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.arrow_forward_rounded,
                      color: Color(0xFF2563EB),
                      size: 14.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 12.0),

        // Send Parcel Button (Tertiary Theme Color Gradient)
        Expanded(
          child: Container(
            height: 52.0,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [tertiaryColor, tertiaryColor.withValues(alpha: 0.85)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(16.0),
              boxShadow: [
                BoxShadow(
                  color: tertiaryColor.withValues(alpha: 0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: () async {
                context.pushNamed(
                  SendParcelWidget.routeName,
                  queryParameters: {
                    'bookingKarnaHai': serializeParam(
                      rideRecord.reference,
                      ParamType.DocumentReference,
                    ),
                  }.withoutNulls,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Send Parcel',
                    style: GoogleFonts.inter(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Container(
                    padding: const EdgeInsets.all(4.0),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.arrow_forward_rounded,
                      color: tertiaryColor,
                      size: 14.0,
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

}
