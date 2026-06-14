import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'post_ride_select_model.dart';
export 'post_ride_select_model.dart';

class PostRideSelectWidget extends StatefulWidget {
  const PostRideSelectWidget({super.key});

  static String routeName = 'PostRideSelect';
  static String routePath = '/postRideSelect';

  @override
  State<PostRideSelectWidget> createState() => _PostRideSelectWidgetState();
}

class _PostRideSelectWidgetState extends State<PostRideSelectWidget> {
  late PostRideSelectModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PostRideSelectModel());
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
        body: SafeArea(
          top: true,
          child: Align(
            alignment: AlignmentDirectional(0.0, 0.0),
            child: SingleChildScrollView(
              primary: false,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Align(
                    alignment: AlignmentDirectional(0.0, 0.0),
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 70.0, 0.0, 0.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 5.0, 0.0, 5.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10.0, 0.0, 0.0, 0.0),
                                  child: Text(
                                    ' What are you \n looking for?',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                      font: GoogleFonts.inter(
                                        fontWeight: FontWeight.w600,
                                        fontStyle:
                                        FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                      fontSize: 35.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
                                      fontStyle:
                                      FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: AlignmentDirectional(0.0, 0.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.asset(
                                      'assets/images/Travia_app_ui_bird.gif',
                                      width: 126.4,
                                      height: 219.09,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 196.12,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FFButtonWidget(
                            onPressed: () async {
                              context.pushNamed(RideLocation1Widget.routeName);
                            },
                            text: 'Post Daily Rides',
                            options: FFButtonOptions(
                              width: 400.0,
                              height: 50.0,
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 0.0, 16.0, 0.0),
                              iconPadding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              color: Color(0x00354767),
                              textStyle: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .override(
                                    font: GoogleFonts.interTight(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .fontStyle,
                                    ),
                                    color: Color(0xFF354767),
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontStyle,
                                  ),
                              elevation: 0.0,
                              borderSide: BorderSide(
                                color: Color(0xFF354767),
                              ),
                              borderRadius: BorderRadius.circular(12.0),
                              hoverColor: Color(0xFFF57C3B),
                              hoverBorderSide: BorderSide(
                                color: Colors.white,
                              ),
                              hoverTextColor: Colors.white,
                            ),
                          ),
                          FFButtonWidget(
                            onPressed: () async {
                              context.pushNamed(MarketRideWidget.routeName);
                            },
                            // onPressed: () async {
                              // context.pushNamed(
                              //   MarketPlaceCustomerWidget.routeName,
                              //   // queryParameters: {
                              //   //   'tabNumberRef': serializeParam(
                              //   //     0,
                              //   //     ParamType.int,
                              //   //   ),
                              //   // }.withoutNulls,
                              // );
                            // },
                            text: 'Post Marketplace',
                            options: FFButtonOptions(
                              width: 400.0,
                              height: 50.0,
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 0.0, 16.0, 0.0),
                              iconPadding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              color: Color(0x00354767),
                              textStyle: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .override(
                                    font: GoogleFonts.interTight(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .fontStyle,
                                    ),
                                    color: Color(0xFF354767),
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontStyle,
                                  ),
                              elevation: 0.0,
                              borderSide: BorderSide(
                                color: Color(0xFF354767),
                              ),
                              borderRadius: BorderRadius.circular(12.0),
                              hoverColor: Color(0xFFF57C3B),
                              hoverBorderSide: BorderSide(
                                color: Colors.white,
                              ),
                              hoverTextColor: Colors.white,
                            ),
                          ),
                        ].divide(SizedBox(height: 15.0)),
                      ),
                    ),
                  ),
                ]
                    .divide(SizedBox(height: 20.0))
                    .addToEnd(SizedBox(height: 10.0)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
