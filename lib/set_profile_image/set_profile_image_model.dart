import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import 'dart:ui';
import '/index.dart';
import 'set_profile_image_widget.dart' show SetProfileImageWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SetProfileImageModel extends FlutterFlowModel<SetProfileImageWidget> {
  ///  State fields for stateful widgets in this page.

  bool isDataUploading_uploadDataK69 = false;
  FFUploadedFile uploadedLocalFile_uploadDataK69 =
      FFUploadedFile(bytes: Uint8List.fromList([]), originalFilename: '');
  String uploadedFileUrl_uploadDataK69 = '';

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
