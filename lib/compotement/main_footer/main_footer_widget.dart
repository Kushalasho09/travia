import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import 'package:flutter_svg/svg.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'main_footer_model.dart';
export 'main_footer_model.dart';

class MainFooterWidget extends StatefulWidget {
  const MainFooterWidget({super.key});

  @override
  State<MainFooterWidget> createState() => _MainFooterWidgetState();
}

class _MainFooterWidgetState extends State<MainFooterWidget> {
  late MainFooterModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MainFooterModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 55.0,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        boxShadow: [
          BoxShadow(
            blurRadius: 5.0,
            color: Color(0x20000000),
            offset: Offset(
              0.0,
              -2.0,
            ),
          )
        ],
        borderRadius: BorderRadius.circular(0.0),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {
                context.pushNamed(
                  HomeWidget.routeName,
                  queryParameters: {
                    'tabNumberRef': serializeParam(
                      0,
                      ParamType.int,
                    ),
                  }.withoutNulls,
                );
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: SvgPicture.asset(
                      'assets/images/4.svg',  // Changed from .png to .svg
                      width: 24.0,
                      height: 24.0,
                      fit: BoxFit.cover,
                    )
                  ),
                  SizedBox(height: 4.0,),

                  Text(
                    'Rides',
                    style: FlutterFlowTheme.of(context).bodySmall.override(
                          font: GoogleFonts.inter(
                            fontWeight: FontWeight.w500,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodySmall
                                .fontStyle,
                          ),
                          color: FlutterFlowTheme.of(context).primaryText,
                          fontSize: 11.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w500,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodySmall.fontStyle,
                        ),
                  ),
                ],
              ),
            ),
            InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {
                context.pushNamed(
                  MarketPlaceCustomerWidget.routeName,
                  queryParameters: {
                    'tabNumberRef': serializeParam(
                      0,
                      ParamType.int,
                    ),
                  }.withoutNulls,
                );
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: SvgPicture.asset(
                      'assets/images/3.svg',  // Changed from .png to .svg
                      width: 24.0,
                      height: 24.0,
                      fit: BoxFit.cover,
                    )
                  ),
                  SizedBox(height: 4.0,),

                  Text(
                    'Market ',
                    style: FlutterFlowTheme.of(context).bodySmall.override(
                          font: GoogleFonts.inter(
                            fontWeight: FontWeight.w500,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodySmall
                                .fontStyle,
                          ),
                          color: FlutterFlowTheme.of(context).primaryText,
                          fontSize: 11.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w500,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodySmall.fontStyle,
                        ),
                  ),
                ],
              ),
            ),







            InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {
                context.pushNamed(SelectBidTypeWidget.routeName);
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                     context.pushNamed(PostRideSelectWidget.routeName);
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          'assets/images/5.svg',  // Changed from .png to .svg
                          width: 24.0,
                          height: 24.0,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(height: 4.0,),
                        Text(
                          'Publish',
                          style: FlutterFlowTheme.of(context).bodySmall.override(
                            font: GoogleFonts.inter(
                              fontWeight: FontWeight.w500,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodySmall
                                  .fontStyle,
                            ),
                            color: FlutterFlowTheme.of(context).primaryText,
                            fontSize: 11.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w500,
                            fontStyle:
                            FlutterFlowTheme.of(context).bodySmall.fontStyle,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),












            loggedIn
                ? StreamBuilder<List<ChatsRecord>>(
                    stream: queryChatsRecord(
                      queryBuilder: (chatsRecord) => chatsRecord
                          .where('userIDs', arrayContains: currentUserReference)
                          .orderBy('lastMessageTime', descending: true),
                    ),
                    builder: (context, snapshot) {
                      bool hasUnread = false;
                      if (snapshot.hasData) {
                        final chatsList = snapshot.data!;
                        hasUnread = chatsList.any((chat) {
                          if (chat.lastMessagesSeenBy == null) return true;
                          final hasSeen = chat.lastMessagesSeenBy!.any(
                            (userRef) => userRef.id == currentUserUid
                          );
                          return !hasSeen;
                        });
                      }

                      return InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          context.pushNamed(ChatUsersWidget.routeName);
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Stack(
                              clipBehavior: Clip.none,
                              children: [
                                SvgPicture.asset(
                                  'assets/images/2.svg',
                                  width: 24.0,
                                  height: 24.0,
                                  fit: BoxFit.cover,
                                ),
                                if (hasUnread)
                                  Positioned(
                                    top: -2.0,
                                    right: -2.0,
                                    child: Container(
                                      width: 8.0,
                                      height: 8.0,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFF77F4A),
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: FlutterFlowTheme.of(context).secondaryBackground,
                                          width: 1.5,
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            SizedBox(height: 4.0,),
                            Text(
                              'Chats',
                              style: FlutterFlowTheme.of(context).bodySmall.override(
                                    font: GoogleFonts.inter(
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodySmall
                                          .fontStyle,
                                    ),
                                    color: FlutterFlowTheme.of(context).primaryText,
                                    fontSize: 11.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w500,
                                    fontStyle:
                                        FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                  ),
                            ),
                          ],
                        ),
                      );
                    },
                  )
                : InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      context.pushNamed(ChatUsersWidget.routeName);
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          'assets/images/2.svg',
                          width: 24.0,
                          height: 24.0,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(height: 4.0,),
                        Text(
                          'Chats',
                          style: FlutterFlowTheme.of(context).bodySmall.override(
                                font: GoogleFonts.inter(
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodySmall
                                      .fontStyle,
                                ),
                                color: FlutterFlowTheme.of(context).primaryText,
                                fontSize: 11.0,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w500,
                                fontStyle:
                                    FlutterFlowTheme.of(context).bodySmall.fontStyle,
                              ),
                        ),
                      ],
                    ),
                  ),
            InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {
                context.pushNamed(DriveProfileWidget.routeName);
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: SvgPicture.asset(
                      'assets/images/1.svg',  // Changed from .png to .svg
                      width: 24.0,
                      height: 24.0,
                      fit: BoxFit.cover,
                    )
                  ),
                  SizedBox(height: 4.0,),

                  Text(
                    'Profile',
                    style: FlutterFlowTheme.of(context).bodySmall.override(
                          font: GoogleFonts.inter(
                            fontWeight: FontWeight.w500,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodySmall
                                .fontStyle,
                          ),
                          color: FlutterFlowTheme.of(context).primaryText,
                          fontSize: 11.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w500,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodySmall.fontStyle,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
