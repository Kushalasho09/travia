import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'ride_location1_widget.dart' show RideLocation1Widget;
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class RideLocation1Model extends FlutterFlowModel<RideLocation1Widget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for RideStartLocation widget.
  FocusNode? rideStartLocationFocusNode;
  // TextEditingController? rideStartLocationTextController;
  late TextEditingController rideStartLocationTextController;
  late TextEditingController rideEndLocationTextController;
  String? Function(BuildContext, String?)?
      rideStartLocationTextControllerValidator;
  // State field(s) for RideEndLocation widget.
  FocusNode? rideEndLocationFocusNode;
  // TextEditingController? rideEndLocationTextController;
  String? Function(BuildContext, String?)?
      rideEndLocationTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    rideStartLocationFocusNode?.dispose();
    rideStartLocationTextController.dispose();

    rideEndLocationFocusNode?.dispose();
    rideEndLocationTextController.dispose();
  }

  /// Action blocks.
  Future lsls(BuildContext context) async {
    await lsls(context);
  }
}
