import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/no_saved_rides_widget.dart';
import '/compotement/main_footer/main_footer_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:math';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'saved_rides_widget.dart' show SavedRidesWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SavedRidesModel extends FlutterFlowModel<SavedRidesWidget> {
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
