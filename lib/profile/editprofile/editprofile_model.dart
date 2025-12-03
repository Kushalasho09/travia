import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/flutter_flow/upload_data.dart';
import 'dart:ui';
import '/index.dart';
import 'editprofile_widget.dart' show EditprofileWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

class EditprofileModel extends FlutterFlowModel<EditprofileWidget> {
  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  bool isDataUploading_uploadDataZt4 = false;
  FFUploadedFile uploadedLocalFile_uploadDataZt4 =
      FFUploadedFile(bytes: Uint8List.fromList([]), originalFilename: '');
  String uploadedFileUrl_uploadDataZt4 = '';

  // State field(s) for NameUser widget.
  FocusNode? nameUserFocusNode;
  TextEditingController? nameUserTextController;
  String? Function(BuildContext, String?)? nameUserTextControllerValidator;
  String? _nameUserTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Enter your full name is required';
    }

    return null;
  }
  FocusNode? emailUserFocusNode;
  TextEditingController? emailUserTextController;
  String? Function(BuildContext, String?)? emailUserTextControllerValidator;
  String? _emailUserTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Enter your Email is required';
    }

    return null;
  }

  // State field(s) for MobileNuberUser widget.
  FocusNode? mobileNuberUserFocusNode;
  TextEditingController? mobileNuberUserTextController;
  late MaskTextInputFormatter mobileNuberUserMask;
  String? Function(BuildContext, String?)?
      mobileNuberUserTextControllerValidator;
  String? _mobileNuberUserTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Enter Your Mobile Number is required';
    }

    if (val.length < 10) {
      return 'Requires at least 10 characters.';
    }
    if (val.length > 13) {
      return 'Maximum 13 characters allowed, currently ${val.length}.';
    }

    return null;
  }

  // State field(s) for AddharNumberUser widget.
  FocusNode? addharNumberUserFocusNode;
  TextEditingController? addharNumberUserTextController;
  late MaskTextInputFormatter addharNumberUserMask;
  String? Function(BuildContext, String?)?
      addharNumberUserTextControllerValidator;
  // State field(s) for DOB widget.
  FocusNode? dobFocusNode;
  TextEditingController? dobTextController;
  late MaskTextInputFormatter dobMask;
  String? Function(BuildContext, String?)? dobTextControllerValidator;
  // State field(s) for street widget.
  FocusNode? streetFocusNode;
  TextEditingController? streetTextController;
  String? Function(BuildContext, String?)? streetTextControllerValidator;
  // State field(s) for city widget.
  FocusNode? cityFocusNode;
  TextEditingController? cityTextController;
  String? Function(BuildContext, String?)? cityTextControllerValidator;
  // State field(s) for States widget.
  String? statesValue;
  FormFieldController<String>? statesValueController;
  // State field(s) for country widget.
  FocusNode? countryFocusNode;
  TextEditingController? countryTextController;
  String? Function(BuildContext, String?)? countryTextControllerValidator;
  // State field(s) for pinCode widget.
  FocusNode? pinCodeFocusNode;
  TextEditingController? pinCodeTextController;
  String? Function(BuildContext, String?)? pinCodeTextControllerValidator;

  @override
  void initState(BuildContext context) {
    nameUserTextControllerValidator = _nameUserTextControllerValidator;
    mobileNuberUserTextControllerValidator =
        _mobileNuberUserTextControllerValidator;
    emailUserTextControllerValidator = _emailUserTextControllerValidator;
  }

  @override
  void dispose() {
    nameUserFocusNode?.dispose();
    nameUserTextController?.dispose();

    mobileNuberUserFocusNode?.dispose();
    mobileNuberUserTextController?.dispose();

    addharNumberUserFocusNode?.dispose();
    addharNumberUserTextController?.dispose();

    dobFocusNode?.dispose();
    dobTextController?.dispose();

    streetFocusNode?.dispose();
    streetTextController?.dispose();

    cityFocusNode?.dispose();
    cityTextController?.dispose();

    countryFocusNode?.dispose();
    countryTextController?.dispose();

    pinCodeFocusNode?.dispose();
    pinCodeTextController?.dispose();
  }
}
