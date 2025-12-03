import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'parcel_cost6_widget.dart' show ParcelCost6Widget;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

class ParcelCost6Model extends FlutterFlowModel<ParcelCost6Widget> {
  ///  Local state fields for this page.

  List<String> itttems = [];
  void addToItttems(String item) => itttems.add(item);
  void removeFromItttems(String item) => itttems.remove(item);
  void removeAtIndexFromItttems(int index) => itttems.removeAt(index);
  void insertAtIndexInItttems(int index, String item) =>
      itttems.insert(index, item);
  void updateItttemsAtIndex(int index, Function(String) updateFn) =>
      itttems[index] = updateFn(itttems[index]);

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
