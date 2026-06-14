import 'package:flutter/services.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

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
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'market_place_customer_model.dart';
export 'market_place_customer_model.dart';

class MarketPlaceCustomerWidget extends StatefulWidget {
  const MarketPlaceCustomerWidget({
    super.key,
    int? tabNumberRef,
  }) : this.tabNumberRef = tabNumberRef ?? 0;

  final int tabNumberRef;

  static String routeName = 'Market_Place_Customer';
  static String routePath = '/marketPlaceCustomer';

  @override
  State<MarketPlaceCustomerWidget> createState() =>
      _MarketPlaceCustomerWidgetState();
}

class _MarketPlaceCustomerWidgetState extends State<MarketPlaceCustomerWidget>
    with TickerProviderStateMixin {
  late MarketPlaceCustomerModel _model;
// 👈 HELPER FUNCTION (add at top of file or in model)
  Color _getStatusColor(String status) {
    switch (status) {
      case 'Active':
        return FlutterFlowTheme.of(context).success;
      case 'Rejected':
        return FlutterFlowTheme.of(context).error;
      default:
        return FlutterFlowTheme.of(context).warning;
    }
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MarketPlaceCustomerModel());

    _model.tabBarController = TabController(
      vsync: this,
      length: 3,
      initialIndex: min(
          valueOrDefault<int>(
            widget.tabNumberRef,
            0,
          ),
          2),
    )..addListener(() => safeSetState(() {}));

    // _model.orgineTextController ??= TextEditingController();
    // _model.orgineFocusNode ??= FocusNode();
    //
    // _model.destinationTextController ??= TextEditingController();
    // _model.destinationFocusNode ??= FocusNode();

    _model.orgineTextController = TextEditingController();
    _model.destinationTextController = TextEditingController();
    _model.orgineFocusNode ??= FocusNode();

    // _model.endLocationTextController ??= TextEditingController();
    _model.destinationFocusNode ??= FocusNode();

    animationsMap.addAll({
      'listViewOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          ShimmerEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            color: Color(0x80FFFFFF),
            angle: 0.524,
          ),
        ],
      ),
    });
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          return await showDialog<bool>(
                context: context,
                barrierDismissible: true,
                barrierColor: Colors.black54,
                builder: (context) => Dialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 32.0,
                          spreadRadius: 0,
                          offset: Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Header with icon
                        Column(
                          children: [
                            SizedBox(height: 20.0),

                            // Icon Container
                            Container(
                              width: 72.0,
                              height: 72.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .tertiary
                                    .withOpacity(0.12),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: FlutterFlowTheme.of(context)
                                      .tertiary
                                      .withOpacity(0.2),
                                  width: 2.0,
                                ),
                              ),
                              child: Icon(
                                Icons.exit_to_app_rounded,
                                size: 36.0,
                                color: FlutterFlowTheme.of(context).tertiary,
                              ),
                            ),
                            SizedBox(height: 16.0),
                            // Title
                            Text(
                              'Exit Application',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF333333),
                                fontFamily: 'Inter',
                              ),
                            ),
                          ],
                        ),

                        // Content
                        Padding(
                          padding: EdgeInsets.all(24.0),
                          child: Column(
                            children: [
                              Text(
                                'Are you sure you want to exit the app?',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Color(0xFF666666),
                                  fontFamily: 'Inter',
                                  height: 1.5,
                                ),
                              ),
                              SizedBox(height: 8.0),
                              Text(
                                'Any unsaved changes may be lost.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: Color(0xFF999999),
                                  fontFamily: 'Inter',
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Divider
                        Divider(
                          height: 0,
                          thickness: 1,
                          color: Colors.grey[200],
                        ),

                        // Buttons
                        Container(
                          padding: EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              // Cancel Button
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: () =>
                                      Navigator.of(context).pop(false),
                                  style: OutlinedButton.styleFrom(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 16.0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    side: BorderSide(
                                      color: Colors.grey[300]!,
                                      width: 1.0,
                                    ),
                                  ),
                                  child: Text(
                                    'Cancel',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF666666),
                                      fontFamily: 'Inter',
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(width: 16.0),

                              // Exit Button
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(true);
                                    SystemNavigator.pop();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 16.0),
                                    backgroundColor:
                                        FlutterFlowTheme.of(context).tertiary,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    elevation: 0,
                                    shadowColor: FlutterFlowTheme.of(context)
                                        .tertiary
                                        .withOpacity(0.3),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Exit',
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                          fontFamily: 'Inter',
                                        ),
                                      ),
                                      SizedBox(width: 8.0),
                                      Icon(
                                        Icons.arrow_forward_rounded,
                                        size: 18.0,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ) ??
              false;
        },
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: Colors.white,
            drawer: Drawer(
              width: MediaQuery.of(context).size.width * 0.88,
              elevation: 16.0,
              child: wrapWithModel(
                model: _model.sidebarMenuModel,
                updateCallback: () => safeSetState(() {}),
                child: SidebarMenuWidget(),
              ),
            ),
            appBar: AppBar(
              backgroundColor: Color(0xFFF4F4F4),
              automaticallyImplyLeading: false,
              elevation: 2.0,
              shadowColor: Colors.black.withOpacity(0.05),
              leading: Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: FlutterFlowIconButton(
                  borderRadius: 12.0,
                  buttonSize: 44.0,
                  icon: FaIcon(
                    FontAwesomeIcons.bars,
                    color: Color(0xFF283B5E),
                    size: 22.0,
                  ),
                  onPressed: () async {
                    if (scaffoldKey.currentState != null) {
                      scaffoldKey.currentState!.openDrawer();
                    }
                  },
                ),
              ),
              title: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Container(
                  height: 45.0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: Image.asset(
                      'assets/images/logoTraviaJi.png',
                      fit: BoxFit.contain,
                      alignment: Alignment.centerLeft,
                    ),
                  ),
                ),
              ),
              actions: [
                Container(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Notification Icon with Badge
                      StreamBuilder<List<ChatsRecord>>(
                        stream: queryChatsRecord(
                          queryBuilder: (chatsRecord) => chatsRecord
                              .where('userIDs',
                                  arrayContains: currentUserReference)
                              .orderBy('lastMessageTime', descending: true),
                        ),
                        builder: (context, snapshot) {
                          int unreadCount = 0;

                          if (snapshot.hasData) {
                            final chatsList = snapshot.data!;
                            unreadCount = chatsList.where((chat) {
                              if (chat.lastMessagesSeenBy == null) return true;
                              final hasSeen = chat.lastMessagesSeenBy!.any(
                                  (userRef) => userRef.id == currentUserUid);
                              return !hasSeen;
                            }).length;
                          }

                          return Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                width: 44.0,
                                height: 44.0,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(14.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.05),
                                      blurRadius: 8.0,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(14.0),
                                  onTap: () async {
                                    context.pushNamed(
                                        PageNotificationWidget.routeName);
                                  },
                                  child: Center(
                                    child: Icon(
                                      Icons.notifications_outlined,
                                      color: Color(0xFF283B5E),
                                      size: 24.0,
                                    ),
                                  ),
                                ),
                              ),
                              if (unreadCount > 0)
                                Positioned(
                                  right: -2,
                                  top: -2,
                                  child: Container(
                                    constraints: BoxConstraints(
                                      minWidth: 20.0,
                                      minHeight: 20.0,
                                    ),
                                    padding: EdgeInsets.all(4.0),
                                    decoration: BoxDecoration(
                                      color: Color(0xFFE74C3C),
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Color(0xFFF4F4F4),
                                        width: 2.0,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.red.withOpacity(0.3),
                                          blurRadius: 4.0,
                                          offset: Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: Center(
                                      child: Text(
                                        unreadCount > 9
                                            ? '9+'
                                            : unreadCount.toString(),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize:
                                              unreadCount > 9 ? 8.0 : 10.0,
                                          fontWeight: FontWeight.w700,
                                          height: 1.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          );
                        },
                      ),

                      SizedBox(width: 12.0),

                      // Crown Icon (Plans)
                      Container(
                        width: 44.0,
                        height: 44.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 8.0,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(14.0),
                          onTap: () async {
                            context.pushNamed(PlansWidget.routeName);
                          },
                          child: Center(
                            child: FaIcon(
                              FontAwesomeIcons.crown,
                              color: Color(0xFF283B5E),
                              size: 20.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              centerTitle: false,
            ),
            body: SafeArea(
              top: true,
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: SizedBox(
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment(0.0, 0),
                              child: TabBar(
                                labelColor:
                                    FlutterFlowTheme.of(context).primaryText,
                                unselectedLabelColor:
                                    FlutterFlowTheme.of(context).secondaryText,
                                labelStyle: FlutterFlowTheme.of(context)
                                    .titleMedium
                                    .override(
                                      font: GoogleFonts.interTight(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .titleMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .titleMedium
                                            .fontStyle,
                                      ),
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .fontStyle,
                                    ),
                                unselectedLabelStyle: FlutterFlowTheme.of(
                                        context)
                                    .titleMedium
                                    .override(
                                      font: GoogleFonts.interTight(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .titleMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .titleMedium
                                            .fontStyle,
                                      ),
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .fontStyle,
                                    ),
                                indicatorColor:
                                    FlutterFlowTheme.of(context).primary,
                                tabs: [
                                  Tab(
                                    text: 'All',
                                  ),
                                  Tab(
                                    text: 'My Booked',
                                  ),
                                  Tab(
                                    text: 'My Listed',
                                  ),
                                ],
                                controller: _model.tabBarController,
                                onTap: (i) async {
                                  [() async {}, () async {}, () async {}][i]();
                                },
                              ),
                            ),
                            Expanded(
                              child: SizedBox(
                                child: Column(
                                  children: [
                                    if (_model.tabBarController?.index == 0)
                                      Align(
                                        alignment:
                                            AlignmentDirectional(0.0, 0.0),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 10),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              // AIzaSyDZkxRpoy0BOIAPwMaMIvAd5xpCe
                                              Expanded(
                                                child: Container(
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .alternate,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    border: Border.all(
                                                      color: const Color(
                                                          0xFFE69A6A),
                                                      width: 1,
                                                    ),
                                                  ),
                                                  child:
                                                      GooglePlaceAutoCompleteTextField(
                                                    focusNode:
                                                        _model.orgineFocusNode,
                                                    textEditingController: _model
                                                        .orgineTextController,
                                                    googleAPIKey:
                                                        "AIzaSyDZkxRpoy0BOIAPwMaMIvAd5xpCe-6ZYvs",
                                                    inputDecoration:
                                                        const InputDecoration(
                                                      hintText:
                                                          'Origin from...',
                                                      isDense: false,
                                                      filled: false,
                                                      contentPadding:
                                                          EdgeInsets.symmetric(
                                                        horizontal: 14,
                                                        vertical: 14,
                                                      ),

                                                      // ✅ NO INNER BORDER
                                                      border: InputBorder.none,
                                                      enabledBorder:
                                                          InputBorder.none,
                                                      focusedBorder:
                                                          InputBorder.none,
                                                      disabledBorder:
                                                          InputBorder.none,
                                                      errorBorder:
                                                          InputBorder.none,
                                                      focusedErrorBorder:
                                                          InputBorder.none,
                                                    ),
                                                    textStyle: FlutterFlowTheme
                                                            .of(context)
                                                        .bodyMedium
                                                        .copyWith(fontSize: 14),
                                                    debounceTime: 600,
                                                    countries: ["in"],
                                                    isLatLngRequired: false,
                                                    itemClick: (prediction) {
                                                      _model
                                                          .orgineTextController
                                                          .text = prediction
                                                              .description ??
                                                          "";
                                                      _model.orgineTextController
                                                              .selection =
                                                          TextSelection
                                                              .fromPosition(
                                                        TextPosition(
                                                          offset: prediction
                                                                  .description
                                                                  ?.length ??
                                                              0,
                                                        ),
                                                      );
                                                    },
                                                    itemBuilder: (context,
                                                        index, prediction) {
                                                      return Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                          horizontal: 14,
                                                          vertical: 10,
                                                        ),
                                                        child: Row(
                                                          children: [
                                                            Icon(
                                                              Icons.location_on,
                                                              size: 18,
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .tertiary,
                                                            ),
                                                            const SizedBox(
                                                                width: 8),
                                                            Expanded(
                                                              child: Text(
                                                                prediction
                                                                        .description ??
                                                                    "",
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .copyWith(
                                                                        fontSize:
                                                                            13),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    },
                                                    seperatedBuilder:
                                                        const Divider(
                                                            height: 1),
                                                    isCrossBtnShown: true,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Container(
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .alternate,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    border: Border.all(
                                                      color: const Color(
                                                          0xFFE69A6A),
                                                      width: 1,
                                                    ),
                                                  ),
                                                  child:
                                                      GooglePlaceAutoCompleteTextField(
                                                    focusNode: _model
                                                        .destinationFocusNode,
                                                    textEditingController: _model
                                                        .destinationTextController,
                                                    googleAPIKey:
                                                        "AIzaSyDZkxRpoy0BOIAPwMaMIvAd5xpCe-6ZYvs",
                                                    inputDecoration:
                                                        const InputDecoration(
                                                      hintText:
                                                          "Destination...",
                                                      isDense: false,
                                                      filled: false,
                                                      contentPadding:
                                                          EdgeInsets.symmetric(
                                                        horizontal: 14,
                                                        vertical: 14,
                                                      ),

                                                      // ✅ NO INNER BORDER
                                                      border: InputBorder.none,
                                                      enabledBorder:
                                                          InputBorder.none,
                                                      focusedBorder:
                                                          InputBorder.none,
                                                      disabledBorder:
                                                          InputBorder.none,
                                                      errorBorder:
                                                          InputBorder.none,
                                                      focusedErrorBorder:
                                                          InputBorder.none,
                                                    ),
                                                    textStyle: FlutterFlowTheme
                                                            .of(context)
                                                        .bodyMedium
                                                        .copyWith(fontSize: 14),
                                                    debounceTime: 600,
                                                    countries: ["in"],
                                                    isLatLngRequired: false,
                                                    itemClick: (prediction) {
                                                      _model
                                                          .destinationTextController
                                                          .text = prediction
                                                              .description ??
                                                          "";
                                                      _model.destinationTextController
                                                              .selection =
                                                          TextSelection
                                                              .fromPosition(
                                                        TextPosition(
                                                          offset: prediction
                                                                  .description
                                                                  ?.length ??
                                                              0,
                                                        ),
                                                      );
                                                    },
                                                    itemBuilder: (context,
                                                        index, prediction) {
                                                      return Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                          horizontal: 14,
                                                          vertical: 10,
                                                        ),
                                                        child: Row(
                                                          children: [
                                                            Icon(
                                                              Icons.location_on,
                                                              size: 18,
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .tertiary,
                                                            ),
                                                            const SizedBox(
                                                                width: 8),
                                                            Expanded(
                                                              child: Text(
                                                                prediction
                                                                        .description ??
                                                                    "",
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .copyWith(
                                                                        fontSize:
                                                                            13),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    },
                                                    seperatedBuilder:
                                                        const Divider(
                                                            height: 1),
                                                    isCrossBtnShown: true,
                                                  ),
                                                ),
                                              ),
                                              InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  final origin = _model
                                                      .orgineTextController.text
                                                      .trim();
                                                  final destination = _model
                                                      .destinationTextController
                                                      .text
                                                      .trim();

                                                  debugPrint('ORIGIN: $origin');
                                                  debugPrint(
                                                      'DESTINATION: $destination');

                                                  // Empty fields check
                                                  if (origin.isEmpty ||
                                                      destination.isEmpty) {
                                                    await showDialog(
                                                      context: context,
                                                      builder:
                                                          (alertDialogContext) {
                                                        return AlertDialog(
                                                          title: Text(
                                                              'Attention Required'),
                                                          content: Text(
                                                              'Please fill origin from and destination.'),
                                                          actions: [
                                                            TextButton(
                                                              onPressed: () =>
                                                                  Navigator.pop(
                                                                      alertDialogContext),
                                                              child: Text('Ok'),
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    );
                                                    return;
                                                  }

                                                  // Same location check
                                                  if (origin.toLowerCase() ==
                                                      destination
                                                          .toLowerCase()) {
                                                    await showDialog(
                                                      context: context,
                                                      builder:
                                                          (alertDialogContext) {
                                                        return AlertDialog(
                                                          title: Text(
                                                              'Invalid Route'),
                                                          content: Text(
                                                              'Origin and destination cannot be the same.'),
                                                          actions: [
                                                            TextButton(
                                                              onPressed: () =>
                                                                  Navigator.pop(
                                                                      alertDialogContext),
                                                              child: Text('Ok'),
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    );
                                                    return;
                                                  }

                                                  // Success - Update search state
                                                  setState(() {
                                                    _model.searchOrigin =
                                                        origin;
                                                    _model.searchDestination =
                                                        destination;
                                                    _model.isSearchActive =
                                                        true;
                                                  });

                                                  // Show success feedback
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                          'Searching marketplace from $origin → $destination'),
                                                      backgroundColor:
                                                          Colors.green.shade600,
                                                      duration:
                                                          Duration(seconds: 2),
                                                    ),
                                                  );
                                                },
                                                // onTap: () async {
                                                //   if ((_model.orgineTextController.text != null && _model.orgineTextController.text != '') && (_model.destinationTextController.text != null && _model.destinationTextController.text != '')) {
                                                //     context.pushNamed(
                                                //       SearchMarketPlaceWidget.routeName,
                                                //       queryParameters: {
                                                //         'searchQuery1': serializeParam(
                                                //           _model.orgineTextController.text,
                                                //           ParamType.String,
                                                //         ),
                                                //         'searchQuery2': serializeParam(
                                                //           _model.destinationTextController.text,
                                                //           ParamType.String,
                                                //         ),
                                                //       }.withoutNulls,
                                                //     );
                                                //   } else {
                                                //     await showDialog(
                                                //       context: context,
                                                //       builder: (alertDialogContext) {
                                                //         return AlertDialog(
                                                //           title: Text('Attention Required '),
                                                //           content: Text('Please fill origin from and destination.'),
                                                //           actions: [
                                                //             TextButton(
                                                //               onPressed: () => Navigator.pop(alertDialogContext),
                                                //               child: Text('Ok'),
                                                //             ),
                                                //           ],
                                                //         );
                                                //       },
                                                //     );
                                                //   }
                                                // },
                                                child: Container(
                                                  width: 40.0,
                                                  height: 40.0,
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .tertiary,
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            0.0, 0.0),
                                                    child: Icon(
                                                      Icons.arrow_forward,
                                                      color: Colors.white,
                                                      size: 20.0,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ].divide(SizedBox(width: 8.0)),
                                          ).animateOnPageLoad(animationsMap[
                                              'listViewOnPageLoadAnimation']!),
                                        ),
                                      ),
                                    Expanded(
                                      child: TabBarView(
                                        controller: _model.tabBarController,
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                flex: 2, // Same as example

                                                child: SingleChildScrollView(
                                                  physics:
                                                      const AlwaysScrollableScrollPhysics(),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    0.0,
                                                                    4.0,
                                                                    0.0), // Reduced right from 10→4
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,

                                                          // mainAxisAlignment: MainAxisAlignment.start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Flexible(
                                                              child: Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                child:
                                                                    ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              12.0),
                                                                  child:
                                                                      Container(
                                                                    width: MediaQuery.sizeOf(context)
                                                                            .width *
                                                                        0.28,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryBackground,
                                                                      boxShadow: [
                                                                        BoxShadow(
                                                                          blurRadius:
                                                                              4.0,
                                                                          color:
                                                                              Color(0x10000000),
                                                                          offset: Offset(
                                                                              0.0,
                                                                              2.0),
                                                                        )
                                                                      ],
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              12.0),
                                                                    ),
                                                                    child:
                                                                        Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          6.0,
                                                                          0.0),
                                                                      child: StreamBuilder<
                                                                          List<
                                                                              AdminSetDateRecord>>(
                                                                        stream: queryAdminSetDateRecord(
                                                                            queryBuilder: (adminSetDateRecord) => adminSetDateRecord
                                                                              ..where('dateList', isGreaterThanOrEqualTo: DateTime.now().subtract(Duration(hours: 1)))),
                                                                        builder:
                                                                            (context,
                                                                                snapshot) {
                                                                          if (!snapshot
                                                                              .hasData) {
                                                                            return Center(
                                                                              child: SizedBox(
                                                                                width: 50.0,
                                                                                height: 50.0,
                                                                                child: SpinKitFadingCircle(
                                                                                  color: Color(0xFF2B3C58),
                                                                                  size: 50.0,
                                                                                ),
                                                                              ),
                                                                            );
                                                                          }

                                                                          final now =
                                                                              DateTime.now();
                                                                          final startDate = DateTime(
                                                                              now.year,
                                                                              now.month,
                                                                              1);
                                                                          final endDate = DateTime(
                                                                              now.year,
                                                                              now.month + 2,
                                                                              0);
                                                                          final totalDays =
                                                                              endDate.difference(startDate).inDays + 1;

                                                                          return ListView
                                                                              .separated(
                                                                            padding:
                                                                                EdgeInsets.zero,
                                                                            primary:
                                                                                false,
                                                                            shrinkWrap:
                                                                                true,
                                                                            scrollDirection:
                                                                                Axis.vertical,
                                                                            itemCount:
                                                                                totalDays,
                                                                            separatorBuilder: (_, __) =>
                                                                                const SizedBox(height: 15.0),
                                                                            itemBuilder:
                                                                                (context, listViewIndex) {
                                                                              final date = startDate.add(Duration(days: listViewIndex));
                                                                              final isSelected = _model.pageState != null && _model.pageState!.year == date.year && _model.pageState!.month == date.month && _model.pageState!.day == date.day;

                                                                              return InkWell(
                                                                                splashColor: Colors.transparent,
                                                                                focusColor: Colors.transparent,
                                                                                hoverColor: Colors.transparent,
                                                                                highlightColor: Colors.transparent,
                                                                                onTap: () async {
                                                                                  final startOfDay = DateTime(date.year, date.month, date.day, 0, 0, 0);
                                                                                  print('🔥 DATE: ${dateTimeFormat("dd MMM", date)}');
                                                                                  print('📅 START: $startOfDay');

                                                                                  _model.pageState = startOfDay;
                                                                                  safeSetState(() {});

                                                                                  if (mounted) {
                                                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                                                      SnackBar(
                                                                                        content: Text(
                                                                                          '📅 Switched to ${dateTimeFormat("dd MMM yyyy", startOfDay)}',
                                                                                        ),
                                                                                        backgroundColor: FlutterFlowTheme.of(context).tertiary,
                                                                                        duration: const Duration(seconds: 3),
                                                                                      ),
                                                                                    );
                                                                                  }
                                                                                },
                                                                                child: Container(
                                                                                  width: 70.53,
                                                                                  height: 70.0,
                                                                                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                                                                                  decoration: BoxDecoration(
                                                                                    color: isSelected ? Colors.white : const Color(0xFFF4F4F4),
                                                                                    borderRadius: const BorderRadius.only(
                                                                                      bottomLeft: Radius.circular(0.0),
                                                                                      bottomRight: Radius.circular(15.0),
                                                                                      topLeft: Radius.circular(0.0),
                                                                                      topRight: Radius.circular(15.0),
                                                                                    ),
                                                                                    border: isSelected
                                                                                        ? Border.all(
                                                                                            color: FlutterFlowTheme.of(context).tertiary,
                                                                                            width: 2.0,
                                                                                          )
                                                                                        : null,
                                                                                    boxShadow: [
                                                                                      BoxShadow(
                                                                                        blurRadius: isSelected ? 4.0 : 2.0,
                                                                                        color: isSelected ? FlutterFlowTheme.of(context).tertiary.withOpacity(0.2) : const Color(0x0F000000),
                                                                                        offset: Offset(0.0, isSelected ? 2.0 : 1.0),
                                                                                      )
                                                                                    ],
                                                                                  ),
                                                                                  child: Column(
                                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                                    children: [
                                                                                      Text(
                                                                                        '${date.day}',
                                                                                        style: TextStyle(
                                                                                          fontWeight: FontWeight.bold,
                                                                                          color: isSelected ? FlutterFlowTheme.of(context).tertiary : Colors.black,
                                                                                          fontSize: isSelected ? 22.0 : 18.0,
                                                                                        ),
                                                                                      ),
                                                                                      Text(
                                                                                        dateTimeFormat("MMM", date).toUpperCase(),
                                                                                        style: TextStyle(
                                                                                          fontWeight: FontWeight.w600,
                                                                                          color: isSelected ? FlutterFlowTheme.of(context).tertiary : Colors.black54,
                                                                                          fontSize: isSelected ? 14.0 : 12.0,
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              );
                                                                            },
                                                                          );
                                                                        },
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ).animateOnPageLoad(
                                                                        animationsMap[
                                                                            'listViewOnPageLoadAnimation']!),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              child: Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            5.0,
                                                                            0.0),
                                                                child:
                                                                    Container(
                                                                  width: MediaQuery.sizeOf(
                                                                              context)
                                                                          .width *
                                                                      0.78,
                                                                  decoration:
                                                                      BoxDecoration(),
                                                                  child: StreamBuilder<
                                                                      List<
                                                                          MarketPlaceRecord>>(
                                                                    stream: () {
                                                                      // 👈 DYNAMIC QUERY BASED ON SEARCH MODE
                                                                      if (_model
                                                                              .isSearchActive &&
                                                                          _model.searchOrigin !=
                                                                              null &&
                                                                          _model.searchDestination !=
                                                                              null) {
                                                                        // ✅ SEARCH MODE: Filter by location (origin AND destination)
                                                                        print(
                                                                            '🔍 SEARCH MODE: ${_model.searchOrigin} → ${_model.searchDestination}');
                                                                        return queryMarketPlaceRecord(
                                                                          queryBuilder: (marketPlaceRecord) => marketPlaceRecord
                                                                              .where('status', isEqualTo: 'Active')
                                                                              .where('origin', isEqualTo: _model.searchOrigin)
                                                                              .where('destination', isEqualTo: _model.searchDestination),
                                                                        );
                                                                      } else if (_model
                                                                              .pageState !=
                                                                          null) {
                                                                        // ✅ DATE MODE: Filter by selected date
                                                                        final startOfDay =
                                                                            _model.pageState!;
                                                                        final endOfDay =
                                                                            startOfDay.add(Duration(days: 1));

                                                                        print(
                                                                            '📅 DATE MODE: $startOfDay → $endOfDay');

                                                                        return queryMarketPlaceRecord(
                                                                          queryBuilder: (marketPlaceRecord) => marketPlaceRecord
                                                                              .where('status', isEqualTo: 'Active')
                                                                              .where('arivalDate', isGreaterThanOrEqualTo: startOfDay)
                                                                              .where('arivalDate', isLessThan: endOfDay),
                                                                        );
                                                                      } else {
                                                                        // ✅ DEFAULT: Show ALL active marketplace items
                                                                        print(
                                                                            '📱 DEFAULT: Showing all active items');
                                                                        return queryMarketPlaceRecord(
                                                                          queryBuilder: (marketPlaceRecord) => marketPlaceRecord.where(
                                                                              'status',
                                                                              isEqualTo: 'Active'),
                                                                        );
                                                                      }
                                                                    }(),
                                                                    // stream: FFAppState().idontKnow(
                                                                    //   requestFn: () {
                                                                    //     // Start with base query
                                                                    //     var query = queryMarketPlaceRecord(
                                                                    //       queryBuilder: (marketPlaceRecord) {
                                                                    //         var baseQuery = marketPlaceRecord
                                                                    //             .where('arivalDate', isEqualTo: _model.selectPickupTime)
                                                                    //             .where('status', isEqualTo: 'Active');
                                                                    //
                                                                    //         // Add search filters if search is active
                                                                    //         if (_model.isSearchActive == true) {
                                                                    //           if (_model.searchOrigin != null && _model.searchOrigin!.isNotEmpty) {
                                                                    //             baseQuery = baseQuery.where('origin', isEqualTo: _model.searchOrigin);
                                                                    //           }
                                                                    //           if (_model.searchDestination != null && _model.searchDestination!.isNotEmpty) {
                                                                    //             baseQuery = baseQuery.where('destination', isEqualTo: _model.searchDestination);
                                                                    //           }
                                                                    //         }
                                                                    //
                                                                    //         return baseQuery;
                                                                    //       },
                                                                    //     );
                                                                    //     return query;
                                                                    //   },
                                                                    // ),
                                                                    builder:
                                                                        (context,
                                                                            snapshot) {
                                                                      // Customize what your widget looks like when it's loading.
                                                                      if (!snapshot
                                                                          .hasData) {
                                                                        return Center(
                                                                          child:
                                                                              SizedBox(
                                                                            width:
                                                                                50.0,
                                                                            height:
                                                                                50.0,
                                                                            child:
                                                                                SpinKitFadingCircle(
                                                                              color: Color(0xFF2B3C58),
                                                                              size: 50.0,
                                                                            ),
                                                                          ),
                                                                        );
                                                                      }
                                                                      List<MarketPlaceRecord>
                                                                          listViewMarketPlaceRecordList =
                                                                          snapshot
                                                                              .data!;

                                                                      // Show "no results" message if search is active but no results found
                                                                      if (listViewMarketPlaceRecordList
                                                                          .isEmpty) {
                                                                        if (_model.isSearchActive ==
                                                                            true) {
                                                                          return Center(
                                                                            child:
                                                                                Column(
                                                                              mainAxisSize: MainAxisSize.min,
                                                                              children: [
                                                                                Icon(
                                                                                  Icons.search_off,
                                                                                  size: 64,
                                                                                  color: Colors.grey,
                                                                                ),
                                                                                SizedBox(height: 16),
                                                                                Text(
                                                                                  'No marketplace items found for',
                                                                                  style: TextStyle(fontSize: 16, color: Colors.grey),
                                                                                ),
                                                                                Text(
                                                                                  '${_model.searchOrigin} → ${_model.searchDestination}',
                                                                                  style: TextStyle(
                                                                                    fontSize: 14,
                                                                                    fontWeight: FontWeight.bold,
                                                                                    color: FlutterFlowTheme.of(context).tertiary,
                                                                                  ),
                                                                                ),
                                                                                SizedBox(height: 16),
                                                                                TextButton(
                                                                                  onPressed: () {
                                                                                    setState(() {
                                                                                      _model.isSearchActive = false;
                                                                                      _model.searchOrigin = null;
                                                                                      _model.searchDestination = null;
                                                                                      _model.orgineTextController.clear();
                                                                                      _model.destinationTextController.clear();
                                                                                    });
                                                                                  },
                                                                                  child: Text('Clear Search'),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          );
                                                                        }
                                                                        return NoRideToShowUserWidget();
                                                                      }

                                                                      return ListView
                                                                          .separated(
                                                                        // padding: EdgeInsets.zero,
                                                                        physics:
                                                                            NeverScrollableScrollPhysics(),
                                                                        primary:
                                                                            false,
                                                                        shrinkWrap:
                                                                            true,
                                                                        scrollDirection:
                                                                            Axis.vertical,
                                                                        itemCount:
                                                                            listViewMarketPlaceRecordList.length,
                                                                        separatorBuilder:
                                                                            (_, __) =>
                                                                                SizedBox(height: 15.0),
                                                                        itemBuilder:
                                                                            (context,
                                                                                listViewIndex) {
                                                                          final listViewMarketPlaceRecord =
                                                                              listViewMarketPlaceRecordList[listViewIndex];
                                                                          return InkWell(
                                                                            splashColor:
                                                                                Colors.transparent,
                                                                            focusColor:
                                                                                Colors.transparent,
                                                                            hoverColor:
                                                                                Colors.transparent,
                                                                            highlightColor:
                                                                                Colors.transparent,
                                                                            onTap:
                                                                                () async {
                                                                              context.pushNamed(
                                                                                MarketPlaceBookingWidget.routeName,
                                                                                queryParameters: {
                                                                                  'showCustomerMarketPlaceRef': serializeParam(
                                                                                    listViewMarketPlaceRecord.reference,
                                                                                    ParamType.DocumentReference,
                                                                                  ),
                                                                                }.withoutNulls,
                                                                              );
                                                                            },
                                                                            child:
                                                                                Material(
                                                                              color: Colors.transparent,
                                                                              elevation: 4.0,
                                                                              shape: RoundedRectangleBorder(
                                                                                borderRadius: BorderRadius.circular(20.0),
                                                                              ),
                                                                              child: Container(
                                                                                decoration: BoxDecoration(
                                                                                  color: Colors.white,
                                                                                  borderRadius: BorderRadius.circular(20.0),
                                                                                  border: Border.all(
                                                                                    color: FlutterFlowTheme.of(context).tertiary.withOpacity(0.1),
                                                                                    width: 1.0,
                                                                                  ),
                                                                                ),
                                                                                child: Padding(
                                                                                  padding: EdgeInsets.all(12.0),
                                                                                  child: Column(
                                                                                    mainAxisSize: MainAxisSize.min,
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                    children: [
                                                                                      // --- BEAUTIFUL PRODUCT CARD (overlapping design) ---
                                                                                      Stack(
                                                                                        children: [
                                                                                          // Main content
                                                                                          Container(
                                                                                            width: double.infinity,
                                                                                            child: Row(
                                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                                              children: [
                                                                                                // Quote icon integrated nicely
                                                                                                Container(
                                                                                                  margin: EdgeInsets.only(top: 2),
                                                                                                  child: Transform.rotate(
                                                                                                    angle: 3.1416,
                                                                                                    child: Icon(
                                                                                                      Icons.format_quote_rounded,
                                                                                                      color: FlutterFlowTheme.of(context).tertiary.withOpacity(0.3),
                                                                                                      size: 18.0,
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                SizedBox(width: 8),

                                                                                                // Description with subtle background
                                                                                                Expanded(
                                                                                                  child: Container(
                                                                                                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                                                                                    decoration: BoxDecoration(
                                                                                                      color: Colors.grey.shade50,
                                                                                                      borderRadius: BorderRadius.circular(12),
                                                                                                    ),
                                                                                                    child: Text(
                                                                                                      listViewMarketPlaceRecord.descriptionItem ?? 'No description',
                                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                            fontFamily: 'Inter',
                                                                                                            fontSize: 12.0,
                                                                                                            fontWeight: FontWeight.w400,
                                                                                                            fontStyle: FontStyle.italic,
                                                                                                            color: Color(0xFF4A5568),
                                                                                                            // height: 1.3,
                                                                                                          ),
                                                                                                      maxLines: 2,
                                                                                                      overflow: TextOverflow.ellipsis,
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                SizedBox(width: 12),

                                                                                                // Product Image with shadow
                                                                                                Container(
                                                                                                  width: 65.0,
                                                                                                  height: 65.0,
                                                                                                  decoration: BoxDecoration(
                                                                                                    borderRadius: BorderRadius.circular(16.0),
                                                                                                    boxShadow: [
                                                                                                      BoxShadow(
                                                                                                        color: Colors.black.withOpacity(0.05),
                                                                                                        blurRadius: 8,
                                                                                                        offset: Offset(0, 2),
                                                                                                      )
                                                                                                    ],
                                                                                                  ),
                                                                                                  child: ClipRRect(
                                                                                                    borderRadius: BorderRadius.circular(14.0),
                                                                                                    child: listViewMarketPlaceRecord.imageOfproduct != null && listViewMarketPlaceRecord.imageOfproduct!.isNotEmpty
                                                                                                        ? Image.network(
                                                                                                            listViewMarketPlaceRecord.imageOfproduct!,
                                                                                                            fit: BoxFit.cover,
                                                                                                            errorBuilder: (context, error, stackTrace) => Container(
                                                                                                              color: Colors.grey.shade100,
                                                                                                              child: Icon(
                                                                                                                Icons.image_not_supported,
                                                                                                                color: Colors.grey.shade400,
                                                                                                                size: 24.0,
                                                                                                              ),
                                                                                                            ),
                                                                                                          )
                                                                                                        : Container(
                                                                                                            color: FlutterFlowTheme.of(context).tertiary.withOpacity(0.1),
                                                                                                            child: Icon(
                                                                                                              Icons.shopping_bag,
                                                                                                              color: FlutterFlowTheme.of(context).tertiary,
                                                                                                              size: 28.0,
                                                                                                            ),
                                                                                                          ),
                                                                                                  ),
                                                                                                ),
                                                                                              ],
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      ),

                                                                                      SizedBox(height: 12),

                                                                                      // --- SELLER INFO WITH MODERN DESIGN ---
                                                                                      if (listViewMarketPlaceRecord.postedBy != null)
                                                                                        StreamBuilder<UsersRecord>(
                                                                                          stream: UsersRecord.getDocument(listViewMarketPlaceRecord.postedBy!),
                                                                                          builder: (context, snapshot) {
                                                                                            if (!snapshot.hasData) {
                                                                                              return Center(
                                                                                                child: SizedBox(
                                                                                                  width: 24,
                                                                                                  height: 24,
                                                                                                  child: CircularProgressIndicator(
                                                                                                    strokeWidth: 2,
                                                                                                    color: FlutterFlowTheme.of(context).tertiary,
                                                                                                  ),
                                                                                                ),
                                                                                              );
                                                                                            }

                                                                                            final sellerRecord = snapshot.data!;

                                                                                            return Container(
                                                                                              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                                                                                              decoration: BoxDecoration(
                                                                                                color: Colors.grey.shade50,
                                                                                                borderRadius: BorderRadius.circular(16),
                                                                                                border: Border.all(
                                                                                                  color: Colors.grey.shade200,
                                                                                                  width: 1,
                                                                                                ),
                                                                                              ),
                                                                                              child: Row(
                                                                                                children: [
                                                                                                  // Avatar with ring
                                                                                                  Container(
                                                                                                    padding: EdgeInsets.all(2),
                                                                                                    decoration: BoxDecoration(
                                                                                                      shape: BoxShape.circle,
                                                                                                      gradient: LinearGradient(
                                                                                                        colors: [
                                                                                                          FlutterFlowTheme.of(context).tertiary,
                                                                                                          FlutterFlowTheme.of(context).tertiary.withOpacity(0.5),
                                                                                                        ],
                                                                                                      ),
                                                                                                    ),
                                                                                                    child: Container(
                                                                                                      width: 32,
                                                                                                      height: 32,
                                                                                                      decoration: BoxDecoration(
                                                                                                        shape: BoxShape.circle,
                                                                                                        border: Border.all(color: Colors.white, width: 2),
                                                                                                      ),
                                                                                                      child: ClipRRect(
                                                                                                        borderRadius: BorderRadius.circular(16),
                                                                                                        child: sellerRecord.photoUrl != null && sellerRecord.photoUrl!.isNotEmpty
                                                                                                            ? Image.network(
                                                                                                                sellerRecord.photoUrl!,
                                                                                                                fit: BoxFit.cover,
                                                                                                                errorBuilder: (context, error, stackTrace) => Image.asset(
                                                                                                                  'assets/images/userIconTr.png',
                                                                                                                  fit: BoxFit.cover,
                                                                                                                ),
                                                                                                              )
                                                                                                            : Image.asset(
                                                                                                                'assets/images/userIconTr.png',
                                                                                                                fit: BoxFit.cover,
                                                                                                              ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),

                                                                                                  SizedBox(width: 8),

                                                                                                  // Seller name and rating in column
                                                                                                  Expanded(
                                                                                                    child: Column(
                                                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                      mainAxisSize: MainAxisSize.min,
                                                                                                      children: [
                                                                                                        Text(
                                                                                                          sellerRecord.displayName ?? 'Seller',
                                                                                                          style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                                                fontFamily: 'Inter',
                                                                                                                fontSize: 12,
                                                                                                                fontWeight: FontWeight.w600,
                                                                                                                color: Color(0xFF2D3748),
                                                                                                              ),
                                                                                                          maxLines: 1,
                                                                                                          overflow: TextOverflow.ellipsis,
                                                                                                        ),
                                                                                                        Row(
                                                                                                          children: [
                                                                                                            Icon(
                                                                                                              Icons.star,
                                                                                                              color: Colors.amber,
                                                                                                              size: 12,
                                                                                                            ),
                                                                                                            SizedBox(width: 2),
                                                                                                            Text(
                                                                                                              valueOrDefault<String>(
                                                                                                                formatNumber(
                                                                                                                  functions.averageRating(sellerRecord.ratings.toList()),
                                                                                                                  formatType: FormatType.compact,
                                                                                                                ),
                                                                                                                '4.5',
                                                                                                              ),
                                                                                                              style: TextStyle(
                                                                                                                fontSize: 10,
                                                                                                                fontWeight: FontWeight.w600,
                                                                                                                color: Colors.grey.shade600,
                                                                                                              ),
                                                                                                            ),
                                                                                                            Text(
                                                                                                              ' • ',
                                                                                                              style: TextStyle(
                                                                                                                color: Colors.grey.shade400,
                                                                                                                fontSize: 10,
                                                                                                              ),
                                                                                                            ),
                                                                                                          ],
                                                                                                        ),
                                                                                                      ],
                                                                                                    ),
                                                                                                  ),

                                                                                                  // Call button with modern design
                                                                                                  Container(
                                                                                                    decoration: BoxDecoration(
                                                                                                      color: FlutterFlowTheme.of(context).tertiary.withOpacity(0.1),
                                                                                                      borderRadius: BorderRadius.circular(12),
                                                                                                    ),
                                                                                                    child: Material(
                                                                                                      color: Colors.transparent,
                                                                                                      child: InkWell(
                                                                                                        borderRadius: BorderRadius.circular(12),
                                                                                                        onTap: () async {
                                                                                                          final phoneNumber = sellerRecord.phoneNumber ?? '';
                                                                                                          if (phoneNumber.isNotEmpty) {
                                                                                                            final Uri callUri = Uri(scheme: 'tel', path: phoneNumber);
                                                                                                            if (await canLaunchUrl(callUri)) {
                                                                                                              await launchUrl(callUri);
                                                                                                            }
                                                                                                          }
                                                                                                        },
                                                                                                        child: Container(
                                                                                                          padding: EdgeInsets.all(8),
                                                                                                          child: Icon(
                                                                                                            Icons.call_rounded,
                                                                                                            color: FlutterFlowTheme.of(context).tertiary,
                                                                                                            size: 16,
                                                                                                          ),
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ],
                                                                                              ),
                                                                                            );
                                                                                          },
                                                                                        ),

                                                                                      SizedBox(height: 10),

                                                                                      // --- BUTTONS WITH ELEGANT DESIGN ---
                                                                                      StreamBuilder<UsersRecord>(
                                                                                        stream: UsersRecord.getDocument(listViewMarketPlaceRecord.postedBy!),
                                                                                        builder: (context, snapshot) {
                                                                                          if (!snapshot.hasData) {
                                                                                            return SizedBox(height: 40);
                                                                                          }

                                                                                          final sellerRecord = snapshot.data!;
                                                                                          final isChatConnected = sellerRecord.chatConnected?.contains(currentUserReference) ?? false;

                                                                                          return Row(
                                                                                            children: [
                                                                                              // CHAT/TEXT Button with gradient
                                                                                              Expanded(
                                                                                                child: Container(
                                                                                                  decoration: BoxDecoration(
                                                                                                    gradient: LinearGradient(
                                                                                                      colors: [
                                                                                                        Color(0xFF4A90E2),
                                                                                                        Color(0xFF357ABD),
                                                                                                      ],
                                                                                                    ),
                                                                                                    borderRadius: BorderRadius.circular(14),
                                                                                                    boxShadow: [
                                                                                                      BoxShadow(
                                                                                                        color: Color(0xFF4A90E2).withOpacity(0.2),
                                                                                                        blurRadius: 6,
                                                                                                        offset: Offset(0, 2),
                                                                                                      ),
                                                                                                    ],
                                                                                                  ),
                                                                                                  child: Material(
                                                                                                    color: Colors.transparent,
                                                                                                    child: InkWell(
                                                                                                      borderRadius: BorderRadius.circular(14),
                                                                                                      onTap: () async {
                                                                                                        if (!isChatConnected) {
                                                                                                          await ChatsRecord.collection.doc().set({
                                                                                                            ...createChatsRecordData(
                                                                                                              lastMessage: 'Hey, ',
                                                                                                              lastMessageTime: getCurrentTimestamp,
                                                                                                            ),
                                                                                                            ...mapToFirestore({
                                                                                                              'userIDs': functions.generateListOfUsers(
                                                                                                                currentUserReference!,
                                                                                                                sellerRecord.reference,
                                                                                                              ),
                                                                                                              'userNames': functions.generateListOfNames(
                                                                                                                currentUserDisplayName,
                                                                                                                sellerRecord.displayName,
                                                                                                              ),
                                                                                                            }),
                                                                                                          });

                                                                                                          await sellerRecord.reference.update({
                                                                                                            ...mapToFirestore({
                                                                                                              'chatConnected': FieldValue.arrayUnion([currentUserReference]),
                                                                                                            }),
                                                                                                          });
                                                                                                        } else {
                                                                                                          context.pushNamed(ChatUsersWidget.routeName);
                                                                                                        }
                                                                                                      },
                                                                                                      child: Container(
                                                                                                        padding: EdgeInsets.symmetric(vertical: 10),
                                                                                                        child: Center(
                                                                                                          child: Row(
                                                                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                                                                            children: [
                                                                                                              Icon(
                                                                                                                isChatConnected ? Icons.chat : Icons.message,
                                                                                                                color: Colors.white,
                                                                                                                size: 14,
                                                                                                              ),
                                                                                                              SizedBox(width: 6),
                                                                                                              Text(
                                                                                                                isChatConnected ? 'CHAT' : 'MESSAGE',
                                                                                                                style: TextStyle(
                                                                                                                  color: Colors.white,
                                                                                                                  fontSize: 11,
                                                                                                                  fontWeight: FontWeight.w600,
                                                                                                                  letterSpacing: 0.5,
                                                                                                                ),
                                                                                                              ),
                                                                                                            ],
                                                                                                          ),
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                              ),

                                                                                              SizedBox(width: 8),

                                                                                              // ORDER Button with gradient
                                                                                              Expanded(
                                                                                                child: Container(
                                                                                                  decoration: BoxDecoration(
                                                                                                    gradient: LinearGradient(
                                                                                                      colors: [
                                                                                                        FlutterFlowTheme.of(context).tertiary,
                                                                                                        FlutterFlowTheme.of(context).tertiary.withOpacity(0.8),
                                                                                                      ],
                                                                                                    ),
                                                                                                    borderRadius: BorderRadius.circular(14),
                                                                                                    boxShadow: [
                                                                                                      BoxShadow(
                                                                                                        color: FlutterFlowTheme.of(context).tertiary.withOpacity(0.2),
                                                                                                        blurRadius: 6,
                                                                                                        offset: Offset(0, 2),
                                                                                                      ),
                                                                                                    ],
                                                                                                  ),
                                                                                                  child: Material(
                                                                                                    color: Colors.transparent,
                                                                                                    child: InkWell(
                                                                                                      borderRadius: BorderRadius.circular(14),
                                                                                                      onTap: () async {
                                                                                                        context.pushNamed(
                                                                                                          MarketPlaceBidYourRateWidget.routeName,
                                                                                                          queryParameters: {
                                                                                                            'marketPlaceBids': serializeParam(
                                                                                                              listViewMarketPlaceRecord.reference,
                                                                                                              ParamType.DocumentReference,
                                                                                                            ),
                                                                                                          }.withoutNulls,
                                                                                                        );
                                                                                                      },
                                                                                                      child: Container(
                                                                                                        padding: EdgeInsets.symmetric(vertical: 10),
                                                                                                        child: Center(
                                                                                                          child: Row(
                                                                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                                                                            children: [
                                                                                                              Icon(
                                                                                                                Icons.shopping_bag,
                                                                                                                color: Colors.white,
                                                                                                                size: 14,
                                                                                                              ),
                                                                                                              SizedBox(width: 6),
                                                                                                              Text(
                                                                                                                'ORDER',
                                                                                                                style: TextStyle(
                                                                                                                  color: Colors.white,
                                                                                                                  fontSize: 11,
                                                                                                                  fontWeight: FontWeight.w600,
                                                                                                                  letterSpacing: 0.5,
                                                                                                                ),
                                                                                                              ),
                                                                                                            ],
                                                                                                          ),
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            ],
                                                                                          );
                                                                                        },
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          );
                                                                        },
                                                                      ).animateOnPageLoad(
                                                                          animationsMap[
                                                                              'listViewOnPageLoadAnimation']!);
                                                                    },
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Expanded(
                                            flex: 8, // Same as example

                                            child: SingleChildScrollView(
                                              physics:
                                                  const AlwaysScrollableScrollPhysics(),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(10.0, 5.0,
                                                                5.0, 5.0),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        // ✅ RESPONSIVE DROPDOWN - Takes available space!
                                                        Flexible(
                                                          child:
                                                              FlutterFlowDropDown<
                                                                  String>(
                                                            controller: _model
                                                                    .bookingsDropDownValueController ??=
                                                                FormFieldController<
                                                                        String>(
                                                                    'All'),

                                                            // controller: _model.bookingsDropDownValueController ??= FormFieldController<String>(null),
                                                            options: [
                                                              'All',
                                                              'Pending',
                                                              'Accepted',
                                                              'Completed',
                                                              'Rejected'
                                                            ],
                                                            // onChanged: (val) async {
                                                            //   safeSetState(() => _model.bookingsDropDownValue = val);
                                                            //   _model.showMyBookings = _model.showMyBookings;
                                                            //   safeSetState(() {});
                                                            // },
                                                            onChanged:
                                                                (val) async {
                                                              safeSetState(() =>
                                                                  _model.bookingsDropDownValue =
                                                                      val);
                                                              _model.showMyBookings =
                                                                  val!; // ✅ Use the dropdown value
                                                              safeSetState(
                                                                  () {});
                                                            },
                                                            // ✅ REMOVED width: 383.5 → RESPONSIVE!
                                                            height: 40.0,
                                                            textStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .inter(),
                                                                      fontSize:
                                                                          14.0,
                                                                    ),
                                                            hintText:
                                                                'Filter by Status...',
                                                            icon: Icon(
                                                                Icons
                                                                    .keyboard_arrow_down_rounded,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondaryText,
                                                                size: 24.0),
                                                            fillColor: FlutterFlowTheme
                                                                    .of(context)
                                                                .secondaryBackground,
                                                            elevation: 2.0,
                                                            borderColor:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .primary,
                                                            borderWidth: 0.0,
                                                            borderRadius: 8.0,
                                                            margin:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        12.0,
                                                                        0.0,
                                                                        12.0,
                                                                        0.0),
                                                            hidesUnderline:
                                                                true,
                                                            isOverButton: false,
                                                            isSearchable: false,
                                                            isMultiSelect:
                                                                false,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  if (_model.showMyBookings ==
                                                      'All')
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  6.0,
                                                                  5.0,
                                                                  6.0,
                                                                  5.0),
                                                      child: StreamBuilder<
                                                          List<
                                                              BidsForMarketPlaceRecord>>(
                                                        stream:
                                                            queryBidsForMarketPlaceRecord(
                                                          queryBuilder:
                                                              (bidsForMarketPlaceRecord) =>
                                                                  bidsForMarketPlaceRecord
                                                                      .where(
                                                            'bidsCreatorID',
                                                            isEqualTo:
                                                                currentUserReference,
                                                          ),
                                                        ),
                                                        builder: (context,
                                                            snapshot) {
                                                          // Customize what your widget looks like when it's loading.
                                                          if (!snapshot
                                                              .hasData) {
                                                            return Center(
                                                              child: SizedBox(
                                                                width: 50.0,
                                                                height: 50.0,
                                                                child:
                                                                    SpinKitFadingCircle(
                                                                  color: Color(
                                                                      0xFF2B3C58),
                                                                  size: 50.0,
                                                                ),
                                                              ),
                                                            );
                                                          }
                                                          List<BidsForMarketPlaceRecord>
                                                              allBookingsBidsForMarketPlaceRecordList =
                                                              snapshot.data!;

                                                          return ListView
                                                              .separated(
                                                            padding:
                                                                EdgeInsets.zero,
                                                            physics:
                                                                NeverScrollableScrollPhysics(),
                                                            primary: false,
                                                            shrinkWrap: true,
                                                            scrollDirection:
                                                                Axis.vertical,
                                                            itemCount:
                                                                allBookingsBidsForMarketPlaceRecordList
                                                                    .length,
                                                            separatorBuilder: (_,
                                                                    __) =>
                                                                SizedBox(
                                                                    height:
                                                                        15.0),
                                                            itemBuilder: (context,
                                                                allBookingsIndex) {
                                                              final allBookingsBidsForMarketPlaceRecord =
                                                                  allBookingsBidsForMarketPlaceRecordList[
                                                                      allBookingsIndex];
                                                              return StreamBuilder<
                                                                  MarketPlaceRecord>(
                                                                stream: MarketPlaceRecord
                                                                    .getDocument(
                                                                        allBookingsBidsForMarketPlaceRecord
                                                                            .marketPlaceRef!),
                                                                builder: (context,
                                                                    snapshot) {
                                                                  // Customize what your widget looks like when it's loading.
                                                                  if (!snapshot
                                                                      .hasData) {
                                                                    return Center(
                                                                      child:
                                                                          SizedBox(
                                                                        width:
                                                                            50.0,
                                                                        height:
                                                                            50.0,
                                                                        child:
                                                                            SpinKitFadingCircle(
                                                                          color:
                                                                              Color(0xFF2B3C58),
                                                                          size:
                                                                              50.0,
                                                                        ),
                                                                      ),
                                                                    );
                                                                  }

                                                                  final containerMarketPlaceRecord =
                                                                      snapshot
                                                                          .data!;

                                                                  return Material(
                                                                    color: Colors
                                                                        .transparent,
                                                                    elevation:
                                                                        2.0,
                                                                    shape:
                                                                        RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              12.0),
                                                                    ),
                                                                    child:
                                                                        Container(
                                                                      width: double
                                                                          .infinity,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primaryBackground,
                                                                        borderRadius:
                                                                            BorderRadius.circular(12.0),
                                                                        border:
                                                                            Border.all(
                                                                          color:
                                                                              FlutterFlowTheme.of(context).alternate,
                                                                          width:
                                                                              1.0,
                                                                        ),
                                                                      ),
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            EdgeInsets.all(16.0),
                                                                        child:
                                                                            Column(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          children: [
                                                                            Row(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                Flexible(
                                                                                  child: Column(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                    children: [
                                                                                      Padding(
                                                                                        padding: EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 0.0),
                                                                                        child: Text(
                                                                                          'Placed on ${dateTimeFormat("yMMMd", allBookingsBidsForMarketPlaceRecord.createAt)}',
                                                                                          style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                                font: GoogleFonts.inter(
                                                                                                  fontWeight: FontWeight.w600,
                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                                ),
                                                                                                color: FlutterFlowTheme.of(context).primaryText,
                                                                                                fontSize: 12.0,
                                                                                                letterSpacing: 0.0,
                                                                                                fontWeight: FontWeight.w600,
                                                                                                fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                              ),
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                                Container(
                                                                                  width: 80.0,
                                                                                  height: 28.0,
                                                                                  decoration: BoxDecoration(
                                                                                    color: () {
                                                                                      if (allBookingsBidsForMarketPlaceRecord.status == 'Completed') {
                                                                                        return FlutterFlowTheme.of(context).success;
                                                                                      } else if (allBookingsBidsForMarketPlaceRecord.status == 'Accepted') {
                                                                                        return Color(0xFFFD803D);
                                                                                      } else if (allBookingsBidsForMarketPlaceRecord.status == 'Rejected') {
                                                                                        return FlutterFlowTheme.of(context).error;
                                                                                      } else {
                                                                                        return FlutterFlowTheme.of(context).warning;
                                                                                      }
                                                                                    }(),
                                                                                    borderRadius: BorderRadius.circular(14.0),
                                                                                  ),
                                                                                  child: Align(
                                                                                    alignment: AlignmentDirectional(0.0, 0.0),
                                                                                    child: Padding(
                                                                                      padding: EdgeInsets.all(8.0),
                                                                                      child: Text(
                                                                                        allBookingsBidsForMarketPlaceRecord.status,
                                                                                        textAlign: TextAlign.center,
                                                                                        style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                              font: GoogleFonts.inter(
                                                                                                fontWeight: FontWeight.w600,
                                                                                                fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                              ),
                                                                                              color: Colors.white,
                                                                                              fontSize: 11.0,
                                                                                              letterSpacing: 0.0,
                                                                                              fontWeight: FontWeight.w600,
                                                                                              fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                            ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            Divider(
                                                                              height: 20.0,
                                                                              thickness: 1.0,
                                                                              color: FlutterFlowTheme.of(context).alternate,
                                                                            ),
                                                                            Row(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              children: [
                                                                                ClipRRect(
                                                                                  borderRadius: BorderRadius.circular(8.0),
                                                                                  child: Image.network(
                                                                                    containerMarketPlaceRecord.imageOfproduct,
                                                                                    width: 60.0,
                                                                                    height: 60.0,
                                                                                    fit: BoxFit.cover,
                                                                                  ),
                                                                                ),
                                                                                Flexible(
                                                                                  child: Column(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                    children: [
                                                                                      Text(
                                                                                        containerMarketPlaceRecord.productName,
                                                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                              font: GoogleFonts.inter(
                                                                                                fontWeight: FontWeight.w500,
                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                              ),
                                                                                              color: FlutterFlowTheme.of(context).primaryText,
                                                                                              fontSize: 14.0,
                                                                                              letterSpacing: 0.0,
                                                                                              fontWeight: FontWeight.w500,
                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                            ),
                                                                                      ),
                                                                                      Padding(
                                                                                        padding: EdgeInsetsDirectional.fromSTEB(0.0, 2.0, 0.0, 0.0),
                                                                                        child: Text(
                                                                                          containerMarketPlaceRecord.descriptionItem,
                                                                                          style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                                font: GoogleFonts.inter(
                                                                                                  fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                                ),
                                                                                                color: FlutterFlowTheme.of(context).primaryText,
                                                                                                fontSize: 12.0,
                                                                                                letterSpacing: 0.0,
                                                                                                fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                                fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                              ),
                                                                                        ),
                                                                                      ),
                                                                                      Padding(
                                                                                        padding: EdgeInsetsDirectional.fromSTEB(0.0, 2.0, 0.0, 0.0),
                                                                                        child: Text(
                                                                                          'Quantity: ${allBookingsBidsForMarketPlaceRecord.quantity.toString()}',
                                                                                          style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                                font: GoogleFonts.inter(
                                                                                                  fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                                ),
                                                                                                color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                fontSize: 12.0,
                                                                                                letterSpacing: 0.0,
                                                                                                fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                                fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                              ),
                                                                                        ),
                                                                                      ),
                                                                                      Padding(
                                                                                        padding: EdgeInsetsDirectional.fromSTEB(0.0, 2.0, 0.0, 0.0),
                                                                                        child: Text(
                                                                                          '₹${allBookingsBidsForMarketPlaceRecord.price.toString()} each',
                                                                                          style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                                font: GoogleFonts.inter(
                                                                                                  fontWeight: FontWeight.w600,
                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                                ),
                                                                                                color: FlutterFlowTheme.of(context).primary,
                                                                                                fontSize: 12.0,
                                                                                                letterSpacing: 0.0,
                                                                                                fontWeight: FontWeight.w600,
                                                                                                fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                              ),
                                                                                        ),
                                                                                      ),
                                                                                      Padding(
                                                                                        padding: EdgeInsetsDirectional.fromSTEB(0.0, 2.0, 0.0, 0.0),
                                                                                        child: Text(
                                                                                          allBookingsBidsForMarketPlaceRecord.description,
                                                                                          style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                                font: GoogleFonts.inter(
                                                                                                  fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                                ),
                                                                                                color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                fontSize: 12.0,
                                                                                                letterSpacing: 0.0,
                                                                                                fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                                fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                              ),
                                                                                        ),
                                                                                      ),
                                                                                    ].divide(SizedBox(height: 3.0)),
                                                                                  ),
                                                                                ),
                                                                                Column(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                                                  children: [
                                                                                    Text(
                                                                                      '₹${(allBookingsBidsForMarketPlaceRecord.price * allBookingsBidsForMarketPlaceRecord.quantity).toString()}',
                                                                                      style: FlutterFlowTheme.of(context).titleMedium.override(
                                                                                            font: GoogleFonts.interTight(
                                                                                              fontWeight: FontWeight.w600,
                                                                                              fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                                            ),
                                                                                            color: FlutterFlowTheme.of(context).primaryText,
                                                                                            fontSize: 16.0,
                                                                                            letterSpacing: 0.0,
                                                                                            fontWeight: FontWeight.w600,
                                                                                            fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                                          ),
                                                                                    ),
                                                                                    Text(
                                                                                      'Total',
                                                                                      style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                            font: GoogleFonts.inter(
                                                                                              fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                              fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                            ),
                                                                                            color: FlutterFlowTheme.of(context).secondaryText,
                                                                                            fontSize: 11.0,
                                                                                            letterSpacing: 0.0,
                                                                                            fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                            fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                          ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ].divide(SizedBox(width: 12.0)),
                                                                            ),
                                                                            Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
                                                                              child: Row(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                children: [
                                                                                  FFButtonWidget(
                                                                                    onPressed: () async {
                                                                                      context.pushNamed(
                                                                                        MarketPlaceBidYourRateWidget.routeName,
                                                                                        queryParameters: {
                                                                                          'marketPlaceBids': serializeParam(
                                                                                            containerMarketPlaceRecord.reference,
                                                                                            ParamType.DocumentReference,
                                                                                          ),
                                                                                        }.withoutNulls,
                                                                                      );
                                                                                    },
                                                                                    text: 'Reorder',
                                                                                    options: FFButtonOptions(
                                                                                      height: 32.0,
                                                                                      padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
                                                                                      iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                                                      color: FlutterFlowTheme.of(context).secondary,
                                                                                      textStyle: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                            font: GoogleFonts.inter(
                                                                                              fontWeight: FontWeight.w600,
                                                                                              fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                            ),
                                                                                            color: Colors.white,
                                                                                            fontSize: 12.0,
                                                                                            letterSpacing: 0.0,
                                                                                            fontWeight: FontWeight.w600,
                                                                                            fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                          ),
                                                                                      elevation: 0.0,
                                                                                      borderRadius: BorderRadius.circular(6.0),
                                                                                    ),
                                                                                  ),
                                                                                  FFButtonWidget(
                                                                                    onPressed: () async {
                                                                                      context.pushNamed(PlansWidget.routeName);

                                                                                      ScaffoldMessenger.of(context).showSnackBar(
                                                                                        SnackBar(
                                                                                          content: Text(
                                                                                            'You don\'t have to have an active plan to use this feature.',
                                                                                            style: TextStyle(
                                                                                              color: FlutterFlowTheme.of(context).primaryText,
                                                                                            ),
                                                                                          ),
                                                                                          duration: Duration(milliseconds: 4000),
                                                                                          backgroundColor: FlutterFlowTheme.of(context).secondary,
                                                                                        ),
                                                                                      );
                                                                                    },
                                                                                    text: 'Contact Seller',
                                                                                    icon: Icon(
                                                                                      Icons.lock,
                                                                                      size: 15.0,
                                                                                    ),
                                                                                    options: FFButtonOptions(
                                                                                      height: 32.0,
                                                                                      padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
                                                                                      iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                                                      color: FlutterFlowTheme.of(context).otherColour,
                                                                                      textStyle: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                            font: GoogleFonts.inter(
                                                                                              fontWeight: FontWeight.w600,
                                                                                              fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                            ),
                                                                                            color: Colors.white,
                                                                                            fontSize: 12.0,
                                                                                            letterSpacing: 0.0,
                                                                                            fontWeight: FontWeight.w600,
                                                                                            fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                          ),
                                                                                      elevation: 0.0,
                                                                                      borderRadius: BorderRadius.circular(6.0),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  );
                                                                },
                                                              );
                                                            },
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  if (_model.showMyBookings ==
                                                      'Pending')
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  6.0,
                                                                  5.0,
                                                                  6.0,
                                                                  5.0),
                                                      child: StreamBuilder<
                                                          List<
                                                              BidsForMarketPlaceRecord>>(
                                                        stream:
                                                            queryBidsForMarketPlaceRecord(
                                                          queryBuilder:
                                                              (bidsForMarketPlaceRecord) =>
                                                                  bidsForMarketPlaceRecord
                                                                      .where(
                                                                        'bidsCreatorID',
                                                                        isEqualTo:
                                                                            currentUserReference,
                                                                      )
                                                                      .where(
                                                                        'status',
                                                                        isEqualTo:
                                                                            'Pending',
                                                                      ),
                                                        ),
                                                        builder: (context,
                                                            snapshot) {
                                                          // Customize what your widget looks like when it's loading.
                                                          if (!snapshot
                                                              .hasData) {
                                                            return Center(
                                                              child: SizedBox(
                                                                width: 50.0,
                                                                height: 50.0,
                                                                child:
                                                                    SpinKitFadingCircle(
                                                                  color: Color(
                                                                      0xFF2B3C58),
                                                                  size: 50.0,
                                                                ),
                                                              ),
                                                            );
                                                          }
                                                          List<BidsForMarketPlaceRecord>
                                                              pendingBookingsBidsForMarketPlaceRecordList =
                                                              snapshot.data!;

                                                          return ListView
                                                              .separated(
                                                            padding:
                                                                EdgeInsets.zero,
                                                            physics:
                                                                NeverScrollableScrollPhysics(),
                                                            primary: false,
                                                            shrinkWrap: true,
                                                            scrollDirection:
                                                                Axis.vertical,
                                                            itemCount:
                                                                pendingBookingsBidsForMarketPlaceRecordList
                                                                    .length,
                                                            separatorBuilder: (_,
                                                                    __) =>
                                                                SizedBox(
                                                                    height:
                                                                        15.0),
                                                            itemBuilder: (context,
                                                                pendingBookingsIndex) {
                                                              final pendingBookingsBidsForMarketPlaceRecord =
                                                                  pendingBookingsBidsForMarketPlaceRecordList[
                                                                      pendingBookingsIndex];
                                                              return StreamBuilder<
                                                                  MarketPlaceRecord>(
                                                                stream: MarketPlaceRecord
                                                                    .getDocument(
                                                                        pendingBookingsBidsForMarketPlaceRecord
                                                                            .marketPlaceRef!),
                                                                builder: (context,
                                                                    snapshot) {
                                                                  // Customize what your widget looks like when it's loading.
                                                                  if (!snapshot
                                                                      .hasData) {
                                                                    return Center(
                                                                      child:
                                                                          SizedBox(
                                                                        width:
                                                                            50.0,
                                                                        height:
                                                                            50.0,
                                                                        child:
                                                                            SpinKitFadingCircle(
                                                                          color:
                                                                              Color(0xFF2B3C58),
                                                                          size:
                                                                              50.0,
                                                                        ),
                                                                      ),
                                                                    );
                                                                  }

                                                                  final containerMarketPlaceRecord =
                                                                      snapshot
                                                                          .data!;

                                                                  return Material(
                                                                    color: Colors
                                                                        .transparent,
                                                                    elevation:
                                                                        2.0,
                                                                    shape:
                                                                        RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              12.0),
                                                                    ),
                                                                    child:
                                                                        Container(
                                                                      width: double
                                                                          .infinity,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primaryBackground,
                                                                        borderRadius:
                                                                            BorderRadius.circular(12.0),
                                                                        border:
                                                                            Border.all(
                                                                          color:
                                                                              FlutterFlowTheme.of(context).alternate,
                                                                          width:
                                                                              1.0,
                                                                        ),
                                                                      ),
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            EdgeInsets.all(16.0),
                                                                        child:
                                                                            Column(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          children: [
                                                                            Row(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                Flexible(
                                                                                  child: Column(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                    children: [
                                                                                      Padding(
                                                                                        padding: EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 0.0),
                                                                                        child: Text(
                                                                                          'Placed on ${dateTimeFormat("yMMMd", pendingBookingsBidsForMarketPlaceRecord.createAt)}',
                                                                                          style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                                font: GoogleFonts.inter(
                                                                                                  fontWeight: FontWeight.w600,
                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                                ),
                                                                                                color: FlutterFlowTheme.of(context).primaryText,
                                                                                                fontSize: 12.0,
                                                                                                letterSpacing: 0.0,
                                                                                                fontWeight: FontWeight.w600,
                                                                                                fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                              ),
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                                Container(
                                                                                  width: 80.0,
                                                                                  height: 28.0,
                                                                                  decoration: BoxDecoration(
                                                                                    color: () {
                                                                                      if (pendingBookingsBidsForMarketPlaceRecord.status == 'Completed') {
                                                                                        return FlutterFlowTheme.of(context).success;
                                                                                      } else if (pendingBookingsBidsForMarketPlaceRecord.status == 'Accepted') {
                                                                                        return Color(0xFFFD803D);
                                                                                      } else if (pendingBookingsBidsForMarketPlaceRecord.status == 'Rejected') {
                                                                                        return FlutterFlowTheme.of(context).error;
                                                                                      } else {
                                                                                        return FlutterFlowTheme.of(context).warning;
                                                                                      }
                                                                                    }(),
                                                                                    borderRadius: BorderRadius.circular(14.0),
                                                                                  ),
                                                                                  child: Align(
                                                                                    alignment: AlignmentDirectional(0.0, 0.0),
                                                                                    child: Padding(
                                                                                      padding: EdgeInsets.all(8.0),
                                                                                      child: Text(
                                                                                        pendingBookingsBidsForMarketPlaceRecord.status,
                                                                                        textAlign: TextAlign.center,
                                                                                        style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                              font: GoogleFonts.inter(
                                                                                                fontWeight: FontWeight.w600,
                                                                                                fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                              ),
                                                                                              color: Colors.white,
                                                                                              fontSize: 11.0,
                                                                                              letterSpacing: 0.0,
                                                                                              fontWeight: FontWeight.w600,
                                                                                              fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                            ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            Divider(
                                                                              height: 20.0,
                                                                              thickness: 1.0,
                                                                              color: FlutterFlowTheme.of(context).alternate,
                                                                            ),
                                                                            Row(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              children: [
                                                                                ClipRRect(
                                                                                  borderRadius: BorderRadius.circular(8.0),
                                                                                  child: Image.network(
                                                                                    containerMarketPlaceRecord.imageOfproduct,
                                                                                    width: 60.0,
                                                                                    height: 60.0,
                                                                                    fit: BoxFit.cover,
                                                                                  ),
                                                                                ),
                                                                                Flexible(
                                                                                  child: Column(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                    children: [
                                                                                      Text(
                                                                                        containerMarketPlaceRecord.productName,
                                                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                              font: GoogleFonts.inter(
                                                                                                fontWeight: FontWeight.w500,
                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                              ),
                                                                                              color: FlutterFlowTheme.of(context).primaryText,
                                                                                              fontSize: 14.0,
                                                                                              letterSpacing: 0.0,
                                                                                              fontWeight: FontWeight.w500,
                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                            ),
                                                                                      ),
                                                                                      Padding(
                                                                                        padding: EdgeInsetsDirectional.fromSTEB(0.0, 2.0, 0.0, 0.0),
                                                                                        child: Text(
                                                                                          containerMarketPlaceRecord.descriptionItem,
                                                                                          style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                                font: GoogleFonts.inter(
                                                                                                  fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                                ),
                                                                                                color: FlutterFlowTheme.of(context).primaryText,
                                                                                                fontSize: 12.0,
                                                                                                letterSpacing: 0.0,
                                                                                                fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                                fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                              ),
                                                                                        ),
                                                                                      ),
                                                                                      Padding(
                                                                                        padding: EdgeInsetsDirectional.fromSTEB(0.0, 2.0, 0.0, 0.0),
                                                                                        child: Text(
                                                                                          'Quantity: ${pendingBookingsBidsForMarketPlaceRecord.quantity.toString()}',
                                                                                          style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                                font: GoogleFonts.inter(
                                                                                                  fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                                ),
                                                                                                color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                fontSize: 12.0,
                                                                                                letterSpacing: 0.0,
                                                                                                fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                                fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                              ),
                                                                                        ),
                                                                                      ),
                                                                                      Padding(
                                                                                        padding: EdgeInsetsDirectional.fromSTEB(0.0, 2.0, 0.0, 0.0),
                                                                                        child: Text(
                                                                                          '₹${pendingBookingsBidsForMarketPlaceRecord.price.toString()} each',
                                                                                          style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                                font: GoogleFonts.inter(
                                                                                                  fontWeight: FontWeight.w600,
                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                                ),
                                                                                                color: FlutterFlowTheme.of(context).primary,
                                                                                                fontSize: 12.0,
                                                                                                letterSpacing: 0.0,
                                                                                                fontWeight: FontWeight.w600,
                                                                                                fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                              ),
                                                                                        ),
                                                                                      ),
                                                                                      Padding(
                                                                                        padding: EdgeInsetsDirectional.fromSTEB(0.0, 2.0, 0.0, 0.0),
                                                                                        child: Text(
                                                                                          pendingBookingsBidsForMarketPlaceRecord.description,
                                                                                          style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                                font: GoogleFonts.inter(
                                                                                                  fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                                ),
                                                                                                color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                fontSize: 12.0,
                                                                                                letterSpacing: 0.0,
                                                                                                fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                                fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                              ),
                                                                                        ),
                                                                                      ),
                                                                                    ].divide(SizedBox(height: 3.0)),
                                                                                  ),
                                                                                ),
                                                                                Column(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                                                  children: [
                                                                                    Text(
                                                                                      '₹${(pendingBookingsBidsForMarketPlaceRecord.price * pendingBookingsBidsForMarketPlaceRecord.quantity).toString()}',
                                                                                      style: FlutterFlowTheme.of(context).titleMedium.override(
                                                                                            font: GoogleFonts.interTight(
                                                                                              fontWeight: FontWeight.w600,
                                                                                              fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                                            ),
                                                                                            color: FlutterFlowTheme.of(context).primaryText,
                                                                                            fontSize: 16.0,
                                                                                            letterSpacing: 0.0,
                                                                                            fontWeight: FontWeight.w600,
                                                                                            fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                                          ),
                                                                                    ),
                                                                                    Text(
                                                                                      'Total',
                                                                                      style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                            font: GoogleFonts.inter(
                                                                                              fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                              fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                            ),
                                                                                            color: FlutterFlowTheme.of(context).secondaryText,
                                                                                            fontSize: 11.0,
                                                                                            letterSpacing: 0.0,
                                                                                            fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                            fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                          ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ].divide(SizedBox(width: 12.0)),
                                                                            ),
                                                                            Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
                                                                              child: Row(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                children: [
                                                                                  FFButtonWidget(
                                                                                    onPressed: () async {
                                                                                      context.pushNamed(
                                                                                        MarketPlaceBidYourRateWidget.routeName,
                                                                                        queryParameters: {
                                                                                          'marketPlaceBids': serializeParam(
                                                                                            containerMarketPlaceRecord.reference,
                                                                                            ParamType.DocumentReference,
                                                                                          ),
                                                                                        }.withoutNulls,
                                                                                      );
                                                                                    },
                                                                                    text: 'Reorder',
                                                                                    options: FFButtonOptions(
                                                                                      height: 32.0,
                                                                                      padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
                                                                                      iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                                                      color: FlutterFlowTheme.of(context).secondary,
                                                                                      textStyle: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                            font: GoogleFonts.inter(
                                                                                              fontWeight: FontWeight.w600,
                                                                                              fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                            ),
                                                                                            color: Colors.white,
                                                                                            fontSize: 12.0,
                                                                                            letterSpacing: 0.0,
                                                                                            fontWeight: FontWeight.w600,
                                                                                            fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                          ),
                                                                                      elevation: 0.0,
                                                                                      borderRadius: BorderRadius.circular(6.0),
                                                                                    ),
                                                                                  ),
                                                                                  FFButtonWidget(
                                                                                    onPressed: () async {
                                                                                      context.pushNamed(PlansWidget.routeName);

                                                                                      ScaffoldMessenger.of(context).showSnackBar(
                                                                                        SnackBar(
                                                                                          content: Text(
                                                                                            'You don\'t have to have an active plan to use this feature.',
                                                                                            style: TextStyle(
                                                                                              color: FlutterFlowTheme.of(context).primaryText,
                                                                                            ),
                                                                                          ),
                                                                                          duration: Duration(milliseconds: 4000),
                                                                                          backgroundColor: FlutterFlowTheme.of(context).secondary,
                                                                                        ),
                                                                                      );
                                                                                    },
                                                                                    text: 'Contact Seller',
                                                                                    icon: Icon(
                                                                                      Icons.lock,
                                                                                      size: 15.0,
                                                                                    ),
                                                                                    options: FFButtonOptions(
                                                                                      height: 32.0,
                                                                                      padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
                                                                                      iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                                                      color: FlutterFlowTheme.of(context).otherColour,
                                                                                      textStyle: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                            font: GoogleFonts.inter(
                                                                                              fontWeight: FontWeight.w600,
                                                                                              fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                            ),
                                                                                            color: Colors.white,
                                                                                            fontSize: 12.0,
                                                                                            letterSpacing: 0.0,
                                                                                            fontWeight: FontWeight.w600,
                                                                                            fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                          ),
                                                                                      elevation: 0.0,
                                                                                      borderRadius: BorderRadius.circular(6.0),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  );
                                                                },
                                                              );
                                                            },
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  if (_model.showMyBookings ==
                                                      'Accepted')
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  6.0,
                                                                  5.0,
                                                                  6.0,
                                                                  5.0),
                                                      child: StreamBuilder<
                                                          List<
                                                              BidsForMarketPlaceRecord>>(
                                                        stream:
                                                            queryBidsForMarketPlaceRecord(
                                                          queryBuilder:
                                                              (bidsForMarketPlaceRecord) =>
                                                                  bidsForMarketPlaceRecord
                                                                      .where(
                                                                        'bidsCreatorID',
                                                                        isEqualTo:
                                                                            currentUserReference,
                                                                      )
                                                                      .where(
                                                                        'status',
                                                                        isEqualTo:
                                                                            'Accepted',
                                                                      ),
                                                        ),
                                                        builder: (context,
                                                            snapshot) {
                                                          // Customize what your widget looks like when it's loading.
                                                          if (!snapshot
                                                              .hasData) {
                                                            return Center(
                                                              child: SizedBox(
                                                                width: 50.0,
                                                                height: 50.0,
                                                                child:
                                                                    SpinKitFadingCircle(
                                                                  color: Color(
                                                                      0xFF2B3C58),
                                                                  size: 50.0,
                                                                ),
                                                              ),
                                                            );
                                                          }
                                                          List<BidsForMarketPlaceRecord>
                                                              acceptedBookingsBidsForMarketPlaceRecordList =
                                                              snapshot.data!;

                                                          return ListView
                                                              .separated(
                                                            padding:
                                                                EdgeInsets.zero,
                                                            physics:
                                                                NeverScrollableScrollPhysics(),
                                                            primary: false,
                                                            shrinkWrap: true,
                                                            scrollDirection:
                                                                Axis.vertical,
                                                            itemCount:
                                                                acceptedBookingsBidsForMarketPlaceRecordList
                                                                    .length,
                                                            separatorBuilder: (_,
                                                                    __) =>
                                                                SizedBox(
                                                                    height:
                                                                        15.0),
                                                            itemBuilder: (context,
                                                                acceptedBookingsIndex) {
                                                              final acceptedBookingsBidsForMarketPlaceRecord =
                                                                  acceptedBookingsBidsForMarketPlaceRecordList[
                                                                      acceptedBookingsIndex];
                                                              return StreamBuilder<
                                                                  MarketPlaceRecord>(
                                                                stream: MarketPlaceRecord
                                                                    .getDocument(
                                                                        acceptedBookingsBidsForMarketPlaceRecord
                                                                            .marketPlaceRef!),
                                                                builder: (context,
                                                                    snapshot) {
                                                                  // Customize what your widget looks like when it's loading.
                                                                  if (!snapshot
                                                                      .hasData) {
                                                                    return Center(
                                                                      child:
                                                                          SizedBox(
                                                                        width:
                                                                            50.0,
                                                                        height:
                                                                            50.0,
                                                                        child:
                                                                            SpinKitFadingCircle(
                                                                          color:
                                                                              Color(0xFF2B3C58),
                                                                          size:
                                                                              50.0,
                                                                        ),
                                                                      ),
                                                                    );
                                                                  }

                                                                  final containerMarketPlaceRecord =
                                                                      snapshot
                                                                          .data!;

                                                                  return Material(
                                                                    color: Colors
                                                                        .transparent,
                                                                    elevation:
                                                                        2.0,
                                                                    shape:
                                                                        RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              12.0),
                                                                    ),
                                                                    child:
                                                                        Container(
                                                                      width: double
                                                                          .infinity,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primaryBackground,
                                                                        borderRadius:
                                                                            BorderRadius.circular(12.0),
                                                                        border:
                                                                            Border.all(
                                                                          color:
                                                                              FlutterFlowTheme.of(context).alternate,
                                                                          width:
                                                                              1.0,
                                                                        ),
                                                                      ),
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            EdgeInsets.all(16.0),
                                                                        child:
                                                                            Column(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          children: [
                                                                            Row(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                Flexible(
                                                                                  child: Column(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                    children: [
                                                                                      Padding(
                                                                                        padding: EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 0.0),
                                                                                        child: Text(
                                                                                          'Placed on ${dateTimeFormat("yMMMd", acceptedBookingsBidsForMarketPlaceRecord.createAt)}',
                                                                                          style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                                font: GoogleFonts.inter(
                                                                                                  fontWeight: FontWeight.w600,
                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                                ),
                                                                                                color: FlutterFlowTheme.of(context).primaryText,
                                                                                                fontSize: 12.0,
                                                                                                letterSpacing: 0.0,
                                                                                                fontWeight: FontWeight.w600,
                                                                                                fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                              ),
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                                Container(
                                                                                  width: 80.0,
                                                                                  height: 28.0,
                                                                                  decoration: BoxDecoration(
                                                                                    color: () {
                                                                                      if (acceptedBookingsBidsForMarketPlaceRecord.status == 'Completed') {
                                                                                        return FlutterFlowTheme.of(context).success;
                                                                                      } else if (acceptedBookingsBidsForMarketPlaceRecord.status == 'Accepted') {
                                                                                        return Color(0xFFFD803D);
                                                                                      } else if (acceptedBookingsBidsForMarketPlaceRecord.status == 'Rejected') {
                                                                                        return FlutterFlowTheme.of(context).error;
                                                                                      } else {
                                                                                        return FlutterFlowTheme.of(context).warning;
                                                                                      }
                                                                                    }(),
                                                                                    borderRadius: BorderRadius.circular(14.0),
                                                                                  ),
                                                                                  child: Align(
                                                                                    alignment: AlignmentDirectional(0.0, 0.0),
                                                                                    child: Padding(
                                                                                      padding: EdgeInsets.all(8.0),
                                                                                      child: Text(
                                                                                        acceptedBookingsBidsForMarketPlaceRecord.status,
                                                                                        textAlign: TextAlign.center,
                                                                                        style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                              font: GoogleFonts.inter(
                                                                                                fontWeight: FontWeight.w600,
                                                                                                fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                              ),
                                                                                              color: Colors.white,
                                                                                              fontSize: 11.0,
                                                                                              letterSpacing: 0.0,
                                                                                              fontWeight: FontWeight.w600,
                                                                                              fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                            ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            Divider(
                                                                              height: 20.0,
                                                                              thickness: 1.0,
                                                                              color: FlutterFlowTheme.of(context).alternate,
                                                                            ),
                                                                            Row(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              children: [
                                                                                ClipRRect(
                                                                                  borderRadius: BorderRadius.circular(8.0),
                                                                                  child: Image.network(
                                                                                    containerMarketPlaceRecord.imageOfproduct,
                                                                                    width: 60.0,
                                                                                    height: 60.0,
                                                                                    fit: BoxFit.cover,
                                                                                  ),
                                                                                ),
                                                                                Flexible(
                                                                                  child: Column(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                    children: [
                                                                                      Text(
                                                                                        containerMarketPlaceRecord.productName,
                                                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                              font: GoogleFonts.inter(
                                                                                                fontWeight: FontWeight.w500,
                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                              ),
                                                                                              color: FlutterFlowTheme.of(context).primaryText,
                                                                                              fontSize: 14.0,
                                                                                              letterSpacing: 0.0,
                                                                                              fontWeight: FontWeight.w500,
                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                            ),
                                                                                      ),
                                                                                      Padding(
                                                                                        padding: EdgeInsetsDirectional.fromSTEB(0.0, 2.0, 0.0, 0.0),
                                                                                        child: Text(
                                                                                          containerMarketPlaceRecord.descriptionItem,
                                                                                          style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                                font: GoogleFonts.inter(
                                                                                                  fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                                ),
                                                                                                color: FlutterFlowTheme.of(context).primaryText,
                                                                                                fontSize: 12.0,
                                                                                                letterSpacing: 0.0,
                                                                                                fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                                fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                              ),
                                                                                        ),
                                                                                      ),
                                                                                      Padding(
                                                                                        padding: EdgeInsetsDirectional.fromSTEB(0.0, 2.0, 0.0, 0.0),
                                                                                        child: Text(
                                                                                          'Quantity: ${acceptedBookingsBidsForMarketPlaceRecord.quantity.toString()}',
                                                                                          style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                                font: GoogleFonts.inter(
                                                                                                  fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                                ),
                                                                                                color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                fontSize: 12.0,
                                                                                                letterSpacing: 0.0,
                                                                                                fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                                fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                              ),
                                                                                        ),
                                                                                      ),
                                                                                      Padding(
                                                                                        padding: EdgeInsetsDirectional.fromSTEB(0.0, 2.0, 0.0, 0.0),
                                                                                        child: Text(
                                                                                          '₹${acceptedBookingsBidsForMarketPlaceRecord.price.toString()} each',
                                                                                          style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                                font: GoogleFonts.inter(
                                                                                                  fontWeight: FontWeight.w600,
                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                                ),
                                                                                                color: FlutterFlowTheme.of(context).primary,
                                                                                                fontSize: 12.0,
                                                                                                letterSpacing: 0.0,
                                                                                                fontWeight: FontWeight.w600,
                                                                                                fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                              ),
                                                                                        ),
                                                                                      ),
                                                                                      Padding(
                                                                                        padding: EdgeInsetsDirectional.fromSTEB(0.0, 2.0, 0.0, 0.0),
                                                                                        child: Text(
                                                                                          acceptedBookingsBidsForMarketPlaceRecord.description,
                                                                                          style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                                font: GoogleFonts.inter(
                                                                                                  fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                                ),
                                                                                                color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                fontSize: 12.0,
                                                                                                letterSpacing: 0.0,
                                                                                                fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                                fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                              ),
                                                                                        ),
                                                                                      ),
                                                                                    ].divide(SizedBox(height: 3.0)),
                                                                                  ),
                                                                                ),
                                                                                Column(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                                                  children: [
                                                                                    Text(
                                                                                      '₹${(acceptedBookingsBidsForMarketPlaceRecord.price * acceptedBookingsBidsForMarketPlaceRecord.quantity).toString()}',
                                                                                      style: FlutterFlowTheme.of(context).titleMedium.override(
                                                                                            font: GoogleFonts.interTight(
                                                                                              fontWeight: FontWeight.w600,
                                                                                              fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                                            ),
                                                                                            color: FlutterFlowTheme.of(context).primaryText,
                                                                                            fontSize: 16.0,
                                                                                            letterSpacing: 0.0,
                                                                                            fontWeight: FontWeight.w600,
                                                                                            fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                                          ),
                                                                                    ),
                                                                                    Text(
                                                                                      'Total',
                                                                                      style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                            font: GoogleFonts.inter(
                                                                                              fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                              fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                            ),
                                                                                            color: FlutterFlowTheme.of(context).secondaryText,
                                                                                            fontSize: 11.0,
                                                                                            letterSpacing: 0.0,
                                                                                            fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                            fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                          ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ].divide(SizedBox(width: 12.0)),
                                                                            ),
                                                                            Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
                                                                              child: Row(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                children: [
                                                                                  FFButtonWidget(
                                                                                    onPressed: () async {
                                                                                      context.pushNamed(
                                                                                        MarketPlaceBidYourRateWidget.routeName,
                                                                                        queryParameters: {
                                                                                          'marketPlaceBids': serializeParam(
                                                                                            containerMarketPlaceRecord.reference,
                                                                                            ParamType.DocumentReference,
                                                                                          ),
                                                                                        }.withoutNulls,
                                                                                      );
                                                                                    },
                                                                                    text: 'Reorder',
                                                                                    options: FFButtonOptions(
                                                                                      height: 32.0,
                                                                                      padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
                                                                                      iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                                                      color: FlutterFlowTheme.of(context).secondary,
                                                                                      textStyle: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                            font: GoogleFonts.inter(
                                                                                              fontWeight: FontWeight.w600,
                                                                                              fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                            ),
                                                                                            color: Colors.white,
                                                                                            fontSize: 12.0,
                                                                                            letterSpacing: 0.0,
                                                                                            fontWeight: FontWeight.w600,
                                                                                            fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                          ),
                                                                                      elevation: 0.0,
                                                                                      borderRadius: BorderRadius.circular(6.0),
                                                                                    ),
                                                                                  ),
                                                                                  FFButtonWidget(
                                                                                    onPressed: () async {
                                                                                      context.pushNamed(PlansWidget.routeName);

                                                                                      ScaffoldMessenger.of(context).showSnackBar(
                                                                                        SnackBar(
                                                                                          content: Text(
                                                                                            'You don\'t have to have an active plan to use this feature.',
                                                                                            style: TextStyle(
                                                                                              color: FlutterFlowTheme.of(context).primaryText,
                                                                                            ),
                                                                                          ),
                                                                                          duration: Duration(milliseconds: 4000),
                                                                                          backgroundColor: FlutterFlowTheme.of(context).secondary,
                                                                                        ),
                                                                                      );
                                                                                    },
                                                                                    text: 'Contact Seller',
                                                                                    icon: Icon(
                                                                                      Icons.lock,
                                                                                      size: 15.0,
                                                                                    ),
                                                                                    options: FFButtonOptions(
                                                                                      height: 32.0,
                                                                                      padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
                                                                                      iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                                                      color: FlutterFlowTheme.of(context).otherColour,
                                                                                      textStyle: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                            font: GoogleFonts.inter(
                                                                                              fontWeight: FontWeight.w600,
                                                                                              fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                            ),
                                                                                            color: Colors.white,
                                                                                            fontSize: 12.0,
                                                                                            letterSpacing: 0.0,
                                                                                            fontWeight: FontWeight.w600,
                                                                                            fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                          ),
                                                                                      elevation: 0.0,
                                                                                      borderRadius: BorderRadius.circular(6.0),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  );
                                                                },
                                                              );
                                                            },
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  if (_model.showMyBookings ==
                                                      'Completed')
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  6.0,
                                                                  5.0,
                                                                  6.0,
                                                                  5.0),
                                                      child: StreamBuilder<
                                                          List<
                                                              BidsForMarketPlaceRecord>>(
                                                        stream:
                                                            queryBidsForMarketPlaceRecord(
                                                          queryBuilder:
                                                              (bidsForMarketPlaceRecord) =>
                                                                  bidsForMarketPlaceRecord
                                                                      .where(
                                                                        'bidsCreatorID',
                                                                        isEqualTo:
                                                                            currentUserReference,
                                                                      )
                                                                      .where(
                                                                        'status',
                                                                        isEqualTo:
                                                                            'Completed',
                                                                      ),
                                                        ),
                                                        builder: (context,
                                                            snapshot) {
                                                          // Customize what your widget looks like when it's loading.
                                                          if (!snapshot
                                                              .hasData) {
                                                            return Center(
                                                              child: SizedBox(
                                                                width: 50.0,
                                                                height: 50.0,
                                                                child:
                                                                    SpinKitFadingCircle(
                                                                  color: Color(
                                                                      0xFF2B3C58),
                                                                  size: 50.0,
                                                                ),
                                                              ),
                                                            );
                                                          }
                                                          List<BidsForMarketPlaceRecord>
                                                              completedBookingsBidsForMarketPlaceRecordList =
                                                              snapshot.data!;

                                                          return ListView
                                                              .separated(
                                                            padding:
                                                                EdgeInsets.zero,
                                                            physics:
                                                                NeverScrollableScrollPhysics(),
                                                            primary: false,
                                                            shrinkWrap: true,
                                                            scrollDirection:
                                                                Axis.vertical,
                                                            itemCount:
                                                                completedBookingsBidsForMarketPlaceRecordList
                                                                    .length,
                                                            separatorBuilder: (_,
                                                                    __) =>
                                                                SizedBox(
                                                                    height:
                                                                        15.0),
                                                            itemBuilder: (context,
                                                                completedBookingsIndex) {
                                                              final completedBookingsBidsForMarketPlaceRecord =
                                                                  completedBookingsBidsForMarketPlaceRecordList[
                                                                      completedBookingsIndex];
                                                              return StreamBuilder<
                                                                  MarketPlaceRecord>(
                                                                stream: MarketPlaceRecord
                                                                    .getDocument(
                                                                        completedBookingsBidsForMarketPlaceRecord
                                                                            .marketPlaceRef!),
                                                                builder: (context,
                                                                    snapshot) {
                                                                  // Customize what your widget looks like when it's loading.
                                                                  if (!snapshot
                                                                      .hasData) {
                                                                    return Center(
                                                                      child:
                                                                          SizedBox(
                                                                        width:
                                                                            50.0,
                                                                        height:
                                                                            50.0,
                                                                        child:
                                                                            SpinKitFadingCircle(
                                                                          color:
                                                                              Color(0xFF2B3C58),
                                                                          size:
                                                                              50.0,
                                                                        ),
                                                                      ),
                                                                    );
                                                                  }

                                                                  final containerMarketPlaceRecord =
                                                                      snapshot
                                                                          .data!;

                                                                  return Material(
                                                                    color: Colors
                                                                        .transparent,
                                                                    elevation:
                                                                        2.0,
                                                                    shape:
                                                                        RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              12.0),
                                                                    ),
                                                                    child:
                                                                        Container(
                                                                      width: double
                                                                          .infinity,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primaryBackground,
                                                                        borderRadius:
                                                                            BorderRadius.circular(12.0),
                                                                        border:
                                                                            Border.all(
                                                                          color:
                                                                              FlutterFlowTheme.of(context).alternate,
                                                                          width:
                                                                              1.0,
                                                                        ),
                                                                      ),
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            EdgeInsets.all(16.0),
                                                                        child:
                                                                            Column(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          children: [
                                                                            Row(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                Flexible(
                                                                                  child: Column(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                    children: [
                                                                                      Padding(
                                                                                        padding: EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 0.0),
                                                                                        child: Text(
                                                                                          'Placed on ${dateTimeFormat("yMMMd", completedBookingsBidsForMarketPlaceRecord.createAt)}',
                                                                                          style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                                font: GoogleFonts.inter(
                                                                                                  fontWeight: FontWeight.w600,
                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                                ),
                                                                                                color: FlutterFlowTheme.of(context).primaryText,
                                                                                                fontSize: 12.0,
                                                                                                letterSpacing: 0.0,
                                                                                                fontWeight: FontWeight.w600,
                                                                                                fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                              ),
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                                Container(
                                                                                  width: 80.0,
                                                                                  height: 28.0,
                                                                                  decoration: BoxDecoration(
                                                                                    color: () {
                                                                                      if (completedBookingsBidsForMarketPlaceRecord.status == 'Completed') {
                                                                                        return FlutterFlowTheme.of(context).success;
                                                                                      } else if (completedBookingsBidsForMarketPlaceRecord.status == 'Accepted') {
                                                                                        return Color(0xFFFD803D);
                                                                                      } else if (completedBookingsBidsForMarketPlaceRecord.status == 'Rejected') {
                                                                                        return FlutterFlowTheme.of(context).error;
                                                                                      } else {
                                                                                        return FlutterFlowTheme.of(context).warning;
                                                                                      }
                                                                                    }(),
                                                                                    borderRadius: BorderRadius.circular(14.0),
                                                                                  ),
                                                                                  child: Align(
                                                                                    alignment: AlignmentDirectional(0.0, 0.0),
                                                                                    child: Padding(
                                                                                      padding: EdgeInsets.all(8.0),
                                                                                      child: Text(
                                                                                        completedBookingsBidsForMarketPlaceRecord.status,
                                                                                        textAlign: TextAlign.center,
                                                                                        style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                              font: GoogleFonts.inter(
                                                                                                fontWeight: FontWeight.w600,
                                                                                                fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                              ),
                                                                                              color: Colors.white,
                                                                                              fontSize: 11.0,
                                                                                              letterSpacing: 0.0,
                                                                                              fontWeight: FontWeight.w600,
                                                                                              fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                            ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            Divider(
                                                                              height: 20.0,
                                                                              thickness: 1.0,
                                                                              color: FlutterFlowTheme.of(context).alternate,
                                                                            ),
                                                                            Row(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              children: [
                                                                                ClipRRect(
                                                                                  borderRadius: BorderRadius.circular(8.0),
                                                                                  child: Image.network(
                                                                                    containerMarketPlaceRecord.imageOfproduct,
                                                                                    width: 60.0,
                                                                                    height: 60.0,
                                                                                    fit: BoxFit.cover,
                                                                                  ),
                                                                                ),
                                                                                Flexible(
                                                                                  child: Column(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                    children: [
                                                                                      Text(
                                                                                        containerMarketPlaceRecord.productName,
                                                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                              font: GoogleFonts.inter(
                                                                                                fontWeight: FontWeight.w500,
                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                              ),
                                                                                              color: FlutterFlowTheme.of(context).primaryText,
                                                                                              fontSize: 14.0,
                                                                                              letterSpacing: 0.0,
                                                                                              fontWeight: FontWeight.w500,
                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                            ),
                                                                                      ),
                                                                                      Padding(
                                                                                        padding: EdgeInsetsDirectional.fromSTEB(0.0, 2.0, 0.0, 0.0),
                                                                                        child: Text(
                                                                                          containerMarketPlaceRecord.descriptionItem,
                                                                                          style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                                font: GoogleFonts.inter(
                                                                                                  fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                                ),
                                                                                                color: FlutterFlowTheme.of(context).primaryText,
                                                                                                fontSize: 12.0,
                                                                                                letterSpacing: 0.0,
                                                                                                fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                                fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                              ),
                                                                                        ),
                                                                                      ),
                                                                                      Padding(
                                                                                        padding: EdgeInsetsDirectional.fromSTEB(0.0, 2.0, 0.0, 0.0),
                                                                                        child: Text(
                                                                                          'Quantity: ${completedBookingsBidsForMarketPlaceRecord.quantity.toString()}',
                                                                                          style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                                font: GoogleFonts.inter(
                                                                                                  fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                                ),
                                                                                                color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                fontSize: 12.0,
                                                                                                letterSpacing: 0.0,
                                                                                                fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                                fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                              ),
                                                                                        ),
                                                                                      ),
                                                                                      Padding(
                                                                                        padding: EdgeInsetsDirectional.fromSTEB(0.0, 2.0, 0.0, 0.0),
                                                                                        child: Text(
                                                                                          '₹${completedBookingsBidsForMarketPlaceRecord.price.toString()} each',
                                                                                          style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                                font: GoogleFonts.inter(
                                                                                                  fontWeight: FontWeight.w600,
                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                                ),
                                                                                                color: FlutterFlowTheme.of(context).primary,
                                                                                                fontSize: 12.0,
                                                                                                letterSpacing: 0.0,
                                                                                                fontWeight: FontWeight.w600,
                                                                                                fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                              ),
                                                                                        ),
                                                                                      ),
                                                                                      Padding(
                                                                                        padding: EdgeInsetsDirectional.fromSTEB(0.0, 2.0, 0.0, 0.0),
                                                                                        child: Text(
                                                                                          completedBookingsBidsForMarketPlaceRecord.description,
                                                                                          style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                                font: GoogleFonts.inter(
                                                                                                  fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                                ),
                                                                                                color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                fontSize: 12.0,
                                                                                                letterSpacing: 0.0,
                                                                                                fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                                fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                              ),
                                                                                        ),
                                                                                      ),
                                                                                    ].divide(SizedBox(height: 3.0)),
                                                                                  ),
                                                                                ),
                                                                                Column(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                                                  children: [
                                                                                    Text(
                                                                                      '₹${(completedBookingsBidsForMarketPlaceRecord.price * completedBookingsBidsForMarketPlaceRecord.quantity).toString()}',
                                                                                      style: FlutterFlowTheme.of(context).titleMedium.override(
                                                                                            font: GoogleFonts.interTight(
                                                                                              fontWeight: FontWeight.w600,
                                                                                              fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                                            ),
                                                                                            color: FlutterFlowTheme.of(context).primaryText,
                                                                                            fontSize: 16.0,
                                                                                            letterSpacing: 0.0,
                                                                                            fontWeight: FontWeight.w600,
                                                                                            fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                                          ),
                                                                                    ),
                                                                                    Text(
                                                                                      'Total',
                                                                                      style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                            font: GoogleFonts.inter(
                                                                                              fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                              fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                            ),
                                                                                            color: FlutterFlowTheme.of(context).secondaryText,
                                                                                            fontSize: 11.0,
                                                                                            letterSpacing: 0.0,
                                                                                            fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                            fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                          ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ].divide(SizedBox(width: 12.0)),
                                                                            ),
                                                                            Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
                                                                              child: Row(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                children: [
                                                                                  FFButtonWidget(
                                                                                    onPressed: () async {
                                                                                      context.pushNamed(
                                                                                        MarketPlaceBidYourRateWidget.routeName,
                                                                                        queryParameters: {
                                                                                          'marketPlaceBids': serializeParam(
                                                                                            containerMarketPlaceRecord.reference,
                                                                                            ParamType.DocumentReference,
                                                                                          ),
                                                                                        }.withoutNulls,
                                                                                      );
                                                                                    },
                                                                                    text: 'Reorder',
                                                                                    options: FFButtonOptions(
                                                                                      height: 32.0,
                                                                                      padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
                                                                                      iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                                                      color: FlutterFlowTheme.of(context).secondary,
                                                                                      textStyle: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                            font: GoogleFonts.inter(
                                                                                              fontWeight: FontWeight.w600,
                                                                                              fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                            ),
                                                                                            color: Colors.white,
                                                                                            fontSize: 12.0,
                                                                                            letterSpacing: 0.0,
                                                                                            fontWeight: FontWeight.w600,
                                                                                            fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                          ),
                                                                                      elevation: 0.0,
                                                                                      borderRadius: BorderRadius.circular(6.0),
                                                                                    ),
                                                                                  ),
                                                                                  FFButtonWidget(
                                                                                    onPressed: () async {
                                                                                      context.pushNamed(PlansWidget.routeName);

                                                                                      ScaffoldMessenger.of(context).showSnackBar(
                                                                                        SnackBar(
                                                                                          content: Text(
                                                                                            'You don\'t have to have an active plan to use this feature.',
                                                                                            style: TextStyle(
                                                                                              color: FlutterFlowTheme.of(context).primaryText,
                                                                                            ),
                                                                                          ),
                                                                                          duration: Duration(milliseconds: 4000),
                                                                                          backgroundColor: FlutterFlowTheme.of(context).secondary,
                                                                                        ),
                                                                                      );
                                                                                    },
                                                                                    text: 'Contact Seller',
                                                                                    icon: Icon(
                                                                                      Icons.lock,
                                                                                      size: 15.0,
                                                                                    ),
                                                                                    options: FFButtonOptions(
                                                                                      height: 32.0,
                                                                                      padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
                                                                                      iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                                                      color: FlutterFlowTheme.of(context).otherColour,
                                                                                      textStyle: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                            font: GoogleFonts.inter(
                                                                                              fontWeight: FontWeight.w600,
                                                                                              fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                            ),
                                                                                            color: Colors.white,
                                                                                            fontSize: 12.0,
                                                                                            letterSpacing: 0.0,
                                                                                            fontWeight: FontWeight.w600,
                                                                                            fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                          ),
                                                                                      elevation: 0.0,
                                                                                      borderRadius: BorderRadius.circular(6.0),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  );
                                                                },
                                                              );
                                                            },
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  if (_model.showMyBookings ==
                                                      'Rejected')
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  6.0,
                                                                  5.0,
                                                                  6.0,
                                                                  5.0),
                                                      child: StreamBuilder<
                                                          List<
                                                              BidsForMarketPlaceRecord>>(
                                                        stream:
                                                            queryBidsForMarketPlaceRecord(
                                                          queryBuilder:
                                                              (bidsForMarketPlaceRecord) =>
                                                                  bidsForMarketPlaceRecord
                                                                      .where(
                                                                        'bidsCreatorID',
                                                                        isEqualTo:
                                                                            currentUserReference,
                                                                      )
                                                                      .where(
                                                                        'status',
                                                                        isEqualTo:
                                                                            'Rejected',
                                                                      ),
                                                        ),
                                                        builder: (context,
                                                            snapshot) {
                                                          // Customize what your widget looks like when it's loading.
                                                          if (!snapshot
                                                              .hasData) {
                                                            return Center(
                                                              child: SizedBox(
                                                                width: 50.0,
                                                                height: 50.0,
                                                                child:
                                                                    SpinKitFadingCircle(
                                                                  color: Color(
                                                                      0xFF2B3C58),
                                                                  size: 50.0,
                                                                ),
                                                              ),
                                                            );
                                                          }
                                                          List<BidsForMarketPlaceRecord>
                                                              rejectedBookingsBidsForMarketPlaceRecordList =
                                                              snapshot.data!;

                                                          return ListView
                                                              .separated(
                                                            padding:
                                                                EdgeInsets.zero,
                                                            physics:
                                                                NeverScrollableScrollPhysics(),
                                                            primary: false,
                                                            shrinkWrap: true,
                                                            scrollDirection:
                                                                Axis.vertical,
                                                            itemCount:
                                                                rejectedBookingsBidsForMarketPlaceRecordList
                                                                    .length,
                                                            separatorBuilder: (_,
                                                                    __) =>
                                                                SizedBox(
                                                                    height:
                                                                        15.0),
                                                            itemBuilder: (context,
                                                                rejectedBookingsIndex) {
                                                              final rejectedBookingsBidsForMarketPlaceRecord =
                                                                  rejectedBookingsBidsForMarketPlaceRecordList[
                                                                      rejectedBookingsIndex];
                                                              return StreamBuilder<
                                                                  MarketPlaceRecord>(
                                                                stream: MarketPlaceRecord
                                                                    .getDocument(
                                                                        rejectedBookingsBidsForMarketPlaceRecord
                                                                            .marketPlaceRef!),
                                                                builder: (context,
                                                                    snapshot) {
                                                                  // Customize what your widget looks like when it's loading.
                                                                  if (!snapshot
                                                                      .hasData) {
                                                                    return Center(
                                                                      child:
                                                                          SizedBox(
                                                                        width:
                                                                            50.0,
                                                                        height:
                                                                            50.0,
                                                                        child:
                                                                            SpinKitFadingCircle(
                                                                          color:
                                                                              Color(0xFF2B3C58),
                                                                          size:
                                                                              50.0,
                                                                        ),
                                                                      ),
                                                                    );
                                                                  }

                                                                  final containerMarketPlaceRecord =
                                                                      snapshot
                                                                          .data!;

                                                                  return Material(
                                                                    color: Colors
                                                                        .transparent,
                                                                    elevation:
                                                                        2.0,
                                                                    shape:
                                                                        RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              12.0),
                                                                    ),
                                                                    child:
                                                                        Container(
                                                                      width: double
                                                                          .infinity,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primaryBackground,
                                                                        borderRadius:
                                                                            BorderRadius.circular(12.0),
                                                                        border:
                                                                            Border.all(
                                                                          color:
                                                                              FlutterFlowTheme.of(context).alternate,
                                                                          width:
                                                                              1.0,
                                                                        ),
                                                                      ),
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            EdgeInsets.all(16.0),
                                                                        child:
                                                                            Column(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          children: [
                                                                            Row(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                Flexible(
                                                                                  child: Column(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                    children: [
                                                                                      Padding(
                                                                                        padding: EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 0.0),
                                                                                        child: Text(
                                                                                          'Placed on ${dateTimeFormat("yMMMd", rejectedBookingsBidsForMarketPlaceRecord.createAt)}',
                                                                                          style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                                font: GoogleFonts.inter(
                                                                                                  fontWeight: FontWeight.w600,
                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                                ),
                                                                                                color: FlutterFlowTheme.of(context).primaryText,
                                                                                                fontSize: 12.0,
                                                                                                letterSpacing: 0.0,
                                                                                                fontWeight: FontWeight.w600,
                                                                                                fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                              ),
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                                Container(
                                                                                  width: 80.0,
                                                                                  height: 28.0,
                                                                                  decoration: BoxDecoration(
                                                                                    color: () {
                                                                                      if (rejectedBookingsBidsForMarketPlaceRecord.status == 'Completed') {
                                                                                        return FlutterFlowTheme.of(context).success;
                                                                                      } else if (rejectedBookingsBidsForMarketPlaceRecord.status == 'Accepted') {
                                                                                        return Color(0xFFFD803D);
                                                                                      } else if (rejectedBookingsBidsForMarketPlaceRecord.status == 'Rejected') {
                                                                                        return FlutterFlowTheme.of(context).error;
                                                                                      } else {
                                                                                        return FlutterFlowTheme.of(context).warning;
                                                                                      }
                                                                                    }(),
                                                                                    borderRadius: BorderRadius.circular(14.0),
                                                                                  ),
                                                                                  child: Align(
                                                                                    alignment: AlignmentDirectional(0.0, 0.0),
                                                                                    child: Padding(
                                                                                      padding: EdgeInsets.all(8.0),
                                                                                      child: Text(
                                                                                        rejectedBookingsBidsForMarketPlaceRecord.status,
                                                                                        textAlign: TextAlign.center,
                                                                                        style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                              font: GoogleFonts.inter(
                                                                                                fontWeight: FontWeight.w600,
                                                                                                fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                              ),
                                                                                              color: Colors.white,
                                                                                              fontSize: 11.0,
                                                                                              letterSpacing: 0.0,
                                                                                              fontWeight: FontWeight.w600,
                                                                                              fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                            ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            Divider(
                                                                              height: 20.0,
                                                                              thickness: 1.0,
                                                                              color: FlutterFlowTheme.of(context).alternate,
                                                                            ),
                                                                            Row(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              children: [
                                                                                ClipRRect(
                                                                                  borderRadius: BorderRadius.circular(8.0),
                                                                                  child: Image.network(
                                                                                    containerMarketPlaceRecord.imageOfproduct,
                                                                                    width: 60.0,
                                                                                    height: 60.0,
                                                                                    fit: BoxFit.cover,
                                                                                  ),
                                                                                ),
                                                                                Flexible(
                                                                                  child: Column(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                    children: [
                                                                                      Text(
                                                                                        containerMarketPlaceRecord.productName,
                                                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                              font: GoogleFonts.inter(
                                                                                                fontWeight: FontWeight.w500,
                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                              ),
                                                                                              color: FlutterFlowTheme.of(context).primaryText,
                                                                                              fontSize: 14.0,
                                                                                              letterSpacing: 0.0,
                                                                                              fontWeight: FontWeight.w500,
                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                            ),
                                                                                      ),
                                                                                      Padding(
                                                                                        padding: EdgeInsetsDirectional.fromSTEB(0.0, 2.0, 0.0, 0.0),
                                                                                        child: Text(
                                                                                          containerMarketPlaceRecord.descriptionItem,
                                                                                          style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                                font: GoogleFonts.inter(
                                                                                                  fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                                ),
                                                                                                color: FlutterFlowTheme.of(context).primaryText,
                                                                                                fontSize: 12.0,
                                                                                                letterSpacing: 0.0,
                                                                                                fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                                fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                              ),
                                                                                        ),
                                                                                      ),
                                                                                      Padding(
                                                                                        padding: EdgeInsetsDirectional.fromSTEB(0.0, 2.0, 0.0, 0.0),
                                                                                        child: Text(
                                                                                          'Quantity: ${rejectedBookingsBidsForMarketPlaceRecord.quantity.toString()}',
                                                                                          style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                                font: GoogleFonts.inter(
                                                                                                  fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                                ),
                                                                                                color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                fontSize: 12.0,
                                                                                                letterSpacing: 0.0,
                                                                                                fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                                fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                              ),
                                                                                        ),
                                                                                      ),
                                                                                      Padding(
                                                                                        padding: EdgeInsetsDirectional.fromSTEB(0.0, 2.0, 0.0, 0.0),
                                                                                        child: Text(
                                                                                          '₹${rejectedBookingsBidsForMarketPlaceRecord.price.toString()} each',
                                                                                          style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                                font: GoogleFonts.inter(
                                                                                                  fontWeight: FontWeight.w600,
                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                                ),
                                                                                                color: FlutterFlowTheme.of(context).primary,
                                                                                                fontSize: 12.0,
                                                                                                letterSpacing: 0.0,
                                                                                                fontWeight: FontWeight.w600,
                                                                                                fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                              ),
                                                                                        ),
                                                                                      ),
                                                                                      Padding(
                                                                                        padding: EdgeInsetsDirectional.fromSTEB(0.0, 2.0, 0.0, 0.0),
                                                                                        child: Text(
                                                                                          rejectedBookingsBidsForMarketPlaceRecord.description,
                                                                                          style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                                font: GoogleFonts.inter(
                                                                                                  fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                                ),
                                                                                                color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                fontSize: 12.0,
                                                                                                letterSpacing: 0.0,
                                                                                                fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                                fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                              ),
                                                                                        ),
                                                                                      ),
                                                                                    ].divide(SizedBox(height: 3.0)),
                                                                                  ),
                                                                                ),
                                                                                Column(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                                                  children: [
                                                                                    Text(
                                                                                      '₹${(rejectedBookingsBidsForMarketPlaceRecord.price * rejectedBookingsBidsForMarketPlaceRecord.quantity).toString()}',
                                                                                      style: FlutterFlowTheme.of(context).titleMedium.override(
                                                                                            font: GoogleFonts.interTight(
                                                                                              fontWeight: FontWeight.w600,
                                                                                              fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                                            ),
                                                                                            color: FlutterFlowTheme.of(context).primaryText,
                                                                                            fontSize: 16.0,
                                                                                            letterSpacing: 0.0,
                                                                                            fontWeight: FontWeight.w600,
                                                                                            fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                                          ),
                                                                                    ),
                                                                                    Text(
                                                                                      'Total',
                                                                                      style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                            font: GoogleFonts.inter(
                                                                                              fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                              fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                            ),
                                                                                            color: FlutterFlowTheme.of(context).secondaryText,
                                                                                            fontSize: 11.0,
                                                                                            letterSpacing: 0.0,
                                                                                            fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                            fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                          ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ].divide(SizedBox(width: 12.0)),
                                                                            ),
                                                                            Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
                                                                              child: Row(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                children: [
                                                                                  FFButtonWidget(
                                                                                    onPressed: () async {
                                                                                      context.pushNamed(
                                                                                        MarketPlaceBidYourRateWidget.routeName,
                                                                                        queryParameters: {
                                                                                          'marketPlaceBids': serializeParam(
                                                                                            containerMarketPlaceRecord.reference,
                                                                                            ParamType.DocumentReference,
                                                                                          ),
                                                                                        }.withoutNulls,
                                                                                      );
                                                                                    },
                                                                                    text: 'Reorder',
                                                                                    options: FFButtonOptions(
                                                                                      height: 32.0,
                                                                                      padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
                                                                                      iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                                                      color: FlutterFlowTheme.of(context).secondary,
                                                                                      textStyle: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                            font: GoogleFonts.inter(
                                                                                              fontWeight: FontWeight.w600,
                                                                                              fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                            ),
                                                                                            color: Colors.white,
                                                                                            fontSize: 12.0,
                                                                                            letterSpacing: 0.0,
                                                                                            fontWeight: FontWeight.w600,
                                                                                            fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                          ),
                                                                                      elevation: 0.0,
                                                                                      borderRadius: BorderRadius.circular(6.0),
                                                                                    ),
                                                                                  ),
                                                                                  FFButtonWidget(
                                                                                    onPressed: () async {
                                                                                      context.pushNamed(PlansWidget.routeName);

                                                                                      ScaffoldMessenger.of(context).showSnackBar(
                                                                                        SnackBar(
                                                                                          content: Text(
                                                                                            'You don\'t have to have an active plan to use this feature.',
                                                                                            style: TextStyle(
                                                                                              color: FlutterFlowTheme.of(context).primaryText,
                                                                                            ),
                                                                                          ),
                                                                                          duration: Duration(milliseconds: 4000),
                                                                                          backgroundColor: FlutterFlowTheme.of(context).secondary,
                                                                                        ),
                                                                                      );
                                                                                    },
                                                                                    text: 'Contact Seller',
                                                                                    icon: Icon(
                                                                                      Icons.lock,
                                                                                      size: 15.0,
                                                                                    ),
                                                                                    options: FFButtonOptions(
                                                                                      height: 32.0,
                                                                                      padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
                                                                                      iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                                                      color: FlutterFlowTheme.of(context).otherColour,
                                                                                      textStyle: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                            font: GoogleFonts.inter(
                                                                                              fontWeight: FontWeight.w600,
                                                                                              fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                            ),
                                                                                            color: Colors.white,
                                                                                            fontSize: 12.0,
                                                                                            letterSpacing: 0.0,
                                                                                            fontWeight: FontWeight.w600,
                                                                                            fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                          ),
                                                                                      elevation: 0.0,
                                                                                      borderRadius: BorderRadius.circular(6.0),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  );
                                                                },
                                                              );
                                                            },
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SingleChildScrollView(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                          .fromSTEB(
                                                          12, 10, 12, 0),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        'Filter By Status',
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  font: GoogleFonts.inter(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                                  fontSize: 16,
                                                                ),
                                                      ),
                                                      const SizedBox(width: 12),
                                                      Expanded(
                                                        child:
                                                            FlutterFlowDropDown<
                                                                String>(
                                                          controller: _model
                                                                  .listingDropDownValueController ??=
                                                              FormFieldController<
                                                                      String>(
                                                                  'All'),
                                                          options: const [
                                                            'All',
                                                            'Live',
                                                            'Under Review',
                                                            'Rejected'
                                                          ],
                                                          onChanged:
                                                              (val) async {
                                                            safeSetState(() =>
                                                                _model.listingDropDownValue =
                                                                    val);
                                                            _model.myListingStatus =
                                                                val!;
                                                            safeSetState(() {});
                                                          },
                                                          textStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .inter(
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontStyle,
                                                                    ),
                                                                    letterSpacing:
                                                                        0.0,
                                                                  ),
                                                          hintText:
                                                              'Filter by Status...',
                                                          icon: Icon(
                                                            Icons
                                                                .keyboard_arrow_down_rounded,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .secondaryText,
                                                            size: 24.0,
                                                          ),
                                                          fillColor: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryBackground,
                                                          elevation: 2.0,
                                                          borderColor:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .primary,
                                                          borderWidth: 0.0,
                                                          borderRadius: 8.0,
                                                          margin:
                                                              const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                  12, 0, 12, 0),
                                                          hidesUnderline: true,
                                                          isSearchable: false,
                                                          isMultiSelect: false,
                                                          height: 40.0,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),

                                                // Default view - Shows ALL listings for the current user
                                                if (_model.myListingStatus ==
                                                        null ||
                                                    _model.myListingStatus ==
                                                        'All')
                                                  SizedBox(
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.all(5.0),
                                                      child: StreamBuilder<
                                                          List<
                                                              MarketPlaceRecord>>(
                                                        stream:
                                                            queryMarketPlaceRecord(
                                                          queryBuilder:
                                                              (marketPlaceRecord) =>
                                                                  marketPlaceRecord
                                                                      .where(
                                                            'postedBy',
                                                            isEqualTo:
                                                                currentUserReference,
                                                          ),
                                                        ),
                                                        builder: (context,
                                                            snapshot) {
                                                          // Customize what your widget looks like when it's loading.
                                                          if (!snapshot
                                                              .hasData) {
                                                            return Center(
                                                              child: SizedBox(
                                                                width: 50.0,
                                                                height: 50.0,
                                                                child:
                                                                    SpinKitFadingCircle(
                                                                  color: Color(
                                                                      0xFF2B3C58),
                                                                  size: 50.0,
                                                                ),
                                                              ),
                                                            );
                                                          }
                                                          List<MarketPlaceRecord>
                                                              allListingMarketPlaceRecordList =
                                                              snapshot.data!;
                                                          if (allListingMarketPlaceRecordList
                                                              .isEmpty) {
                                                            return NoMarketPlaceRideDriverWidget();
                                                          }

                                                          return ListView
                                                              .separated(
                                                            padding:
                                                                EdgeInsets.zero,
                                                            physics:
                                                                NeverScrollableScrollPhysics(),
                                                            primary: false,
                                                            shrinkWrap: true,
                                                            scrollDirection:
                                                                Axis.vertical,
                                                            itemCount:
                                                                allListingMarketPlaceRecordList
                                                                    .length,
                                                            separatorBuilder: (_,
                                                                    __) =>
                                                                SizedBox(
                                                                    height:
                                                                        15.0),
                                                            itemBuilder: (context,
                                                                allListingIndex) {
                                                              final allListingMarketPlaceRecord =
                                                                  allListingMarketPlaceRecordList[
                                                                      allListingIndex];
                                                              return StreamBuilder<
                                                                  UsersRecord>(
                                                                stream: UsersRecord
                                                                    .getDocument(
                                                                        allListingMarketPlaceRecord
                                                                            .postedBy!),
                                                                builder: (context,
                                                                    snapshot) {
                                                                  // Customize what your widget looks like when it's loading.
                                                                  if (!snapshot
                                                                      .hasData) {
                                                                    return Center(
                                                                      child:
                                                                          SizedBox(
                                                                        width:
                                                                            50.0,
                                                                        height:
                                                                            50.0,
                                                                        child:
                                                                            SpinKitFadingCircle(
                                                                          color:
                                                                              Color(0xFF2B3C58),
                                                                          size:
                                                                              50.0,
                                                                        ),
                                                                      ),
                                                                    );
                                                                  }

                                                                  final cardUsersRecord =
                                                                      snapshot
                                                                          .data!;

                                                                  return Card(
                                                                    clipBehavior:
                                                                        Clip.antiAliasWithSaveLayer,
                                                                    color: Colors
                                                                        .white,
                                                                    elevation:
                                                                        6.0,
                                                                    shape:
                                                                        RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              16.0),
                                                                      side:
                                                                          BorderSide(
                                                                        color: Colors
                                                                            .grey
                                                                            .shade200,
                                                                        width:
                                                                            1.0,
                                                                      ),
                                                                    ),
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              16.0),
                                                                      child:
                                                                          Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          // --- PRODUCT INFO ROW ---
                                                                          Row(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              // Quote icon
                                                                              Padding(
                                                                                padding: EdgeInsets.only(top: 4.0),
                                                                                child: Icon(
                                                                                  Icons.format_quote_rounded,
                                                                                  color: Color(0xFFE0E0E0),
                                                                                  size: 28.0,
                                                                                ),
                                                                              ),
                                                                              SizedBox(width: 12.0),

                                                                              // Description (Expanded to take available space)
                                                                              Expanded(
                                                                                child: Padding(
                                                                                  padding: EdgeInsets.only(top: 2.0),
                                                                                  child: Text(
                                                                                    allListingMarketPlaceRecord.descriptionItem ?? 'No description available',
                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                          fontFamily: 'Inter',
                                                                                          fontSize: 14.0,
                                                                                          fontWeight: FontWeight.w400,
                                                                                          fontStyle: FontStyle.italic,
                                                                                          color: Colors.grey.shade700,
                                                                                          // height: 1.4,
                                                                                        ),
                                                                                    maxLines: 3,
                                                                                    overflow: TextOverflow.ellipsis,
                                                                                  ),
                                                                                ),
                                                                              ),

                                                                              SizedBox(width: 16.0),

                                                                              // Product Image
                                                                              Container(
                                                                                width: 90.0,
                                                                                height: 90.0,
                                                                                decoration: BoxDecoration(
                                                                                  borderRadius: BorderRadius.circular(12.0),
                                                                                  border: Border.all(
                                                                                    color: Colors.grey.shade200,
                                                                                    width: 1.5,
                                                                                  ),
                                                                                ),
                                                                                child: ClipRRect(
                                                                                  borderRadius: BorderRadius.circular(10.0),
                                                                                  child: allListingMarketPlaceRecord.imageOfproduct != null && allListingMarketPlaceRecord.imageOfproduct!.isNotEmpty
                                                                                      ? Image.network(
                                                                                          allListingMarketPlaceRecord.imageOfproduct!,
                                                                                          width: double.infinity,
                                                                                          height: double.infinity,
                                                                                          fit: BoxFit.cover,
                                                                                          loadingBuilder: (context, child, loadingProgress) {
                                                                                            if (loadingProgress == null) return child;
                                                                                            return Center(
                                                                                              child: CircularProgressIndicator(
                                                                                                value: loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes! : null,
                                                                                                strokeWidth: 2.0,
                                                                                                color: FlutterFlowTheme.of(context).primary,
                                                                                              ),
                                                                                            );
                                                                                          },
                                                                                          errorBuilder: (context, error, stackTrace) => Container(
                                                                                            color: Colors.grey.shade100,
                                                                                            child: Center(
                                                                                              child: Icon(
                                                                                                Icons.image_not_supported,
                                                                                                color: Colors.grey.shade400,
                                                                                                size: 32.0,
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        )
                                                                                      : Container(
                                                                                          color: Colors.grey.shade100,
                                                                                          child: Center(
                                                                                            child: Icon(
                                                                                              Icons.shopping_bag_outlined,
                                                                                              color: Colors.grey.shade400,
                                                                                              size: 32.0,
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),

                                                                          SizedBox(
                                                                              height: 20.0),

                                                                          // --- SELLER INFO ROW ---
                                                                          Row(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceBetween,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.center,
                                                                            children: [
                                                                              // Seller Profile + Name + Rating
                                                                              Expanded(
                                                                                child: InkWell(
                                                                                  splashColor: Colors.transparent,
                                                                                  focusColor: Colors.transparent,
                                                                                  hoverColor: Colors.transparent,
                                                                                  highlightColor: Colors.transparent,
                                                                                  onTap: () async {
                                                                                    context.pushNamed(
                                                                                      DriverReviewWidget.routeName,
                                                                                      queryParameters: {
                                                                                        'userRef': serializeParam(
                                                                                          cardUsersRecord.reference,
                                                                                          ParamType.DocumentReference,
                                                                                        ),
                                                                                      }.withoutNulls,
                                                                                    );
                                                                                  },
                                                                                  child: Row(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    children: [
                                                                                      // Profile Picture
                                                                                      Container(
                                                                                        width: 48.0,
                                                                                        height: 48.0,
                                                                                        decoration: BoxDecoration(
                                                                                          shape: BoxShape.circle,
                                                                                          border: Border.all(
                                                                                            color: FlutterFlowTheme.of(context).primary.withOpacity(0.2),
                                                                                            width: 1.5,
                                                                                          ),
                                                                                        ),
                                                                                        child: ClipRRect(
                                                                                          borderRadius: BorderRadius.circular(24.0),
                                                                                          child: cardUsersRecord.photoUrl != null && cardUsersRecord.photoUrl!.isNotEmpty
                                                                                              ? Image.network(
                                                                                                  cardUsersRecord.photoUrl!,
                                                                                                  fit: BoxFit.cover,
                                                                                                  loadingBuilder: (context, child, loadingProgress) {
                                                                                                    if (loadingProgress == null) return child;
                                                                                                    return Center(
                                                                                                      child: CircularProgressIndicator(
                                                                                                        strokeWidth: 2.0,
                                                                                                        color: FlutterFlowTheme.of(context).primary,
                                                                                                      ),
                                                                                                    );
                                                                                                  },
                                                                                                  errorBuilder: (context, error, stackTrace) => Image.asset(
                                                                                                    'assets/images/userIconTr.png',
                                                                                                    fit: BoxFit.cover,
                                                                                                  ),
                                                                                                )
                                                                                              : Image.asset(
                                                                                                  'assets/images/userIconTr.png',
                                                                                                  fit: BoxFit.cover,
                                                                                                ),
                                                                                        ),
                                                                                      ),

                                                                                      SizedBox(width: 12.0),

                                                                                      // Name and Rating
                                                                                      Expanded(
                                                                                        child: Column(
                                                                                          mainAxisSize: MainAxisSize.min,
                                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                                          children: [
                                                                                            Text(
                                                                                              cardUsersRecord.displayName ?? 'Unknown Seller',
                                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                    fontFamily: 'Inter',
                                                                                                    fontSize: 14.0,
                                                                                                    fontWeight: FontWeight.w600,
                                                                                                    color: Color(0xFF2D3748),
                                                                                                  ),
                                                                                              maxLines: 1,
                                                                                              overflow: TextOverflow.ellipsis,
                                                                                            ),

                                                                                            SizedBox(height: 4.0),

                                                                                            // Rating
                                                                                            Row(
                                                                                              mainAxisSize: MainAxisSize.min,
                                                                                              children: [
                                                                                                Container(
                                                                                                  padding: EdgeInsets.symmetric(
                                                                                                    horizontal: 6.0,
                                                                                                    vertical: 2.0,
                                                                                                  ),
                                                                                                  decoration: BoxDecoration(
                                                                                                    color: Color(0xFFFFF8E1),
                                                                                                    borderRadius: BorderRadius.circular(12.0),
                                                                                                  ),
                                                                                                  child: Row(
                                                                                                    mainAxisSize: MainAxisSize.min,
                                                                                                    children: [
                                                                                                      Icon(
                                                                                                        Icons.star_rounded,
                                                                                                        color: Color(0xFFFFB300),
                                                                                                        size: 14.0,
                                                                                                      ),
                                                                                                      SizedBox(width: 4.0),
                                                                                                      Text(
                                                                                                        valueOrDefault<String>(
                                                                                                          formatNumber(
                                                                                                            functions.averageRating(cardUsersRecord.ratings.toList()),
                                                                                                            formatType: FormatType.compact,
                                                                                                          ),
                                                                                                          '4.5',
                                                                                                        ),
                                                                                                        style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                                              fontFamily: 'Inter',
                                                                                                              fontSize: 11.0,
                                                                                                              fontWeight: FontWeight.w600,
                                                                                                              color: Color(0xFF5D4037),
                                                                                                            ),
                                                                                                      ),
                                                                                                    ],
                                                                                                  ),
                                                                                                ),
                                                                                              ],
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              ),

                                                                              // Status Badge
                                                                              Container(
                                                                                padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0),
                                                                                decoration: BoxDecoration(
                                                                                  color: () {
                                                                                    if (allListingMarketPlaceRecord.status == 'Active' || allListingMarketPlaceRecord.status == 'Live') {
                                                                                      return FlutterFlowTheme.of(context).success.withOpacity(0.1);
                                                                                    } else if (allListingMarketPlaceRecord.status == 'Rejected') {
                                                                                      return FlutterFlowTheme.of(context).error.withOpacity(0.1);
                                                                                    } else {
                                                                                      return FlutterFlowTheme.of(context).warning.withOpacity(0.1);
                                                                                    }
                                                                                  }(),
                                                                                  borderRadius: BorderRadius.circular(20.0),
                                                                                  border: Border.all(
                                                                                    color: () {
                                                                                      if (allListingMarketPlaceRecord.status == 'Active' || allListingMarketPlaceRecord.status == 'Live') {
                                                                                        return FlutterFlowTheme.of(context).success;
                                                                                      } else if (allListingMarketPlaceRecord.status == 'Rejected') {
                                                                                        return FlutterFlowTheme.of(context).error;
                                                                                      } else {
                                                                                        return FlutterFlowTheme.of(context).warning;
                                                                                      }
                                                                                    }(),
                                                                                    width: 1.5,
                                                                                  ),
                                                                                ),
                                                                                child: Row(
                                                                                  mainAxisSize: MainAxisSize.min,
                                                                                  children: [
                                                                                    Container(
                                                                                      width: 8.0,
                                                                                      height: 8.0,
                                                                                      margin: EdgeInsets.only(right: 6.0),
                                                                                      decoration: BoxDecoration(
                                                                                        shape: BoxShape.circle,
                                                                                        color: () {
                                                                                          if (allListingMarketPlaceRecord.status == 'Active' || allListingMarketPlaceRecord.status == 'Live') {
                                                                                            return FlutterFlowTheme.of(context).success;
                                                                                          } else if (allListingMarketPlaceRecord.status == 'Rejected') {
                                                                                            return FlutterFlowTheme.of(context).error;
                                                                                          } else {
                                                                                            return FlutterFlowTheme.of(context).warning;
                                                                                          }
                                                                                        }(),
                                                                                      ),
                                                                                    ),
                                                                                    Text(
                                                                                      allListingMarketPlaceRecord.status ?? 'Unknown',
                                                                                      style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                            fontFamily: 'Inter',
                                                                                            fontSize: 12.0,
                                                                                            fontWeight: FontWeight.w600,
                                                                                            color: () {
                                                                                              if (allListingMarketPlaceRecord.status == 'Active' || allListingMarketPlaceRecord.status == 'Live') {
                                                                                                return FlutterFlowTheme.of(context).success;
                                                                                              } else if (allListingMarketPlaceRecord.status == 'Rejected') {
                                                                                                return FlutterFlowTheme.of(context).error;
                                                                                              } else {
                                                                                                return FlutterFlowTheme.of(context).warning;
                                                                                              }
                                                                                            }(),
                                                                                          ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),

                                                                          SizedBox(
                                                                              height: 24.0),

                                                                          // --- ACTION BUTTONS ROW ---
                                                                          Row(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                              // Delete Button
                                                                              GestureDetector(
                                                                                onTap: () {
                                                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                                                    SnackBar(
                                                                                      content: Row(
                                                                                        children: [
                                                                                          Icon(Icons.info_outline, color: Colors.white, size: 20.0),
                                                                                          SizedBox(width: 8.0),
                                                                                          Expanded(
                                                                                            child: Text(
                                                                                              'Double tap to delete this listing',
                                                                                              style: TextStyle(
                                                                                                color: Colors.white,
                                                                                                fontWeight: FontWeight.w500,
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                      duration: Duration(milliseconds: 3000),
                                                                                      backgroundColor: FlutterFlowTheme.of(context).secondary,
                                                                                      behavior: SnackBarBehavior.floating,
                                                                                      shape: RoundedRectangleBorder(
                                                                                        borderRadius: BorderRadius.circular(12.0),
                                                                                      ),
                                                                                    ),
                                                                                  );
                                                                                },
                                                                                onDoubleTap: () async {
                                                                                  await allListingMarketPlaceRecord.reference.delete();
                                                                                },
                                                                                child: Container(
                                                                                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                                                                                  decoration: BoxDecoration(
                                                                                    color: Color(0xFFFEF2F2),
                                                                                    borderRadius: BorderRadius.circular(10.0),
                                                                                    border: Border.all(
                                                                                      color: Color(0xFFFECACA),
                                                                                      width: 1.5,
                                                                                    ),
                                                                                  ),
                                                                                  child: Row(
                                                                                    mainAxisSize: MainAxisSize.min,
                                                                                    children: [
                                                                                      Icon(
                                                                                        Icons.delete_outline_rounded,
                                                                                        color: Color(0xFFDC2626),
                                                                                        size: 18.0,
                                                                                      ),
                                                                                      SizedBox(width: 8.0),
                                                                                      Text(
                                                                                        'Delete',
                                                                                        style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                              fontFamily: 'Inter',
                                                                                              fontSize: 13.0,
                                                                                              fontWeight: FontWeight.w600,
                                                                                              color: Color(0xFFDC2626),
                                                                                            ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              ),

                                                                              // Bookings Button
                                                                              FFButtonWidget(
                                                                                onPressed: () async {
                                                                                  context.pushNamed(
                                                                                    MarketPlaceOrdersWidget.routeName,
                                                                                    queryParameters: {
                                                                                      'marketPlaceRef': serializeParam(
                                                                                        allListingMarketPlaceRecord.reference,
                                                                                        ParamType.DocumentReference,
                                                                                      ),
                                                                                    }.withoutNulls,
                                                                                  );
                                                                                },
                                                                                text: 'View Bookings',
                                                                                icon: Icon(
                                                                                  Icons.handshake_outlined,
                                                                                  size: 16.0,
                                                                                ),
                                                                                options: FFButtonOptions(
                                                                                  height: 40.0,
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
                                                                                  iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 8.0, 0.0),
                                                                                  color: FlutterFlowTheme.of(context).success,
                                                                                  textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                        fontFamily: 'Inter',
                                                                                        fontSize: 14.0,
                                                                                        fontWeight: FontWeight.w600,
                                                                                        color: Colors.white,
                                                                                      ),
                                                                                  elevation: 0.0,
                                                                                  borderSide: BorderSide(
                                                                                    color: FlutterFlowTheme.of(context).success,
                                                                                    width: 1.5,
                                                                                  ),
                                                                                  borderRadius: BorderRadius.circular(10.0),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  );
                                                                },
                                                              );
                                                            },
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ),

                                                // LIVE listings - status should be 'Active' (check your database field)
                                                if (_model.myListingStatus ==
                                                    'Live')
                                                  SizedBox(
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.all(5.0),
                                                      child: StreamBuilder<
                                                          List<
                                                              MarketPlaceRecord>>(
                                                        stream:
                                                            queryMarketPlaceRecord(
                                                          queryBuilder:
                                                              (marketPlaceRecord) =>
                                                                  marketPlaceRecord
                                                                      .where(
                                                                        'postedBy',
                                                                        isEqualTo:
                                                                            currentUserReference,
                                                                      )
                                                                      .where(
                                                                        'status',
                                                                        isEqualTo:
                                                                            'Active', // IMPORTANT: Check your database field value
                                                                      ),
                                                        ),
                                                        builder: (context,
                                                            snapshot) {
                                                          // Customize what your widget looks like when it's loading.
                                                          if (!snapshot
                                                              .hasData) {
                                                            return Center(
                                                              child: SizedBox(
                                                                width: 50.0,
                                                                height: 50.0,
                                                                child:
                                                                    SpinKitFadingCircle(
                                                                  color: Color(
                                                                      0xFF2B3C58),
                                                                  size: 50.0,
                                                                ),
                                                              ),
                                                            );
                                                          }
                                                          List<MarketPlaceRecord>
                                                              liveMarketPlaceRecordList =
                                                              snapshot.data!;
                                                          if (liveMarketPlaceRecordList
                                                              .isEmpty) {
                                                            return NoMarketPlaceRideDriverWidget();
                                                          }

                                                          return ListView
                                                              .separated(
                                                            padding:
                                                                EdgeInsets.zero,
                                                            physics:
                                                                NeverScrollableScrollPhysics(),
                                                            primary: false,
                                                            shrinkWrap: true,
                                                            scrollDirection:
                                                                Axis.vertical,
                                                            itemCount:
                                                                liveMarketPlaceRecordList
                                                                    .length,
                                                            separatorBuilder: (_,
                                                                    __) =>
                                                                SizedBox(
                                                                    height:
                                                                        15.0),
                                                            itemBuilder:
                                                                (context,
                                                                    liveIndex) {
                                                              final liveMarketPlaceRecord =
                                                                  liveMarketPlaceRecordList[
                                                                      liveIndex];
                                                              return StreamBuilder<
                                                                  UsersRecord>(
                                                                stream: UsersRecord
                                                                    .getDocument(
                                                                        liveMarketPlaceRecord
                                                                            .postedBy!),
                                                                builder: (context,
                                                                    snapshot) {
                                                                  // Customize what your widget looks like when it's loading.
                                                                  if (!snapshot
                                                                      .hasData) {
                                                                    return Center(
                                                                      child:
                                                                          SizedBox(
                                                                        width:
                                                                            50.0,
                                                                        height:
                                                                            50.0,
                                                                        child:
                                                                            SpinKitFadingCircle(
                                                                          color:
                                                                              Color(0xFF2B3C58),
                                                                          size:
                                                                              50.0,
                                                                        ),
                                                                      ),
                                                                    );
                                                                  }

                                                                  final cardUsersRecord =
                                                                      snapshot
                                                                          .data!;

                                                                  return Card(
                                                                    clipBehavior:
                                                                        Clip.antiAliasWithSaveLayer,
                                                                    color: Colors
                                                                        .white,
                                                                    elevation:
                                                                        6.0,
                                                                    shape:
                                                                        RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              16.0),
                                                                      side:
                                                                          BorderSide(
                                                                        color: Colors
                                                                            .grey
                                                                            .shade200,
                                                                        width:
                                                                            1.0,
                                                                      ),
                                                                    ),
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              16.0),
                                                                      child:
                                                                          Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          // --- PRODUCT INFO ROW ---
                                                                          Row(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              // Quote icon
                                                                              Padding(
                                                                                padding: EdgeInsets.only(top: 4.0),
                                                                                child: Icon(
                                                                                  Icons.format_quote_rounded,
                                                                                  color: Color(0xFFE0E0E0),
                                                                                  size: 28.0,
                                                                                ),
                                                                              ),
                                                                              SizedBox(width: 12.0),

                                                                              // Description (Expanded to take available space)
                                                                              Expanded(
                                                                                child: Padding(
                                                                                  padding: EdgeInsets.only(top: 2.0),
                                                                                  child: Text(
                                                                                    liveMarketPlaceRecord.descriptionItem ?? 'No description available',
                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                          fontFamily: 'Inter',
                                                                                          fontSize: 14.0,
                                                                                          fontWeight: FontWeight.w400,
                                                                                          fontStyle: FontStyle.italic,
                                                                                          color: Colors.grey.shade700,
                                                                                          // height: 1.4,
                                                                                        ),
                                                                                    maxLines: 3,
                                                                                    overflow: TextOverflow.ellipsis,
                                                                                  ),
                                                                                ),
                                                                              ),

                                                                              SizedBox(width: 16.0),

                                                                              // Product Image
                                                                              Container(
                                                                                width: 90.0,
                                                                                height: 90.0,
                                                                                decoration: BoxDecoration(
                                                                                  borderRadius: BorderRadius.circular(12.0),
                                                                                  border: Border.all(
                                                                                    color: Colors.grey.shade200,
                                                                                    width: 1.5,
                                                                                  ),
                                                                                ),
                                                                                child: ClipRRect(
                                                                                  borderRadius: BorderRadius.circular(10.0),
                                                                                  child: liveMarketPlaceRecord.imageOfproduct != null && liveMarketPlaceRecord.imageOfproduct!.isNotEmpty
                                                                                      ? Image.network(
                                                                                          liveMarketPlaceRecord.imageOfproduct!,
                                                                                          width: double.infinity,
                                                                                          height: double.infinity,
                                                                                          fit: BoxFit.cover,
                                                                                          loadingBuilder: (context, child, loadingProgress) {
                                                                                            if (loadingProgress == null) return child;
                                                                                            return Center(
                                                                                              child: CircularProgressIndicator(
                                                                                                value: loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes! : null,
                                                                                                strokeWidth: 2.0,
                                                                                                color: FlutterFlowTheme.of(context).primary,
                                                                                              ),
                                                                                            );
                                                                                          },
                                                                                          errorBuilder: (context, error, stackTrace) => Container(
                                                                                            color: Colors.grey.shade100,
                                                                                            child: Center(
                                                                                              child: Icon(
                                                                                                Icons.image_not_supported,
                                                                                                color: Colors.grey.shade400,
                                                                                                size: 32.0,
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        )
                                                                                      : Container(
                                                                                          color: Colors.grey.shade100,
                                                                                          child: Center(
                                                                                            child: Icon(
                                                                                              Icons.shopping_bag_outlined,
                                                                                              color: Colors.grey.shade400,
                                                                                              size: 32.0,
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),

                                                                          SizedBox(
                                                                              height: 20.0),

                                                                          // --- SELLER INFO ROW ---
                                                                          Row(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceBetween,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.center,
                                                                            children: [
                                                                              // Seller Profile + Name + Rating
                                                                              Expanded(
                                                                                child: InkWell(
                                                                                  splashColor: Colors.transparent,
                                                                                  focusColor: Colors.transparent,
                                                                                  hoverColor: Colors.transparent,
                                                                                  highlightColor: Colors.transparent,
                                                                                  onTap: () async {
                                                                                    context.pushNamed(
                                                                                      DriverReviewWidget.routeName,
                                                                                      queryParameters: {
                                                                                        'userRef': serializeParam(
                                                                                          cardUsersRecord.reference,
                                                                                          ParamType.DocumentReference,
                                                                                        ),
                                                                                      }.withoutNulls,
                                                                                    );
                                                                                  },
                                                                                  child: Row(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    children: [
                                                                                      // Profile Picture
                                                                                      Container(
                                                                                        width: 48.0,
                                                                                        height: 48.0,
                                                                                        decoration: BoxDecoration(
                                                                                          shape: BoxShape.circle,
                                                                                          border: Border.all(
                                                                                            color: FlutterFlowTheme.of(context).primary.withOpacity(0.2),
                                                                                            width: 1.5,
                                                                                          ),
                                                                                        ),
                                                                                        child: ClipRRect(
                                                                                          borderRadius: BorderRadius.circular(24.0),
                                                                                          child: cardUsersRecord.photoUrl != null && cardUsersRecord.photoUrl!.isNotEmpty
                                                                                              ? Image.network(
                                                                                                  cardUsersRecord.photoUrl!,
                                                                                                  fit: BoxFit.cover,
                                                                                                  loadingBuilder: (context, child, loadingProgress) {
                                                                                                    if (loadingProgress == null) return child;
                                                                                                    return Center(
                                                                                                      child: CircularProgressIndicator(
                                                                                                        strokeWidth: 2.0,
                                                                                                        color: FlutterFlowTheme.of(context).primary,
                                                                                                      ),
                                                                                                    );
                                                                                                  },
                                                                                                  errorBuilder: (context, error, stackTrace) => Image.asset(
                                                                                                    'assets/images/userIconTr.png',
                                                                                                    fit: BoxFit.cover,
                                                                                                  ),
                                                                                                )
                                                                                              : Image.asset(
                                                                                                  'assets/images/userIconTr.png',
                                                                                                  fit: BoxFit.cover,
                                                                                                ),
                                                                                        ),
                                                                                      ),

                                                                                      SizedBox(width: 12.0),

                                                                                      // Name and Rating
                                                                                      Expanded(
                                                                                        child: Column(
                                                                                          mainAxisSize: MainAxisSize.min,
                                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                                          children: [
                                                                                            Text(
                                                                                              cardUsersRecord.displayName ?? 'Unknown Seller',
                                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                    fontFamily: 'Inter',
                                                                                                    fontSize: 14.0,
                                                                                                    fontWeight: FontWeight.w600,
                                                                                                    color: Color(0xFF2D3748),
                                                                                                  ),
                                                                                              maxLines: 1,
                                                                                              overflow: TextOverflow.ellipsis,
                                                                                            ),

                                                                                            SizedBox(height: 4.0),

                                                                                            // Rating
                                                                                            Row(
                                                                                              mainAxisSize: MainAxisSize.min,
                                                                                              children: [
                                                                                                Container(
                                                                                                  padding: EdgeInsets.symmetric(
                                                                                                    horizontal: 6.0,
                                                                                                    vertical: 2.0,
                                                                                                  ),
                                                                                                  decoration: BoxDecoration(
                                                                                                    color: Color(0xFFFFF8E1),
                                                                                                    borderRadius: BorderRadius.circular(12.0),
                                                                                                  ),
                                                                                                  child: Row(
                                                                                                    mainAxisSize: MainAxisSize.min,
                                                                                                    children: [
                                                                                                      Icon(
                                                                                                        Icons.star_rounded,
                                                                                                        color: Color(0xFFFFB300),
                                                                                                        size: 14.0,
                                                                                                      ),
                                                                                                      SizedBox(width: 4.0),
                                                                                                      Text(
                                                                                                        valueOrDefault<String>(
                                                                                                          formatNumber(
                                                                                                            functions.averageRating(cardUsersRecord.ratings.toList()),
                                                                                                            formatType: FormatType.compact,
                                                                                                          ),
                                                                                                          '4.5',
                                                                                                        ),
                                                                                                        style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                                              fontFamily: 'Inter',
                                                                                                              fontSize: 11.0,
                                                                                                              fontWeight: FontWeight.w600,
                                                                                                              color: Color(0xFF5D4037),
                                                                                                            ),
                                                                                                      ),
                                                                                                    ],
                                                                                                  ),
                                                                                                ),
                                                                                              ],
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              ),

                                                                              // Status Badge
                                                                              Container(
                                                                                padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0),
                                                                                decoration: BoxDecoration(
                                                                                  color: () {
                                                                                    if (liveMarketPlaceRecord.status == 'Active' || liveMarketPlaceRecord.status == 'Live') {
                                                                                      return FlutterFlowTheme.of(context).success.withOpacity(0.1);
                                                                                    } else if (liveMarketPlaceRecord.status == 'Rejected') {
                                                                                      return FlutterFlowTheme.of(context).error.withOpacity(0.1);
                                                                                    } else {
                                                                                      return FlutterFlowTheme.of(context).warning.withOpacity(0.1);
                                                                                    }
                                                                                  }(),
                                                                                  borderRadius: BorderRadius.circular(20.0),
                                                                                  border: Border.all(
                                                                                    color: () {
                                                                                      if (liveMarketPlaceRecord.status == 'Active' || liveMarketPlaceRecord.status == 'Live') {
                                                                                        return FlutterFlowTheme.of(context).success;
                                                                                      } else if (liveMarketPlaceRecord.status == 'Rejected') {
                                                                                        return FlutterFlowTheme.of(context).error;
                                                                                      } else {
                                                                                        return FlutterFlowTheme.of(context).warning;
                                                                                      }
                                                                                    }(),
                                                                                    width: 1.5,
                                                                                  ),
                                                                                ),
                                                                                child: Row(
                                                                                  mainAxisSize: MainAxisSize.min,
                                                                                  children: [
                                                                                    Container(
                                                                                      width: 8.0,
                                                                                      height: 8.0,
                                                                                      margin: EdgeInsets.only(right: 6.0),
                                                                                      decoration: BoxDecoration(
                                                                                        shape: BoxShape.circle,
                                                                                        color: () {
                                                                                          if (liveMarketPlaceRecord.status == 'Active' || liveMarketPlaceRecord.status == 'Live') {
                                                                                            return FlutterFlowTheme.of(context).success;
                                                                                          } else if (liveMarketPlaceRecord.status == 'Rejected') {
                                                                                            return FlutterFlowTheme.of(context).error;
                                                                                          } else {
                                                                                            return FlutterFlowTheme.of(context).warning;
                                                                                          }
                                                                                        }(),
                                                                                      ),
                                                                                    ),
                                                                                    Text(
                                                                                      liveMarketPlaceRecord.status ?? 'Unknown',
                                                                                      style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                            fontFamily: 'Inter',
                                                                                            fontSize: 12.0,
                                                                                            fontWeight: FontWeight.w600,
                                                                                            color: () {
                                                                                              if (liveMarketPlaceRecord.status == 'Active' || liveMarketPlaceRecord.status == 'Live') {
                                                                                                return FlutterFlowTheme.of(context).success;
                                                                                              } else if (liveMarketPlaceRecord.status == 'Rejected') {
                                                                                                return FlutterFlowTheme.of(context).error;
                                                                                              } else {
                                                                                                return FlutterFlowTheme.of(context).warning;
                                                                                              }
                                                                                            }(),
                                                                                          ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),

                                                                          SizedBox(
                                                                              height: 24.0),

                                                                          // --- ACTION BUTTONS ROW ---
                                                                          Row(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                              // Delete Button
                                                                              GestureDetector(
                                                                                onTap: () {
                                                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                                                    SnackBar(
                                                                                      content: Row(
                                                                                        children: [
                                                                                          Icon(Icons.info_outline, color: Colors.white, size: 20.0),
                                                                                          SizedBox(width: 8.0),
                                                                                          Expanded(
                                                                                            child: Text(
                                                                                              'Double tap to delete this listing',
                                                                                              style: TextStyle(
                                                                                                color: Colors.white,
                                                                                                fontWeight: FontWeight.w500,
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                      duration: Duration(milliseconds: 3000),
                                                                                      backgroundColor: FlutterFlowTheme.of(context).secondary,
                                                                                      behavior: SnackBarBehavior.floating,
                                                                                      shape: RoundedRectangleBorder(
                                                                                        borderRadius: BorderRadius.circular(12.0),
                                                                                      ),
                                                                                    ),
                                                                                  );
                                                                                },
                                                                                onDoubleTap: () async {
                                                                                  await liveMarketPlaceRecord.reference.delete();
                                                                                },
                                                                                child: Container(
                                                                                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                                                                                  decoration: BoxDecoration(
                                                                                    color: Color(0xFFFEF2F2),
                                                                                    borderRadius: BorderRadius.circular(10.0),
                                                                                    border: Border.all(
                                                                                      color: Color(0xFFFECACA),
                                                                                      width: 1.5,
                                                                                    ),
                                                                                  ),
                                                                                  child: Row(
                                                                                    mainAxisSize: MainAxisSize.min,
                                                                                    children: [
                                                                                      Icon(
                                                                                        Icons.delete_outline_rounded,
                                                                                        color: Color(0xFFDC2626),
                                                                                        size: 18.0,
                                                                                      ),
                                                                                      SizedBox(width: 8.0),
                                                                                      Text(
                                                                                        'Delete',
                                                                                        style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                              fontFamily: 'Inter',
                                                                                              fontSize: 13.0,
                                                                                              fontWeight: FontWeight.w600,
                                                                                              color: Color(0xFFDC2626),
                                                                                            ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              ),

                                                                              // Bookings Button
                                                                              FFButtonWidget(
                                                                                onPressed: () async {
                                                                                  context.pushNamed(
                                                                                    MarketPlaceOrdersWidget.routeName,
                                                                                    queryParameters: {
                                                                                      'marketPlaceRef': serializeParam(
                                                                                        liveMarketPlaceRecord.reference,
                                                                                        ParamType.DocumentReference,
                                                                                      ),
                                                                                    }.withoutNulls,
                                                                                  );
                                                                                },
                                                                                text: 'View Bookings',
                                                                                icon: Icon(
                                                                                  Icons.handshake_outlined,
                                                                                  size: 16.0,
                                                                                ),
                                                                                options: FFButtonOptions(
                                                                                  height: 40.0,
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
                                                                                  iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 8.0, 0.0),
                                                                                  color: FlutterFlowTheme.of(context).success,
                                                                                  textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                        fontFamily: 'Inter',
                                                                                        fontSize: 14.0,
                                                                                        fontWeight: FontWeight.w600,
                                                                                        color: Colors.white,
                                                                                      ),
                                                                                  elevation: 0.0,
                                                                                  borderSide: BorderSide(
                                                                                    color: FlutterFlowTheme.of(context).success,
                                                                                    width: 1.5,
                                                                                  ),
                                                                                  borderRadius: BorderRadius.circular(10.0),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  );
                                                                  // return Card(
                                                                  //   clipBehavior: Clip.antiAliasWithSaveLayer,
                                                                  //   color: Colors.white,
                                                                  //   elevation: 4.0,
                                                                  //   shape: RoundedRectangleBorder(
                                                                  //     borderRadius: BorderRadius.circular(16.0),
                                                                  //   ),
                                                                  //   child: Padding(
                                                                  //     padding: EdgeInsets.all(5.0),
                                                                  //     child: Column(
                                                                  //       mainAxisSize: MainAxisSize.max,
                                                                  //       crossAxisAlignment: CrossAxisAlignment.start,
                                                                  //       children: [
                                                                  //         Row(
                                                                  //           mainAxisSize: MainAxisSize.max,
                                                                  //           mainAxisAlignment: MainAxisAlignment.start,
                                                                  //           crossAxisAlignment: CrossAxisAlignment.start,
                                                                  //           children: [
                                                                  //             Icon(
                                                                  //               Icons.format_quote,
                                                                  //               color: Color(0xFFD0D0D0),
                                                                  //               size: 24.0,
                                                                  //             ),
                                                                  //             Flexible(
                                                                  //               child: Column(
                                                                  //                 mainAxisSize: MainAxisSize.max,
                                                                  //                 crossAxisAlignment: CrossAxisAlignment.start,
                                                                  //                 children: [
                                                                  //                   Text(
                                                                  //                     liveMarketPlaceRecord.descriptionItem,
                                                                  //                     style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                  //                       font: GoogleFonts.inter(
                                                                  //                         fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                  //                         fontStyle: FontStyle.italic,
                                                                  //                       ),
                                                                  //                       color: FlutterFlowTheme.of(context).primaryText,
                                                                  //                       fontSize: 14.0,
                                                                  //                       letterSpacing: 0.0,
                                                                  //                       fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                  //                       fontStyle: FontStyle.italic,
                                                                  //                     ),
                                                                  //                   ),
                                                                  //                 ],
                                                                  //               ),
                                                                  //             ),
                                                                  //             Container(
                                                                  //               width: 80.0,
                                                                  //               height: 80.0,
                                                                  //               decoration: BoxDecoration(
                                                                  //                 color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                  //                 image: DecorationImage(
                                                                  //                   fit: BoxFit.cover,
                                                                  //                   image: Image.network(
                                                                  //                     '500x500?bakery',
                                                                  //                   ).image,
                                                                  //                 ),
                                                                  //                 borderRadius: BorderRadius.circular(12.0),
                                                                  //               ),
                                                                  //               child: ClipRRect(
                                                                  //                 borderRadius: BorderRadius.circular(8.0),
                                                                  //                 child: Image.network(
                                                                  //                   liveMarketPlaceRecord.imageOfproduct,
                                                                  //                   width: double.infinity,
                                                                  //                   height: 200.0,
                                                                  //                   fit: BoxFit.cover,
                                                                  //                 ),
                                                                  //               ),
                                                                  //             ),
                                                                  //           ].divide(SizedBox(width: 8.0)),
                                                                  //         ),
                                                                  //         Row(
                                                                  //           mainAxisSize: MainAxisSize.max,
                                                                  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  //           crossAxisAlignment: CrossAxisAlignment.center,
                                                                  //           children: [
                                                                  //             Row(
                                                                  //               mainAxisSize: MainAxisSize.max,
                                                                  //               children: [
                                                                  //                 Builder(
                                                                  //                   builder: (context) {
                                                                  //                     if (cardUsersRecord.photoUrl != null && cardUsersRecord.photoUrl != '') {
                                                                  //                       return Container(
                                                                  //                         width: 50.0,
                                                                  //                         height: 50.0,
                                                                  //                         clipBehavior: Clip.antiAlias,
                                                                  //                         decoration: BoxDecoration(
                                                                  //                           shape: BoxShape.circle,
                                                                  //                         ),
                                                                  //                         child: Image.network(
                                                                  //                           cardUsersRecord.photoUrl,
                                                                  //                           fit: BoxFit.cover,
                                                                  //                         ),
                                                                  //                       );
                                                                  //                     } else {
                                                                  //                       return Container(
                                                                  //                         width: 50.0,
                                                                  //                         height: 50.0,
                                                                  //                         clipBehavior: Clip.antiAlias,
                                                                  //                         decoration: BoxDecoration(
                                                                  //                           shape: BoxShape.circle,
                                                                  //                         ),
                                                                  //                         child: Image.asset(
                                                                  //                           'assets/images/userIconTr.png',
                                                                  //                           fit: BoxFit.cover,
                                                                  //                         ),
                                                                  //                       );
                                                                  //                     }
                                                                  //                   },
                                                                  //                 ),
                                                                  //                 Column(
                                                                  //                   mainAxisSize: MainAxisSize.max,
                                                                  //                   crossAxisAlignment: CrossAxisAlignment.start,
                                                                  //                   children: [
                                                                  //                     Row(
                                                                  //                       mainAxisSize: MainAxisSize.min,
                                                                  //                       children: [
                                                                  //                         Text(
                                                                  //                           cardUsersRecord.displayName,
                                                                  //                           style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                  //                             font: GoogleFonts.inter(
                                                                  //                               fontWeight: FontWeight.bold,
                                                                  //                               fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                  //                             ),
                                                                  //                             color: Color(0xFF69778E),
                                                                  //                             fontSize: 12.0,
                                                                  //                             letterSpacing: 0.0,
                                                                  //                             fontWeight: FontWeight.bold,
                                                                  //                             fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                  //                           ),
                                                                  //                         ),
                                                                  //                         Padding(
                                                                  //                           padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 5.0, 0.0),
                                                                  //                           child: Stack(
                                                                  //                             alignment: AlignmentDirectional(0.0, 0.0),
                                                                  //                             children: [
                                                                  //                               ClipRRect(
                                                                  //                                 borderRadius: BorderRadius.circular(8.0),
                                                                  //                                 child: Image.asset(
                                                                  //                                   'assets/images/Ride_Search_Icons.png',
                                                                  //                                   width: 34.0,
                                                                  //                                   height: 35.8,
                                                                  //                                   fit: BoxFit.cover,
                                                                  //                                 ),
                                                                  //                               ),
                                                                  //                               Text(
                                                                  //                                 '4.8',
                                                                  //                                 style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                  //                                   font: GoogleFonts.inter(
                                                                  //                                     fontWeight: FontWeight.w900,
                                                                  //                                     fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                  //                                   ),
                                                                  //                                   color: FlutterFlowTheme.of(context).primaryBackground,
                                                                  //                                   fontSize: 10.0,
                                                                  //                                   letterSpacing: 0.0,
                                                                  //                                   fontWeight: FontWeight.w900,
                                                                  //                                   fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                  //                                 ),
                                                                  //                               ),
                                                                  //                             ],
                                                                  //                           ),
                                                                  //                         ),
                                                                  //                       ].divide(SizedBox(width: 4.0)),
                                                                  //                     ),
                                                                  //                   ],
                                                                  //                 ),
                                                                  //               ].divide(SizedBox(width: 8.0)),
                                                                  //             ),
                                                                  //           ],
                                                                  //         ),
                                                                  //         Row(
                                                                  //           mainAxisSize: MainAxisSize.max,
                                                                  //           mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                  //           children: [
                                                                  //             Text(
                                                                  //               'Current Status:',
                                                                  //               style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                  //                 font: GoogleFonts.inter(
                                                                  //                   fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                  //                   fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                  //                 ),
                                                                  //                 letterSpacing: 0.0,
                                                                  //                 fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                  //                 fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                  //               ),
                                                                  //             ),
                                                                  //             Text(
                                                                  //               liveMarketPlaceRecord.status,
                                                                  //               style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                  //                 font: GoogleFonts.inter(
                                                                  //                   fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                  //                   fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                  //                 ),
                                                                  //                 color: () {
                                                                  //                   if (liveMarketPlaceRecord.status == 'Active') {
                                                                  //                     return FlutterFlowTheme.of(context).success;
                                                                  //                   } else if (liveMarketPlaceRecord.status == 'Rejected') {
                                                                  //                     return FlutterFlowTheme.of(context).error;
                                                                  //                   } else {
                                                                  //                     return FlutterFlowTheme.of(context).warning;
                                                                  //                   }
                                                                  //                 }(),
                                                                  //                 letterSpacing: 0.0,
                                                                  //                 fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                  //                 fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                  //               ),
                                                                  //             ),
                                                                  //           ],
                                                                  //         ),
                                                                  //         Row(
                                                                  //           mainAxisSize: MainAxisSize.max,
                                                                  //           mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                  //           children: [
                                                                  //             InkWell(
                                                                  //               splashColor: Colors.transparent,
                                                                  //               focusColor: Colors.transparent,
                                                                  //               hoverColor: Colors.transparent,
                                                                  //               highlightColor: Colors.transparent,
                                                                  //               onTap: () async {
                                                                  //                 ScaffoldMessenger.of(context).showSnackBar(
                                                                  //                   SnackBar(
                                                                  //                     content: Text(
                                                                  //                       'Double tap to delete it.',
                                                                  //                       style: TextStyle(
                                                                  //                         color: FlutterFlowTheme.of(context).primaryText,
                                                                  //                       ),
                                                                  //                     ),
                                                                  //                     duration: Duration(milliseconds: 4000),
                                                                  //                     backgroundColor: FlutterFlowTheme.of(context).secondary,
                                                                  //                   ),
                                                                  //                 );
                                                                  //               },
                                                                  //               onDoubleTap: () async {
                                                                  //                 await liveMarketPlaceRecord.reference.delete();
                                                                  //               },
                                                                  //               child: Icon(
                                                                  //                 Icons.delete,
                                                                  //                 color: Color(0xFFDC0A46),
                                                                  //                 size: 24.0,
                                                                  //               ),
                                                                  //             ),
                                                                  //             FFButtonWidget(
                                                                  //               onPressed: () async {
                                                                  //                 context.pushNamed(
                                                                  //                   MarketPlaceOrdersWidget.routeName,
                                                                  //                   queryParameters: {
                                                                  //                     'marketPlaceRef': serializeParam(
                                                                  //                       liveMarketPlaceRecord.reference,
                                                                  //                       ParamType.DocumentReference,
                                                                  //                     ),
                                                                  //                   }.withoutNulls,
                                                                  //                 );
                                                                  //               },
                                                                  //               text: 'Bookings',
                                                                  //               icon: Icon(
                                                                  //                 Icons.handshake_sharp,
                                                                  //                 size: 15.0,
                                                                  //               ),
                                                                  //               options: FFButtonOptions(
                                                                  //                 height: 30.0,
                                                                  //                 padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                                                                  //                 iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                                  //                 color: FlutterFlowTheme.of(context).success,
                                                                  //                 textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                                  //                   font: GoogleFonts.interTight(
                                                                  //                     fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
                                                                  //                     fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                  //                   ),
                                                                  //                   color: Colors.white,
                                                                  //                   letterSpacing: 0.0,
                                                                  //                   fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
                                                                  //                   fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                  //                 ),
                                                                  //                 elevation: 0.0,
                                                                  //                 borderRadius: BorderRadius.circular(8.0),
                                                                  //               ),
                                                                  //             ),
                                                                  //           ],
                                                                  //         ),
                                                                  //       ].divide(SizedBox(height: 10.0)),
                                                                  //     ),
                                                                  //   ),
                                                                  // );
                                                                },
                                                              );
                                                            },
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ),

                                                // UNDER REVIEW listings
                                                if (_model.myListingStatus ==
                                                    'Under Review')
                                                  SizedBox(
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.all(5.0),
                                                      child: StreamBuilder<
                                                          List<
                                                              MarketPlaceRecord>>(
                                                        stream:
                                                            queryMarketPlaceRecord(
                                                          queryBuilder:
                                                              (marketPlaceRecord) =>
                                                                  marketPlaceRecord
                                                                      .where(
                                                                        'postedBy',
                                                                        isEqualTo:
                                                                            currentUserReference,
                                                                      )
                                                                      .where(
                                                                        'status',
                                                                        isEqualTo:
                                                                            'Under Review',
                                                                      ),
                                                        ),
                                                        builder: (context,
                                                            snapshot) {
                                                          // Customize what your widget looks like when it's loading.
                                                          if (!snapshot
                                                              .hasData) {
                                                            return Center(
                                                              child: SizedBox(
                                                                width: 50.0,
                                                                height: 50.0,
                                                                child:
                                                                    SpinKitFadingCircle(
                                                                  color: Color(
                                                                      0xFF2B3C58),
                                                                  size: 50.0,
                                                                ),
                                                              ),
                                                            );
                                                          }
                                                          List<MarketPlaceRecord>
                                                              underReviewMarketPlaceRecordList =
                                                              snapshot.data!;
                                                          if (underReviewMarketPlaceRecordList
                                                              .isEmpty) {
                                                            return NoMarketPlaceRideDriverWidget();
                                                          }

                                                          return ListView
                                                              .separated(
                                                            padding:
                                                                EdgeInsets.zero,
                                                            physics:
                                                                NeverScrollableScrollPhysics(),
                                                            primary: false,
                                                            shrinkWrap: true,
                                                            scrollDirection:
                                                                Axis.vertical,
                                                            itemCount:
                                                                underReviewMarketPlaceRecordList
                                                                    .length,
                                                            separatorBuilder: (_,
                                                                    __) =>
                                                                SizedBox(
                                                                    height:
                                                                        15.0),
                                                            itemBuilder: (context,
                                                                underReviewIndex) {
                                                              final underReviewMarketPlaceRecord =
                                                                  underReviewMarketPlaceRecordList[
                                                                      underReviewIndex];
                                                              return StreamBuilder<
                                                                  UsersRecord>(
                                                                stream: UsersRecord
                                                                    .getDocument(
                                                                        underReviewMarketPlaceRecord
                                                                            .postedBy!),
                                                                builder: (context,
                                                                    snapshot) {
                                                                  // Customize what your widget looks like when it's loading.
                                                                  if (!snapshot
                                                                      .hasData) {
                                                                    return Center(
                                                                      child:
                                                                          SizedBox(
                                                                        width:
                                                                            50.0,
                                                                        height:
                                                                            50.0,
                                                                        child:
                                                                            SpinKitFadingCircle(
                                                                          color:
                                                                              Color(0xFF2B3C58),
                                                                          size:
                                                                              50.0,
                                                                        ),
                                                                      ),
                                                                    );
                                                                  }

                                                                  final cardUsersRecord =
                                                                      snapshot
                                                                          .data!;

                                                                  return InkWell(
                                                                    splashColor:
                                                                        Colors
                                                                            .transparent,
                                                                    focusColor:
                                                                        Colors
                                                                            .transparent,
                                                                    hoverColor:
                                                                        Colors
                                                                            .transparent,
                                                                    highlightColor:
                                                                        Colors
                                                                            .transparent,
                                                                    onTap:
                                                                        () async {
                                                                      context
                                                                          .pushNamed(
                                                                        MarketPlaceOrdersWidget
                                                                            .routeName,
                                                                        queryParameters:
                                                                            {
                                                                          'marketPlaceRef':
                                                                              serializeParam(
                                                                            underReviewMarketPlaceRecord.reference,
                                                                            ParamType.DocumentReference,
                                                                          ),
                                                                        }.withoutNulls,
                                                                      );
                                                                    },
                                                                    child: Card(
                                                                      clipBehavior:
                                                                          Clip.antiAliasWithSaveLayer,
                                                                      color: Colors
                                                                          .white,
                                                                      elevation:
                                                                          6.0,
                                                                      shape:
                                                                          RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(16.0),
                                                                        side:
                                                                            BorderSide(
                                                                          color: Colors
                                                                              .grey
                                                                              .shade200,
                                                                          width:
                                                                              1.0,
                                                                        ),
                                                                      ),
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            EdgeInsets.all(16.0),
                                                                        child:
                                                                            Column(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            // --- PRODUCT INFO ROW ---
                                                                            Row(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                // Quote icon
                                                                                Padding(
                                                                                  padding: EdgeInsets.only(top: 4.0),
                                                                                  child: Icon(
                                                                                    Icons.format_quote_rounded,
                                                                                    color: Color(0xFFE0E0E0),
                                                                                    size: 28.0,
                                                                                  ),
                                                                                ),
                                                                                SizedBox(width: 12.0),

                                                                                // Description (Expanded to take available space)
                                                                                Expanded(
                                                                                  child: Padding(
                                                                                    padding: EdgeInsets.only(top: 2.0),
                                                                                    child: Text(
                                                                                      underReviewMarketPlaceRecord.descriptionItem ?? 'No description available',
                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                            fontFamily: 'Inter',
                                                                                            fontSize: 14.0,
                                                                                            fontWeight: FontWeight.w400,
                                                                                            fontStyle: FontStyle.italic,
                                                                                            color: Colors.grey.shade700,
                                                                                            // height: 1.4,
                                                                                          ),
                                                                                      maxLines: 3,
                                                                                      overflow: TextOverflow.ellipsis,
                                                                                    ),
                                                                                  ),
                                                                                ),

                                                                                SizedBox(width: 16.0),

                                                                                // Product Image
                                                                                Container(
                                                                                  width: 90.0,
                                                                                  height: 90.0,
                                                                                  decoration: BoxDecoration(
                                                                                    borderRadius: BorderRadius.circular(12.0),
                                                                                    border: Border.all(
                                                                                      color: Colors.grey.shade200,
                                                                                      width: 1.5,
                                                                                    ),
                                                                                  ),
                                                                                  child: ClipRRect(
                                                                                    borderRadius: BorderRadius.circular(10.0),
                                                                                    child: underReviewMarketPlaceRecord.imageOfproduct != null && underReviewMarketPlaceRecord.imageOfproduct!.isNotEmpty
                                                                                        ? Image.network(
                                                                                            underReviewMarketPlaceRecord.imageOfproduct!,
                                                                                            width: double.infinity,
                                                                                            height: double.infinity,
                                                                                            fit: BoxFit.cover,
                                                                                            loadingBuilder: (context, child, loadingProgress) {
                                                                                              if (loadingProgress == null) return child;
                                                                                              return Center(
                                                                                                child: CircularProgressIndicator(
                                                                                                  value: loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes! : null,
                                                                                                  strokeWidth: 2.0,
                                                                                                  color: FlutterFlowTheme.of(context).primary,
                                                                                                ),
                                                                                              );
                                                                                            },
                                                                                            errorBuilder: (context, error, stackTrace) => Container(
                                                                                              color: Colors.grey.shade100,
                                                                                              child: Center(
                                                                                                child: Icon(
                                                                                                  Icons.image_not_supported,
                                                                                                  color: Colors.grey.shade400,
                                                                                                  size: 32.0,
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          )
                                                                                        : Container(
                                                                                            color: Colors.grey.shade100,
                                                                                            child: Center(
                                                                                              child: Icon(
                                                                                                Icons.shopping_bag_outlined,
                                                                                                color: Colors.grey.shade400,
                                                                                                size: 32.0,
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),

                                                                            SizedBox(height: 20.0),

                                                                            // --- SELLER INFO ROW ---
                                                                            Row(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                                              children: [
                                                                                // Seller Profile + Name + Rating
                                                                                Expanded(
                                                                                  child: InkWell(
                                                                                    splashColor: Colors.transparent,
                                                                                    focusColor: Colors.transparent,
                                                                                    hoverColor: Colors.transparent,
                                                                                    highlightColor: Colors.transparent,
                                                                                    onTap: () async {
                                                                                      context.pushNamed(
                                                                                        DriverReviewWidget.routeName,
                                                                                        queryParameters: {
                                                                                          'userRef': serializeParam(
                                                                                            cardUsersRecord.reference,
                                                                                            ParamType.DocumentReference,
                                                                                          ),
                                                                                        }.withoutNulls,
                                                                                      );
                                                                                    },
                                                                                    child: Row(
                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                      children: [
                                                                                        // Profile Picture
                                                                                        Container(
                                                                                          width: 48.0,
                                                                                          height: 48.0,
                                                                                          decoration: BoxDecoration(
                                                                                            shape: BoxShape.circle,
                                                                                            border: Border.all(
                                                                                              color: FlutterFlowTheme.of(context).primary.withOpacity(0.2),
                                                                                              width: 1.5,
                                                                                            ),
                                                                                          ),
                                                                                          child: ClipRRect(
                                                                                            borderRadius: BorderRadius.circular(24.0),
                                                                                            child: cardUsersRecord.photoUrl != null && cardUsersRecord.photoUrl!.isNotEmpty
                                                                                                ? Image.network(
                                                                                                    cardUsersRecord.photoUrl!,
                                                                                                    fit: BoxFit.cover,
                                                                                                    loadingBuilder: (context, child, loadingProgress) {
                                                                                                      if (loadingProgress == null) return child;
                                                                                                      return Center(
                                                                                                        child: CircularProgressIndicator(
                                                                                                          strokeWidth: 2.0,
                                                                                                          color: FlutterFlowTheme.of(context).primary,
                                                                                                        ),
                                                                                                      );
                                                                                                    },
                                                                                                    errorBuilder: (context, error, stackTrace) => Image.asset(
                                                                                                      'assets/images/userIconTr.png',
                                                                                                      fit: BoxFit.cover,
                                                                                                    ),
                                                                                                  )
                                                                                                : Image.asset(
                                                                                                    'assets/images/userIconTr.png',
                                                                                                    fit: BoxFit.cover,
                                                                                                  ),
                                                                                          ),
                                                                                        ),

                                                                                        SizedBox(width: 12.0),

                                                                                        // Name and Rating
                                                                                        Expanded(
                                                                                          child: Column(
                                                                                            mainAxisSize: MainAxisSize.min,
                                                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                                                            children: [
                                                                                              Text(
                                                                                                cardUsersRecord.displayName ?? 'Unknown Seller',
                                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                      fontFamily: 'Inter',
                                                                                                      fontSize: 14.0,
                                                                                                      fontWeight: FontWeight.w600,
                                                                                                      color: Color(0xFF2D3748),
                                                                                                    ),
                                                                                                maxLines: 1,
                                                                                                overflow: TextOverflow.ellipsis,
                                                                                              ),

                                                                                              SizedBox(height: 4.0),

                                                                                              // Rating
                                                                                              Row(
                                                                                                mainAxisSize: MainAxisSize.min,
                                                                                                children: [
                                                                                                  Container(
                                                                                                    padding: EdgeInsets.symmetric(
                                                                                                      horizontal: 6.0,
                                                                                                      vertical: 2.0,
                                                                                                    ),
                                                                                                    decoration: BoxDecoration(
                                                                                                      color: Color(0xFFFFF8E1),
                                                                                                      borderRadius: BorderRadius.circular(12.0),
                                                                                                    ),
                                                                                                    child: Row(
                                                                                                      mainAxisSize: MainAxisSize.min,
                                                                                                      children: [
                                                                                                        Icon(
                                                                                                          Icons.star_rounded,
                                                                                                          color: Color(0xFFFFB300),
                                                                                                          size: 14.0,
                                                                                                        ),
                                                                                                        SizedBox(width: 4.0),
                                                                                                        Text(
                                                                                                          valueOrDefault<String>(
                                                                                                            formatNumber(
                                                                                                              functions.averageRating(cardUsersRecord.ratings.toList()),
                                                                                                              formatType: FormatType.compact,
                                                                                                            ),
                                                                                                            '4.5',
                                                                                                          ),
                                                                                                          style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                                                fontFamily: 'Inter',
                                                                                                                fontSize: 11.0,
                                                                                                                fontWeight: FontWeight.w600,
                                                                                                                color: Color(0xFF5D4037),
                                                                                                              ),
                                                                                                        ),
                                                                                                      ],
                                                                                                    ),
                                                                                                  ),
                                                                                                ],
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                ),

                                                                                // Status Badge
                                                                                Container(
                                                                                  padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0),
                                                                                  decoration: BoxDecoration(
                                                                                    color: () {
                                                                                      if (underReviewMarketPlaceRecord.status == 'Active' || underReviewMarketPlaceRecord.status == 'Live') {
                                                                                        return FlutterFlowTheme.of(context).success.withOpacity(0.1);
                                                                                      } else if (underReviewMarketPlaceRecord.status == 'Rejected') {
                                                                                        return FlutterFlowTheme.of(context).error.withOpacity(0.1);
                                                                                      } else {
                                                                                        return FlutterFlowTheme.of(context).warning.withOpacity(0.1);
                                                                                      }
                                                                                    }(),
                                                                                    borderRadius: BorderRadius.circular(20.0),
                                                                                    border: Border.all(
                                                                                      color: () {
                                                                                        if (underReviewMarketPlaceRecord.status == 'Active' || underReviewMarketPlaceRecord.status == 'Live') {
                                                                                          return FlutterFlowTheme.of(context).success;
                                                                                        } else if (underReviewMarketPlaceRecord.status == 'Rejected') {
                                                                                          return FlutterFlowTheme.of(context).error;
                                                                                        } else {
                                                                                          return FlutterFlowTheme.of(context).warning;
                                                                                        }
                                                                                      }(),
                                                                                      width: 1.5,
                                                                                    ),
                                                                                  ),
                                                                                  child: Row(
                                                                                    mainAxisSize: MainAxisSize.min,
                                                                                    children: [
                                                                                      Container(
                                                                                        width: 8.0,
                                                                                        height: 8.0,
                                                                                        margin: EdgeInsets.only(right: 6.0),
                                                                                        decoration: BoxDecoration(
                                                                                          shape: BoxShape.circle,
                                                                                          color: () {
                                                                                            if (underReviewMarketPlaceRecord.status == 'Active' || underReviewMarketPlaceRecord.status == 'Live') {
                                                                                              return FlutterFlowTheme.of(context).success;
                                                                                            } else if (underReviewMarketPlaceRecord.status == 'Rejected') {
                                                                                              return FlutterFlowTheme.of(context).error;
                                                                                            } else {
                                                                                              return FlutterFlowTheme.of(context).warning;
                                                                                            }
                                                                                          }(),
                                                                                        ),
                                                                                      ),
                                                                                      Text(
                                                                                        underReviewMarketPlaceRecord.status ?? 'Unknown',
                                                                                        style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                              fontFamily: 'Inter',
                                                                                              fontSize: 12.0,
                                                                                              fontWeight: FontWeight.w600,
                                                                                              color: () {
                                                                                                if (underReviewMarketPlaceRecord.status == 'Active' || underReviewMarketPlaceRecord.status == 'Live') {
                                                                                                  return FlutterFlowTheme.of(context).success;
                                                                                                } else if (underReviewMarketPlaceRecord.status == 'Rejected') {
                                                                                                  return FlutterFlowTheme.of(context).error;
                                                                                                } else {
                                                                                                  return FlutterFlowTheme.of(context).warning;
                                                                                                }
                                                                                              }(),
                                                                                            ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),

                                                                            SizedBox(height: 24.0),

                                                                            // --- ACTION BUTTONS ROW ---
                                                                            Row(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: [
                                                                                // Delete Button
                                                                                GestureDetector(
                                                                                  onTap: () {
                                                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                                                      SnackBar(
                                                                                        content: Row(
                                                                                          children: [
                                                                                            Icon(Icons.info_outline, color: Colors.white, size: 20.0),
                                                                                            SizedBox(width: 8.0),
                                                                                            Expanded(
                                                                                              child: Text(
                                                                                                'Double tap to delete this listing',
                                                                                                style: TextStyle(
                                                                                                  color: Colors.white,
                                                                                                  fontWeight: FontWeight.w500,
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                        duration: Duration(milliseconds: 3000),
                                                                                        backgroundColor: FlutterFlowTheme.of(context).secondary,
                                                                                        behavior: SnackBarBehavior.floating,
                                                                                        shape: RoundedRectangleBorder(
                                                                                          borderRadius: BorderRadius.circular(12.0),
                                                                                        ),
                                                                                      ),
                                                                                    );
                                                                                  },
                                                                                  onDoubleTap: () async {
                                                                                    await underReviewMarketPlaceRecord.reference.delete();
                                                                                  },
                                                                                  child: Container(
                                                                                    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                                                                                    decoration: BoxDecoration(
                                                                                      color: Color(0xFFFEF2F2),
                                                                                      borderRadius: BorderRadius.circular(10.0),
                                                                                      border: Border.all(
                                                                                        color: Color(0xFFFECACA),
                                                                                        width: 1.5,
                                                                                      ),
                                                                                    ),
                                                                                    child: Row(
                                                                                      mainAxisSize: MainAxisSize.min,
                                                                                      children: [
                                                                                        Icon(
                                                                                          Icons.delete_outline_rounded,
                                                                                          color: Color(0xFFDC2626),
                                                                                          size: 18.0,
                                                                                        ),
                                                                                        SizedBox(width: 8.0),
                                                                                        Text(
                                                                                          'Delete',
                                                                                          style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                                fontFamily: 'Inter',
                                                                                                fontSize: 13.0,
                                                                                                fontWeight: FontWeight.w600,
                                                                                                color: Color(0xFFDC2626),
                                                                                              ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                ),

                                                                                // Bookings Button
                                                                                FFButtonWidget(
                                                                                  onPressed: () async {
                                                                                    context.pushNamed(
                                                                                      MarketPlaceOrdersWidget.routeName,
                                                                                      queryParameters: {
                                                                                        'marketPlaceRef': serializeParam(
                                                                                          underReviewMarketPlaceRecord.reference,
                                                                                          ParamType.DocumentReference,
                                                                                        ),
                                                                                      }.withoutNulls,
                                                                                    );
                                                                                  },
                                                                                  text: 'View Bookings',
                                                                                  icon: Icon(
                                                                                    Icons.handshake_outlined,
                                                                                    size: 16.0,
                                                                                  ),
                                                                                  options: FFButtonOptions(
                                                                                    height: 40.0,
                                                                                    padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
                                                                                    iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 8.0, 0.0),
                                                                                    color: FlutterFlowTheme.of(context).success,
                                                                                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                          fontFamily: 'Inter',
                                                                                          fontSize: 14.0,
                                                                                          fontWeight: FontWeight.w600,
                                                                                          color: Colors.white,
                                                                                        ),
                                                                                    elevation: 0.0,
                                                                                    borderSide: BorderSide(
                                                                                      color: FlutterFlowTheme.of(context).success,
                                                                                      width: 1.5,
                                                                                    ),
                                                                                    borderRadius: BorderRadius.circular(10.0),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    // child: Card(
                                                                    //   clipBehavior: Clip.antiAliasWithSaveLayer,
                                                                    //   color: Colors.white,
                                                                    //   elevation: 4.0,
                                                                    //   shape: RoundedRectangleBorder(
                                                                    //     borderRadius: BorderRadius.circular(16.0),
                                                                    //   ),
                                                                    //   child: Padding(
                                                                    //     padding: EdgeInsets.all(16.0),
                                                                    //     child: Column(
                                                                    //       mainAxisSize: MainAxisSize.min,
                                                                    //       crossAxisAlignment: CrossAxisAlignment.start,
                                                                    //       children: [
                                                                    //         Row(
                                                                    //           crossAxisAlignment: CrossAxisAlignment.start,
                                                                    //           children: [
                                                                    //             Icon(Icons.format_quote, color: Color(0xFFD0D0D0), size: 24.0),
                                                                    //             SizedBox(width: 12.0),
                                                                    //             Expanded(
                                                                    //               child: Text(
                                                                    //                 underReviewMarketPlaceRecord.descriptionItem,
                                                                    //                 style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                    //                   fontFamily: GoogleFonts.inter().fontFamily,
                                                                    //                   fontStyle: FontStyle.italic,
                                                                    //                   color: FlutterFlowTheme.of(context).primaryText,
                                                                    //                   fontSize: 14.0,
                                                                    //                 ),
                                                                    //                 maxLines: 2,
                                                                    //               ),
                                                                    //             ),
                                                                    //             SizedBox(width: 12.0),
                                                                    //             ClipRRect(
                                                                    //               borderRadius: BorderRadius.circular(12.0),
                                                                    //               child: Container(
                                                                    //                 width: 80.0,
                                                                    //                 height: 80.0,
                                                                    //                 child: Image.network(
                                                                    //                   underReviewMarketPlaceRecord.imageOfproduct,
                                                                    //                   fit: BoxFit.cover,
                                                                    //                   errorBuilder: (context, error, stackTrace) =>
                                                                    //                       Container(color: FlutterFlowTheme.of(context).secondaryBackground),
                                                                    //                 ),
                                                                    //               ),
                                                                    //             ),
                                                                    //           ],
                                                                    //         ),
                                                                    //         SizedBox(height: 16.0),
                                                                    //         Row(
                                                                    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                    //           children: [
                                                                    //             Row(
                                                                    //               mainAxisSize: MainAxisSize.min,
                                                                    //               children: [
                                                                    //                 Builder(
                                                                    //                   builder: (context) {
                                                                    //                     if (cardUsersRecord.photoUrl != null && cardUsersRecord.photoUrl != '') {
                                                                    //                       return Container(
                                                                    //                         width: 40.0,
                                                                    //                         height: 40.0,
                                                                    //                         clipBehavior: Clip.antiAlias,
                                                                    //                         decoration: BoxDecoration(shape: BoxShape.circle),
                                                                    //                         child: Image.network(cardUsersRecord.photoUrl!, fit: BoxFit.cover),
                                                                    //                       );
                                                                    //                     }
                                                                    //                     return Container(
                                                                    //                       width: 40.0,
                                                                    //                       height: 40.0,
                                                                    //                       clipBehavior: Clip.antiAlias,
                                                                    //                       decoration: BoxDecoration(shape: BoxShape.circle),
                                                                    //                       child: Image.asset('assets/images/userIconTr.png', fit: BoxFit.cover),
                                                                    //                     );
                                                                    //                   },
                                                                    //                 ),
                                                                    //                 SizedBox(width: 12.0),
                                                                    //                 Column(
                                                                    //                   crossAxisAlignment: CrossAxisAlignment.start,
                                                                    //                   mainAxisSize: MainAxisSize.min,
                                                                    //                   children: [
                                                                    //                     Text(
                                                                    //                       cardUsersRecord.displayName ?? 'User',
                                                                    //                       style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                    //                         fontFamily: GoogleFonts.inter().fontFamily,
                                                                    //                         fontWeight: FontWeight.w600,
                                                                    //                         color: Color(0xFF69778E),
                                                                    //                         fontSize: 12.0,
                                                                    //                       ),
                                                                    //                     ),
                                                                    //                     SizedBox(height: 4.0),
                                                                    //                   ],
                                                                    //                 ),
                                                                    //                 SizedBox(width: 12.0),
                                                                    //                 Stack(
                                                                    //                   alignment: AlignmentDirectional(0.0, 0.0),
                                                                    //                   children: [
                                                                    //                     ClipRRect(
                                                                    //                       borderRadius: BorderRadius.circular(8.0),
                                                                    //                       child: Image.asset(
                                                                    //                         'assets/images/Ride_Search_Icons.png',
                                                                    //                         width: 38.0,
                                                                    //                         height: 43.0,
                                                                    //                         fit: BoxFit.contain,
                                                                    //                       ),
                                                                    //                     ),
                                                                    //                     Text(
                                                                    //                       '4.8',
                                                                    //                       style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                    //                         fontFamily: GoogleFonts.inter().fontFamily,
                                                                    //                         fontWeight: FontWeight.w900,
                                                                    //                         color: FlutterFlowTheme.of(context).primaryBackground,
                                                                    //                         fontSize: 10.0,
                                                                    //                       ),
                                                                    //                     ),
                                                                    //                   ],
                                                                    //                 ),
                                                                    //               ],
                                                                    //             ),
                                                                    //           ],
                                                                    //         ),
                                                                    //         SizedBox(height: 16.0),
                                                                    //         Row(
                                                                    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                    //           children: [
                                                                    //             Text(
                                                                    //               'Current Status:',
                                                                    //               style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                    //                 fontFamily: GoogleFonts.inter().fontFamily,
                                                                    //               ),
                                                                    //             ),
                                                                    //             Container(
                                                                    //               padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                                                                    //               decoration: BoxDecoration(
                                                                    //                 color: _getStatusColor(underReviewMarketPlaceRecord.status),
                                                                    //                 borderRadius: BorderRadius.circular(12.0),
                                                                    //               ),
                                                                    //               child: Text(
                                                                    //                 underReviewMarketPlaceRecord.status,
                                                                    //                 style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                    //                   fontFamily: GoogleFonts.inter().fontFamily,
                                                                    //                   fontWeight: FontWeight.w600,
                                                                    //                   color: Colors.white,
                                                                    //                   fontSize: 12.0,
                                                                    //                 ),
                                                                    //               ),
                                                                    //             ),
                                                                    //           ],
                                                                    //         ),
                                                                    //         SizedBox(height: 16.0),
                                                                    //         Row(
                                                                    //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                    //           children: [
                                                                    //             GestureDetector(
                                                                    //               onTap: () {
                                                                    //                 ScaffoldMessenger.of(context).showSnackBar(
                                                                    //                   SnackBar(
                                                                    //                     content: Text('Double tap to delete it.'),
                                                                    //                     duration: Duration(milliseconds: 4000),
                                                                    //                     backgroundColor: FlutterFlowTheme.of(context).secondary,
                                                                    //                   ),
                                                                    //                 );
                                                                    //               },
                                                                    //               onDoubleTap: () async {
                                                                    //                 await underReviewMarketPlaceRecord.reference.delete();
                                                                    //               },
                                                                    //               child: Container(
                                                                    //                 padding: EdgeInsets.all(8.0),
                                                                    //                 child: Icon(Icons.delete, color: Color(0xFFDC0A46), size: 24.0),
                                                                    //               ),
                                                                    //             ),
                                                                    //             Expanded(
                                                                    //               child: FFButtonWidget(
                                                                    //                 onPressed: () async {
                                                                    //                   context.pushNamed(
                                                                    //                     MarketPlaceOrdersWidget.routeName,
                                                                    //                     queryParameters: {
                                                                    //                       'marketPlaceRef': serializeParam(
                                                                    //                         underReviewMarketPlaceRecord.reference,
                                                                    //                         ParamType.DocumentReference,
                                                                    //                       ),
                                                                    //                     }.withoutNulls,
                                                                    //                   );
                                                                    //                 },
                                                                    //                 text: 'Bookings',
                                                                    //                 icon: Icon(Icons.handshake_sharp, size: 15.0),
                                                                    //                 options: FFButtonOptions(
                                                                    //                   height: 36.0,
                                                                    //                   padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                                                                    //                   iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                                    //                   color: FlutterFlowTheme.of(context).success,
                                                                    //                   textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                                    //                     fontFamily: GoogleFonts.interTight().fontFamily,
                                                                    //                     color: Colors.white,
                                                                    //                   ),
                                                                    //                   elevation: 0.0,
                                                                    //                   borderRadius: BorderRadius.circular(8.0),
                                                                    //                 ),
                                                                    //               ),
                                                                    //             ),
                                                                    //           ],
                                                                    //         ),
                                                                    //       ],
                                                                    //     ),
                                                                    //   ),
                                                                    // ),
                                                                  );
                                                                },
                                                              );
                                                            },
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ),

                                                // REJECTED listings
                                                if (_model.myListingStatus ==
                                                    'Rejected')
                                                  SizedBox(
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.all(5.0),
                                                      child: StreamBuilder<
                                                          List<
                                                              MarketPlaceRecord>>(
                                                        stream:
                                                            queryMarketPlaceRecord(
                                                          queryBuilder:
                                                              (marketPlaceRecord) =>
                                                                  marketPlaceRecord
                                                                      .where(
                                                                        'postedBy',
                                                                        isEqualTo:
                                                                            currentUserReference,
                                                                      )
                                                                      .where(
                                                                        'status',
                                                                        isEqualTo:
                                                                            'Rejected',
                                                                      ),
                                                        ),
                                                        builder: (context,
                                                            snapshot) {
                                                          // Customize what your widget looks like when it's loading.
                                                          if (!snapshot
                                                              .hasData) {
                                                            return Center(
                                                              child: SizedBox(
                                                                width: 50.0,
                                                                height: 50.0,
                                                                child:
                                                                    SpinKitFadingCircle(
                                                                  color: Color(
                                                                      0xFF2B3C58),
                                                                  size: 50.0,
                                                                ),
                                                              ),
                                                            );
                                                          }
                                                          List<MarketPlaceRecord>
                                                              rejectedLisitngMarketPlaceRecordList =
                                                              snapshot.data!;
                                                          if (rejectedLisitngMarketPlaceRecordList
                                                              .isEmpty) {
                                                            return NoMarketPlaceRideDriverWidget();
                                                          }

                                                          return ListView
                                                              .separated(
                                                            padding:
                                                                EdgeInsets.zero,
                                                            physics:
                                                                NeverScrollableScrollPhysics(),
                                                            primary: false,
                                                            shrinkWrap: true,
                                                            scrollDirection:
                                                                Axis.vertical,
                                                            itemCount:
                                                                rejectedLisitngMarketPlaceRecordList
                                                                    .length,
                                                            separatorBuilder: (_,
                                                                    __) =>
                                                                SizedBox(
                                                                    height:
                                                                        15.0),
                                                            itemBuilder: (context,
                                                                rejectedLisitngIndex) {
                                                              final rejectedLisitngMarketPlaceRecord =
                                                                  rejectedLisitngMarketPlaceRecordList[
                                                                      rejectedLisitngIndex];
                                                              return StreamBuilder<
                                                                  UsersRecord>(
                                                                stream: UsersRecord
                                                                    .getDocument(
                                                                        rejectedLisitngMarketPlaceRecord
                                                                            .postedBy!),
                                                                builder: (context,
                                                                    snapshot) {
                                                                  // Customize what your widget looks like when it's loading.
                                                                  if (!snapshot
                                                                      .hasData) {
                                                                    return Center(
                                                                      child:
                                                                          SizedBox(
                                                                        width:
                                                                            50.0,
                                                                        height:
                                                                            50.0,
                                                                        child:
                                                                            SpinKitFadingCircle(
                                                                          color:
                                                                              Color(0xFF2B3C58),
                                                                          size:
                                                                              50.0,
                                                                        ),
                                                                      ),
                                                                    );
                                                                  }

                                                                  final cardUsersRecord =
                                                                      snapshot
                                                                          .data!;
                                                                  return Card(
                                                                    clipBehavior:
                                                                        Clip.antiAliasWithSaveLayer,
                                                                    color: Colors
                                                                        .white,
                                                                    elevation:
                                                                        6.0,
                                                                    shape:
                                                                        RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              16.0),
                                                                      side:
                                                                          BorderSide(
                                                                        color: Colors
                                                                            .grey
                                                                            .shade200,
                                                                        width:
                                                                            1.0,
                                                                      ),
                                                                    ),
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              16.0),
                                                                      child:
                                                                          Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          // --- PRODUCT INFO ROW ---
                                                                          Row(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              // Quote icon
                                                                              Padding(
                                                                                padding: EdgeInsets.only(top: 4.0),
                                                                                child: Icon(
                                                                                  Icons.format_quote_rounded,
                                                                                  color: Color(0xFFE0E0E0),
                                                                                  size: 28.0,
                                                                                ),
                                                                              ),
                                                                              SizedBox(width: 12.0),

                                                                              // Description (Expanded to take available space)
                                                                              Expanded(
                                                                                child: Padding(
                                                                                  padding: EdgeInsets.only(top: 2.0),
                                                                                  child: Text(
                                                                                    rejectedLisitngMarketPlaceRecord.descriptionItem ?? 'No description available',
                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                          fontFamily: 'Inter',
                                                                                          fontSize: 14.0,
                                                                                          fontWeight: FontWeight.w400,
                                                                                          fontStyle: FontStyle.italic,
                                                                                          color: Colors.grey.shade700,
                                                                                          // height: 1.4,
                                                                                        ),
                                                                                    maxLines: 3,
                                                                                    overflow: TextOverflow.ellipsis,
                                                                                  ),
                                                                                ),
                                                                              ),

                                                                              SizedBox(width: 16.0),

                                                                              // Product Image
                                                                              Container(
                                                                                width: 90.0,
                                                                                height: 90.0,
                                                                                decoration: BoxDecoration(
                                                                                  borderRadius: BorderRadius.circular(12.0),
                                                                                  border: Border.all(
                                                                                    color: Colors.grey.shade200,
                                                                                    width: 1.5,
                                                                                  ),
                                                                                ),
                                                                                child: ClipRRect(
                                                                                  borderRadius: BorderRadius.circular(10.0),
                                                                                  child: rejectedLisitngMarketPlaceRecord.imageOfproduct != null && rejectedLisitngMarketPlaceRecord.imageOfproduct!.isNotEmpty
                                                                                      ? Image.network(
                                                                                          rejectedLisitngMarketPlaceRecord.imageOfproduct!,
                                                                                          width: double.infinity,
                                                                                          height: double.infinity,
                                                                                          fit: BoxFit.cover,
                                                                                          loadingBuilder: (context, child, loadingProgress) {
                                                                                            if (loadingProgress == null) return child;
                                                                                            return Center(
                                                                                              child: CircularProgressIndicator(
                                                                                                value: loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes! : null,
                                                                                                strokeWidth: 2.0,
                                                                                                color: FlutterFlowTheme.of(context).primary,
                                                                                              ),
                                                                                            );
                                                                                          },
                                                                                          errorBuilder: (context, error, stackTrace) => Container(
                                                                                            color: Colors.grey.shade100,
                                                                                            child: Center(
                                                                                              child: Icon(
                                                                                                Icons.image_not_supported,
                                                                                                color: Colors.grey.shade400,
                                                                                                size: 32.0,
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        )
                                                                                      : Container(
                                                                                          color: Colors.grey.shade100,
                                                                                          child: Center(
                                                                                            child: Icon(
                                                                                              Icons.shopping_bag_outlined,
                                                                                              color: Colors.grey.shade400,
                                                                                              size: 32.0,
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),

                                                                          SizedBox(
                                                                              height: 20.0),

                                                                          // --- SELLER INFO ROW ---
                                                                          Row(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceBetween,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.center,
                                                                            children: [
                                                                              // Seller Profile + Name + Rating
                                                                              Expanded(
                                                                                child: InkWell(
                                                                                  splashColor: Colors.transparent,
                                                                                  focusColor: Colors.transparent,
                                                                                  hoverColor: Colors.transparent,
                                                                                  highlightColor: Colors.transparent,
                                                                                  onTap: () async {
                                                                                    context.pushNamed(
                                                                                      DriverReviewWidget.routeName,
                                                                                      queryParameters: {
                                                                                        'userRef': serializeParam(
                                                                                          cardUsersRecord.reference,
                                                                                          ParamType.DocumentReference,
                                                                                        ),
                                                                                      }.withoutNulls,
                                                                                    );
                                                                                  },
                                                                                  child: Row(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    children: [
                                                                                      // Profile Picture
                                                                                      Container(
                                                                                        width: 48.0,
                                                                                        height: 48.0,
                                                                                        decoration: BoxDecoration(
                                                                                          shape: BoxShape.circle,
                                                                                          border: Border.all(
                                                                                            color: FlutterFlowTheme.of(context).primary.withOpacity(0.2),
                                                                                            width: 1.5,
                                                                                          ),
                                                                                        ),
                                                                                        child: ClipRRect(
                                                                                          borderRadius: BorderRadius.circular(24.0),
                                                                                          child: cardUsersRecord.photoUrl != null && cardUsersRecord.photoUrl!.isNotEmpty
                                                                                              ? Image.network(
                                                                                                  cardUsersRecord.photoUrl!,
                                                                                                  fit: BoxFit.cover,
                                                                                                  loadingBuilder: (context, child, loadingProgress) {
                                                                                                    if (loadingProgress == null) return child;
                                                                                                    return Center(
                                                                                                      child: CircularProgressIndicator(
                                                                                                        strokeWidth: 2.0,
                                                                                                        color: FlutterFlowTheme.of(context).primary,
                                                                                                      ),
                                                                                                    );
                                                                                                  },
                                                                                                  errorBuilder: (context, error, stackTrace) => Image.asset(
                                                                                                    'assets/images/userIconTr.png',
                                                                                                    fit: BoxFit.cover,
                                                                                                  ),
                                                                                                )
                                                                                              : Image.asset(
                                                                                                  'assets/images/userIconTr.png',
                                                                                                  fit: BoxFit.cover,
                                                                                                ),
                                                                                        ),
                                                                                      ),

                                                                                      SizedBox(width: 12.0),

                                                                                      // Name and Rating
                                                                                      Expanded(
                                                                                        child: Column(
                                                                                          mainAxisSize: MainAxisSize.min,
                                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                                          children: [
                                                                                            Text(
                                                                                              cardUsersRecord.displayName ?? 'Unknown Seller',
                                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                    fontFamily: 'Inter',
                                                                                                    fontSize: 14.0,
                                                                                                    fontWeight: FontWeight.w600,
                                                                                                    color: Color(0xFF2D3748),
                                                                                                  ),
                                                                                              maxLines: 1,
                                                                                              overflow: TextOverflow.ellipsis,
                                                                                            ),

                                                                                            SizedBox(height: 4.0),

                                                                                            // Rating
                                                                                            Row(
                                                                                              mainAxisSize: MainAxisSize.min,
                                                                                              children: [
                                                                                                Container(
                                                                                                  padding: EdgeInsets.symmetric(
                                                                                                    horizontal: 6.0,
                                                                                                    vertical: 2.0,
                                                                                                  ),
                                                                                                  decoration: BoxDecoration(
                                                                                                    color: Color(0xFFFFF8E1),
                                                                                                    borderRadius: BorderRadius.circular(12.0),
                                                                                                  ),
                                                                                                  child: Row(
                                                                                                    mainAxisSize: MainAxisSize.min,
                                                                                                    children: [
                                                                                                      Icon(
                                                                                                        Icons.star_rounded,
                                                                                                        color: Color(0xFFFFB300),
                                                                                                        size: 14.0,
                                                                                                      ),
                                                                                                      SizedBox(width: 4.0),
                                                                                                      Text(
                                                                                                        valueOrDefault<String>(
                                                                                                          formatNumber(
                                                                                                            functions.averageRating(cardUsersRecord.ratings.toList()),
                                                                                                            formatType: FormatType.compact,
                                                                                                          ),
                                                                                                          '4.5',
                                                                                                        ),
                                                                                                        style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                                              fontFamily: 'Inter',
                                                                                                              fontSize: 11.0,
                                                                                                              fontWeight: FontWeight.w600,
                                                                                                              color: Color(0xFF5D4037),
                                                                                                            ),
                                                                                                      ),
                                                                                                    ],
                                                                                                  ),
                                                                                                ),
                                                                                              ],
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              ),

                                                                              // Status Badge
                                                                              Container(
                                                                                padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0),
                                                                                decoration: BoxDecoration(
                                                                                  color: () {
                                                                                    if (rejectedLisitngMarketPlaceRecord.status == 'Active' || rejectedLisitngMarketPlaceRecord.status == 'Live') {
                                                                                      return FlutterFlowTheme.of(context).success.withOpacity(0.1);
                                                                                    } else if (rejectedLisitngMarketPlaceRecord.status == 'Rejected') {
                                                                                      return FlutterFlowTheme.of(context).error.withOpacity(0.1);
                                                                                    } else {
                                                                                      return FlutterFlowTheme.of(context).warning.withOpacity(0.1);
                                                                                    }
                                                                                  }(),
                                                                                  borderRadius: BorderRadius.circular(20.0),
                                                                                  border: Border.all(
                                                                                    color: () {
                                                                                      if (rejectedLisitngMarketPlaceRecord.status == 'Active' || rejectedLisitngMarketPlaceRecord.status == 'Live') {
                                                                                        return FlutterFlowTheme.of(context).success;
                                                                                      } else if (rejectedLisitngMarketPlaceRecord.status == 'Rejected') {
                                                                                        return FlutterFlowTheme.of(context).error;
                                                                                      } else {
                                                                                        return FlutterFlowTheme.of(context).warning;
                                                                                      }
                                                                                    }(),
                                                                                    width: 1.5,
                                                                                  ),
                                                                                ),
                                                                                child: Row(
                                                                                  mainAxisSize: MainAxisSize.min,
                                                                                  children: [
                                                                                    Container(
                                                                                      width: 8.0,
                                                                                      height: 8.0,
                                                                                      margin: EdgeInsets.only(right: 6.0),
                                                                                      decoration: BoxDecoration(
                                                                                        shape: BoxShape.circle,
                                                                                        color: () {
                                                                                          if (rejectedLisitngMarketPlaceRecord.status == 'Active' || rejectedLisitngMarketPlaceRecord.status == 'Live') {
                                                                                            return FlutterFlowTheme.of(context).success;
                                                                                          } else if (rejectedLisitngMarketPlaceRecord.status == 'Rejected') {
                                                                                            return FlutterFlowTheme.of(context).error;
                                                                                          } else {
                                                                                            return FlutterFlowTheme.of(context).warning;
                                                                                          }
                                                                                        }(),
                                                                                      ),
                                                                                    ),
                                                                                    Text(
                                                                                      rejectedLisitngMarketPlaceRecord.status ?? 'Unknown',
                                                                                      style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                            fontFamily: 'Inter',
                                                                                            fontSize: 12.0,
                                                                                            fontWeight: FontWeight.w600,
                                                                                            color: () {
                                                                                              if (rejectedLisitngMarketPlaceRecord.status == 'Active' || rejectedLisitngMarketPlaceRecord.status == 'Live') {
                                                                                                return FlutterFlowTheme.of(context).success;
                                                                                              } else if (rejectedLisitngMarketPlaceRecord.status == 'Rejected') {
                                                                                                return FlutterFlowTheme.of(context).error;
                                                                                              } else {
                                                                                                return FlutterFlowTheme.of(context).warning;
                                                                                              }
                                                                                            }(),
                                                                                          ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),

                                                                          SizedBox(
                                                                              height: 24.0),

                                                                          // --- ACTION BUTTONS ROW ---
                                                                          Row(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                              // Delete Button
                                                                              GestureDetector(
                                                                                onTap: () {
                                                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                                                    SnackBar(
                                                                                      content: Row(
                                                                                        children: [
                                                                                          Icon(Icons.info_outline, color: Colors.white, size: 20.0),
                                                                                          SizedBox(width: 8.0),
                                                                                          Expanded(
                                                                                            child: Text(
                                                                                              'Double tap to delete this listing',
                                                                                              style: TextStyle(
                                                                                                color: Colors.white,
                                                                                                fontWeight: FontWeight.w500,
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                      duration: Duration(milliseconds: 3000),
                                                                                      backgroundColor: FlutterFlowTheme.of(context).secondary,
                                                                                      behavior: SnackBarBehavior.floating,
                                                                                      shape: RoundedRectangleBorder(
                                                                                        borderRadius: BorderRadius.circular(12.0),
                                                                                      ),
                                                                                    ),
                                                                                  );
                                                                                },
                                                                                onDoubleTap: () async {
                                                                                  await rejectedLisitngMarketPlaceRecord.reference.delete();
                                                                                },
                                                                                child: Container(
                                                                                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                                                                                  decoration: BoxDecoration(
                                                                                    color: Color(0xFFFEF2F2),
                                                                                    borderRadius: BorderRadius.circular(10.0),
                                                                                    border: Border.all(
                                                                                      color: Color(0xFFFECACA),
                                                                                      width: 1.5,
                                                                                    ),
                                                                                  ),
                                                                                  child: Row(
                                                                                    mainAxisSize: MainAxisSize.min,
                                                                                    children: [
                                                                                      Icon(
                                                                                        Icons.delete_outline_rounded,
                                                                                        color: Color(0xFFDC2626),
                                                                                        size: 18.0,
                                                                                      ),
                                                                                      SizedBox(width: 8.0),
                                                                                      Text(
                                                                                        'Delete',
                                                                                        style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                              fontFamily: 'Inter',
                                                                                              fontSize: 13.0,
                                                                                              fontWeight: FontWeight.w600,
                                                                                              color: Color(0xFFDC2626),
                                                                                            ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              ),

                                                                              // Bookings Button
                                                                              FFButtonWidget(
                                                                                onPressed: () async {
                                                                                  context.pushNamed(
                                                                                    MarketPlaceOrdersWidget.routeName,
                                                                                    queryParameters: {
                                                                                      'marketPlaceRef': serializeParam(
                                                                                        rejectedLisitngMarketPlaceRecord.reference,
                                                                                        ParamType.DocumentReference,
                                                                                      ),
                                                                                    }.withoutNulls,
                                                                                  );
                                                                                },
                                                                                text: 'View Bookings',
                                                                                icon: Icon(
                                                                                  Icons.handshake_outlined,
                                                                                  size: 16.0,
                                                                                ),
                                                                                options: FFButtonOptions(
                                                                                  height: 40.0,
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
                                                                                  iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 8.0, 0.0),
                                                                                  color: FlutterFlowTheme.of(context).success,
                                                                                  textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                        fontFamily: 'Inter',
                                                                                        fontSize: 14.0,
                                                                                        fontWeight: FontWeight.w600,
                                                                                        color: Colors.white,
                                                                                      ),
                                                                                  elevation: 0.0,
                                                                                  borderSide: BorderSide(
                                                                                    color: FlutterFlowTheme.of(context).success,
                                                                                    width: 1.5,
                                                                                  ),
                                                                                  borderRadius: BorderRadius.circular(10.0),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  );

                                                                  // return Card(
                                                                  //   clipBehavior: Clip.antiAliasWithSaveLayer,
                                                                  //   color: Colors.white,
                                                                  //   elevation: 4.0,
                                                                  //   shape: RoundedRectangleBorder(
                                                                  //     borderRadius: BorderRadius.circular(16.0),
                                                                  //   ),
                                                                  //   child: Padding(
                                                                  //     padding: EdgeInsets.all(5.0),
                                                                  //     child: Column(
                                                                  //       mainAxisSize: MainAxisSize.max,
                                                                  //       crossAxisAlignment: CrossAxisAlignment.start,
                                                                  //       children: [
                                                                  //         Row(
                                                                  //           mainAxisSize: MainAxisSize.max,
                                                                  //           mainAxisAlignment: MainAxisAlignment.start,
                                                                  //           crossAxisAlignment: CrossAxisAlignment.start,
                                                                  //           children: [
                                                                  //             Icon(
                                                                  //               Icons.format_quote,
                                                                  //               color: Color(0xFFD0D0D0),
                                                                  //               size: 24.0,
                                                                  //             ),
                                                                  //             Flexible(
                                                                  //               child: Column(
                                                                  //                 mainAxisSize: MainAxisSize.max,
                                                                  //                 crossAxisAlignment: CrossAxisAlignment.start,
                                                                  //                 children: [
                                                                  //                   Text(
                                                                  //                     rejectedLisitngMarketPlaceRecord.descriptionItem,
                                                                  //                     style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                  //                       font: GoogleFonts.inter(
                                                                  //                         fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                  //                         fontStyle: FontStyle.italic,
                                                                  //                       ),
                                                                  //                       color: FlutterFlowTheme.of(context).primaryText,
                                                                  //                       fontSize: 14.0,
                                                                  //                       letterSpacing: 0.0,
                                                                  //                       fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                  //                       fontStyle: FontStyle.italic,
                                                                  //                     ),
                                                                  //                   ),
                                                                  //                 ],
                                                                  //               ),
                                                                  //             ),
                                                                  //             Container(
                                                                  //               width: 80.0,
                                                                  //               height: 80.0,
                                                                  //               decoration: BoxDecoration(
                                                                  //                 color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                  //                 image: DecorationImage(
                                                                  //                   fit: BoxFit.cover,
                                                                  //                   image: Image.network(
                                                                  //                     '500x500?bakery',
                                                                  //                   ).image,
                                                                  //                 ),
                                                                  //                 borderRadius: BorderRadius.circular(12.0),
                                                                  //               ),
                                                                  //               child: ClipRRect(
                                                                  //                 borderRadius: BorderRadius.circular(8.0),
                                                                  //                 child: Image.network(
                                                                  //                   rejectedLisitngMarketPlaceRecord.imageOfproduct,
                                                                  //                   width: double.infinity,
                                                                  //                   height: 200.0,
                                                                  //                   fit: BoxFit.cover,
                                                                  //                 ),
                                                                  //               ),
                                                                  //             ),
                                                                  //           ].divide(SizedBox(width: 8.0)),
                                                                  //         ),
                                                                  //         Row(
                                                                  //           mainAxisSize: MainAxisSize.max,
                                                                  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  //           crossAxisAlignment: CrossAxisAlignment.center,
                                                                  //           children: [
                                                                  //             Row(
                                                                  //               mainAxisSize: MainAxisSize.max,
                                                                  //               children: [
                                                                  //                 Builder(
                                                                  //                   builder: (context) {
                                                                  //                     if (cardUsersRecord.photoUrl != null && cardUsersRecord.photoUrl != '') {
                                                                  //                       return Container(
                                                                  //                         width: 50.0,
                                                                  //                         height: 50.0,
                                                                  //                         clipBehavior: Clip.antiAlias,
                                                                  //                         decoration: BoxDecoration(
                                                                  //                           shape: BoxShape.circle,
                                                                  //                         ),
                                                                  //                         child: Image.network(
                                                                  //                           cardUsersRecord.photoUrl,
                                                                  //                           fit: BoxFit.cover,
                                                                  //                         ),
                                                                  //                       );
                                                                  //                     } else {
                                                                  //                       return Container(
                                                                  //                         width: 50.0,
                                                                  //                         height: 50.0,
                                                                  //                         clipBehavior: Clip.antiAlias,
                                                                  //                         decoration: BoxDecoration(
                                                                  //                           shape: BoxShape.circle,
                                                                  //                         ),
                                                                  //                         child: Image.asset(
                                                                  //                           'assets/images/userIconTr.png',
                                                                  //                           fit: BoxFit.cover,
                                                                  //                         ),
                                                                  //                       );
                                                                  //                     }
                                                                  //                   },
                                                                  //                 ),
                                                                  //                 Column(
                                                                  //                   mainAxisSize: MainAxisSize.max,
                                                                  //                   crossAxisAlignment: CrossAxisAlignment.start,
                                                                  //                   children: [
                                                                  //                     Row(
                                                                  //                       mainAxisSize: MainAxisSize.min,
                                                                  //                       children: [
                                                                  //                         Text(
                                                                  //                           cardUsersRecord.displayName,
                                                                  //                           style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                  //                             font: GoogleFonts.inter(
                                                                  //                               fontWeight: FontWeight.bold,
                                                                  //                               fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                  //                             ),
                                                                  //                             color: Color(0xFF69778E),
                                                                  //                             fontSize: 12.0,
                                                                  //                             letterSpacing: 0.0,
                                                                  //                             fontWeight: FontWeight.bold,
                                                                  //                             fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                  //                           ),
                                                                  //                         ),
                                                                  //                         Padding(
                                                                  //                           padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 5.0, 0.0),
                                                                  //                           child: Stack(
                                                                  //                             alignment: AlignmentDirectional(0.0, 0.0),
                                                                  //                             children: [
                                                                  //                               ClipRRect(
                                                                  //                                 borderRadius: BorderRadius.circular(8.0),
                                                                  //                                 child: Image.asset(
                                                                  //                                   'assets/images/Ride_Search_Icons.png',
                                                                  //                                   width: 34.0,
                                                                  //                                   height: 35.8,
                                                                  //                                   fit: BoxFit.cover,
                                                                  //                                 ),
                                                                  //                               ),
                                                                  //                               Text(
                                                                  //                                 '4.8',
                                                                  //                                 style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                  //                                   font: GoogleFonts.inter(
                                                                  //                                     fontWeight: FontWeight.w900,
                                                                  //                                     fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                  //                                   ),
                                                                  //                                   color: FlutterFlowTheme.of(context).primaryBackground,
                                                                  //                                   fontSize: 10.0,
                                                                  //                                   letterSpacing: 0.0,
                                                                  //                                   fontWeight: FontWeight.w900,
                                                                  //                                   fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                  //                                 ),
                                                                  //                               ),
                                                                  //                             ],
                                                                  //                           ),
                                                                  //                         ),
                                                                  //                       ].divide(SizedBox(width: 4.0)),
                                                                  //                     ),
                                                                  //                   ],
                                                                  //                 ),
                                                                  //               ].divide(SizedBox(width: 8.0)),
                                                                  //             ),
                                                                  //           ],
                                                                  //         ),
                                                                  //         Row(
                                                                  //           mainAxisSize: MainAxisSize.max,
                                                                  //           mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                  //           children: [
                                                                  //             Text(
                                                                  //               'Current Status:',
                                                                  //               style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                  //                 font: GoogleFonts.inter(
                                                                  //                   fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                  //                   fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                  //                 ),
                                                                  //                 letterSpacing: 0.0,
                                                                  //                 fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                  //                 fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                  //               ),
                                                                  //             ),
                                                                  //             Text(
                                                                  //               rejectedLisitngMarketPlaceRecord.status,
                                                                  //               style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                  //                 font: GoogleFonts.inter(
                                                                  //                   fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                  //                   fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                  //                 ),
                                                                  //                 color: () {
                                                                  //                   if (rejectedLisitngMarketPlaceRecord.status == 'Active') {
                                                                  //                     return FlutterFlowTheme.of(context).success;
                                                                  //                   } else if (rejectedLisitngMarketPlaceRecord.status == 'Rejected') {
                                                                  //                     return FlutterFlowTheme.of(context).error;
                                                                  //                   } else {
                                                                  //                     return FlutterFlowTheme.of(context).warning;
                                                                  //                   }
                                                                  //                 }(),
                                                                  //                 letterSpacing: 0.0,
                                                                  //                 fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                  //                 fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                  //               ),
                                                                  //             ),
                                                                  //           ],
                                                                  //         ),
                                                                  //         Row(
                                                                  //           mainAxisSize: MainAxisSize.max,
                                                                  //           mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                  //           children: [
                                                                  //             InkWell(
                                                                  //               splashColor: Colors.transparent,
                                                                  //               focusColor: Colors.transparent,
                                                                  //               hoverColor: Colors.transparent,
                                                                  //               highlightColor: Colors.transparent,
                                                                  //               onTap: () async {
                                                                  //                 ScaffoldMessenger.of(context).showSnackBar(
                                                                  //                   SnackBar(
                                                                  //                     content: Text(
                                                                  //                       'Double tap to delete it.',
                                                                  //                       style: TextStyle(
                                                                  //                         color: FlutterFlowTheme.of(context).primaryText,
                                                                  //                       ),
                                                                  //                     ),
                                                                  //                     duration: Duration(milliseconds: 4000),
                                                                  //                     backgroundColor: FlutterFlowTheme.of(context).secondary,
                                                                  //                   ),
                                                                  //                 );
                                                                  //               },
                                                                  //               onDoubleTap: () async {
                                                                  //                 await rejectedLisitngMarketPlaceRecord.reference.delete();
                                                                  //               },
                                                                  //               child: Icon(
                                                                  //                 Icons.delete,
                                                                  //                 color: Color(0xFFDC0A46),
                                                                  //                 size: 24.0,
                                                                  //               ),
                                                                  //             ),
                                                                  //             FFButtonWidget(
                                                                  //               onPressed: () async {
                                                                  //                 context.pushNamed(
                                                                  //                   MarketPlaceOrdersWidget.routeName,
                                                                  //                   queryParameters: {
                                                                  //                     'marketPlaceRef': serializeParam(
                                                                  //                       rejectedLisitngMarketPlaceRecord.reference,
                                                                  //                       ParamType.DocumentReference,
                                                                  //                     ),
                                                                  //                   }.withoutNulls,
                                                                  //                 );
                                                                  //               },
                                                                  //               text: 'Bookings',
                                                                  //               icon: Icon(
                                                                  //                 Icons.handshake_sharp,
                                                                  //                 size: 15.0,
                                                                  //               ),
                                                                  //               options: FFButtonOptions(
                                                                  //                 height: 30.0,
                                                                  //                 padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                                                                  //                 iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                                  //                 color: FlutterFlowTheme.of(context).success,
                                                                  //                 textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                                  //                   font: GoogleFonts.interTight(
                                                                  //                     fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
                                                                  //                     fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                  //                   ),
                                                                  //                   color: Colors.white,
                                                                  //                   letterSpacing: 0.0,
                                                                  //                   fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
                                                                  //                   fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                  //                 ),
                                                                  //                 elevation: 0.0,
                                                                  //                 borderRadius: BorderRadius.circular(8.0),
                                                                  //               ),
                                                                  //             ),
                                                                  //           ],
                                                                  //         ),
                                                                  //       ].divide(SizedBox(height: 10.0)),
                                                                  //     ),
                                                                  //   ),
                                                                  // );
                                                                },
                                                              );
                                                            },
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    wrapWithModel(
                      model: _model.mainFooterModel,
                      updateCallback: () => safeSetState(() {}),
                      child: MainFooterWidget(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
