import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'add_rating_widget.dart' show AddRatingWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AddRatingModel extends FlutterFlowModel<AddRatingWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for RatingBar widget.
  double? ratingBarValue;
  // State field(s) for reviewWords widget.
  FocusNode? reviewWordsFocusNode;
  TextEditingController? reviewWordsTextController;
  String? Function(BuildContext, String?)? reviewWordsTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    reviewWordsFocusNode?.dispose();
    reviewWordsTextController?.dispose();
  }
}
