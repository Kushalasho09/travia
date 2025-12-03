import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/bid_posted_thanks_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'send_parcel_widget.dart' show SendParcelWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SendParcelModel extends FlutterFlowModel<SendParcelWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for itemName widget.
  FocusNode? itemNameFocusNode;
  TextEditingController? itemNameTextController;
  String? Function(BuildContext, String?)? itemNameTextControllerValidator;
  // State field(s) for reciverName widget.
  FocusNode? reciverNameFocusNode;
  TextEditingController? reciverNameTextController;
  String? Function(BuildContext, String?)? reciverNameTextControllerValidator;
  // State field(s) for phoneNumber widget.
  FocusNode? phoneNumberFocusNode;
  TextEditingController? phoneNumberTextController;
  String? Function(BuildContext, String?)? phoneNumberTextControllerValidator;
  // State field(s) for address widget.
  FocusNode? addressFocusNode;
  TextEditingController? addressTextController;
  String? Function(BuildContext, String?)? addressTextControllerValidator;
  // State field(s) for additionalInformation widget.
  FocusNode? additionalInformationFocusNode;
  TextEditingController? additionalInformationTextController;
  String? Function(BuildContext, String?)?
      additionalInformationTextControllerValidator;
  // State field(s) for Checkbox widget.
  bool? checkboxValue;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    itemNameFocusNode?.dispose();
    itemNameTextController?.dispose();

    reciverNameFocusNode?.dispose();
    reciverNameTextController?.dispose();

    phoneNumberFocusNode?.dispose();
    phoneNumberTextController?.dispose();

    addressFocusNode?.dispose();
    addressTextController?.dispose();

    additionalInformationFocusNode?.dispose();
    additionalInformationTextController?.dispose();
  }
}
