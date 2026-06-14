import '/auth/firebase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'market_ride2_widget.dart' show MarketRide2Widget;
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MarketRide2Model extends FlutterFlowModel<MarketRide2Widget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for Descriptionoftheitem widget.
  FocusNode? descriptionoftheitemFocusNode;
  TextEditingController? descriptionoftheitemTextController;
  String? Function(BuildContext, String?)?
      descriptionoftheitemTextControllerValidator;
  // State field(s) for Price widget.
  FocusNode? priceFocusNode;
  TextEditingController? priceTextController;
  String? Function(BuildContext, String?)? priceTextControllerValidator;
  // State field(s) for Quantity widget.
  FocusNode? quantityFocusNode;
  TextEditingController? quantityTextController;
  String? Function(BuildContext, String?)? quantityTextControllerValidator;
  DateTime? datePicked;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    descriptionoftheitemFocusNode?.dispose();
    descriptionoftheitemTextController?.dispose();

    priceFocusNode?.dispose();
    priceTextController?.dispose();

    quantityFocusNode?.dispose();
    quantityTextController?.dispose();
  }
}
