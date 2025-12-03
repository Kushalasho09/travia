import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:math';
import 'dart:ui';
import '/index.dart';
import 'book_ride_widget.dart' show BookRideWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

class BookRideModel extends FlutterFlowModel<BookRideWidget> {
  ///  Local state fields for this page.

  String bookingFor = 'NotSet';

  ///  State fields for stateful widgets in this page.

  // State field(s) for name widget.
  FocusNode? nameFocusNode;
  TextEditingController? nameTextController;
  String? Function(BuildContext, String?)? nameTextControllerValidator;
  // State field(s) for contactNumber widget.
  FocusNode? contactNumberFocusNode;
  TextEditingController? contactNumberTextController;
  late MaskTextInputFormatter contactNumberMask;
  String? Function(BuildContext, String?)? contactNumberTextControllerValidator;
  // State field(s) for meetupAddress widget.
  FocusNode? meetupAddressFocusNode;
  TextEditingController? meetupAddressTextController;
  String? Function(BuildContext, String?)? meetupAddressTextControllerValidator;
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
    nameFocusNode?.dispose();
    nameTextController?.dispose();

    contactNumberFocusNode?.dispose();
    contactNumberTextController?.dispose();

    meetupAddressFocusNode?.dispose();
    meetupAddressTextController?.dispose();

    additionalInformationFocusNode?.dispose();
    additionalInformationTextController?.dispose();
  }
}
