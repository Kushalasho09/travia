import 'package:google_places_flutter/google_places_flutter.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
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

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => RideLocation1Model());

    // _model.rideStartLocationTextController ??=
    //     TextEditingController(text: FFAppState().RideStartLocaction);
    // _model.rideStartLocationFocusNode ??= FocusNode();
    //
    // _model.rideEndLocationTextController ??=
    //     TextEditingController(text: FFAppState().RideEndLocaction);
    // _model.rideEndLocationFocusNode ??= FocusNode();

    _model.rideStartLocationTextController = TextEditingController();
    _model.rideEndLocationTextController = TextEditingController();
    _model.rideStartLocationFocusNode ??= FocusNode();

    // _model.endLocationTextController ??= TextEditingController();
    _model.rideEndLocationFocusNode ??= FocusNode();

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
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            primary: false,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: AlignmentDirectional(0.0, 0.0),
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(20.0, 50.0, 20.0, 20.0),
                    child: SingleChildScrollView(
                      primary: false,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
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
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
                                child: Container(
                                  // ✅ RESPONSIVE WIDTH
                                  width: MediaQuery.sizeOf(context).width * 0.85,  // 85% screen width
                                  constraints: BoxConstraints(maxWidth: 350.0, minWidth: 280.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.0),
                                    border: Border.all(color: Color(0xFF4DABF7), width: 1.0),
                                  ),
                                  child: GooglePlaceAutoCompleteTextField(
                                    focusNode: _model.rideStartLocationFocusNode,
                                    textEditingController: _model.rideStartLocationTextController,
                                    googleAPIKey: "AIzaSyDZkxRpoy0BOIAPwMaMIvAd5xpCe-6ZYvs",
                                    inputDecoration: InputDecoration(
                                      labelText: 'Ride Start Location',
                                      hintText: 'Ride Start Location',
                                      hintStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                        font: GoogleFonts.inter(),
                                        color: Color(0xFF999999),
                                      ),
                                      // ✅ NO INNER BORDER
                                      border: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      focusedErrorBorder: InputBorder.none,
                                      contentPadding: EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 12.0),
                                    ),
                                    textStyle: FlutterFlowTheme.of(context).bodyMedium.override(fontSize: 14.0),
                                    debounceTime: 600,
                                    countries: ["in"],
                                    isLatLngRequired: false,
                                    itemClick: (prediction) {
                                      _model.rideStartLocationTextController.text = prediction.description ?? "";
                                      _model.rideStartLocationTextController.selection = TextSelection.fromPosition(
                                        TextPosition(offset: prediction.description?.length ?? 0),
                                      );
                                    },
                                    itemBuilder: (context, index, prediction) {
                                      return Container(
                                        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                                        child: Row(
                                          children: [
                                            Icon(Icons.location_on_outlined, size: 18.0, color: Color(0xFF4DABF7),),
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
                              ),
                            ],
                          ),
                          // Row(
                          //   mainAxisSize: MainAxisSize.max,
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: [
                          //     Padding(
                          //       padding: EdgeInsetsDirectional.fromSTEB(
                          //           0.0, 5.0, 0.0, 0.0),
                          //       child: Container(
                          //         width: 310.0,
                          //         child: TextFormField(
                          //           controller:
                          //               _model.rideEndLocationTextController,
                          //           focusNode: _model.rideEndLocationFocusNode,
                          //           autofocus: false,
                          //           obscureText: false,
                          //           decoration: InputDecoration(
                          //             labelText: 'Ride End Location',
                          //             hintText: 'Ride End Location',
                          //             hintStyle: FlutterFlowTheme.of(context)
                          //                 .bodyMedium
                          //                 .override(
                          //                   font: GoogleFonts.inter(
                          //                     fontWeight:
                          //                         FlutterFlowTheme.of(context)
                          //                             .bodyMedium
                          //                             .fontWeight,
                          //                     fontStyle:
                          //                         FlutterFlowTheme.of(context)
                          //                             .bodyMedium
                          //                             .fontStyle,
                          //                   ),
                          //                   color: Color(0xFF999999),
                          //                   letterSpacing: 0.0,
                          //                   fontWeight:
                          //                       FlutterFlowTheme.of(context)
                          //                           .bodyMedium
                          //                           .fontWeight,
                          //                   fontStyle:
                          //                       FlutterFlowTheme.of(context)
                          //                           .bodyMedium
                          //                           .fontStyle,
                          //                 ),
                          //             enabledBorder: OutlineInputBorder(
                          //               borderSide: BorderSide(
                          //                 color: Color(0xFF4DABF7),
                          //                 width: 1.0,
                          //               ),
                          //               borderRadius:
                          //                   BorderRadius.circular(12.0),
                          //             ),
                          //             focusedBorder: OutlineInputBorder(
                          //               borderSide: BorderSide(
                          //                 color: Color(0xFF4DABF7),
                          //                 width: 1.0,
                          //               ),
                          //               borderRadius:
                          //                   BorderRadius.circular(12.0),
                          //             ),
                          //             errorBorder: OutlineInputBorder(
                          //               borderSide: BorderSide(
                          //                 color: Color(0x00000000),
                          //                 width: 1.0,
                          //               ),
                          //               borderRadius:
                          //                   BorderRadius.circular(12.0),
                          //             ),
                          //             focusedErrorBorder: OutlineInputBorder(
                          //               borderSide: BorderSide(
                          //                 color: Color(0x00000000),
                          //                 width: 1.0,
                          //               ),
                          //               borderRadius:
                          //                   BorderRadius.circular(12.0),
                          //             ),
                          //             contentPadding:
                          //                 EdgeInsetsDirectional.fromSTEB(
                          //                     16.0, 0.0, 16.0, 0.0),
                          //           ),
                          //           style: FlutterFlowTheme.of(context)
                          //               .bodyMedium
                          //               .override(
                          //                 font: GoogleFonts.inter(
                          //                   fontWeight:
                          //                       FlutterFlowTheme.of(context)
                          //                           .bodyMedium
                          //                           .fontWeight,
                          //                   fontStyle:
                          //                       FlutterFlowTheme.of(context)
                          //                           .bodyMedium
                          //                           .fontStyle,
                          //                 ),
                          //                 letterSpacing: 0.0,
                          //                 fontWeight:
                          //                     FlutterFlowTheme.of(context)
                          //                         .bodyMedium
                          //                         .fontWeight,
                          //                 fontStyle:
                          //                     FlutterFlowTheme.of(context)
                          //                         .bodyMedium
                          //                         .fontStyle,
                          //               ),
                          //           validator: _model
                          //               .rideEndLocationTextControllerValidator
                          //               .asValidator(context),
                          //         ),
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
                                child: Container(
                                  // ✅ RESPONSIVE WIDTH
                                  width: MediaQuery.sizeOf(context).width * 0.85,  // 85% screen width
                                  constraints: BoxConstraints(maxWidth: 350.0, minWidth: 280.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.0),
                                    border: Border.all(color: Color(0xFF4DABF7), width: 1.0),
                                  ),
                                  child: GooglePlaceAutoCompleteTextField(
                                    focusNode: _model.rideEndLocationFocusNode,
                                    textEditingController: _model.rideEndLocationTextController,
                                    googleAPIKey: "AIzaSyDZkxRpoy0BOIAPwMaMIvAd5xpCe-6ZYvs",
                                    inputDecoration: InputDecoration(
                                      labelText: 'Ride Start Location',
                                      hintText: 'Ride Start Location',
                                      hintStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                        font: GoogleFonts.inter(),
                                        color: Color(0xFF999999),
                                      ),
                                      // ✅ NO INNER BORDER
                                      border: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      focusedErrorBorder: InputBorder.none,
                                      contentPadding: EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 12.0),
                                    ),
                                    textStyle: FlutterFlowTheme.of(context).bodyMedium.override(fontSize: 14.0),
                                    debounceTime: 600,
                                    countries: ["in"],
                                    isLatLngRequired: false,
                                    itemClick: (prediction) {
                                      _model.rideEndLocationTextController.text = prediction.description ?? "";
                                      _model.rideEndLocationTextController.selection = TextSelection.fromPosition(
                                        TextPosition(offset: prediction.description?.length ?? 0),
                                      );
                                    },
                                    itemBuilder: (context, index, prediction) {
                                      return Container(
                                        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                                        child: Row(
                                          children: [
                                            Icon(Icons.location_on_outlined, size: 18.0, color: Color(0xFF4DABF7),),
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
                              ),
                            ],
                          ),

                        ].divide(SizedBox(height: 45.0)),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(1.0, 1.0),
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(24.0, 24.0, 24.0, 24.0),
                    child: InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        if ((_model.rideStartLocationTextController.text !=
                                    null &&
                                _model.rideStartLocationTextController.text !=
                                    '') &&
                            (_model.rideEndLocationTextController.text !=
                                    null &&
                                _model.rideEndLocationTextController.text !=
                                    '')) {
                          FFAppState().RideStartLocaction =
                              _model.rideStartLocationTextController.text;
                          FFAppState().RideEndLocaction =
                              _model.rideEndLocationTextController.text;
                          safeSetState(() {});
                          if (Navigator.of(context).canPop()) {
                            context.pop();
                          }
                          context.pushNamed(RideStartDateTime2Widget.routeName);
                        } else {
                          await showDialog(
                            context: context,
                            builder: (alertDialogContext) {
                              return AlertDialog(
                                title: Text('Attention'),
                                content: Text('Please fill details carefully'),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(alertDialogContext),
                                    child: Text('Ok'),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                      child: Container(
                        width: 80.0,
                        height: 80.0,
                        decoration: BoxDecoration(
                          color: Color(0xFFFF8C00),
                          shape: BoxShape.circle,
                        ),
                        child: Align(
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                            size: 30.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ].divide(SizedBox(height: 50.0)),
            ),
          ),
        ),
      ),
    );
  }
}
