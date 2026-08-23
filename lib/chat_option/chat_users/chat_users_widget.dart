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
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          elevation: 0.5,
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
                      List<ChatsRecord> listViewChatsRecordList = snapshot.data!;


                      // ✅ FILTER OUT CHATS WHERE YOU'RE THE ONLY PARTICIPANT
                      List<ChatsRecord> filteredChats = listViewChatsRecordList.where((chat) {
                        // Check if chat has userIDs
                        if (chat.userIDs == null || chat.userIDs.isEmpty) return false;

                        // Get all participant IDs
                        List<String> participantIds = chat.userIDs.map((ref) => ref.id).toList();

                        // Remove current user from the list
                        List<String> otherParticipants = participantIds.where((id) => id != currentUserUid).toList();

                        // Keep only chats that have at least one other participant
                        return otherParticipants.isNotEmpty;
                      }).toList();


                      return ListView.separated(
                        padding: EdgeInsets.zero,
                        primary: false,
                        shrinkWrap: true,
                        physics: AlwaysScrollableScrollPhysics(),
                        // ✅ Smooth scrolling
                        scrollDirection: Axis.vertical,
                        itemCount: filteredChats.length,
                        separatorBuilder: (_, __) => SizedBox(height: 15.0),
                        itemBuilder: (context, listViewIndex) {
                          final listViewChatsRecord = filteredChats[listViewIndex];
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
                                  onTap: () => context.pushNamed(ChatWidget.routeName,
                                      queryParameters: {
                                        'reciveChats': serializeParam(listViewChatsRecord.reference, ParamType.DocumentReference),
                                      }.withoutNulls),
                                  child: Material(
                                    color: Colors.transparent,
                                    elevation: 2.0,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                                    child: Container(
                                      width: double.infinity,
                                      constraints: BoxConstraints(minHeight: 70.0, maxHeight: 85.0), // ✅ FIXED HEIGHT
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(12.0),
                                        border: Border.all(color: const Color(0xFFE2E8F0)),
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
                                                child: containerUsersRecord.photoUrl?.isNotEmpty == true ? Image.network(containerUsersRecord.photoUrl!, fit: BoxFit.cover) : Image.asset('assets/images/userIconTr.png', fit: BoxFit.cover),
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
                                                          containerUsersRecord.displayName.trim().isNotEmpty
                                                              ? containerUsersRecord.displayName.trim()
                                                              : (containerUsersRecord.userName.trim().isNotEmpty
                                                                  ? containerUsersRecord.userName.trim()
                                                                  : 'User'),
                                                          style: FlutterFlowTheme.of(context).titleMedium.override(fontWeight: FontWeight.w600, fontSize: 15.0),
                                                          overflow: TextOverflow.ellipsis,
                                                        ),
                                                      ),
                                                      // Unread indicator + Time
                                                      Row(
                                                        mainAxisSize: MainAxisSize.min,
                                                        children: [
                                                          if (!listViewChatsRecord.lastMessagesSeenBy.contains(currentUserReference)) Container(width: 8.0, height: 8.0, decoration: BoxDecoration(color: Color(0xFF1439B1), shape: BoxShape.circle)),
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
