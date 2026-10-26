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
                                      color: Colors.black.withOpacity(0.06),
                                      blurRadius: 10.0,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(14.0),
                                  onTap: () async {
                                    context.pushNamed(
                                        PageNotificationWidget.routeName);
                                  },
                                  child: const Center(
                                    child: Icon(
                                      Icons.notifications_none_rounded,
                                      color: Color(0xFF1E293B),
                                      size: 24.0,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                right: -1,
                                top: -1,
                                child: Container(
                                  constraints: const BoxConstraints(
                                    minWidth: 18.0,
                                    minHeight: 18.0,
                                  ),
                                  padding: const EdgeInsets.all(3.0),
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context).tertiary,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 2.0,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: FlutterFlowTheme.of(context).tertiary.withOpacity(0.3),
                                        blurRadius: 4.0,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Text(
                                      unreadCount > 9 ? '9+' : unreadCount.toString(),
                                      style: GoogleFonts.inter(
                                        color: Colors.white,
                                        fontSize: unreadCount > 9 ? 8.0 : 9.5,
                                        fontWeight: FontWeight.bold,
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

                      const SizedBox(width: 10.0),

                      // Orange Crown Icon (Plans)
                      Container(
                        width: 44.0,
                        height: 44.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.06),
                              blurRadius: 10.0,
                              offset: const Offset(0, 3),
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
                              color: FlutterFlowTheme.of(context).tertiary,
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
                                    FlutterFlowTheme.of(context).tertiary,
                                unselectedLabelColor:
                                    const Color(0xFF64748B),
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
                                    FlutterFlowTheme.of(context).tertiary,
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
                                                                              now.day);
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
                                                                        // ✅ DEFAULT: Show active marketplace items from today onwards
                                                                        final now = DateTime.now();
                                                                        final today = DateTime(now.year, now.month, now.day);
                                                                        print(
                                                                            '📱 DEFAULT: Showing all active items from today onwards');
                                                                        return queryMarketPlaceRecord(
                                                                          queryBuilder: (marketPlaceRecord) => marketPlaceRecord
                                                                              .where('status', isEqualTo: 'Active')
                                                                              .where('arivalDate', isGreaterThanOrEqualTo: today)
                                                                              .orderBy('arivalDate', descending: false),
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

                                                                      // Filter out past bookings (before today)
                                                                      final nowFilter = DateTime.now();
                                                                      final todayFilter = DateTime(nowFilter.year, nowFilter.month, nowFilter.day);
                                                                      listViewMarketPlaceRecordList = listViewMarketPlaceRecordList.where((item) {
                                                                        if (item.arivalDate == null) return false;
                                                                        return !item.arivalDate!.isBefore(todayFilter);
                                                                      }).toList();

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
                                          // ==========================================
                                          // TAB 1: MY BOOKED
                                          // ==========================================
                                          SingleChildScrollView(
                                            physics: const AlwaysScrollableScrollPhysics(),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                // Filter by Status Header
                                                Padding(
                                                  padding: const EdgeInsetsDirectional.fromSTEB(14.0, 12.0, 14.0, 10.0),
                                                  child: Container(
                                                    padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 4.0),
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius: BorderRadius.circular(14.0),
                                                      border: Border.all(color: const Color(0xFFE2E8F0)),
                                                      boxShadow: const [
                                                        BoxShadow(
                                                          color: Color(0x08000000),
                                                          blurRadius: 6.0,
                                                          offset: Offset(0, 2),
                                                        ),
                                                      ],
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        const Icon(Icons.filter_list_rounded, size: 20.0, color: Color(0xFFE66A4E)),
                                                        const SizedBox(width: 8.0),
                                                        Text(
                                                          'Status:',
                                                          style: GoogleFonts.inter(
                                                            fontSize: 14.0,
                                                            fontWeight: FontWeight.w700,
                                                            color: const Color(0xFF1E293B),
                                                          ),
                                                        ),
                                                        const SizedBox(width: 12.0),
                                                        Expanded(
                                                          child: FlutterFlowDropDown<String>(
                                                            controller: _model.bookingsDropDownValueController ??=
                                                                FormFieldController<String>('All'),
                                                            options: const [
                                                              'All',
                                                              'Pending',
                                                              'Accepted',
                                                              'Completed',
                                                              'Rejected'
                                                            ],
                                                            onChanged: (val) async {
                                                              safeSetState(() => _model.bookingsDropDownValue = val);
                                                              _model.showMyBookings = val!;
                                                              safeSetState(() {});
                                                            },
                                                            height: 38.0,
                                                            textStyle: GoogleFonts.inter(
                                                              fontSize: 13.5,
                                                              fontWeight: FontWeight.w600,
                                                              color: const Color(0xFF334155),
                                                            ),
                                                            hintText: 'Filter by Status...',
                                                            icon: const Icon(
                                                              Icons.keyboard_arrow_down_rounded,
                                                              color: Color(0xFF64748B),
                                                              size: 22.0,
                                                            ),
                                                            fillColor: Colors.white,
                                                            elevation: 4.0,
                                                            borderColor: Colors.transparent,
                                                            borderWidth: 0.0,
                                                            borderRadius: 12.0,
                                                            margin: const EdgeInsets.symmetric(horizontal: 10.0),
                                                            hidesUnderline: true,
                                                            isOverButton: false,
                                                            isSearchable: false,
                                                            isMultiSelect: false,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),

                                                // Horizontal Status Filter Chips
                                                SingleChildScrollView(
                                                  scrollDirection: Axis.horizontal,
                                                  padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 2.0),
                                                  child: Row(
                                                    children: [
                                                      _buildStatusFilterChip('All', _model.showMyBookings == 'All', () {
                                                        safeSetState(() {
                                                          _model.bookingsDropDownValue = 'All';
                                                          _model.showMyBookings = 'All';
                                                          _model.bookingsDropDownValueController?.value = 'All';
                                                        });
                                                      }),
                                                      _buildStatusFilterChip('Pending', _model.showMyBookings == 'Pending', () {
                                                        safeSetState(() {
                                                          _model.bookingsDropDownValue = 'Pending';
                                                          _model.showMyBookings = 'Pending';
                                                          _model.bookingsDropDownValueController?.value = 'Pending';
                                                        });
                                                      }, icon: Icons.hourglass_top_rounded),
                                                      _buildStatusFilterChip('Accepted', _model.showMyBookings == 'Accepted', () {
                                                        safeSetState(() {
                                                          _model.bookingsDropDownValue = 'Accepted';
                                                          _model.showMyBookings = 'Accepted';
                                                          _model.bookingsDropDownValueController?.value = 'Accepted';
                                                        });
                                                      }, icon: Icons.thumb_up_alt_rounded),
                                                      _buildStatusFilterChip('Completed', _model.showMyBookings == 'Completed', () {
                                                        safeSetState(() {
                                                          _model.bookingsDropDownValue = 'Completed';
                                                          _model.showMyBookings = 'Completed';
                                                          _model.bookingsDropDownValueController?.value = 'Completed';
                                                        });
                                                      }, icon: Icons.check_circle_rounded),
                                                      _buildStatusFilterChip('Rejected', _model.showMyBookings == 'Rejected', () {
                                                        safeSetState(() {
                                                          _model.bookingsDropDownValue = 'Rejected';
                                                          _model.showMyBookings = 'Rejected';
                                                          _model.bookingsDropDownValueController?.value = 'Rejected';
                                                        });
                                                      }, icon: Icons.cancel_rounded),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(height: 6.0),

                                                // Bookings Stream
                                                StreamBuilder<List<BidsForMarketPlaceRecord>>(
                                                  stream: queryBidsForMarketPlaceRecord(
                                                    queryBuilder: (bids) {
                                                      var q = bids.where('bidsCreatorID', isEqualTo: currentUserReference);
                                                      if (_model.showMyBookings != 'All') {
                                                        q = q.where('status', isEqualTo: _model.showMyBookings);
                                                      }
                                                      return q;
                                                    },
                                                  ),
                                                  builder: (context, snapshot) {
                                                    if (!snapshot.hasData) {
                                                      return const Padding(
                                                        padding: EdgeInsets.symmetric(vertical: 40.0),
                                                        child: Center(
                                                          child: SizedBox(
                                                            width: 40.0,
                                                            height: 40.0,
                                                            child: SpinKitFadingCircle(
                                                              color: Color(0xFFE66A4E),
                                                              size: 40.0,
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }

                                                    final bookingsList = snapshot.data!;
                                                    if (bookingsList.isEmpty) {
                                                      return Padding(
                                                        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
                                                        child: Center(
                                                          child: Column(
                                                            mainAxisSize: MainAxisSize.min,
                                                            children: [
                                                              Container(
                                                                width: 76.0,
                                                                height: 76.0,
                                                                decoration: const BoxDecoration(
                                                                  color: Color(0xFFFFF1EE),
                                                                  shape: BoxShape.circle,
                                                                ),
                                                                child: const Center(
                                                                  child: Icon(
                                                                    Icons.shopping_bag_outlined,
                                                                    color: Color(0xFFE66A4E),
                                                                    size: 38.0,
                                                                  ),
                                                                ),
                                                              ),
                                                              const SizedBox(height: 16.0),
                                                              Text(
                                                                'No Bookings Found',
                                                                style: GoogleFonts.inter(
                                                                  fontSize: 18.0,
                                                                  fontWeight: FontWeight.w700,
                                                                  color: const Color(0xFF1E293B),
                                                                ),
                                                              ),
                                                              const SizedBox(height: 8.0),
                                                              Text(
                                                                _model.showMyBookings == 'All'
                                                                    ? 'You haven\'t placed any orders or bids yet. Explore the marketplace to find great deals!'
                                                                    : 'No bookings found with "${_model.showMyBookings}" status.',
                                                                textAlign: TextAlign.center,
                                                                style: GoogleFonts.inter(
                                                                  fontSize: 13.5,
                                                                  color: const Color(0xFF64748B),
                                                                  height: 1.4,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    }

                                                    return ListView.separated(
                                                      padding: const EdgeInsets.only(bottom: 24.0),
                                                      physics: const NeverScrollableScrollPhysics(),
                                                      primary: false,
                                                      shrinkWrap: true,
                                                      itemCount: bookingsList.length,
                                                      separatorBuilder: (_, __) => const SizedBox(height: 4.0),
                                                      itemBuilder: (context, index) {
                                                        return _buildBookedCard(bookingsList[index]);
                                                      },
                                                    );
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),

                                          // ==========================================
                                          // TAB 2: MY LISTED
                                          // ==========================================
                                          SingleChildScrollView(
                                            physics: const AlwaysScrollableScrollPhysics(),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                // Filter by Status Header
                                                Padding(
                                                  padding: const EdgeInsetsDirectional.fromSTEB(14.0, 12.0, 14.0, 10.0),
                                                  child: Container(
                                                    padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 4.0),
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius: BorderRadius.circular(14.0),
                                                      border: Border.all(color: const Color(0xFFE2E8F0)),
                                                      boxShadow: const [
                                                        BoxShadow(
                                                          color: Color(0x08000000),
                                                          blurRadius: 6.0,
                                                          offset: Offset(0, 2),
                                                        ),
                                                      ],
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        const Icon(Icons.filter_list_rounded, size: 20.0, color: Color(0xFFE66A4E)),
                                                        const SizedBox(width: 8.0),
                                                        Text(
                                                          'Status:',
                                                          style: GoogleFonts.inter(
                                                            fontSize: 14.0,
                                                            fontWeight: FontWeight.w700,
                                                            color: const Color(0xFF1E293B),
                                                          ),
                                                        ),
                                                        const SizedBox(width: 12.0),
                                                        Expanded(
                                                          child: FlutterFlowDropDown<String>(
                                                            controller: _model.listingDropDownValueController ??=
                                                                FormFieldController<String>('All'),
                                                            options: const [
                                                              'All',
                                                              'Live',
                                                              'Under Review',
                                                              'Rejected'
                                                            ],
                                                            onChanged: (val) async {
                                                              safeSetState(() => _model.listingDropDownValue = val);
                                                              _model.myListingStatus = val!;
                                                              safeSetState(() {});
                                                            },
                                                            height: 38.0,
                                                            textStyle: GoogleFonts.inter(
                                                              fontSize: 13.5,
                                                              fontWeight: FontWeight.w600,
                                                              color: const Color(0xFF334155),
                                                            ),
                                                            hintText: 'Filter by Status...',
                                                            icon: const Icon(
                                                              Icons.keyboard_arrow_down_rounded,
                                                              color: Color(0xFF64748B),
                                                              size: 22.0,
                                                            ),
                                                            fillColor: Colors.white,
                                                            elevation: 4.0,
                                                            borderColor: Colors.transparent,
                                                            borderWidth: 0.0,
                                                            borderRadius: 12.0,
                                                            margin: const EdgeInsets.symmetric(horizontal: 10.0),
                                                            hidesUnderline: true,
                                                            isOverButton: false,
                                                            isSearchable: false,
                                                            isMultiSelect: false,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),

                                                // Horizontal Status Filter Chips
                                                SingleChildScrollView(
                                                  scrollDirection: Axis.horizontal,
                                                  padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 2.0),
                                                  child: Row(
                                                    children: [
                                                      _buildStatusFilterChip('All', _model.myListingStatus == 'All', () {
                                                        safeSetState(() {
                                                          _model.listingDropDownValue = 'All';
                                                          _model.myListingStatus = 'All';
                                                          _model.listingDropDownValueController?.value = 'All';
                                                        });
                                                      }),
                                                      _buildStatusFilterChip('Live', _model.myListingStatus == 'Live', () {
                                                        safeSetState(() {
                                                          _model.listingDropDownValue = 'Live';
                                                          _model.myListingStatus = 'Live';
                                                          _model.listingDropDownValueController?.value = 'Live';
                                                        });
                                                      }, icon: Icons.check_circle_rounded),
                                                      _buildStatusFilterChip('Under Review', _model.myListingStatus == 'Under Review', () {
                                                        safeSetState(() {
                                                          _model.listingDropDownValue = 'Under Review';
                                                          _model.myListingStatus = 'Under Review';
                                                          _model.listingDropDownValueController?.value = 'Under Review';
                                                        });
                                                      }, icon: Icons.schedule_rounded),
                                                      _buildStatusFilterChip('Rejected', _model.myListingStatus == 'Rejected', () {
                                                        safeSetState(() {
                                                          _model.listingDropDownValue = 'Rejected';
                                                          _model.myListingStatus = 'Rejected';
                                                          _model.listingDropDownValueController?.value = 'Rejected';
                                                        });
                                                      }, icon: Icons.cancel_rounded),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(height: 6.0),

                                                // Listings Stream
                                                StreamBuilder<List<MarketPlaceRecord>>(
                                                  stream: queryMarketPlaceRecord(
                                                    queryBuilder: (listings) {
                                                      var q = listings.where('postedBy', isEqualTo: currentUserReference);
                                                      if (_model.myListingStatus == 'Live') {
                                                        q = q.where('status', isEqualTo: 'Active');
                                                      } else if (_model.myListingStatus == 'Under Review') {
                                                        q = q.where('status', isEqualTo: 'Under Review');
                                                      } else if (_model.myListingStatus == 'Rejected') {
                                                        q = q.where('status', isEqualTo: 'Rejected');
                                                      }
                                                      return q;
                                                    },
                                                  ),
                                                  builder: (context, snapshot) {
                                                    if (!snapshot.hasData) {
                                                      return const Padding(
                                                        padding: EdgeInsets.symmetric(vertical: 40.0),
                                                        child: Center(
                                                          child: SizedBox(
                                                            width: 40.0,
                                                            height: 40.0,
                                                            child: SpinKitFadingCircle(
                                                              color: Color(0xFFE66A4E),
                                                              size: 40.0,
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }

                                                    final listingsList = snapshot.data!;
                                                    if (listingsList.isEmpty) {
                                                      return const NoMarketPlaceRideDriverWidget();
                                                    }

                                                    return ListView.separated(
                                                      padding: const EdgeInsets.only(bottom: 24.0),
                                                      physics: const NeverScrollableScrollPhysics(),
                                                      primary: false,
                                                      shrinkWrap: true,
                                                      itemCount: listingsList.length,
                                                      separatorBuilder: (_, __) => const SizedBox(height: 4.0),
                                                      itemBuilder: (context, index) {
                                                        return _buildListingCard(listingsList[index]);
                                                      },
                                                    );
                                                  },
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

  // =========================================================================
  // HELPER: STATUS FILTER CHIP
  // =========================================================================
  Widget _buildStatusFilterChip(
    String label,
    bool isSelected,
    VoidCallback onTap, {
    IconData? icon,
  }) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20.0),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 7.0),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFFE66A4E) : Colors.white,
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(
              color: isSelected ? const Color(0xFFE66A4E) : const Color(0xFFE2E8F0),
              width: 1.2,
            ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: const Color(0xFFE66A4E).withOpacity(0.25),
                      blurRadius: 6.0,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(
                  icon,
                  size: 13.0,
                  color: isSelected ? Colors.white : const Color(0xFF64748B),
                ),
                const SizedBox(width: 5.0),
              ],
              Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 12.5,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  color: isSelected ? Colors.white : const Color(0xFF475569),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // =========================================================================
  // HELPER CARD: MY BOOKED
  // =========================================================================
  Widget _buildBookedCard(BidsForMarketPlaceRecord bid) {
    if (bid.marketPlaceRef == null) {
      return const SizedBox.shrink();
    }
    return StreamBuilder<MarketPlaceRecord>(
      stream: MarketPlaceRecord.getDocument(bid.marketPlaceRef!),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container(
            height: 140,
            margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFF1F5F9)),
            ),
            child: const Center(
              child: SizedBox(
                width: 28,
                height: 28,
                child: SpinKitFadingCircle(color: Color(0xFFE66A4E), size: 28),
              ),
            ),
          );
        }

        final product = snapshot.data!;
        final double unitPrice = bid.price;
        final double qty = bid.quantity;
        final double totalPrice = unitPrice * qty;

        Color statusBg;
        Color statusBorder;
        Color statusTextColor;
        IconData statusIcon;

        switch (bid.status) {
          case 'Completed':
            statusBg = const Color(0xFFECFDF5);
            statusBorder = const Color(0xFFA7F3D0);
            statusTextColor = const Color(0xFF059669);
            statusIcon = Icons.check_circle_rounded;
            break;
          case 'Accepted':
            statusBg = const Color(0xFFFFF7ED);
            statusBorder = const Color(0xFFFFEDD5);
            statusTextColor = const Color(0xFFEA580C);
            statusIcon = Icons.thumb_up_alt_rounded;
            break;
          case 'Rejected':
            statusBg = const Color(0xFFFEF2F2);
            statusBorder = const Color(0xFFFECACA);
            statusTextColor = const Color(0xFFDC2626);
            statusIcon = Icons.cancel_rounded;
            break;
          default: // Pending
            statusBg = const Color(0xFFFFFBEB);
            statusBorder = const Color(0xFFFDE68A);
            statusTextColor = const Color(0xFFD97706);
            statusIcon = Icons.hourglass_top_rounded;
            break;
        }

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18.0),
            border: Border.all(color: const Color(0xFFE2E8F0), width: 1.0),
            boxShadow: const [
              BoxShadow(
                color: Color(0x0A000000),
                blurRadius: 10.0,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header: Order date + Status Pill
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.calendar_today_rounded, size: 13.0, color: Color(0xFF94A3B8)),
                        const SizedBox(width: 5.0),
                        Text(
                          bid.hasCreateAt()
                              ? 'Placed on ${dateTimeFormat("yMMMd", bid.createAt)}'
                              : 'Order Placed',
                          style: GoogleFonts.inter(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF64748B),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                      decoration: BoxDecoration(
                        color: statusBg,
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(color: statusBorder, width: 1.0),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(statusIcon, size: 13.0, color: statusTextColor),
                          const SizedBox(width: 4.0),
                          Text(
                            bid.status.isNotEmpty ? bid.status : 'Pending',
                            style: GoogleFonts.inter(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w700,
                              color: statusTextColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: Divider(height: 1.0, thickness: 1.0, color: Color(0xFFF1F5F9)),
                ),

                // Product Info Row
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product Image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: Container(
                        width: 68.0,
                        height: 68.0,
                        color: const Color(0xFFF8FAFC),
                        child: product.imageOfproduct.isNotEmpty
                            ? Image.network(
                                product.imageOfproduct,
                                width: 68.0,
                                height: 68.0,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => const Center(
                                  child: Icon(Icons.shopping_bag_outlined, color: Color(0xFF94A3B8), size: 28),
                                ),
                              )
                            : const Center(
                                child: Icon(Icons.shopping_bag_outlined, color: Color(0xFF94A3B8), size: 28),
                              ),
                      ),
                    ),
                    const SizedBox(width: 12.0),

                    // Product Details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.productName.isNotEmpty ? product.productName : 'Marketplace Item',
                            style: GoogleFonts.inter(
                              fontSize: 14.5,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF1E293B),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          if (product.descriptionItem.isNotEmpty) ...[
                            const SizedBox(height: 3.0),
                            Text(
                              product.descriptionItem,
                              style: GoogleFonts.inter(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFF64748B),
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                          const SizedBox(height: 6.0),
                          Wrap(
                            spacing: 8.0,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 7.0, vertical: 2.0),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF1F5F9),
                                  borderRadius: BorderRadius.circular(6.0),
                                ),
                                child: Text(
                                  'Qty: ${qty.toInt() == qty ? qty.toInt() : qty}',
                                  style: GoogleFonts.inter(
                                    fontSize: 11.5,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF475569),
                                  ),
                                ),
                              ),
                              Text(
                                '₹${unitPrice.toStringAsFixed(0)} each',
                                style: GoogleFonts.inter(
                                  fontSize: 11.5,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF64748B),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Total Price
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '₹${totalPrice.toStringAsFixed(0)}',
                          style: GoogleFonts.inter(
                            fontSize: 16.5,
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFFE66A4E),
                          ),
                        ),
                        Text(
                          'Total',
                          style: GoogleFonts.inter(
                            fontSize: 11.0,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF94A3B8),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 12.0),

                // Action Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Contact Seller
                    InkWell(
                      onTap: () {
                        context.pushNamed(PlansWidget.routeName);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text(
                              'You don\'t have to have an active plan to use this feature.',
                              style: TextStyle(color: Colors.white),
                            ),
                            backgroundColor: const Color(0xFF1E293B),
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                          ),
                        );
                      },
                      borderRadius: BorderRadius.circular(10.0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 7.0),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8FAFC),
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.chat_bubble_outline_rounded, size: 14.0, color: Color(0xFF475569)),
                            const SizedBox(width: 5.0),
                            Text(
                              'Contact Seller',
                              style: GoogleFonts.inter(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF475569),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 8.0),

                    // Reorder Button
                    InkWell(
                      onTap: () {
                        context.pushNamed(
                          MarketPlaceBidYourRateWidget.routeName,
                          queryParameters: {
                            'marketPlaceBids': serializeParam(
                              product.reference,
                              ParamType.DocumentReference,
                            ),
                          }.withoutNulls,
                        );
                      },
                      borderRadius: BorderRadius.circular(10.0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 7.0),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFFE66A4E), Color(0xFFD4553A)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFFE66A4E).withOpacity(0.25),
                              blurRadius: 6.0,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.replay_rounded, size: 14.0, color: Colors.white),
                            const SizedBox(width: 5.0),
                            Text(
                              'Reorder',
                              style: GoogleFonts.inter(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
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
  }

  // =========================================================================
  // HELPER CARD: MY LISTED
  // =========================================================================
  Widget _buildListingCard(MarketPlaceRecord listing) {
    return StreamBuilder<UsersRecord>(
      stream: listing.postedBy != null
          ? UsersRecord.getDocument(listing.postedBy!)
          : null,
      builder: (context, snapshot) {
        final seller = snapshot.data;

        Color statusBg;
        Color statusBorder;
        Color statusTextColor;
        IconData statusIcon;
        final status = listing.status.isNotEmpty ? listing.status : 'Active';

        if (status == 'Active' || status == 'Live') {
          statusBg = const Color(0xFFECFDF5);
          statusBorder = const Color(0xFFA7F3D0);
          statusTextColor = const Color(0xFF059669);
          statusIcon = Icons.check_circle_rounded;
        } else if (status == 'Rejected') {
          statusBg = const Color(0xFFFEF2F2);
          statusBorder = const Color(0xFFFECACA);
          statusTextColor = const Color(0xFFDC2626);
          statusIcon = Icons.cancel_rounded;
        } else {
          statusBg = const Color(0xFFFFFBEB);
          statusBorder = const Color(0xFFFDE68A);
          statusTextColor = const Color(0xFFD97706);
          statusIcon = Icons.schedule_rounded;
        }

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 7.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18.0),
            border: Border.all(color: const Color(0xFFE2E8F0), width: 1.0),
            boxShadow: const [
              BoxShadow(
                color: Color(0x0A000000),
                blurRadius: 10.0,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Row: Product details + Image
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            listing.productName.isNotEmpty
                                ? listing.productName
                                : 'Marketplace Listing',
                            style: GoogleFonts.inter(
                              fontSize: 15.5,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF1E293B),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          if (listing.descriptionItem.isNotEmpty) ...[
                            const SizedBox(height: 4.0),
                            Text(
                              listing.descriptionItem,
                              style: GoogleFonts.inter(
                                fontSize: 12.5,
                                color: const Color(0xFF64748B),
                                height: 1.35,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                          const SizedBox(height: 8.0),
                          if (listing.price.isNotEmpty)
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFF1EE),
                                borderRadius: BorderRadius.circular(6.0),
                              ),
                              child: Text(
                                '₹${listing.price}',
                                style: GoogleFonts.inter(
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFFE66A4E),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12.0),

                    // Image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: Container(
                        width: 80.0,
                        height: 80.0,
                        color: const Color(0xFFF8FAFC),
                        child: listing.imageOfproduct.isNotEmpty
                            ? Image.network(
                                listing.imageOfproduct,
                                width: 80.0,
                                height: 80.0,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => const Center(
                                  child: Icon(Icons.image_not_supported_outlined, color: Color(0xFF94A3B8), size: 28),
                                ),
                              )
                            : const Center(
                                child: Icon(Icons.shopping_bag_outlined, color: Color(0xFF94A3B8), size: 28),
                              ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12.0),
                const Divider(height: 1.0, thickness: 1.0, color: Color(0xFFF1F5F9)),
                const SizedBox(height: 12.0),

                // Middle: Seller profile + Status Badge
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Seller Info
                    if (seller != null)
                      InkWell(
                        onTap: () {
                          context.pushNamed(
                            DriverReviewWidget.routeName,
                            queryParameters: {
                              'userRef': serializeParam(
                                seller.reference,
                                ParamType.DocumentReference,
                              ),
                            }.withoutNulls,
                          );
                        },
                        child: Row(
                          children: [
                            Container(
                              width: 34.0,
                              height: 34.0,
                              decoration: const BoxDecoration(shape: BoxShape.circle),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(17.0),
                                child: seller.photoUrl.isNotEmpty
                                    ? Image.network(
                                        seller.photoUrl,
                                        fit: BoxFit.cover,
                                        errorBuilder: (_, __, ___) => Image.asset(
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
                            const SizedBox(width: 8.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  seller.displayName.isNotEmpty ? seller.displayName : 'You',
                                  style: GoogleFonts.inter(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF334155),
                                  ),
                                ),
                                Row(
                                  children: [
                                    const Icon(Icons.star_rounded, size: 13.0, color: Color(0xFFF59E0B)),
                                    const SizedBox(width: 2.0),
                                    Text(
                                      formatNumber(
                                        functions.averageRating(seller.ratings.toList()),
                                        formatType: FormatType.compact,
                                      ),
                                      style: GoogleFonts.inter(
                                        fontSize: 11.0,
                                        fontWeight: FontWeight.w600,
                                        color: const Color(0xFF64748B),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    else
                      const SizedBox.shrink(),

                    // Status Badge
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                      decoration: BoxDecoration(
                        color: statusBg,
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(color: statusBorder, width: 1.0),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(statusIcon, size: 13.0, color: statusTextColor),
                          const SizedBox(width: 4.0),
                          Text(
                            status,
                            style: GoogleFonts.inter(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w700,
                              color: statusTextColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 14.0),

                // Action Buttons Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Delete button (double tap protection)
                    GestureDetector(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Row(
                              children: const [
                                Icon(Icons.info_outline, color: Colors.white, size: 18.0),
                                SizedBox(width: 8.0),
                                Text('Double-tap to delete this listing', style: TextStyle(color: Colors.white)),
                              ],
                            ),
                            duration: const Duration(seconds: 2),
                            backgroundColor: const Color(0xFFEF4444),
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                          ),
                        );
                      },
                      onDoubleTap: () async {
                        await listing.reference.delete();
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text('Listing deleted'),
                              backgroundColor: const Color(0xFF1E293B),
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                            ),
                          );
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFEF2F2),
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(color: const Color(0xFFFECACA)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.delete_outline_rounded, color: Color(0xFFDC2626), size: 16.0),
                            const SizedBox(width: 5.0),
                            Text(
                              'Delete',
                              style: GoogleFonts.inter(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFFDC2626),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // View Bookings / Manage Orders button
                    FFButtonWidget(
                      onPressed: () async {
                        context.pushNamed(
                          MarketPlaceOrdersWidget.routeName,
                          queryParameters: {
                            'marketPlaceRef': serializeParam(
                              listing.reference,
                              ParamType.DocumentReference,
                            ),
                          }.withoutNulls,
                        );
                      },
                      text: 'Manage Orders',
                      icon: const Icon(
                        Icons.receipt_long_rounded,
                        size: 15.0,
                        color: Colors.white,
                      ),
                      options: FFButtonOptions(
                        height: 36.0,
                        padding: const EdgeInsetsDirectional.fromSTEB(14.0, 0.0, 14.0, 0.0),
                        color: const Color(0xFFE66A4E),
                        textStyle: GoogleFonts.inter(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                        elevation: 0.0,
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
  }
}
