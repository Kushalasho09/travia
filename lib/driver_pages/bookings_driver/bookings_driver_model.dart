import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/compotement/main_footer/main_footer_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/sidebar_menu/sidebar_menu_widget.dart';
import 'dart:math';
import 'dart:ui';
import '/index.dart';
import 'bookings_driver_widget.dart' show BookingsDriverWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class BookingsDriverModel extends FlutterFlowModel<BookingsDriverWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;
  int get tabBarPreviousIndex =>
      tabBarController != null ? tabBarController!.previousIndex : 0;

  // Model for MainFooter component.
  late MainFooterModel mainFooterModel;
  // Model for sidebarMenu component.
  late SidebarMenuModel sidebarMenuModel;

  @override
  void initState(BuildContext context) {
    mainFooterModel = createModel(context, () => MainFooterModel());
    sidebarMenuModel = createModel(context, () => SidebarMenuModel());
  }

  @override
  void dispose() {
    tabBarController?.dispose();
    mainFooterModel.dispose();
    sidebarMenuModel.dispose();
  }
}
