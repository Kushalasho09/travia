import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/bid_posted_thanks_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_place_picker.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/place.dart';
import 'dart:io';
import 'dart:ui';
import '/index.dart';
import 'edit_bookings_widget.dart' show EditBookingsWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class EditBookingsModel extends FlutterFlowModel<EditBookingsWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for items widget.
  FocusNode? itemsFocusNode;
  TextEditingController? itemsTextController;
  String? Function(BuildContext, String?)? itemsTextControllerValidator;
  // State field(s) for reciverName widget.
  FocusNode? reciverNameFocusNode;
  TextEditingController? reciverNameTextController;
  String? Function(BuildContext, String?)? reciverNameTextControllerValidator;
  // State field(s) for contactNumber widget.
  FocusNode? contactNumberFocusNode;
  TextEditingController? contactNumberTextController;
  String? Function(BuildContext, String?)? contactNumberTextControllerValidator;
  // State field(s) for Address widget.
  FocusNode? addressFocusNode;
  TextEditingController? addressTextController;
  String? Function(BuildContext, String?)? addressTextControllerValidator;
  // State field(s) for PlacePicker widget.
  FFPlace placePickerValue = FFPlace();
  // State field(s) for additionalDetails widget.
  FocusNode? additionalDetailsFocusNode;
  TextEditingController? additionalDetailsTextController;
  String? Function(BuildContext, String?)?
      additionalDetailsTextControllerValidator;
  // State field(s) for Checkbox widget.
  bool? checkboxValue;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    itemsFocusNode?.dispose();
    itemsTextController?.dispose();

    reciverNameFocusNode?.dispose();
    reciverNameTextController?.dispose();

    contactNumberFocusNode?.dispose();
    contactNumberTextController?.dispose();

    addressFocusNode?.dispose();
    addressTextController?.dispose();

    additionalDetailsFocusNode?.dispose();
    additionalDetailsTextController?.dispose();
  }
}
