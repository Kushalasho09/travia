import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_ad_banner.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:math';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'market_place_booking_model.dart';
export 'market_place_booking_model.dart';

class MarketPlaceBookingWidget extends StatefulWidget {
  const MarketPlaceBookingWidget({
    super.key,
    required this.showCustomerMarketPlaceRef,
  });

  final DocumentReference? showCustomerMarketPlaceRef;

  static String routeName = 'MarketPlaceBooking';
  static String routePath = '/marketPlaceBooking';

  @override
  State<MarketPlaceBookingWidget> createState() =>
      _MarketPlaceBookingWidgetState();
}

class _MarketPlaceBookingWidgetState extends State<MarketPlaceBookingWidget>
    with TickerProviderStateMixin {
  late MarketPlaceBookingModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MarketPlaceBookingModel());

    animationsMap.addAll({
      'containerOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          ScaleEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: Offset(1.0, 1.0),
            end: Offset(1.0, 1.0),
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
    return StreamBuilder<MarketPlaceRecord>(
      stream:
          MarketPlaceRecord.getDocument(widget!.showCustomerMarketPlaceRef!),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            body: Center(
              child: SizedBox(
                width: 50.0,
                height: 50.0,
                child: SpinKitFadingCircle(
                  color: Color(0xFF2B3C58),
                  size: 50.0,
                ),
              ),
            ),
          );
        }

        final marketPlaceBookingMarketPlaceRecord = snapshot.data!;

        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
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
                              .where('userIDs', arrayContains: currentUserReference)
                              .orderBy('lastMessageTime', descending: true),
                        ),
                        builder: (context, snapshot) {
                          int unreadCount = 0;

                          if (snapshot.hasData) {
                            final chatsList = snapshot.data!;
                            unreadCount = chatsList.where((chat) {
                              if (chat.lastMessagesSeenBy == null) return true;
                              final hasSeen = chat.lastMessagesSeenBy!.any(
                                      (userRef) => userRef.id == currentUserUid
                              );
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
                                    context.pushNamed(PageNotificationWidget.routeName);
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
                                        unreadCount > 9 ? '9+' : unreadCount.toString(),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: unreadCount > 9 ? 8.0 : 10.0,
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
              child: Align(
                alignment: AlignmentDirectional(0.0, 0.0),
                child: SingleChildScrollView(
                  primary: false,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      /*
                      =================== OLD UI (COMMENTED OUT) ===================
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 12.0,
                              color: Color(0x1A000000),
                              offset: Offset(
                                0.0,
                                4.0,
                              ),
                            )
                          ],
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(16.0),
                                child: Image.network(
                                  marketPlaceBookingMarketPlaceRecord
                                      .imageOfproduct,
                                  width: double.infinity,
                                  height: 220.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color:
                                        FlutterFlowTheme.of(context).boxColour,
                                    borderRadius: BorderRadius.circular(12.0),
                                    border: Border.all(
                                      color: FlutterFlowTheme.of(context)
                                          .containerBG,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        FaIcon(
                                          FontAwesomeIcons.quoteLeft,
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          size: 24.0,
                                        ),
                                        Expanded(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                marketPlaceBookingMarketPlaceRecord
                                                    .descriptionItem,
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyMedium
                                                    .override(
                                                      font: GoogleFonts.inter(
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontWeight,
                                                        fontStyle:
                                                            FontStyle.italic,
                                                      ),
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                      fontSize: 15.0,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontWeight,
                                                      fontStyle:
                                                          FontStyle.italic,
                                                    ),
                                              ),
                                              Align(
                                                alignment: AlignmentDirectional(
                                                    1.0, 1.0),
                                                child: FaIcon(
                                                  FontAwesomeIcons.quoteRight,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primary,
                                                  size: 24.0,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ].divide(SizedBox(width: 8.0)),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 20.0, 0.0, 0.0),
                                child: StreamBuilder<UsersRecord>(
                                  stream: UsersRecord.getDocument(
                                      marketPlaceBookingMarketPlaceRecord
                                          .postedBy!),
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData) {
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

                                    final rowUsersRecord = snapshot.data!;

                                    return InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        context.pushNamed(
                                          DriverReviewWidget.routeName,
                                          queryParameters: {
                                            'userRef': serializeParam(
                                              rowUsersRecord.reference,
                                              ParamType.DocumentReference,
                                            ),
                                          }.withoutNulls,
                                        );
                                      },
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Builder(
                                                builder: (context) {
                                                  if (rowUsersRecord.photoUrl !=
                                                          null &&
                                                      rowUsersRecord.photoUrl !=
                                                          '') {
                                                    return Container(
                                                      width: 48.0,
                                                      height: 48.0,
                                                      clipBehavior:
                                                          Clip.antiAlias,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: Image.network(
                                                        rowUsersRecord.photoUrl,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    );
                                                  } else {
                                                    return Container(
                                                      width: 48.0,
                                                      height: 48.0,
                                                      clipBehavior:
                                                          Clip.antiAlias,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: Image.asset(
                                                        'assets/images/userIconTr.png',
                                                        fit: BoxFit.cover,
                                                      ),
                                                    );
                                                  }
                                                },
                                              ),
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Text(
                                                    rowUsersRecord.displayName,
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          font:
                                                              GoogleFonts.inter(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                          ),
                                                          fontSize: 16.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                  ),
                                                ].divide(SizedBox(width: 5.0)),
                                              ),
                                            ].divide(SizedBox(width: 12.0)),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 5.0, 0.0),
                                            child: Stack(
                                              alignment: AlignmentDirectional(
                                                  0.0, 0.0),
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                  child: Image.asset(
                                                    'assets/images/Ride_Search_Icons.png',
                                                    width: 30.0,
                                                    height: 35.0,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                Text(
                                                  valueOrDefault<String>(
                                                    formatNumber(
                                                      functions.averageRating(
                                                          rowUsersRecord.ratings
                                                              .toList()),
                                                      formatType:
                                                          FormatType.compact,
                                                    ),
                                                    '0',
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight:
                                                              FontWeight.w900,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                        color: FlutterFlowTheme
                                                                .of(context)
                                                            .primaryBackground,
                                                        fontSize: 8.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.w900,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontStyle,
                                                      ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 24.0, 0.0, 24.0),
                                child: FFButtonWidget(
                                  onPressed: () async {
                                    context.pushNamed(
                                      MarketPlaceBidYourRateWidget.routeName,
                                      queryParameters: {
                                        'marketPlaceBids': serializeParam(
                                          marketPlaceBookingMarketPlaceRecord
                                              .reference,
                                          ParamType.DocumentReference,
                                        ),
                                      }.withoutNulls,
                                    );
                                  },
                                  text: 'Submit Order Request',
                                  options: FFButtonOptions(
                                    width: double.infinity,
                                    height: 50.0,
                                    padding: EdgeInsets.all(8.0),
                                    iconPadding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
                                    color: FlutterFlowTheme.of(context).primary,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .override(
                                          font: GoogleFonts.interTight(
                                            fontWeight: FontWeight.bold,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .fontStyle,
                                          ),
                                          color: Colors.white,
                                          fontSize: 16.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.bold,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .titleSmall
                                                  .fontStyle,
                                        ),
                                    elevation: 2.0,
                                    borderSide: BorderSide(
                                      color: Colors.transparent,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                ),
                              ),
                            ].divide(SizedBox(height: 15.0)),
                          ),
                        ),
                      ).animateOnPageLoad(
                          animationsMap['containerOnPageLoadAnimation']!),
                      FlutterFlowAdBanner(
                        width: MediaQuery.sizeOf(context).width * 1.0,
                        height: 100.0,
                        showsTestAd: false,
                      ),
                      =================== END OLD UI (COMMENTED OUT) ===================
                      */

                      // =================== NEW UI (MATCHING IMAGE 2) ===================
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 12.0),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.0),
                            border: Border.all(
                                color: const Color(0xFFE2E8F0), width: 1.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.06),
                                blurRadius: 16.0,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // 1. Product Image Header Card with Overlays
                                Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(16.0),
                                      child: Builder(
                                        builder: (context) {
                                          final imgUrl =
                                              marketPlaceBookingMarketPlaceRecord
                                                  .imageOfproduct;
                                          if (imgUrl.isNotEmpty) {
                                            return Image.network(
                                              imgUrl,
                                              width: double.infinity,
                                              height: 240.0,
                                              fit: BoxFit.cover,
                                              errorBuilder:
                                                  (context, error, stackTrace) =>
                                                      Container(
                                                height: 240.0,
                                                color: Colors.grey[200],
                                                child: const Icon(
                                                    Icons.image_not_supported,
                                                    size: 40),
                                              ),
                                            );
                                          } else {
                                            return Container(
                                              height: 240.0,
                                              color: const Color(0xFFE2E8F0),
                                              child: const Center(
                                                child: Icon(Icons.image,
                                                    size: 50,
                                                    color: Colors.grey),
                                              ),
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                    // Top Left: Available Badge
                                    Positioned(
                                      top: 12.0,
                                      left: 12.0,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.92),
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.08),
                                              blurRadius: 4.0,
                                            ),
                                          ],
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10.0, vertical: 5.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Container(
                                              width: 8.0,
                                              height: 8.0,
                                              decoration: const BoxDecoration(
                                                color: Color(0xFF2ECC71),
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                            const SizedBox(width: 5.0),
                                            const Text(
                                              'Available',
                                              style: TextStyle(
                                                color: Color(0xFF1E293B),
                                                fontSize: 11.0,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    // Top Right: Share & Favorite Action Buttons
                                    Positioned(
                                      top: 12.0,
                                      right: 12.0,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Container(
                                            width: 36.0,
                                            height: 36.0,
                                            decoration: BoxDecoration(
                                              color: Colors.white
                                                  .withOpacity(0.92),
                                              shape: BoxShape.circle,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.1),
                                                  blurRadius: 4.0,
                                                ),
                                              ],
                                            ),
                                            child: const Icon(
                                              Icons.share_outlined,
                                              size: 18.0,
                                              color: Color(0xFF334155),
                                            ),
                                          ),
                                          const SizedBox(width: 8.0),
                                          Container(
                                            width: 36.0,
                                            height: 36.0,
                                            decoration: BoxDecoration(
                                              color: Colors.white
                                                  .withOpacity(0.92),
                                              shape: BoxShape.circle,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.1),
                                                  blurRadius: 4.0,
                                                ),
                                              ],
                                            ),
                                            child: const Icon(
                                              Icons.favorite_border,
                                              size: 18.0,
                                              color: Color(0xFFEF4444),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    // Bottom Left: Authenticity Tag
                                    Positioned(
                                      bottom: 12.0,
                                      left: 12.0,
                                      right: 85.0,
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.black.withOpacity(0.65),
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10.0, vertical: 6.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: const [
                                              Icon(
                                                Icons.check_circle_rounded,
                                                color: Colors.white,
                                                size: 13.0,
                                              ),
                                              SizedBox(width: 4.0),
                                              Flexible(
                                                child: Text(
                                                  'Fresh from Garhwal  |  100% Authentic',
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 10.5,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    // Bottom Right: Quantity Box
                                    Positioned(
                                      bottom: 12.0,
                                      right: 12.0,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.75),
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10.0, vertical: 5.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Builder(
                                              builder: (context) {
                                                final q =
                                                    marketPlaceBookingMarketPlaceRecord
                                                        .quantity;
                                                final displayQ = q.isNotEmpty
                                                    ? (q
                                                            .toLowerCase()
                                                            .contains('kg')
                                                        ? q
                                                        : '$q kg')
                                                    : '10 kg';
                                                return Text(
                                                  displayQ,
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14.0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                );
                                              },
                                            ),
                                            const Text(
                                              'Quantity',
                                              style: TextStyle(
                                                color: Colors.white70,
                                                fontSize: 9.5,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 16.0),

                                // 2. Quote Section with Description
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 8.0),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF8FAFC),
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const FaIcon(
                                        FontAwesomeIcons.quoteLeft,
                                        color: Color(0xFF007AFF),
                                        size: 18.0,
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                marketPlaceBookingMarketPlaceRecord
                                                        .descriptionItem
                                                        .isNotEmpty
                                                    ? marketPlaceBookingMarketPlaceRecord
                                                        .descriptionItem
                                                    : 'I am coming from Tehri to Aligarh . and I have 10 kg Authentic Mountains Potatoes from Garhwal.',
                                                style: const TextStyle(
                                                  fontSize: 13.5,
                                                  color: Color(0xFF334155),
                                                  height: 1.45,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: const FaIcon(
                                                  FontAwesomeIcons.quoteRight,
                                                  color: Color(0xFF007AFF),
                                                  size: 18.0,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                // 3. Prominent Full-Width Route Card
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0, vertical: 10.0),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF4F8FF),
                                    borderRadius: BorderRadius.circular(14.0),
                                    border: Border.all(
                                        color: const Color(0xFFE2E8F0)),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 32.0,
                                        height: 32.0,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFE0EDFF),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        child: const Icon(
                                          Icons.location_on_rounded,
                                          color: Color(0xFF2563EB),
                                          size: 18.0,
                                        ),
                                      ),
                                      const SizedBox(width: 10.0),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Route',
                                              style: TextStyle(
                                                fontSize: 10.5,
                                                color: Color(0xFF64748B),
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            const SizedBox(height: 2.0),
                                            Builder(
                                              builder: (context) {
                                                final origin =
                                                    marketPlaceBookingMarketPlaceRecord
                                                        .origin;
                                                final dest =
                                                    marketPlaceBookingMarketPlaceRecord
                                                        .destination;
                                                final routeText = (origin
                                                            .isNotEmpty &&
                                                        dest.isNotEmpty)
                                                    ? '$origin → $dest'
                                                    : (origin.isNotEmpty
                                                        ? origin
                                                        : (dest.isNotEmpty
                                                            ? dest
                                                            : 'Tehri → Aligarh'));
                                                return Text(
                                                  routeText,
                                                  style: const TextStyle(
                                                    fontSize: 13.5,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xFF0F172A),
                                                  ),
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                const SizedBox(height: 8.0),

                                // 4. Travel Date & Category 2-Column Row
                                Row(
                                  children: [
                                    // Travel Date Tile
                                    Expanded(
                                      child: _buildInfoCard(
                                        icon: Icons.calendar_month_rounded,
                                        iconColor: const Color(0xFF16A34A),
                                        iconBgColor: const Color(0xFFDCFCE7),
                                        cardBgColor: const Color(0xFFF0FDF4),
                                        title: 'Travel Date',
                                        value:
                                            marketPlaceBookingMarketPlaceRecord
                                                        .arivalDate !=
                                                    null
                                                ? dateTimeFormat(
                                                    'd MMM, EEE',
                                                    marketPlaceBookingMarketPlaceRecord
                                                        .arivalDate)
                                                : '31 Oct, Fri',
                                      ),
                                    ),
                                    const SizedBox(width: 8.0),
                                    // Category Tile
                                    Expanded(
                                      child: _buildInfoCard(
                                        icon: Icons.shopping_bag_rounded,
                                        iconColor: const Color(0xFFEA580C),
                                        iconBgColor: const Color(0xFFFFEDD5),
                                        cardBgColor: const Color(0xFFFFF7ED),
                                        title: 'Category',
                                        value:
                                            marketPlaceBookingMarketPlaceRecord
                                                    .productName.isNotEmpty
                                                ? marketPlaceBookingMarketPlaceRecord
                                                    .productName
                                                : 'Fruits & Vegetables',
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 16.0),

                                // 4. Seller / Traveller Profile Row
                                StreamBuilder<UsersRecord>(
                                  stream: UsersRecord.getDocument(
                                      marketPlaceBookingMarketPlaceRecord
                                          .postedBy!),
                                  builder: (context, snapshot) {
                                    final rowUsersRecord = snapshot.data;
                                    final displayName =
                                        rowUsersRecord?.displayName.isNotEmpty ==
                                                true
                                            ? rowUsersRecord!.displayName
                                            : 'Mohammad Nawazish';
                                    final photoUrl =
                                        rowUsersRecord?.photoUrl ?? '';

                                    return InkWell(
                                      onTap: () async {
                                        if (rowUsersRecord != null) {
                                          context.pushNamed(
                                            DriverReviewWidget.routeName,
                                            queryParameters: {
                                              'userRef': serializeParam(
                                                rowUsersRecord.reference,
                                                ParamType.DocumentReference,
                                              ),
                                            }.withoutNulls,
                                          );
                                        }
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 6.0),
                                        child: Row(
                                          children: [
                                            // Avatar with green checkmark
                                            Stack(
                                              clipBehavior: Clip.none,
                                              children: [
                                                Container(
                                                  width: 48.0,
                                                  height: 48.0,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                      color: const Color(
                                                          0xFFE2E8F0),
                                                      width: 1.5,
                                                    ),
                                                  ),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            24.0),
                                                    child: photoUrl.isNotEmpty
                                                        ? Image.network(
                                                            photoUrl,
                                                            fit: BoxFit.cover,
                                                            errorBuilder:
                                                                (context, err,
                                                                        stack) =>
                                                                    Image.asset(
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
                                                Positioned(
                                                  bottom: 0,
                                                  right: 0,
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            1.5),
                                                    decoration:
                                                        const BoxDecoration(
                                                      color: Colors.white,
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: const Icon(
                                                      Icons.check_circle_rounded,
                                                      color: Color(0xFF10B981),
                                                      size: 15.0,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(width: 10.0),
                                            // User info & badges
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    displayName,
                                                    style: const TextStyle(
                                                      fontSize: 14.5,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color(0xFF0F172A),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 2.0),
                                                  FittedBox(
                                                    fit: BoxFit.scaleDown,
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Row(
                                                      children: const [
                                                        Icon(
                                                          Icons.star_rounded,
                                                          color:
                                                              Color(0xFFF59E0B),
                                                          size: 15.0,
                                                        ),
                                                        SizedBox(width: 2.0),
                                                        Text(
                                                          '5.0 (28 Reviews)',
                                                          style: TextStyle(
                                                            fontSize: 10.5,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: Color(
                                                                0xFF475569),
                                                          ),
                                                        ),
                                                        Text(
                                                          '  |  42 Successful Orders',
                                                          style: TextStyle(
                                                            fontSize: 10.5,
                                                            color: Color(
                                                                0xFF64748B),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(height: 5.0),
                                                  Wrap(
                                                    spacing: 5.0,
                                                    runSpacing: 4.0,
                                                    children: [
                                                      Container(
                                                        padding: const EdgeInsets
                                                            .symmetric(
                                                            horizontal: 7.0,
                                                            vertical: 2.5),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: const Color(
                                                              0xFFD1FAE5),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                        ),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: const [
                                                            Icon(
                                                              Icons
                                                                  .check_rounded,
                                                              color: Color(
                                                                  0xFF059669),
                                                              size: 11.0,
                                                            ),
                                                            SizedBox(width: 2.0),
                                                            Text(
                                                              'Verified Seller',
                                                              style: TextStyle(
                                                                color: Color(
                                                                    0xFF059669),
                                                                fontSize: 9.5,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        padding: const EdgeInsets
                                                            .symmetric(
                                                            horizontal: 7.0,
                                                            vertical: 2.5),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: const Color(
                                                              0xFFDBEAFE),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                        ),
                                                        child: const Text(
                                                          'Trusted Traveller',
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xFF2563EB),
                                                            fontSize: 9.5,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(width: 4.0),
                                            // Yellow Star Rating Badge (5)
                                            Container(
                                              width: 35.0,
                                              height: 35.0,
                                              decoration: BoxDecoration(
                                                color: const Color(0xFFFFB800),
                                                shape: BoxShape.circle,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: const Color(
                                                            0xFFFFB800)
                                                        .withOpacity(0.35),
                                                    blurRadius: 5.0,
                                                    offset: const Offset(0, 2),
                                                  ),
                                                ],
                                              ),
                                              child: Center(
                                                child: Stack(
                                                  alignment: Alignment.center,
                                                  children: const [
                                                    Icon(
                                                      Icons.star_rounded,
                                                      color: Colors.white,
                                                      size: 29.0,
                                                    ),
                                                    Text(
                                                      '5',
                                                      style: TextStyle(
                                                        color: Color(0xFFD97706),
                                                        fontSize: 9.5,
                                                        fontWeight:
                                                            FontWeight.w900,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),

                                const SizedBox(height: 16.0),

                                // 5. Feature Grid (Safe & Secure, Handled with Care, Live Tracking, Best Value)
                                Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF8FAFC),
                                    borderRadius: BorderRadius.circular(16.0),
                                    border: Border.all(
                                      color: const Color(0xFFF1F5F9),
                                    ),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 4.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: _buildFeatureTile(
                                          icon: Icons.shield_outlined,
                                          iconColor: const Color(0xFF10B981),
                                          bgColor: const Color(0xFFD1FAE5),
                                          title: 'Safe & Secure',
                                          subtitle: 'OTP verified delivery',
                                        ),
                                      ),
                                      Expanded(
                                        child: _buildFeatureTile(
                                          icon: Icons.widgets_outlined,
                                          iconColor: const Color(0xFF3B82F6),
                                          bgColor: const Color(0xFFDBEAFE),
                                          title: 'Handled with Care',
                                          subtitle: 'Trusted travellers',
                                        ),
                                      ),
                                      Expanded(
                                        child: _buildFeatureTile(
                                          icon: Icons.location_on_outlined,
                                          iconColor: const Color(0xFF8B5CF6),
                                          bgColor: const Color(0xFFEDE9FE),
                                          title: 'Live Tracking',
                                          subtitle: 'Track your order',
                                        ),
                                      ),
                                      Expanded(
                                        child: _buildFeatureTile(
                                          icon: Icons.verified_user_outlined,
                                          iconColor: const Color(0xFFF59E0B),
                                          bgColor: const Color(0xFFFEF3C7),
                                          title: 'Best Value',
                                          subtitle: 'Fair & transparent',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                const SizedBox(height: 16.0),

                                // 6. Bottom Price, Chat & Submit Order Request Bar
                                Row(
                                  children: [
                                    // Total Price
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          '₹${marketPlaceBookingMarketPlaceRecord.price.isNotEmpty ? marketPlaceBookingMarketPlaceRecord.price : "120"}',
                                          style: const TextStyle(
                                            fontSize: 19.0,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF0F172A),
                                          ),
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: const [
                                            Text(
                                              'Total Price ',
                                              style: TextStyle(
                                                fontSize: 10.5,
                                                color: Color(0xFF64748B),
                                              ),
                                            ),
                                            Icon(
                                              Icons.info_outline_rounded,
                                              size: 11.5,
                                              color: Color(0xFF64748B),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(width: 8.0),
                                    // Chat Button
                                    Container(
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFEFF6FF),
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                      child: InkWell(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                        onTap: () async {
                                          // Navigate to chat or driver review
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 11.0, vertical: 9.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: const [
                                              Icon(
                                                Icons
                                                    .chat_bubble_outline_rounded,
                                                color: Color(0xFF1E40AF),
                                                size: 16.0,
                                              ),
                                              SizedBox(width: 4.0),
                                              Text(
                                                'Chat',
                                                style: TextStyle(
                                                  color: Color(0xFF1E40AF),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 11.5,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8.0),
                                    // Submit Order Request Call-To-Action Button
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF1E293B),
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                          boxShadow: [
                                            BoxShadow(
                                              color: const Color(0xFF1E293B)
                                                  .withOpacity(0.25),
                                              blurRadius: 6.0,
                                              offset: const Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        child: InkWell(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                          onTap: () async {
                                            context.pushNamed(
                                              MarketPlaceBidYourRateWidget
                                                  .routeName,
                                              queryParameters: {
                                                'marketPlaceBids':
                                                    serializeParam(
                                                  marketPlaceBookingMarketPlaceRecord
                                                      .reference,
                                                  ParamType.DocumentReference,
                                                ),
                                              }.withoutNulls,
                                            );
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10.0, vertical: 8.0),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: const [
                                                      Text(
                                                        'Submit Order Request',
                                                        maxLines: 1,
                                                        overflow:
                                                            TextOverflow.ellipsis,
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 12.0,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      Text(
                                                        'Send request to traveller',
                                                        maxLines: 1,
                                                        overflow:
                                                            TextOverflow.ellipsis,
                                                        style: TextStyle(
                                                          color: Colors.white70,
                                                          fontSize: 8.5,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(width: 4.0),
                                                Container(
                                                  width: 24.0,
                                                  height: 24.0,
                                                  decoration: const BoxDecoration(
                                                    color: Colors.white,
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: const Icon(
                                                    Icons.arrow_forward_rounded,
                                                    color: Color(0xFF1E293B),
                                                    size: 14.0,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // =================== END NEW UI ===================
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required Color iconColor,
    required Color iconBgColor,
    required Color cardBgColor,
    required String title,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 7.0),
      decoration: BoxDecoration(
        color: cardBgColor,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        children: [
          Container(
            width: 24.0,
            height: 24.0,
            decoration: BoxDecoration(
              color: iconBgColor,
              borderRadius: BorderRadius.circular(7.0),
            ),
            child: Icon(icon, color: iconColor, size: 13.0),
          ),
          const SizedBox(width: 4.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 8.5,
                    color: Color(0xFF64748B),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 1.0),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    value,
                    style: const TextStyle(
                      fontSize: 10.5,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureTile({
    required IconData icon,
    required Color iconColor,
    required Color bgColor,
    required String title,
    required String subtitle,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 30.0,
          height: 30.0,
          decoration: BoxDecoration(
            color: bgColor,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: iconColor, size: 15.0),
        ),
        const SizedBox(height: 5.0),
        FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.center,
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 9.5,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E293B),
            ),
          ),
        ),
        const SizedBox(height: 2.0),
        FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.center,
          child: Text(
            subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 8.0,
              color: Color(0xFF64748B),
            ),
          ),
        ),
      ],
    );
  }
}


