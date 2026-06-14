import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import 'dart:ui';
import 'personal_k_y_c_widget.dart' show PersonalKYCWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PersonalKYCModel extends FlutterFlowModel<PersonalKYCWidget> {
  ///  State fields for stateful widgets in this page.

  bool isDataUploading_uploadData1pv = false;
  FFUploadedFile uploadedLocalFile_uploadData1pv =
      FFUploadedFile(bytes: Uint8List.fromList([]), originalFilename: '');
  String uploadedFileUrl_uploadData1pv = '';

  bool isDataUploading_uploadDataUud = false;
  FFUploadedFile uploadedLocalFile_uploadDataUud =
      FFUploadedFile(bytes: Uint8List.fromList([]), originalFilename: '');
  String uploadedFileUrl_uploadDataUud = '';

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
