import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'third_widget.dart' show ThirdWidget;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

class ThirdModel extends FlutterFlowModel<ThirdWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for parcelDelivery widget.
  FocusNode? parcelDeliveryFocusNode;
  TextEditingController? parcelDeliveryTextController;
  String? Function(BuildContext, String?)?
      parcelDeliveryTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    parcelDeliveryFocusNode?.dispose();
    parcelDeliveryTextController?.dispose();
  }
}
