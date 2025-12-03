import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/no_market_place_ride_driver_widget.dart';
import '/components/no_ride_to_show_user_widget.dart';
import '/compotement/main_footer/main_footer_widget.dart';
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
import 'market_place_customer_widget.dart' show MarketPlaceCustomerWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MarketPlaceCustomerModel
    extends FlutterFlowModel<MarketPlaceCustomerWidget> {
  ///  Local state fields for this page.

  DateTime? selectPickupTime;

  String showMyBookings = 'All';

  String myListingStatus = 'All';

  ///  State fields for stateful widgets in this page.

  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;
  int get tabBarPreviousIndex =>
      tabBarController != null ? tabBarController!.previousIndex : 0;

  // State field(s) for orgine widget.
  FocusNode? orgineFocusNode;
  TextEditingController? orgineTextController;
  String? Function(BuildContext, String?)? orgineTextControllerValidator;
  // State field(s) for destination widget.
  FocusNode? destinationFocusNode;
  TextEditingController? destinationTextController;
  String? Function(BuildContext, String?)? destinationTextControllerValidator;
  // State field(s) for BookingsDropDown widget.
  String? bookingsDropDownValue;
  FormFieldController<String>? bookingsDropDownValueController;
  // State field(s) for ListingDropDown widget.
  String? listingDropDownValue;
  FormFieldController<String>? listingDropDownValueController;
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
    orgineFocusNode?.dispose();
    orgineTextController?.dispose();

    destinationFocusNode?.dispose();
    destinationTextController?.dispose();

    mainFooterModel.dispose();
    sidebarMenuModel.dispose();
  }
}
