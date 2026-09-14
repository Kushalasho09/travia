import '/flutter_flow/flutter_flow_util.dart';
import 'no_ride_to_show_user_widget.dart' show NoRideToShowUserWidget;
import 'package:flutter/material.dart';

class NoRideToShowUserModel extends FlutterFlowModel<NoRideToShowUserWidget> {
  DateTime? pageState;
  DateTime? selectedDate;
  bool isRefreshing = false;

  @override
  void initState(BuildContext context) {
    pageState = DateTime.now();
    selectedDate = DateTime.now().add(const Duration(days: 1));
  }

  @override
  void dispose() {}
}
