import '/flutter_flow/flutter_flow_util.dart';
import 'phone_number_login_widget.dart' show PhoneNumberLoginWidget;
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class PhoneNumberLoginModel extends FlutterFlowModel<PhoneNumberLoginWidget> {
  ///  Local state fields for this page.

  int? phoneNumber;

  ///  State fields for stateful widgets in this page.

  // State field(s) for PhoneNumber widget.
  FocusNode? phoneNumberFocusNode;
  TextEditingController? phoneNumberTextController;
  MaskTextInputFormatter? phoneNumberMask;
  String? Function(BuildContext, String?)? phoneNumberTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    phoneNumberFocusNode?.dispose();
    phoneNumberTextController?.dispose();
  }
}
