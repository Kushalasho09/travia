import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:ui';
import '/index.dart';
import 'first_widget.dart' show FirstWidget;
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

class FirstModel extends FlutterFlowModel<FirstWidget> {
  ///  Local state fields for this page.

  String isPassangerAllowed = 'NotSet';

  ///  State fields for stateful widgets in this page.

  // State field(s) for isCarryPassanger widget.
  String? isCarryPassangerValue;
  FormFieldController<String>? isCarryPassangerValueController;
  // State field(s) for carryParcel widget.
  String? carryParcelValue;
  FormFieldController<String>? carryParcelValueController;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
