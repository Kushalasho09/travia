import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'add_fund_widget.dart' show AddFundWidget;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AddFundModel extends FlutterFlowModel<AddFundWidget> {
  ///  Local state fields for this page.

  double? amountSet;

  ///  State fields for stateful widgets in this page.

  // State field(s) for AmountSection widget.
  FocusNode? amountSectionFocusNode;
  TextEditingController? amountSectionTextController;
  String? Function(BuildContext, String?)? amountSectionTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    amountSectionFocusNode?.dispose();
    amountSectionTextController?.dispose();
  }
}
