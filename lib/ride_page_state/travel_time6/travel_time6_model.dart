import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'travel_time6_widget.dart' show TravelTime6Widget;
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

class TravelTime6Model extends FlutterFlowModel<TravelTime6Widget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for travelTime widget.
  FocusNode? travelTimeFocusNode;
  TextEditingController? travelTimeTextController;
  String? Function(BuildContext, String?)? travelTimeTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    travelTimeFocusNode?.dispose();
    travelTimeTextController?.dispose();
  }
}
