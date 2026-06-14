import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'ride_end_date_time3_model.dart';
export 'ride_end_date_time3_model.dart';

class RideEndDateTime3Widget extends StatefulWidget {
  const RideEndDateTime3Widget({super.key});

  static String routeName = 'RideEndDateTime3';
  static String routePath = '/rideEndDateTime3';

  @override
  State<RideEndDateTime3Widget> createState() => _RideEndDateTime3WidgetState();
}

class _RideEndDateTime3WidgetState extends State<RideEndDateTime3Widget> {
  late RideEndDateTime3Model _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => RideEndDateTime3Model());
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
            'End Date',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  font: GoogleFonts.interTight(
                    fontWeight:
                        FlutterFlowTheme.of(context).headlineMedium.fontWeight,
                    fontStyle:
                        FlutterFlowTheme.of(context).headlineMedium.fontStyle,
                  ),
                  color: FlutterFlowTheme.of(context).primaryText,
                  fontSize: 20.0,
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
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Align(
                    alignment: AlignmentDirectional(0.0, 0.0),
                    child: Padding(
                      padding: EdgeInsets.all(24.0),
                      child: ListView(
                        padding: EdgeInsets.zero,
                        primary: false,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        children: [
                          CircularPercentIndicator(
                            percent: 0.3,
                            radius: 60.0,
                            lineWidth: 12.0,
                            animation: true,
                            animateFromLastPercent: true,
                            progressColor: Color(0xFFF57C3B),
                            backgroundColor: Color(0xFFD8D5D5),
                            center: Text(
                              '30%',
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
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 15.0, 0.0, 10.0),
                            child: Text(
                              'Ride End Date and Time',
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
                                    fontSize: 18.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                            ),
                          ),
                          InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              final _datePickedDate = await showDatePicker(
                                context: context,
                                initialDate: getCurrentTimestamp,
                                firstDate: getCurrentTimestamp,
                                lastDate: DateTime(2050),
                                builder: (context, child) {
                                  return wrapInMaterialDatePickerTheme(
                                    context,
                                    child!,
                                    headerBackgroundColor: Color(0xFFF9814F),
                                    headerForegroundColor:
                                        FlutterFlowTheme.of(context).info,
                                    headerTextStyle:
                                        FlutterFlowTheme.of(context)
                                            .headlineLarge
                                            .override(
                                              font: GoogleFonts.interTight(
                                                fontWeight: FontWeight.w600,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .headlineLarge
                                                        .fontStyle,
                                              ),
                                              fontSize: 32.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w600,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .headlineLarge
                                                      .fontStyle,
                                            ),
                                    pickerBackgroundColor:
                                        FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                    pickerForegroundColor:
                                        FlutterFlowTheme.of(context)
                                            .primaryText,
                                    selectedDateTimeBackgroundColor:
                                        Color(0xFFF9814F),
                                    selectedDateTimeForegroundColor:
                                        FlutterFlowTheme.of(context).info,
                                    actionButtonForegroundColor:
                                        FlutterFlowTheme.of(context)
                                            .primaryText,
                                    iconSize: 24.0,
                                  );
                                },
                              );

                              TimeOfDay? _datePickedTime;
                              if (_datePickedDate != null) {
                                _datePickedTime = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.fromDateTime(
                                      getCurrentTimestamp),
                                  builder: (context, child) {
                                    return wrapInMaterialTimePickerTheme(
                                      context,
                                      child!,
                                      headerBackgroundColor: Color(0xFFF9814F),
                                      headerForegroundColor:
                                          FlutterFlowTheme.of(context).info,
                                      headerTextStyle: FlutterFlowTheme.of(
                                              context)
                                          .headlineLarge
                                          .override(
                                            font: GoogleFonts.interTight(
                                              fontWeight: FontWeight.w600,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .headlineLarge
                                                      .fontStyle,
                                            ),
                                            fontSize: 32.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .headlineLarge
                                                    .fontStyle,
                                          ),
                                      pickerBackgroundColor:
                                          FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                      pickerForegroundColor:
                                          FlutterFlowTheme.of(context)
                                              .primaryText,
                                      selectedDateTimeBackgroundColor:
                                          Color(0xFFF9814F),
                                      selectedDateTimeForegroundColor:
                                          FlutterFlowTheme.of(context).info,
                                      actionButtonForegroundColor:
                                          FlutterFlowTheme.of(context)
                                              .primaryText,
                                      iconSize: 24.0,
                                    );
                                  },
                                );
                              }

                              if (_datePickedDate != null &&
                                  _datePickedTime != null) {
                                safeSetState(() {
                                  _model.datePicked = DateTime(
                                    _datePickedDate.year,
                                    _datePickedDate.month,
                                    _datePickedDate.day,
                                    _datePickedTime!.hour,
                                    _datePickedTime.minute,
                                  );
                                });
                              } else if (_model.datePicked != null) {
                                safeSetState(() {
                                  _model.datePicked = getCurrentTimestamp;
                                });
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).otherColour,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    if (_model.datePicked != null)
                                      Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: RichText(
                                          textScaler:
                                              MediaQuery.of(context).textScaler,
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: dateTimeFormat(
                                                    "jm", _model.datePicked),
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyLarge
                                                    .override(
                                                      font: GoogleFonts.inter(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyLarge
                                                                .fontStyle,
                                                      ),
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .info,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyLarge
                                                              .fontStyle,
                                                    ),
                                              ),
                                              TextSpan(
                                                text: ' | ',
                                                style: TextStyle(),
                                              ),
                                              TextSpan(
                                                text: dateTimeFormat(
                                                    "yMMMd", _model.datePicked),
                                                style: TextStyle(),
                                              )
                                            ],
                                            style: FlutterFlowTheme.of(context)
                                                .bodyLarge
                                                .override(
                                                  font: GoogleFonts.inter(
                                                    fontWeight: FontWeight.w500,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyLarge
                                                            .fontStyle,
                                                  ),
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .info,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w500,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyLarge
                                                          .fontStyle,
                                                ),
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    if (_model.datePicked == null)
                                      Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: Text(
                                          'Tap to fill details',
                                          textAlign: TextAlign.center,
                                          style: FlutterFlowTheme.of(context)
                                              .bodyLarge
                                              .override(
                                                font: GoogleFonts.inter(
                                                  fontWeight: FontWeight.w500,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyLarge
                                                          .fontStyle,
                                                ),
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .info,
                                                fontSize: 18.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w500,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyLarge
                                                        .fontStyle,
                                              ),
                                        ),
                                      ),

                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 80, // 👈 FIXED WIDTH

                            child: InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                // Direct navigation without any conditions
                                context.pushNamed(TransportMode4Widget.routeName);  // 👈 NEXT SCREEN

                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),

                                decoration: BoxDecoration(

                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(30.0), // 👈 RECTANGLE CIRCLE (rounded rectangle)
                                  border: Border.all(
                                    color: FlutterFlowTheme.of(context).otherColour, // 👈 TERNARY COLOR
                                    width: 1.5,
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
                                  child: Text(
                                    'Skip',
                                    textAlign: TextAlign.center,
                                    style: FlutterFlowTheme.of(context).bodyLarge.override(
                                      font: GoogleFonts.inter(
                                        fontWeight: FontWeight.w500,
                                      ),
                                      color: FlutterFlowTheme.of(context).otherColour, // 👈 TERNARY COLOR
                                      fontSize: 16.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ].divide(SizedBox(height: 10.0)),
                      ),
                    ),
                  ),
                ),
                if (_model.datePicked != null)
                  Align(
                    alignment: AlignmentDirectional(1.0, 1.0),
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 24.0),
                      child: InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        // onTap: () async {
                        //   if (_model.datePicked != null) {
                        //     FFAppState().DropTime = _model.datePicked;
                        //     safeSetState(() {});
                        //
                        //     context.pushNamed(TransportMode4Widget.routeName);
                        //   } else {
                        //     await showDialog(
                        //       context: context,
                        //       builder: (alertDialogContext) {
                        //         return AlertDialog(
                        //           title: Text('Attention'),
                        //           content: Text(
                        //               'Please Select Ride End Date & Time'),
                        //           actions: [
                        //             TextButton(
                        //               onPressed: () =>
                        //                   Navigator.pop(alertDialogContext),
                        //               child: Text('Ok'),
                        //             ),
                        //           ],
                        //         );
                        //       },
                        //     );
                        //   }
                        // },
                        onTap: () async {
                          // 👈 VALIDATION 1: END DATE SELECTED?
                          if (_model.datePicked == null) {
                            await showDialog(
                              context: context,
                              builder: (alertDialogContext) {
                                return AlertDialog(
                                  title: Text('Attention'),
                                  content: Text('Please Select Ride End Date & Time'),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(alertDialogContext),
                                      child: Text('Ok'),
                                    ),
                                  ],
                                );
                              },
                            );
                            return;
                          }

                          // 👈 VALIDATION 2: START DATE EXISTS?
                          if (FFAppState().pickupTime == null) {
                            await showDialog(
                              context: context,
                              builder: (alertDialogContext) {
                                return AlertDialog(
                                  title: Text('Error'),
                                  content: Text('Please select Start Date first!'),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(alertDialogContext),
                                      child: Text('Ok'),
                                    ),
                                  ],
                                );
                              },
                            );
                            return;
                          }

                          // 👈 VALIDATION 3: END DATE >= START DATE?
                          if (_model.datePicked!.isBefore(FFAppState().pickupTime!)) {
                            await showDialog(
                              context: context,
                              builder: (alertDialogContext) {
                                return Dialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  elevation: 10,
                                  child: Container(
                                    padding: EdgeInsets.all(24),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          FlutterFlowTheme.of(context).primaryBackground,
                                          FlutterFlowTheme.of(context).alternate,
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color(0x1A000000),
                                          blurRadius: 20,
                                          offset: Offset(0, 10),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        // 👈 ICON
                                        Container(
                                          padding: EdgeInsets.all(16),
                                          decoration: BoxDecoration(
                                            color: Color(0xFFE69A6A).withOpacity(0.2),
                                            shape: BoxShape.circle,
                                          ),
                                          child: Icon(
                                            Icons.schedule_outlined,
                                            size: 32,
                                            color: Color(0xFFE69A6A),
                                          ),
                                        ),
                                        SizedBox(height: 16),

                                        // 👈 TITLE
                                        Text(
                                          'Invalid Date Range',
                                          style: FlutterFlowTheme.of(context).titleMedium.override(
                                            fontWeight: FontWeight.bold,
                                            color: FlutterFlowTheme.of(context).primaryText,
                                            fontSize: 18,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        SizedBox(height: 12),

                                        // 👈 DATES COMPARISON
                                        Container(
                                          padding: EdgeInsets.all(16),
                                          decoration: BoxDecoration(
                                            color: Colors.white.withOpacity(0.7),
                                            borderRadius: BorderRadius.circular(12),
                                            border: Border.all(color: Color(0xFFE69A6A).withOpacity(0.3)),
                                          ),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Icon(Icons.access_time, color: Colors.green, size: 18),
                                                  SizedBox(width: 8),
                                                  Expanded(
                                                    child: Text(
                                                      'Start: ${DateFormat('MMM d, yyyy \'at\' HH:mm').format(FFAppState().pickupTime!)}',
                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                        fontWeight: FontWeight.w600,
                                                        color: Colors.green.shade700,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 8),
                                              Row(
                                                children: [
                                                  Icon(Icons.access_time, color: Colors.red, size: 18),
                                                  SizedBox(width: 8),
                                                  Expanded(
                                                    child: Text(
                                                      'End: ${DateFormat('MMM d, yyyy \'at\' HH:mm').format(_model.datePicked!)}',
                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                        fontWeight: FontWeight.w600,
                                                        color: Colors.red.shade700,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 20),

                                        // 👈 MESSAGE
                                        Text(
                                          'End date must be after the start date',
                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                            color: FlutterFlowTheme.of(context).secondaryText,
                                            fontSize: 14,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        SizedBox(height: 24),

                                        // 👈 BUTTON
                                        SizedBox(
                                          width: double.infinity,
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Color(0xFFE69A6A),
                                              foregroundColor: Colors.white,
                                              padding: EdgeInsets.symmetric(vertical: 12),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(12),
                                              ),
                                              elevation: 2,
                                            ),
                                            onPressed: () => Navigator.pop(alertDialogContext),
                                            child:Text(
                                              'Got it!',
                                              style: FlutterFlowTheme.of(context).titleSmall.override(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,  // 👈 WHITE TEXT!
                                                fontStyle: FontStyle.normal,
                                              ),
                                            ),

                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                            return;
                          }

                          // ✅ ALL VALIDATIONS PASSED!
                          FFAppState().DropTime = _model.datePicked;  // 👈 SAVE END DATE
                          safeSetState(() {});

                          context.pushNamed(TransportMode4Widget.routeName);  // 👈 NEXT SCREEN
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
