import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'cary_items5_widget.dart' show CaryItems5Widget;
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

class CaryItems5Model extends FlutterFlowModel<CaryItems5Widget> {
  ///  Local state fields for this page.

  List<String> items11 = [];
  void addToItems11(String item) => items11.add(item);
  void removeFromItems11(String item) => items11.remove(item);
  void removeAtIndexFromItems11(int index) => items11.removeAt(index);
  void insertAtIndexInItems11(int index, String item) =>
      items11.insert(index, item);
  void updateItems11AtIndex(int index, Function(String) updateFn) =>
      items11[index] = updateFn(items11[index]);

  ///  State fields for stateful widgets in this page.

  // State field(s) for items widget.
  FocusNode? itemsFocusNode;
  TextEditingController? itemsTextController;
  String? Function(BuildContext, String?)? itemsTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    itemsFocusNode?.dispose();
    itemsTextController?.dispose();
  }
}
