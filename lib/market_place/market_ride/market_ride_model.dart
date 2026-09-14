import '/flutter_flow/flutter_flow_util.dart';
import 'market_ride_widget.dart' show MarketRideWidget;
import 'package:flutter/material.dart';

class MarketRideModel extends FlutterFlowModel<MarketRideWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for NameoftheProducts widget.
  FocusNode? nameoftheProductsFocusNode;
  TextEditingController? nameoftheProductsTextController;
  String? Function(BuildContext, String?)?
      nameoftheProductsTextControllerValidator;
  // State field(s) for Origin widget.
  FocusNode? originFocusNode;
  // TextEditingController? originTextController;
  late TextEditingController originTextController;
  late TextEditingController destinationTextController;

  String? Function(BuildContext, String?)? originTextControllerValidator;
  // State field(s) for Destination widget.
  FocusNode? destinationFocusNode;
  // TextEditingController? destinationTextController;
  String? Function(BuildContext, String?)? destinationTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    nameoftheProductsFocusNode?.dispose();
    nameoftheProductsTextController?.dispose();

    originFocusNode?.dispose();
    originTextController.dispose();

    destinationFocusNode?.dispose();
    destinationTextController.dispose();
  }
}
