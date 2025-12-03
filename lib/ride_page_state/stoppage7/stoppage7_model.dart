import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'stoppage7_widget.dart' show Stoppage7Widget;
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

class Stoppage7Model extends FlutterFlowModel<Stoppage7Widget> {
  ///  Local state fields for this page.

  List<String> stoppages = [];
  void addToStoppages(String item) => stoppages.add(item);
  void removeFromStoppages(String item) => stoppages.remove(item);
  void removeAtIndexFromStoppages(int index) => stoppages.removeAt(index);
  void insertAtIndexInStoppages(int index, String item) =>
      stoppages.insert(index, item);
  void updateStoppagesAtIndex(int index, Function(String) updateFn) =>
      stoppages[index] = updateFn(stoppages[index]);

  ///  State fields for stateful widgets in this page.

  // State field(s) for stoppages widget.
  FocusNode? stoppagesFocusNode;
  TextEditingController? stoppagesTextController;
  String? Function(BuildContext, String?)? stoppagesTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    stoppagesFocusNode?.dispose();
    stoppagesTextController?.dispose();
  }
}
