import '/flutter_flow/flutter_flow_util.dart';
import 'plans_widget.dart' show PlansWidget;
import 'package:flutter/material.dart';

class PlansModel extends FlutterFlowModel<PlansWidget> {
  PageController? pageViewController;

  int get pageViewCurrentIndex => pageViewController != null &&
          pageViewController!.hasClients &&
          pageViewController!.page != null
      ? pageViewController!.page!.round()
      : 0;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    pageViewController?.dispose();
  }
}
