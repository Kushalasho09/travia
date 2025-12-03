import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/no_ride_posted_widget.dart';
import '/components/no_ride_to_show_user_widget.dart';
import '/compotement/main_footer/main_footer_widget.dart';
import '/customer_bookings/no_any_bids_by_users/no_any_bids_by_users_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/pages/sidebar_menu/sidebar_menu_widget.dart';
import 'dart:math';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'home_widget.dart' show HomeWidget;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomeModel extends FlutterFlowModel<HomeWidget> {
  ///  Local state fields for this page.

  DateTime? pageState;

  String myRidesStatus = 'All Rides';

  String myBookingStatus = 'All Bookings';

  ///  State fields for stateful widgets in this page.

  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;
  int get tabBarPreviousIndex =>
      tabBarController != null ? tabBarController!.previousIndex : 0;

  // State field(s) for startLocation widget.
  FocusNode? startLocationFocusNode;
  TextEditingController? startLocationTextController;
  String? Function(BuildContext, String?)? startLocationTextControllerValidator;
  // State field(s) for EndLocation widget.
  FocusNode? endLocationFocusNode;
  TextEditingController? endLocationTextController;
  String? Function(BuildContext, String?)? endLocationTextControllerValidator;
  // State field(s) for BookingDropDown widget.
  String? bookingDropDownValue;
  FormFieldController<String>? bookingDropDownValueController;
  // State field(s) for PostedRidesDropDown widget.
  String? postedRidesDropDownValue;
  FormFieldController<String>? postedRidesDropDownValueController;
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
    startLocationFocusNode?.dispose();
    startLocationTextController?.dispose();

    endLocationFocusNode?.dispose();
    endLocationTextController?.dispose();

    mainFooterModel.dispose();
    sidebarMenuModel.dispose();
  }
}
