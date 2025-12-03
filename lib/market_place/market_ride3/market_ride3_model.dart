import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/components/thank_you_market_place_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import 'dart:ui';
import '/index.dart';
import 'market_ride3_widget.dart' show MarketRide3Widget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MarketRide3Model extends FlutterFlowModel<MarketRide3Widget> {
  ///  State fields for stateful widgets in this page.

  bool isDataUploading_uploadDataCdwjvinsuh = false;
  FFUploadedFile uploadedLocalFile_uploadDataCdwjvinsuh =
      FFUploadedFile(bytes: Uint8List.fromList([]), originalFilename: '');
  String uploadedFileUrl_uploadDataCdwjvinsuh = '';

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
