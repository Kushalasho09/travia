import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'no_ride_to_show_user_widget.dart' show NoRideToShowUserWidget;
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class NoRideToShowUserModel extends FlutterFlowModel<NoRideToShowUserWidget> {
  DateTime? pageState; // 👈 Add this




  /// 👈 SELECTED DATE FROM DATE PICKER
  DateTime? selectedDate;

  /// 👈 REFRESH STATE
  bool isRefreshing = false;

  @override
  void initState(BuildContext context) {
    // super.initState();
    // 👈 Default to tomorrow
    pageState = DateTime.now();
    selectedDate = DateTime.now().add(Duration(days: 1));
  }

  @override
  void dispose() {}
}
