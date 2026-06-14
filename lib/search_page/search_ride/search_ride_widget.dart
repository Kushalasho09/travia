import 'package:auto_size_text/auto_size_text.dart';

import '/backend/backend.dart';
import '/components/no_ride_to_show_user_widget.dart';
import '/compotement/main_footer/main_footer_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'search_ride_model.dart';
export 'search_ride_model.dart';

class SearchRideWidget extends StatefulWidget {
  const SearchRideWidget({
    super.key,
    required this.query1,
    required this.query2,
  });

  final String? query1;
  final String? query2;

  static String routeName = 'SearchRide';
  static String routePath = '/searchRide';

  @override
  State<SearchRideWidget> createState() => _SearchRideWidgetState();
}

class _SearchRideWidgetState extends State<SearchRideWidget> {
  late SearchRideModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SearchRideModel());
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
        backgroundColor: FlutterFlowTheme
            .of(context)
            .primaryBackground,
        appBar: AppBar(
          backgroundColor: Color(0xFFF4F4F4),
          automaticallyImplyLeading: false,
          leading: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
            child: Container(
              width: 40.0,
              height: 40.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: Image
                      .network(
                    '500x500?person',
                  )
                      .image,
                ),
                shape: BoxShape.circle,
                border: Border.all(
                  color: Color(0xFF283B5E),
                  width: 1.0,
                ),
              ),
              child: InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  context.pushNamed(DriveProfileWidget.routeName);
                },
                child: Container(
                  width: 200.0,
                  height: 200.0,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    'assets/images/profileIcon.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          title: Padding(
            padding: EdgeInsets.all(5.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                'assets/images/logoTraviaJi.png',
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  FlutterFlowIconButton(
                    borderRadius: 20.0,
                    buttonSize: 40.0,
                    icon: FaIcon(
                      FontAwesomeIcons.bars,
                      color: Color(0xFF283B5E),
                      size: 30.0,
                    ),
                    onPressed: () async {
                      context.pushNamed(HomeWidget.routeName);
                    },
                  ),
                  FlutterFlowIconButton(
                    borderRadius: 20.0,
                    buttonSize: 40.0,
                    icon: Icon(
                      Icons.notifications_none,
                      color: Color(0xFF283B5E),
                      size: 30.0,
                    ),
                    onPressed: () async {
                      context.pushNamed(PageNotificationWidget.routeName);
                    },
                  ),
                ],
              ),
            ),
          ],
          centerTitle: false,
          elevation: 2.0,
        ),
        body: SafeArea(
          top: true,
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(5.0, 5.0, 5.0, 0.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                // StreamBuilder with Expanded for scrollable rides
                Expanded(
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 25.0, 0.0, 0.0),
                    child: StreamBuilder<List<RidesNewRecord>>(
                      stream: queryRidesNewRecord(
                        queryBuilder: (ridesNewRecord) =>
                            ridesNewRecord.where(Filter.and(
                              Filter(
                                'RideStartLocation',
                                isEqualTo: widget.query1,
                              ),
                              Filter(
                                'RideEndLocation',
                                isEqualTo: widget.query2,
                              ),
                            )),
                      ),
                      builder: (context, snapshot) {
                        // ✅ DEBUG PRINT 1: Query parameters
                        print("🔍 SEARCH QUERY1: '${widget.query1}'");
                        print("🔍 SEARCH QUERY2: '${widget.query2}'");

                        if (!snapshot.hasData) {
                          print("⏳ LOADING...");
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

                        final list = snapshot.data!;
                        print("📊 TOTAL RIDES FOUND: ${list.length}");

                        // ✅ DEBUG PRINT 2: Show ALL ride data
                        for (int i = 0; i < list.length; i++) {
                          final ride = list[i];
                          print("🚗 RIDE $i:");
                          print("   RideStartLocation: '${ride.rideStartLocation}'");
                          print("   RideEndLocation: '${ride.rideEndLocation}'");
                          print("   creatorID: ${ride.creatorID}");
                          print("   modeOfTransport: '${ride.modeOfTransport}'");
                        }
                        if (list.isEmpty) {
                          print("❌ NO RIDES MATCHED - Check Firestore data!");

                          return NoRideToShowUserWidget();
                        }

                        // return ListView.separated(
                        //   padding: EdgeInsets.zero,
                        //   itemCount: list.length,
                        //   separatorBuilder: (_, __) => SizedBox(height: 10.0),
                        //   itemBuilder: (context, index) {
                        //     final ride = list[index];
                        //     return InkWell(
                        //       splashColor: Colors.transparent,
                        //       focusColor: Colors.transparent,
                        //       hoverColor: Colors.transparent,
                        //       highlightColor: Colors.transparent,
                        //       onTap: () async {
                        //         context.pushNamed(
                        //           RideDetailsCustomerWidget.routeName,
                        //           queryParameters: {
                        //             'rideDetails': serializeParam(
                        //               ride.reference,
                        //               ParamType.DocumentReference,
                        //             ),
                        //           }.withoutNulls,
                        //         );
                        //       },
                        //       child: ClipRRect(
                        //         borderRadius: BorderRadius.circular(12.0),
                        //         child: Container(
                        //           width: double.infinity,
                        //           decoration: BoxDecoration(
                        //             color: FlutterFlowTheme.of(context).primaryBackground,
                        //             boxShadow: [
                        //               BoxShadow(
                        //                 blurRadius: 4.0,
                        //                 color: Color(0x1A000000),
                        //                 offset: Offset(0.0, 2.0),
                        //               )
                        //             ],
                        //             borderRadius: BorderRadius.circular(12.0),
                        //             border: Border.all(color: Color(0xFF4DABF7)),
                        //           ),
                        //           child: Padding(
                        //             padding: EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 5.0, 10.0),
                        //             child: Column(
                        //               mainAxisSize: MainAxisSize.min,
                        //               children: [
                        //                 // START Location Row
                        //                 Row(
                        //                   children: [
                        //                     Icon(
                        //                       Icons.location_on_outlined,
                        //                       color: FlutterFlowTheme.of(context).primary,
                        //                       size: 24.0,
                        //                     ),
                        //                     SizedBox(width: 5.0),
                        //                     Expanded(
                        //                       child: Container(
                        //                         decoration: BoxDecoration(
                        //                           color: Color(0xFFE3E6E0),
                        //                           borderRadius: BorderRadius.circular(15.0),
                        //                         ),
                        //                         padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                        //                         child: Text(
                        //                           ride.rideStartLocation,
                        //                           style: FlutterFlowTheme.of(context).bodyMedium.copyWith(fontSize: 12.0),
                        //                         ),
                        //                       ),
                        //                     ),
                        //                   ],
                        //                 ),
                        //                 SizedBox(height: 8.0),
                        //                 // Mode of transport + Travel time
                        //                 Row(
                        //                   children: [
                        //                     if (ride.modeOfTransport == 'Bike')
                        //                       Icon(Icons.motorcycle_sharp, color: Color(0xFF8A8888), size: 20.0),
                        //                     if (ride.modeOfTransport == 'Bus')
                        //                       FaIcon(FontAwesomeIcons.bus, color: Color(0xFF919191), size: 15.0),
                        //                     if (ride.modeOfTransport == 'Train')
                        //                       Icon(Icons.train, color: Color(0xFF929090), size: 20.0),
                        //                     if (ride.modeOfTransport == 'Car')
                        //                       FaIcon(FontAwesomeIcons.carSide, color: Color(0xFF8F9192), size: 15.0),
                        //                     SizedBox(width: 5.0),
                        //                     Text(
                        //                       'Travel time: ${ride.travelTime}',
                        //                       style: FlutterFlowTheme.of(context).labelMedium.copyWith(fontSize: 12.0),
                        //                     ),
                        //                   ],
                        //                 ),
                        //                 SizedBox(height: 8.0),
                        //                 // END Location Row
                        //                 Row(
                        //                   children: [
                        //                     Icon(Icons.location_on_outlined, color: FlutterFlowTheme.of(context).primary, size: 24.0),
                        //                     SizedBox(width: 5.0),
                        //                     Expanded(
                        //                       child: Container(
                        //                         decoration: BoxDecoration(
                        //                           color: Color(0xFFE3E6E0),
                        //                           borderRadius: BorderRadius.circular(15.0),
                        //                         ),
                        //                         padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                        //                         child: Text(
                        //                           ride.rideEndLocation,
                        //                           style: FlutterFlowTheme.of(context).bodyMedium.copyWith(fontSize: 12.0),
                        //                         ),
                        //                       ),
                        //                     ),
                        //                   ],
                        //                 ),
                        //                 SizedBox(height: 8.0),
                        //                 // Creator info + rating
                        //                 StreamBuilder<UsersRecord>(
                        //                   stream: UsersRecord.getDocument(ride.creatorID!),
                        //                   builder: (context, snapshot) {
                        //                     if (!snapshot.hasData) {
                        //                       return Center(
                        //                         child: SizedBox(
                        //                           width: 50.0,
                        //                           height: 50.0,
                        //                           child: SpinKitFadingCircle(
                        //                             color: Color(0xFF2B3C58),
                        //                             size: 50.0,
                        //                           ),
                        //                         ),
                        //                       );
                        //                     }
                        //                     final user = snapshot.data!;
                        //                     return Row(
                        //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //                       children: [
                        //                         Row(
                        //                           children: [
                        //                             InkWell(
                        //                               onTap: () async {
                        //                                 context.pushNamed(
                        //                                   DriverReviewWidget.routeName,
                        //                                   queryParameters: {
                        //                                     'userRef': serializeParam(
                        //                                       user.reference,
                        //                                       ParamType.DocumentReference,
                        //                                     ),
                        //                                   }.withoutNulls,
                        //                                 );
                        //                               },
                        //                               child: CircleAvatar(
                        //                                 radius: 15.0,
                        //                                 backgroundImage: user.photoUrl != null && user.photoUrl != ''
                        //                                     ? NetworkImage(user.photoUrl!)
                        //                                     : AssetImage('assets/images/userIconTr.png') as ImageProvider,
                        //                               ),
                        //                             ),
                        //                             SizedBox(width: 12.0),
                        //                             Text(
                        //                               user.displayName != null && user.displayName != '' ? user.displayName! : 'Driver',
                        //                               style: FlutterFlowTheme.of(context).bodyMedium.copyWith(
                        //                                 fontSize: 12.0,
                        //                                 fontWeight: FontWeight.w600,
                        //                               ),
                        //                             ),
                        //                           ],
                        //                         ),
                        //                         Container(
                        //                           width: 30.0,
                        //                           height: 30.0,
                        //                           child: Stack(
                        //                             alignment: Alignment.center,
                        //                             children: [
                        //                               ClipRRect(
                        //                                 borderRadius: BorderRadius.circular(8.0),
                        //                                 child: Image.asset(
                        //                                   'assets/images/Ride_Search_Icons.png',
                        //                                   width: 25.0,
                        //                                   height: 30.0,
                        //                                   fit: BoxFit.cover,
                        //                                 ),
                        //                               ),
                        //                               Text(
                        //                                 valueOrDefault<String>(
                        //                                   formatNumber(
                        //                                     functions.averageRating(user.ratings.toList()),
                        //                                     formatType: FormatType.compact,
                        //                                   ),
                        //                                   '0',
                        //                                 ),
                        //                                 style: FlutterFlowTheme.of(context).bodyMedium.copyWith(
                        //                                   fontSize: 8.0,
                        //                                   fontWeight: FontWeight.w900,
                        //                                   color: FlutterFlowTheme.of(context).primaryBackground,
                        //                                 ),
                        //                               ),
                        //                             ],
                        //                           ),
                        //                         ),
                        //                       ],
                        //                     );
                        //                   },
                        //                 ),
                        //               ],
                        //             ),
                        //           ),
                        //         ),
                        //       ),
                        //     );
                        //   },
                        // );

                        return ListView.separated(
                          padding: EdgeInsets.zero,
                          primary: false,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: list.length,
                          separatorBuilder: (_, __) => SizedBox(height: 10.0),
                          itemBuilder: (context, index) {
                            final ride = list[index];
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
                                          color: FlutterFlowTheme
                                              .of(context)
                                              .primaryBackground,
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
                                            color: FlutterFlowTheme
                                                .of(context)
                                                .tertiary,
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
                                                          color: FlutterFlowTheme
                                                              .of(context)
                                                              .primary,
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
                                                                  ride.rideStartLocation,
                                                                style: FlutterFlowTheme
                                                                    .of(context)
                                                                    .bodyMedium
                                                                    .override(
                                                                  font: GoogleFonts.inter(
                                                                    fontWeight: FlutterFlowTheme
                                                                        .of(context)
                                                                        .bodyMedium
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme
                                                                        .of(context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  fontSize: 12.0,
                                                                  letterSpacing: 0.0,
                                                                  fontWeight: FlutterFlowTheme
                                                                      .of(context)
                                                                      .bodyMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme
                                                                      .of(context)
                                                                      .bodyMedium
                                                                      .fontStyle,
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
                                                        mainAxisSize: MainAxisSize.max,
                                                        children: [
                                                          if (ride.modeOfTransport == 'Bike')
                                                            Padding(
                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
                                                              child: Icon(
                                                                Icons.motorcycle_sharp,
                                                                color: Color(0xFF8A8888),
                                                                size: 20.0,
                                                              ),
                                                            ),
                                                          if (ride.modeOfTransport == 'Train')
                                                            Padding(
                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
                                                              child: Icon(
                                                                Icons.train,
                                                                color: Color(0xFF929090),
                                                                size: 20.0,
                                                              ),
                                                            ),
                                                          if (ride.modeOfTransport == 'Car')
                                                            Padding(
                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
                                                              child: FaIcon(
                                                                FontAwesomeIcons.carSide,
                                                                color: Color(0xFF8F9192),
                                                                size: 15.0,
                                                              ),
                                                            ),
                                                          if (ride.modeOfTransport == 'Bus')
                                                            FaIcon(
                                                              FontAwesomeIcons.bus,
                                                              color: Color(0xFF919191),
                                                              size: 15.0,
                                                            ),
                                                          Align(
                                                            alignment: AlignmentDirectional(0.0, 0.0),
                                                            child: Text(
                                                              '${dateTimeFormat("jm", ride.pickupTime)} । ${dateTimeFormat("yMMMd", ride.pickupTime)}',
                                                              style: FlutterFlowTheme
                                                                  .of(context)
                                                                  .labelMedium
                                                                  .override(
                                                                font: GoogleFonts.inter(
                                                                  fontWeight: FlutterFlowTheme
                                                                      .of(context)
                                                                      .labelMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme
                                                                      .of(context)
                                                                      .labelMedium
                                                                      .fontStyle,
                                                                ),
                                                                color: FlutterFlowTheme
                                                                    .of(context)
                                                                    .secondaryText,
                                                                fontSize: 12.0,
                                                                letterSpacing: 0.0,
                                                                fontWeight: FlutterFlowTheme
                                                                    .of(context)
                                                                    .labelMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme
                                                                    .of(context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                              ),
                                                            ),
                                                          ),
                                                        ].divide(SizedBox(width: 5.0)),
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
                                                          color: FlutterFlowTheme
                                                              .of(context)
                                                              .primary,
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
                                                              ride.rideEndLocation,
                                                              style: FlutterFlowTheme
                                                                  .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                font: GoogleFonts.inter(
                                                                  fontWeight: FlutterFlowTheme
                                                                      .of(context)
                                                                      .bodyMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme
                                                                      .of(context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                                fontSize: 12.0,
                                                                letterSpacing: 0.0,
                                                                fontWeight: FlutterFlowTheme
                                                                    .of(context)
                                                                    .bodyMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme
                                                                    .of(context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ].divide(SizedBox(width: 5.0)),
                                                ),
                                                if (ride.creatorID != null)
                                                  Padding(
                                                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                    child: StreamBuilder<UsersRecord>(
                                                      stream: UsersRecord.getDocument(ride.creatorID!),
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
                                                            Align(
                                                              alignment: AlignmentDirectional(-1.0, 0.0),
                                                              child: Container(
                                                                width: 180.0,
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
                                                                      onTap: () async {
                                                                        context.pushNamed(
                                                                          DriverReviewWidget.routeName,
                                                                          queryParameters: {
                                                                            'userRef': serializeParam(
                                                                              rowUsersRecord.reference,
                                                                              ParamType.DocumentReference,
                                                                            ),
                                                                          }.withoutNulls,
                                                                        );
                                                                      },
                                                                      child: Builder(
                                                                        builder: (context) {
                                                                          if (rowUsersRecord.photoUrl != null && rowUsersRecord.photoUrl != '') {
                                                                            return Container(
                                                                              width: 30.0,
                                                                              height: 30.0,
                                                                              clipBehavior: Clip.antiAlias,
                                                                              decoration: BoxDecoration(
                                                                                shape: BoxShape.circle,
                                                                              ),
                                                                              child: Image.network(
                                                                                rowUsersRecord.photoUrl,
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
                                                                                      rowUsersRecord.reference,
                                                                                      ParamType.DocumentReference,
                                                                                    ),
                                                                                  }.withoutNulls,
                                                                                );
                                                                              },
                                                                              child: Container(
                                                                                width: 30.0,
                                                                                height: 30.0,
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
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 5.0, 0.0),
                                                                      child: Column(
                                                                        mainAxisSize: MainAxisSize.min,
                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                        children: [
                                                                          Text(
                                                                            rowUsersRecord.displayName != null && rowUsersRecord.displayName != '' ? rowUsersRecord.displayName : 'Driver',
                                                                            style: FlutterFlowTheme
                                                                                .of(context)
                                                                                .bodyMedium
                                                                                .override(
                                                                              font: GoogleFonts.inter(
                                                                                fontWeight: FontWeight.w600,
                                                                                fontStyle: FlutterFlowTheme
                                                                                    .of(context)
                                                                                    .bodyMedium
                                                                                    .fontStyle,
                                                                              ),
                                                                              fontSize: 12.0,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FontWeight.w600,
                                                                              fontStyle: FlutterFlowTheme
                                                                                  .of(context)
                                                                                  .bodyMedium
                                                                                  .fontStyle,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
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
                                                                            functions.averageRating(rowUsersRecord.ratings.toList()),
                                                                            formatType: FormatType.compact,
                                                                          ),
                                                                          '0',
                                                                        ),
                                                                        style: FlutterFlowTheme
                                                                            .of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                          font: GoogleFonts.inter(
                                                                            fontWeight: FontWeight.w900,
                                                                            fontStyle: FlutterFlowTheme
                                                                                .of(context)
                                                                                .bodyMedium
                                                                                .fontStyle,
                                                                          ),
                                                                          color: FlutterFlowTheme
                                                                              .of(context)
                                                                              .primaryBackground,
                                                                          fontSize: 9.0,
                                                                          letterSpacing: 0.0,
                                                                          fontWeight: FontWeight.w900,
                                                                          fontStyle: FlutterFlowTheme
                                                                              .of(context)
                                                                              .bodyMedium
                                                                              .fontStyle,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ].divide(SizedBox(width: 1.0)),
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
                                ),
                                Align(
                                  alignment: AlignmentDirectional(0.97, -0.96),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 5.0, 0.0),
                                    child: Container(
                                      width: 60.0,
                                      height: 100.0,
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
                                              style: FlutterFlowTheme
                                                  .of(context)
                                                  .bodyMedium
                                                  .override(
                                                font: GoogleFonts.inter(
                                                  fontWeight: FlutterFlowTheme
                                                      .of(context)
                                                      .bodyMedium
                                                      .fontWeight,
                                                  fontStyle: FlutterFlowTheme
                                                      .of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                                ),
                                                color: FlutterFlowTheme
                                                    .of(context)
                                                    .info,
                                                fontSize: 12.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FlutterFlowTheme
                                                    .of(context)
                                                    .bodyMedium
                                                    .fontWeight,
                                                fontStyle: FlutterFlowTheme
                                                    .of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 4.0),
                                            child: AutoSizeText(
                                              '₹${formatNumber(
                                                ride.rideCost,
                                                formatType: FormatType.custom,
                                                format: '',
                                                locale: '',
                                              )}',
                                              style: FlutterFlowTheme
                                                  .of(context)
                                                  .bodyMedium
                                                  .override(
                                                font: GoogleFonts.inter(
                                                  fontWeight: FontWeight.bold,
                                                  fontStyle: FlutterFlowTheme
                                                      .of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                                ),
                                                color: FlutterFlowTheme
                                                    .of(context)
                                                    .info,
                                                fontSize: 15.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.bold,
                                                fontStyle: FlutterFlowTheme
                                                    .of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: double.infinity,
                                            height: 55.0,
                                            decoration: BoxDecoration(
                                              color: Color(0xFFFF9561),
                                              borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(10.0),
                                                bottomRight: Radius.circular(10.0),
                                                topLeft: Radius.circular(10.0),
                                                topRight: Radius.circular(10.0),
                                              ),
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
                                                  child: Text(
                                                    'Parcel',
                                                    textAlign: TextAlign.center,
                                                    style: FlutterFlowTheme
                                                        .of(context)
                                                        .labelSmall
                                                        .override(
                                                      font: GoogleFonts.inter(
                                                        fontWeight: FontWeight.w500,
                                                        fontStyle: FlutterFlowTheme
                                                            .of(context)
                                                            .labelSmall
                                                            .fontStyle,
                                                      ),
                                                      color: FlutterFlowTheme
                                                          .of(context)
                                                          .info,
                                                      fontSize: 12.0,
                                                      letterSpacing: 0.0,
                                                      fontWeight: FontWeight.w500,
                                                      fontStyle: FlutterFlowTheme
                                                          .of(context)
                                                          .labelSmall
                                                          .fontStyle,
                                                    ),
                                                  ),
                                                ),
                                                AutoSizeText(
                                                  '₹${ride.totalDeliveryCost}',
                                                  textAlign: TextAlign.center,
                                                  style: FlutterFlowTheme
                                                      .of(context)
                                                      .labelSmall
                                                      .override(
                                                    font: GoogleFonts.inter(
                                                      fontWeight: FontWeight.bold,
                                                      fontStyle: FlutterFlowTheme
                                                          .of(context)
                                                          .labelSmall
                                                          .fontStyle,
                                                    ),
                                                    color: FlutterFlowTheme
                                                        .of(context)
                                                        .info,
                                                    fontSize: 15.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.bold,
                                                    fontStyle: FlutterFlowTheme
                                                        .of(context)
                                                        .labelSmall
                                                        .fontStyle,
                                                  ),
                                                ),
                                              ].divide(SizedBox(height: 4.0)),
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
                        );
                      },
                    ),
                  ),
                ),
                // Footer
                wrapWithModel(
                  model: _model.mainFooterModel,
                  updateCallback: () => safeSetState(() {}),
                  child: MainFooterWidget(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
