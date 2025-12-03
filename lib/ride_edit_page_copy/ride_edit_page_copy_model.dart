import '/compotement/termsconditions11/termsconditions11_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'ride_edit_page_copy_widget.dart' show RideEditPageCopyWidget;
import 'package:expandable/expandable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

class RideEditPageCopyModel extends FlutterFlowModel<RideEditPageCopyWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for Expandable widget.
  late ExpandableController expandableExpandableController1;

  // State field(s) for Expandable widget.
  late ExpandableController expandableExpandableController2;

  // State field(s) for Expandable widget.
  late ExpandableController expandableExpandableController3;

  // State field(s) for Expandable widget.
  late ExpandableController expandableExpandableController4;

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode1;
  TextEditingController? textController1;
  String? Function(BuildContext, String?)? textController1Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode2;
  TextEditingController? textController2;
  String? Function(BuildContext, String?)? textController2Validator;
  DateTime? datePicked1;
  DateTime? datePicked2;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode3;
  TextEditingController? textController3;
  String? Function(BuildContext, String?)? textController3Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode4;
  TextEditingController? textController4;
  String? Function(BuildContext, String?)? textController4Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode5;
  TextEditingController? textController5;
  String? Function(BuildContext, String?)? textController5Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode6;
  TextEditingController? textController6;
  String? Function(BuildContext, String?)? textController6Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode7;
  TextEditingController? textController7;
  String? Function(BuildContext, String?)? textController7Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode8;
  TextEditingController? textController8;
  String? Function(BuildContext, String?)? textController8Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode9;
  TextEditingController? textController9;
  String? Function(BuildContext, String?)? textController9Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode10;
  TextEditingController? textController10;
  String? Function(BuildContext, String?)? textController10Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode11;
  TextEditingController? textController11;
  String? Function(BuildContext, String?)? textController11Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode12;
  TextEditingController? textController12;
  String? Function(BuildContext, String?)? textController12Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode13;
  TextEditingController? textController13;
  String? Function(BuildContext, String?)? textController13Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode14;
  TextEditingController? textController14;
  String? Function(BuildContext, String?)? textController14Validator;
  // State field(s) for travelTime widget.
  FocusNode? travelTimeFocusNode;
  TextEditingController? travelTimeTextController;
  String? Function(BuildContext, String?)? travelTimeTextControllerValidator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode15;
  TextEditingController? textController16;
  String? Function(BuildContext, String?)? textController16Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode16;
  TextEditingController? textController17;
  String? Function(BuildContext, String?)? textController17Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode17;
  TextEditingController? textController18;
  String? Function(BuildContext, String?)? textController18Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode18;
  TextEditingController? textController19;
  String? Function(BuildContext, String?)? textController19Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode19;
  TextEditingController? textController20;
  String? Function(BuildContext, String?)? textController20Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode20;
  TextEditingController? textController21;
  String? Function(BuildContext, String?)? textController21Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode21;
  TextEditingController? textController22;
  String? Function(BuildContext, String?)? textController22Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode22;
  TextEditingController? textController23;
  String? Function(BuildContext, String?)? textController23Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode23;
  TextEditingController? textController24;
  String? Function(BuildContext, String?)? textController24Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode24;
  TextEditingController? textController25;
  String? Function(BuildContext, String?)? textController25Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode25;
  TextEditingController? textController26;
  String? Function(BuildContext, String?)? textController26Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode26;
  TextEditingController? textController27;
  String? Function(BuildContext, String?)? textController27Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode27;
  TextEditingController? textController28;
  String? Function(BuildContext, String?)? textController28Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode28;
  TextEditingController? textController29;
  String? Function(BuildContext, String?)? textController29Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode29;
  TextEditingController? textController30;
  String? Function(BuildContext, String?)? textController30Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode30;
  TextEditingController? textController31;
  String? Function(BuildContext, String?)? textController31Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode31;
  TextEditingController? textController32;
  String? Function(BuildContext, String?)? textController32Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode32;
  TextEditingController? textController33;
  String? Function(BuildContext, String?)? textController33Validator;
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
    expandableExpandableController2.dispose();
    expandableExpandableController3.dispose();
    expandableExpandableController4.dispose();
    textFieldFocusNode1?.dispose();
    textController1?.dispose();

    textFieldFocusNode2?.dispose();
    textController2?.dispose();

    textFieldFocusNode3?.dispose();
    textController3?.dispose();

    textFieldFocusNode4?.dispose();
    textController4?.dispose();

    textFieldFocusNode5?.dispose();
    textController5?.dispose();

    textFieldFocusNode6?.dispose();
    textController6?.dispose();

    textFieldFocusNode7?.dispose();
    textController7?.dispose();

    textFieldFocusNode8?.dispose();
    textController8?.dispose();

    textFieldFocusNode9?.dispose();
    textController9?.dispose();

    textFieldFocusNode10?.dispose();
    textController10?.dispose();

    textFieldFocusNode11?.dispose();
    textController11?.dispose();

    textFieldFocusNode12?.dispose();
    textController12?.dispose();

    textFieldFocusNode13?.dispose();
    textController13?.dispose();

    textFieldFocusNode14?.dispose();
    textController14?.dispose();

    travelTimeFocusNode?.dispose();
    travelTimeTextController?.dispose();

    textFieldFocusNode15?.dispose();
    textController16?.dispose();

    textFieldFocusNode16?.dispose();
    textController17?.dispose();

    textFieldFocusNode17?.dispose();
    textController18?.dispose();

    textFieldFocusNode18?.dispose();
    textController19?.dispose();

    textFieldFocusNode19?.dispose();
    textController20?.dispose();

    textFieldFocusNode20?.dispose();
    textController21?.dispose();

    textFieldFocusNode21?.dispose();
    textController22?.dispose();

    textFieldFocusNode22?.dispose();
    textController23?.dispose();

    textFieldFocusNode23?.dispose();
    textController24?.dispose();

    textFieldFocusNode24?.dispose();
    textController25?.dispose();

    textFieldFocusNode25?.dispose();
    textController26?.dispose();

    textFieldFocusNode26?.dispose();
    textController27?.dispose();

    textFieldFocusNode27?.dispose();
    textController28?.dispose();

    textFieldFocusNode28?.dispose();
    textController29?.dispose();

    textFieldFocusNode29?.dispose();
    textController30?.dispose();

    textFieldFocusNode30?.dispose();
    textController31?.dispose();

    textFieldFocusNode31?.dispose();
    textController32?.dispose();

    textFieldFocusNode32?.dispose();
    textController33?.dispose();

    driverContactnumberFocusNode?.dispose();
    driverContactnumberTextController?.dispose();

    vehicleNumberFocusNode?.dispose();
    vehicleNumberTextController?.dispose();
  }
}
