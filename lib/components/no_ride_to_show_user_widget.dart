import '../user_look/home/home_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'no_ride_to_show_user_model.dart';
export 'no_ride_to_show_user_model.dart';

class NoRideToShowUserWidget extends StatefulWidget {
  final Function(DateTime)? onDateChanged; // 👈 CALLBACK!

  const NoRideToShowUserWidget({super.key, this.onDateChanged});

  @override
  State<NoRideToShowUserWidget> createState() => _NoRideToShowUserWidgetState();
}

class _NoRideToShowUserWidgetState extends State<NoRideToShowUserWidget> {
  late NoRideToShowUserModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NoRideToShowUserModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '☹️',
                    textAlign: TextAlign.center,
                    style:
                        FlutterFlowTheme.of(context).headlineSmall.override(
                              font: GoogleFonts.interTight(
                                fontWeight: FlutterFlowTheme.of(context)
                                    .headlineSmall
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .headlineSmall
                                    .fontStyle,
                              ),
                              fontSize: 80.0,
                              letterSpacing: 0.0,
                              fontWeight: FlutterFlowTheme.of(context)
                                  .headlineSmall
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .headlineSmall
                                  .fontStyle,
                            ),
                  ),
                  Text(
                    'No Listings Available',
                    textAlign: TextAlign.center,
                    style:
                        FlutterFlowTheme.of(context).headlineSmall.override(
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
                  Text(
                    'Sorry! There are currently no marketplace listings available for your selected location or category.',
                    textAlign: TextAlign.center,
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          font: GoogleFonts.inter(
                            fontWeight: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                          color: FlutterFlowTheme.of(context).secondaryText,
                          letterSpacing: 0.0,
                          fontWeight: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .fontWeight,
                          fontStyle: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .fontStyle,
                        ),
                  ),
                ].divide(SizedBox(height: 8.0)),
              ),
              // Column(
              //   mainAxisSize: MainAxisSize.min,
              //   children: [
              //     FFButtonWidget(
              //       onPressed: () async {
              //         final selectedDate = await showDatePicker(
              //           context: context,
              //           initialDate: DateTime.now(), // 👈 No model dependency
              //           firstDate: DateTime.now(),
              //           lastDate: DateTime.now().add(Duration(days: 30)),
              //         );
              //
              //         if (selectedDate != null) {
              //           // 👈 Store in LOCAL variable (works everywhere!)
              //           final pickedDate = DateTime(selectedDate.year, selectedDate.month, selectedDate.day);
              //
              //           ScaffoldMessenger.of(context).showSnackBar(
              //             SnackBar(content: Text('Selected: ${dateTimeFormat("MMM dd", pickedDate)}')),
              //           );
              //
              //           // 👈 Trigger parent refresh (FlutterFlow safe!)
              //           context.read<NoRideToShowUserModel>().update(() {
              //             // Model will refresh parent StreamBuilder
              //           });
              //         }
              //       },
              //       text: '📅 Change Date',
              //       options: FFButtonOptions(
              //         width: double.infinity,
              //         height: 52,
              //         color: FlutterFlowTheme.of(context).primary,
              //         textStyle: FlutterFlowTheme.of(context).titleSmall.override(color: Colors.white),
              //         elevation: 3,
              //         borderRadius: BorderRadius.circular(12),
              //       ),
              //     ),
              //     SizedBox(height: 16),
              //     FFButtonWidget(
              //       onPressed: () {
              //         // 👈 Simple refresh - no model vars needed!
              //         ScaffoldMessenger.of(context).showSnackBar(
              //           SnackBar(
              //             content: Text('🔄 Refreshing rides...'),
              //             backgroundColor: Colors.green,
              //           ),
              //         );
              //
              //         // 👈 FlutterFlow auto-refreshes StreamBuilder
              //         setState(() {});
              //       },
              //       text: '🔍 Try Again',
              //       options: FFButtonOptions(
              //         width: double.infinity,
              //         height: 52,
              //         color: Colors.green.shade600,
              //         textStyle: FlutterFlowTheme.of(context).titleSmall.override(color: Colors.white),
              //         elevation: 3,
              //         borderRadius: BorderRadius.circular(12),
              //       ),
              //     ),
              //   ],
              // ),

              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FFButtonWidget(
                    onPressed: () async {
                      final pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now().subtract(Duration(days: 7)), // 👈 Past 7 days too!
                        lastDate: DateTime.now().add(Duration(days: 30)),
                      );

                      if (pickedDate != null) {
                        // 👈 NORMALIZE TO START OF DAY!
                        final normalizedDate = DateTime(
                            pickedDate.year,
                            pickedDate.month,
                            pickedDate.day,
                            0, 0, 0  // 👈 00:00:00
                        );

                        print('📅 NoRide DatePicker: $normalizedDate');

                        // 👈 CALL PARENT CALLBACK!
                        widget.onDateChanged?.call(normalizedDate);

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('📅 Date set to ${dateTimeFormat("dd MMM yyyy", normalizedDate)}'),
                            backgroundColor: Colors.blue.shade600,
                            duration: Duration(seconds: 3),
                          ),
                        );
                      }
                    },
                    text: '📅 Change Date',
                    options: FFButtonOptions(
                      width: double.infinity,
                      height: 50,
                      padding: EdgeInsets.all(16),
                      color: FlutterFlowTheme.of(context).primary,
                      textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                      elevation: 3,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  SizedBox(height: 12),
                  FFButtonWidget(
                    onPressed: () {
                      // 👈 REFRESH CURRENT DATE (or today)
                      final currentDate = DateTime.now();
                      final normalizedToday = DateTime(
                          currentDate.year,
                          currentDate.month,
                          currentDate.day,
                          0, 0, 0
                      );

                      widget.onDateChanged?.call(normalizedToday);


                      // 👈 SAFE SNACKBAR!
                      if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Searching rides for today...'),
                            backgroundColor: FlutterFlowTheme.of(context).tertiary,
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }

                    },
                    text: '🔄 Try Again',
                    options: FFButtonOptions(
                      width: double.infinity,
                      height: 50,
                      padding: EdgeInsets.all(16),
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                        color: FlutterFlowTheme.of(context).primary,
                        fontWeight: FontWeight.w700,
                      ),
                      elevation: 2,
                      borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).primary,
                          width: 2
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ],
              ),
            ].divide(SizedBox(height: 16.0)),
          ),
        ),
      ),
    );
  }
}
