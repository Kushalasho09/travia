import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/flutter_flow/random_data_util.dart' as random_data;
import '/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'areyousure12_model.dart';
export 'areyousure12_model.dart';

class Areyousure12Widget extends StatefulWidget {
  const Areyousure12Widget({super.key});

  static String routeName = 'Areyousure12';
  static String routePath = '/areyousure12';

  @override
  State<Areyousure12Widget> createState() => _Areyousure12WidgetState();
}

class _Areyousure12WidgetState extends State<Areyousure12Widget> {
  late Areyousure12Model _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => Areyousure12Model());
  }

  @override
  void dispose() {
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
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
          automaticallyImplyLeading: false,
          title: Text(
            'Publish Ride',
            style: FlutterFlowTheme.of(context).titleLarge.override(
                  font: GoogleFonts.interTight(
                    fontWeight:
                        FlutterFlowTheme.of(context).titleLarge.fontWeight,
                    fontStyle:
                        FlutterFlowTheme.of(context).titleLarge.fontStyle,
                  ),
                  color: FlutterFlowTheme.of(context).primaryText,
                  letterSpacing: 0.0,
                  fontWeight:
                      FlutterFlowTheme.of(context).titleLarge.fontWeight,
                  fontStyle: FlutterFlowTheme.of(context).titleLarge.fontStyle,
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
              padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
              child: SingleChildScrollView(
                primary: false,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 20.0),
                      child: CircularPercentIndicator(
                        percent: 1.0,
                        radius: 60.0,
                        lineWidth: 12.0,
                        animation: true,
                        animateFromLastPercent: true,
                        progressColor: Color(0xFFF57C3B),
                        backgroundColor: Color(0xFFD8D5D5),
                        center: Text(
                          '100%',
                          style: FlutterFlowTheme.of(context)
                              .headlineSmall
                              .override(
                                font: GoogleFonts.interTight(
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .headlineSmall
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .headlineSmall
                                      .fontStyle,
                                ),
                                letterSpacing: 0.0,
                                fontWeight: FlutterFlowTheme.of(context)
                                    .headlineSmall
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .headlineSmall
                                    .fontStyle,
                              ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(24.0),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color(0xFFF4F4F4),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 5.0,
                              color: Color(0x20000000),
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Are you sure to publish ride?',
                                textAlign: TextAlign.center,
                                style: FlutterFlowTheme.of(context)
                                    .headlineMedium
                                    .override(
                                      font: GoogleFonts.interTight(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .headlineMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .headlineMedium
                                            .fontStyle,
                                      ),
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .headlineMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .headlineMedium
                                          .fontStyle,
                                    ),
                              ),
                              Text(
                                'Once published, your ride will be visible to potential passengers after review. Please ensure all details are correct.',
                                textAlign: TextAlign.center,
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      font: GoogleFonts.inter(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: FFButtonWidget(
                                      onPressed: () async {
                                        FFAppState().RideStartLocaction = '';
                                        FFAppState().RideEndLocaction = '';
                                        FFAppState().pickupTime = null;
                                        FFAppState().DropTime = null;
                                        FFAppState().isPredefinedItems = false;
                                        FFAppState().isPassengers = '';
                                        FFAppState().numPassengers = 0;
                                        FFAppState().pricePerPassengers = 0;
                                        FFAppState().numBagAllowed = 0;
                                        FFAppState().isRiderulesAccepted =
                                            false;
                                        FFAppState().isTermAccepted = false;
                                        FFAppState().rideRule1 = '';
                                        FFAppState().rideRule2 = '';
                                        FFAppState().rideRule3 = '';
                                        FFAppState().rideRule4 = '';
                                        FFAppState().rideRule5 = '';
                                        FFAppState().rideRule6 = '';
                                        FFAppState().rideRule7 = '';
                                        FFAppState().rideRule8 = '';
                                        FFAppState().modeOfTransport = '';
                                        FFAppState().travelTime = '';
                                        FFAppState().vehicleNumber = '';
                                        FFAppState().totalDelvieryCost = '';
                                        FFAppState().DriverNumber = '';
                                        safeSetState(() {});

                                        context.pushNamed(HomeWidget.routeName);
                                      },
                                      text: 'Cancel',
                                      options: FFButtonOptions(
                                        width: 140.0,
                                        height: 50.0,
                                        padding: EdgeInsets.all(8.0),
                                        iconPadding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                0.0, 0.0, 0.0, 0.0),
                                        color: FlutterFlowTheme.of(context)
                                            .alternate,
                                        textStyle: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .override(
                                              font: GoogleFonts.interTight(
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .titleSmall
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .titleSmall
                                                        .fontStyle,
                                              ),
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              letterSpacing: 0.0,
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .titleSmall
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .titleSmall
                                                      .fontStyle,
                                            ),
                                        borderSide: BorderSide(
                                          color: Colors.transparent,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: StreamBuilder<
                                        List<AdminApprovalOnRidesRecord>>(
                                      stream: queryAdminApprovalOnRidesRecord(
                                        singleRecord: true,
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
                                        List<AdminApprovalOnRidesRecord>
                                            buttonAdminApprovalOnRidesRecordList =
                                            snapshot.data!;
                                        // Return an empty Container when the item does not exist.
                                        if (snapshot.data!.isEmpty) {
                                          return Container();
                                        }
                                        final buttonAdminApprovalOnRidesRecord =
                                            buttonAdminApprovalOnRidesRecordList
                                                    .isNotEmpty
                                                ? buttonAdminApprovalOnRidesRecordList
                                                    .first
                                                : null;

                                        return FFButtonWidget(
                                          onPressed: () async {
                                            await RidesNewRecord.collection
                                                .doc()
                                                .set({
                                              ...createRidesNewRecordData(
                                                rideStartLocation: FFAppState()
                                                    .RideStartLocaction,
                                                rideEndLocation: FFAppState()
                                                    .RideEndLocaction,
                                                pickupTime:
                                                    FFAppState().pickupTime,
                                                dropTime: FFAppState().DropTime,
                                                isPredefinedItems: FFAppState()
                                                    .isPredefinedItems,
                                                numPassengers:
                                                    FFAppState().numPassengers,
                                                pricePerPassengers: FFAppState()
                                                    .pricePerPassengers,
                                                numBagAllowed:
                                                    FFAppState().numBagAllowed,
                                                rideRule1:
                                                    FFAppState().rideRule1,
                                                rideRule2:
                                                    FFAppState().rideRule2,
                                                rideRule3:
                                                    FFAppState().rideRule3,
                                                rideRule4:
                                                    FFAppState().rideRule4,
                                                rideRule5:
                                                    FFAppState().rideRule5,
                                                rideRule6:
                                                    FFAppState().rideRule6,
                                                isTermAccepted: FFAppState()
                                                    .isRiderulesAccepted,
                                                modeOfTransport: FFAppState()
                                                    .modeOfTransport,
                                                travelTime:
                                                    FFAppState().travelTime,
                                                vehicleNumber:
                                                    FFAppState().vehicleNumber,
                                                totalDeliveryCost: FFAppState()
                                                    .totalDelvieryCost,
                                                driverNumber:
                                                    FFAppState().DriverNumber,
                                                creatorID: currentUserReference,
                                                isRideApproved: false,
                                                createdTime:
                                                    getCurrentTimestamp,
                                                rideID: random_data
                                                    .randomInteger(2, 10)
                                                    .toString(),
                                                rideStatus:
                                                    buttonAdminApprovalOnRidesRecord
                                                        ?.isDirectApproved,
                                                isPassangerAllowedinCar:
                                                    FFAppState().isPassengers,
                                                isRideRulesAccepted:
                                                    FFAppState()
                                                        .isRiderulesAccepted,
                                                rideStartLocationGoogle:
                                                    FFAppState()
                                                        .rideStartLocationGoogle,
                                                rideEndLocationGoogle:
                                                    FFAppState()
                                                        .rideEndLocationGoogle,
                                                rideCost: FFAppState()
                                                    .rideCostforDetailRides,
                                                googleStartAddress: FFAppState()
                                                    .GoogleStartAddress,
                                                googleEndAddress: FFAppState()
                                                    .GoogleEndAddress,
                                              ),
                                              ...mapToFirestore(
                                                {
                                                  'caryyItems': FFAppState()
                                                      .carryItemNormalRides,
                                                  'stoppages': FFAppState()
                                                      .stoppageNormalParcaleRide,
                                                },
                                              ),
                                            });
                                            await showDialog(
                                              context: context,
                                              builder: (alertDialogContext) {
                                                return AlertDialog(
                                                  title: Text(
                                                      'Ride Posted Successfully'),
                                                  content: Text(
                                                      'Your ride is posted successfully, after review by Travia team your ride will go live.'),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () =>
                                                          Navigator.pop(
                                                              alertDialogContext),
                                                      child: Text('Ok'),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                            FFAppState().pickupTime = null;
                                            FFAppState().DropTime = null;
                                            FFAppState().isPredefinedItems =
                                                false;
                                            FFAppState().isPassengers = '';
                                            FFAppState().numPassengers = 0;
                                            FFAppState().isRiderulesAccepted =
                                                false;
                                            FFAppState().isTermAccepted = false;
                                            FFAppState().travelTime = '';
                                            safeSetState(() {});

                                            context.goNamed(
                                              HomeWidget.routeName,
                                              queryParameters: {
                                                'tabNumberRef': serializeParam(
                                                  2,
                                                  ParamType.int,
                                                ),
                                              }.withoutNulls,
                                            );
                                          },
                                          text: 'Publish Ride',
                                          options: FFButtonOptions(
                                            width: 140.0,
                                            height: 50.0,
                                            padding: EdgeInsets.all(8.0),
                                            iconPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            color: Color(0xFFF67E4A),
                                            textStyle: FlutterFlowTheme.of(
                                                    context)
                                                .titleSmall
                                                .override(
                                                  font: GoogleFonts.interTight(
                                                    fontWeight:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .titleSmall
                                                            .fontWeight,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .titleSmall
                                                            .fontStyle,
                                                  ),
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryBackground,
                                                  letterSpacing: 0.0,
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .titleSmall
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .titleSmall
                                                          .fontStyle,
                                                ),
                                            borderSide: BorderSide(
                                              color: Colors.transparent,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ].divide(SizedBox(width: 16.0)),
                              ),
                            ].divide(SizedBox(height: 24.0)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
