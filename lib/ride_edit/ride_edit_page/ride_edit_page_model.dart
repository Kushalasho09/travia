import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'package:styled_divider/styled_divider.dart';
import 'ride_edit_page_widget.dart' show RideEditPageWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

class RideEditPageModel extends FlutterFlowModel<RideEditPageWidget> {
  ///  Local state fields for this page.

  List<DocumentReference> stoppages = [];
  void addToStoppages(DocumentReference item) => stoppages.add(item);
  void removeFromStoppages(DocumentReference item) => stoppages.remove(item);
  void removeAtIndexFromStoppages(int index) => stoppages.removeAt(index);
  void insertAtIndexInStoppages(int index, DocumentReference item) =>
      stoppages.insert(index, item);
  void updateStoppagesAtIndex(
          int index, Function(DocumentReference) updateFn) =>
      stoppages[index] = updateFn(stoppages[index]);

  List<String> newStoppages = [];
  void addToNewStoppages(String item) => newStoppages.add(item);
  void removeFromNewStoppages(String item) => newStoppages.remove(item);
  void removeAtIndexFromNewStoppages(int index) => newStoppages.removeAt(index);
  void insertAtIndexInNewStoppages(int index, String item) =>
      newStoppages.insert(index, item);
  void updateNewStoppagesAtIndex(int index, Function(String) updateFn) =>
      newStoppages[index] = updateFn(newStoppages[index]);

  ///  State fields for stateful widgets in this page.

  // State field(s) for Expandable widget.
  late ExpandableController expandableExpandableController1;

  // State field(s) for rideStartLocation widget.
  FocusNode? rideStartLocationFocusNode;
  TextEditingController? rideStartLocationTextController;
  String? Function(BuildContext, String?)?
      rideStartLocationTextControllerValidator;
  // State field(s) for rideEndLocatio widget.
  FocusNode? rideEndLocatioFocusNode;
  TextEditingController? rideEndLocatioTextController;
  String? Function(BuildContext, String?)?
      rideEndLocatioTextControllerValidator;
  // State field(s) for Expandable widget.
  late ExpandableController expandableExpandableController2;

  DateTime? datePicked1;
  DateTime? datePicked2;
  // State field(s) for Expandable widget.
  late ExpandableController expandableExpandableController3;

  // State field(s) for Expandable widget.
  late ExpandableController expandableExpandableController4;

  // State field(s) for fullCost widget.
  FocusNode? fullCostFocusNode;
  TextEditingController? fullCostTextController;
  String? Function(BuildContext, String?)? fullCostTextControllerValidator;
  // State field(s) for Expandable widget.
  late ExpandableController expandableExpandableController5;

  // State field(s) for travelTime widget.
  FocusNode? travelTimeFocusNode;
  TextEditingController? travelTimeTextController;
  String? Function(BuildContext, String?)? travelTimeTextControllerValidator;
  // State field(s) for Expandable widget.
  late ExpandableController expandableExpandableController6;

  // State field(s) for rideRule1 widget.
  FocusNode? rideRule1FocusNode;
  TextEditingController? rideRule1TextController;
  String? Function(BuildContext, String?)? rideRule1TextControllerValidator;
  // State field(s) for rideRule2 widget.
  FocusNode? rideRule2FocusNode;
  TextEditingController? rideRule2TextController;
  String? Function(BuildContext, String?)? rideRule2TextControllerValidator;
  // State field(s) for rideRule3 widget.
  FocusNode? rideRule3FocusNode;
  TextEditingController? rideRule3TextController;
  String? Function(BuildContext, String?)? rideRule3TextControllerValidator;
  // State field(s) for rideRule4 widget.
  FocusNode? rideRule4FocusNode;
  TextEditingController? rideRule4TextController;
  String? Function(BuildContext, String?)? rideRule4TextControllerValidator;
  // State field(s) for rideRule5 widget.
  FocusNode? rideRule5FocusNode;
  TextEditingController? rideRule5TextController;
  String? Function(BuildContext, String?)? rideRule5TextControllerValidator;
  // State field(s) for rideRule6 widget.
  FocusNode? rideRule6FocusNode;
  TextEditingController? rideRule6TextController;
  String? Function(BuildContext, String?)? rideRule6TextControllerValidator;
  // State field(s) for Expandable widget.
  late ExpandableController expandableExpandableController7;

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
    expandableExpandableController1.dispose();
    rideStartLocationFocusNode?.dispose();
    rideStartLocationTextController?.dispose();

    rideEndLocatioFocusNode?.dispose();
    rideEndLocatioTextController?.dispose();

    expandableExpandableController2.dispose();
    expandableExpandableController3.dispose();
    expandableExpandableController4.dispose();
    fullCostFocusNode?.dispose();
    fullCostTextController?.dispose();

    expandableExpandableController5.dispose();
    travelTimeFocusNode?.dispose();
    travelTimeTextController?.dispose();

    expandableExpandableController6.dispose();
    rideRule1FocusNode?.dispose();
    rideRule1TextController?.dispose();

    rideRule2FocusNode?.dispose();
    rideRule2TextController?.dispose();

    rideRule3FocusNode?.dispose();
    rideRule3TextController?.dispose();

    rideRule4FocusNode?.dispose();
    rideRule4TextController?.dispose();

    rideRule5FocusNode?.dispose();
    rideRule5TextController?.dispose();

    rideRule6FocusNode?.dispose();
    rideRule6TextController?.dispose();

    expandableExpandableController7.dispose();
    driverContactnumberFocusNode?.dispose();
    driverContactnumberTextController?.dispose();

    vehicleNumberFocusNode?.dispose();
    vehicleNumberTextController?.dispose();
  }
}
