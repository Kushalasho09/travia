import '/flutter_flow/flutter_flow_util.dart';
import 'book_ride_widget.dart' show BookRideWidget;
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

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
  LatLng? meetupLocationMap;
  // State field(s) for additionalInformation widget.
  FocusNode? additionalInformationFocusNode;
  TextEditingController? additionalInformationTextController;
  String? Function(BuildContext, String?)?
      additionalInformationTextControllerValidator;
  // State field(s) for Checkbox widget.
  bool? checkboxValue;
  // State field for Live Tracking toggle.
  bool liveTrackingEnabled = true;

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
