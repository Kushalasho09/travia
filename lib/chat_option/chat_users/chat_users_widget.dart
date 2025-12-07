import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/sidebar_menu/sidebar_menu_widget.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'chat_users_model.dart';
export 'chat_users_model.dart';

class ChatUsersWidget extends StatefulWidget {
  const ChatUsersWidget({super.key});

  static String routeName = 'ChatUsers';
  static String routePath = '/chatUsers';

  @override
  State<ChatUsersWidget> createState() => _ChatUsersWidgetState();
}

class _ChatUsersWidgetState extends State<ChatUsersWidget> {
  late ChatUsersModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ChatUsersModel());
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
        backgroundColor: FlutterFlowTheme.of(context).containerColour,
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
          leading: FlutterFlowIconButton(
            borderRadius: 18.0,
            buttonSize: 40.0,
            icon: FaIcon(
              FontAwesomeIcons.bars,
              color: Color(0xFF283B5E),
              size: 27.0,
            ),
            onPressed: () async {
              if (scaffoldKey.currentState != null) {
                scaffoldKey.currentState!.openDrawer();
              }            },
          ),
          title: Padding(
            padding: EdgeInsets.all(5.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                'assets/images/logoTraviaJi.png',
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          actions: [
            Align(
              alignment: AlignmentDirectional(0.0, 0.0),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          context.pushNamed(PlansWidget.routeName);
                        },
                        child: CircleAvatar(
                          radius: 20, // adjust size
                          backgroundColor: Color(0xFF283B5E), // circle color
                          child: Padding(
                            padding: const EdgeInsets.only(right: 2),
                            child: Icon(
                              FontAwesomeIcons.crown,
                              color: Colors.white, // icon color
                              size: 18.0,
                            ),
                          ),
                        )),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
                      child: Container(
                        width: 40.0,
                        height: 40.0,
                        decoration: BoxDecoration(
                          // image: DecorationImage(
                          //   fit: BoxFit.cover,
                          //   image: Image.asset(
                          //     "assets/images/profileIcon.png",
                          //   ).image,
                          // ),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Color(0xFF283B5E),
                            width: 1.0,
                          ),
                        ),
                        child: InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            context.pushNamed(DriveProfileWidget.routeName);
                          },
                          child: Builder(
                            builder: (context) {
                              if (currentUserPhoto != null && currentUserPhoto != '') {
                                return Container(
                                  width: 200.0,
                                  height: 200.0,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.network(
                                    currentUserPhoto,
                                    fit: BoxFit.cover,
                                  ),
                                );
                              } else {
                                return Container(
                                  width: 200.0,
                                  height: 200.0,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.asset(
                                    'assets/images/userIconTravia.png',
                                    fit: BoxFit.cover,
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
          centerTitle: false,
          elevation: 5.0,
        ),
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: StreamBuilder<List<ChatsRecord>>(
                    stream: queryChatsRecord(
                      queryBuilder: (chatsRecord) => chatsRecord
                          .where(
                            'userIDs',
                            arrayContains: currentUserReference,
                          )
                          .orderBy('lastMessageTime', descending: true),
                    ),
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
                      List<ChatsRecord> listViewChatsRecordList =
                          snapshot.data!;

                      return ListView.separated(
                        padding: EdgeInsets.zero,
                        primary: false,
                        shrinkWrap: true,
                        physics: AlwaysScrollableScrollPhysics(),  // ✅ Smooth scrolling
                        scrollDirection: Axis.vertical,
                        itemCount: listViewChatsRecordList.length,
                        separatorBuilder: (_, __) => SizedBox(height: 15.0),
                        itemBuilder: (context, listViewIndex) {
                          final listViewChatsRecord = listViewChatsRecordList[listViewIndex];
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
                            child: StreamBuilder<UsersRecord>(
                              stream: UsersRecord.getDocument(functions.getOtherUserRef(
                                listViewChatsRecord.userIDs.toList(),
                                currentUserReference!,
                              )),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return SizedBox(
                                    height: 70.0,
                                    child: Center(child: SpinKitFadingCircle(color: Color(0xFF2B3C58), size: 30.0)),
                                  );
                                }
                                final containerUsersRecord = snapshot.data!;

                                return InkWell(
                                  onTap: () => context.pushNamed(ChatWidget.routeName, queryParameters: {
                                    'reciveChats': serializeParam(listViewChatsRecord.reference, ParamType.DocumentReference),
                                  }.withoutNulls),
                                  child: Material(
                                    color: Colors.transparent,
                                    elevation: 2.0,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                                    child: Container(
                                      width: double.infinity,
                                      constraints: BoxConstraints(minHeight: 70.0, maxHeight: 85.0),  // ✅ FIXED HEIGHT
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context).secondaryBackground,
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(12.0),
                                        child: Row(
                                          children: [
                                            // ✅ AVATAR - Fixed size
                                            Builder(
                                              builder: (context) => Container(
                                                width: 52.0,
                                                height: 52.0,
                                                decoration: BoxDecoration(shape: BoxShape.circle),
                                                clipBehavior: Clip.antiAlias,
                                                child: containerUsersRecord.photoUrl?.isNotEmpty == true
                                                    ? Image.network(containerUsersRecord.photoUrl!, fit: BoxFit.cover)
                                                    : Image.asset('assets/images/userIconTr.png', fit: BoxFit.cover),
                                              ),
                                            ),
                                            SizedBox(width: 12.0),

                                            // ✅ INFO - Flexible but constrained
                                            Expanded(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      // Name
                                                      Expanded(
                                                        child: Text(
                                                          containerUsersRecord.displayName ?? 'User',
                                                          style: FlutterFlowTheme.of(context).titleMedium.override(fontWeight: FontWeight.w600, fontSize: 15.0),
                                                          overflow: TextOverflow.ellipsis,
                                                        ),
                                                      ),
                                                      // Unread indicator + Time
                                                      Row(
                                                        mainAxisSize: MainAxisSize.min,
                                                        children: [
                                                          if (!listViewChatsRecord.lastMessagesSeenBy.contains(currentUserReference))
                                                            Container(width: 8.0, height: 8.0, decoration: BoxDecoration(color: Color(0xFF1439B1), shape: BoxShape.circle)),
                                                          SizedBox(width: 8.0),
                                                          Text(
                                                            dateTimeFormat("relative", listViewChatsRecord.lastMessageTime!),
                                                            style: FlutterFlowTheme.of(context).bodySmall.override(fontSize: 11.0, color: FlutterFlowTheme.of(context).secondaryText),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 4.0),
                                                  // Last message
                                                  Text(
                                                    listViewChatsRecord.lastMessage.maybeHandleOverflow(maxChars: 30) ?? '',
                                                    maxLines: 2,
                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                      fontSize: 13.0,
                                                      color: FlutterFlowTheme.of(context).secondaryText,
                                                    ),
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
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
      ),
    );
  }
}
