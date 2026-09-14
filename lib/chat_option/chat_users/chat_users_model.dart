import '/flutter_flow/flutter_flow_util.dart';
import '/pages/sidebar_menu/sidebar_menu_model.dart';
import 'chat_users_widget.dart' show ChatUsersWidget;
import 'package:flutter/material.dart';

class ChatUsersModel extends FlutterFlowModel<ChatUsersWidget> {
  // Model for sidebarMenu component.
  late SidebarMenuModel sidebarMenuModel;

  // State fields for search
  FocusNode? searchFocusNode;
  TextEditingController? searchTextController;

  @override
  void initState(BuildContext context) {
    sidebarMenuModel = createModel(context, () => SidebarMenuModel());
  }

  @override
  void dispose() {
    sidebarMenuModel.dispose();
    searchFocusNode?.dispose();
    searchTextController?.dispose();
  }
}
