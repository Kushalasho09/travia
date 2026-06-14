import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/sidebar_menu/sidebar_menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'kksjfkaf_model.dart';
export 'kksjfkaf_model.dart';

class KksjfkafWidget extends StatefulWidget {
  const KksjfkafWidget({super.key});

  static String routeName = 'kksjfkaf';
  static String routePath = '/kksjfkaf';

  @override
  State<KksjfkafWidget> createState() => _KksjfkafWidgetState();
}

class _KksjfkafWidgetState extends State<KksjfkafWidget> {
  late KksjfkafModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => KksjfkafModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: wrapWithModel(
            model: _model.sidebarMenuModel,
            updateCallback: () => safeSetState(() {}),
            child: SidebarMenuWidget(),
          ),
        ),
      ),
    );
  }
}
