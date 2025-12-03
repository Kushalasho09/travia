import '/auth/firebase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'market_ride_widget.dart' show MarketRideWidget;
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MarketRideModel extends FlutterFlowModel<MarketRideWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for NameoftheProducts widget.
  FocusNode? nameoftheProductsFocusNode;
  TextEditingController? nameoftheProductsTextController;
  String? Function(BuildContext, String?)?
      nameoftheProductsTextControllerValidator;
  // State field(s) for Origin widget.
  FocusNode? originFocusNode;
  TextEditingController? originTextController;
  String? Function(BuildContext, String?)? originTextControllerValidator;
  // State field(s) for Destination widget.
  FocusNode? destinationFocusNode;
  TextEditingController? destinationTextController;
  String? Function(BuildContext, String?)? destinationTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    nameoftheProductsFocusNode?.dispose();
    nameoftheProductsTextController?.dispose();

    originFocusNode?.dispose();
    originTextController?.dispose();

    destinationFocusNode?.dispose();
    destinationTextController?.dispose();
  }
}
