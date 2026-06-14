import '/backend/backend.dart';
import '/components/no_ride_to_show_user_widget.dart';
import '/compotement/main_footer/main_footer_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'search_ride_widget.dart' show SearchRideWidget;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SearchRideModel extends FlutterFlowModel<SearchRideWidget> {
  ///  Local state fields for this page.

  DateTime? pageState;

  ///  State fields for stateful widgets in this page.

  // Model for MainFooter component.
  late MainFooterModel mainFooterModel;

  @override
  void initState(BuildContext context) {
    mainFooterModel = createModel(context, () => MainFooterModel());
  }

  @override
  void dispose() {
    mainFooterModel.dispose();
  }
}
