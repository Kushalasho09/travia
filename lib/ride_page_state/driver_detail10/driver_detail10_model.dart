import '/auth/firebase_auth/auth_util.dart';
import '/compotement/termsconditions11/termsconditions11_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'driver_detail10_widget.dart' show DriverDetail10Widget;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

class DriverDetail10Model extends FlutterFlowModel<DriverDetail10Widget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for driverContactnumber widget.
  FocusNode? driverContactnumberFocusNode;
  TextEditingController? driverContactnumberTextController;
  late MaskTextInputFormatter driverContactnumberMask;
  String? Function(BuildContext, String?)?
      driverContactnumberTextControllerValidator;
  // State field(s) for vehicleNumber widget.
  FocusNode? vehicleNumberFocusNode;
  TextEditingController? vehicleNumberTextController;
  String? Function(BuildContext, String?)? vehicleNumberTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    driverContactnumberFocusNode?.dispose();
    driverContactnumberTextController?.dispose();

    vehicleNumberFocusNode?.dispose();
    vehicleNumberTextController?.dispose();
  }
}
