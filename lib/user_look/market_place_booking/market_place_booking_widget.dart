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
                                    // Customize what your widget looks like when it's loading.
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
}
