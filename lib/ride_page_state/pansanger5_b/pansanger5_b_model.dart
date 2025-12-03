import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:ui';
import '/index.dart';
import 'pansanger5_b_widget.dart' show Pansanger5BWidget;
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

class Pansanger5BModel extends FlutterFlowModel<Pansanger5BWidget> {
  ///  Local state fields for this page.

  String isPassangerAllowed = 'NotSet';

  ///  State fields for stateful widgets in this page.

  // State field(s) for isPassangersAllowed widget.
  String? isPassangersAllowedValue;
  FormFieldController<String>? isPassangersAllowedValueController;
  // State field(s) for numOfpass widget.
  FocusNode? numOfpassFocusNode;
  TextEditingController? numOfpassTextController;
  String? Function(BuildContext, String?)? numOfpassTextControllerValidator;
  // State field(s) for price widget.
  FocusNode? priceFocusNode;
  TextEditingController? priceTextController;
  late MaskTextInputFormatter priceMask;
  String? Function(BuildContext, String?)? priceTextControllerValidator;
  // State field(s) for bags widget.
  FocusNode? bagsFocusNode;
  TextEditingController? bagsTextController;
  String? Function(BuildContext, String?)? bagsTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    numOfpassFocusNode?.dispose();
    numOfpassTextController?.dispose();

    priceFocusNode?.dispose();
    priceTextController?.dispose();

    bagsFocusNode?.dispose();
    bagsTextController?.dispose();
  }
}
