import '/flutter_flow/flutter_flow_util.dart';
import '/pages/sidebar_menu/sidebar_menu_model.dart';
import 'chat_widget.dart' show ChatWidget;
import 'package:flutter/material.dart';

class ChatModel extends FlutterFlowModel<ChatWidget> {
  ///  State fields for stateful widgets in this page.

  bool isDataUploading_uploadData5vy = false;
  FFUploadedFile uploadedLocalFile_uploadData5vy =
      FFUploadedFile(bytes: Uint8List.fromList([]), originalFilename: '');
  String uploadedFileUrl_uploadData5vy = '';

  // State field(s) for messageBox widget.
  FocusNode? messageBoxFocusNode;
  TextEditingController? messageBoxTextController;
  String? Function(BuildContext, String?)? messageBoxTextControllerValidator;
  late SidebarMenuModel sidebarMenuModel;

  @override
  void initState(BuildContext context) {
    sidebarMenuModel = createModel(context, () => SidebarMenuModel());
  }

  @override
  void dispose() {
    messageBoxFocusNode?.dispose();
    messageBoxTextController?.dispose();
    sidebarMenuModel.dispose();
  }
}
