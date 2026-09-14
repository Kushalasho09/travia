import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/sidebar_menu/sidebar_menu_widget.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
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
  String _searchQuery = '';
  int _selectedFilter = 0; // 0 = All, 1 = Unread

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ChatUsersModel());
    _model.searchTextController ??= TextEditingController();
    _model.searchFocusNode ??= FocusNode();
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
        backgroundColor: const Color(0xFFF8FAFC),
        drawer: Drawer(
          width: MediaQuery.of(context).size.width * 0.88,
          elevation: 16.0,
          child: wrapWithModel(
            model: _model.sidebarMenuModel,
            updateCallback: () => safeSetState(() {}),
            child: const SidebarMenuWidget(),
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          elevation: 0.5,
          shadowColor: Colors.black.withValues(alpha: 0.04),
          leading: Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: FlutterFlowIconButton(
              borderRadius: 12.0,
              buttonSize: 44.0,
              icon: const FaIcon(
                FontAwesomeIcons.bars,
                color: Color(0xFF283B5E),
                size: 20.0,
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
            child: SizedBox(
              height: 44.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
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
                          final hasSeen = chat.lastMessagesSeenBy.any(
                            (userRef) => userRef.id == currentUserUid,
                          );
                          return !hasSeen;
                        }).length;
                      }

                      return Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            width: 42.0,
                            height: 42.0,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF8FAFC),
                              borderRadius: BorderRadius.circular(12.0),
                              border: Border.all(color: const Color(0xFFE2E8F0)),
                            ),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(12.0),
                              onTap: () async {
                                context.pushNamed(PageNotificationWidget.routeName);
                              },
                              child: const Center(
                                child: Icon(
                                  Icons.notifications_outlined,
                                  color: Color(0xFF283B5E),
                                  size: 22.0,
                                ),
                              ),
                            ),
                          ),
                          if (unreadCount > 0)
                            Positioned(
                              right: -2,
                              top: -2,
                              child: Container(
                                constraints: const BoxConstraints(
                                  minWidth: 18.0,
                                  minHeight: 18.0,
                                ),
                                padding: const EdgeInsets.all(3.0),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFEE7B4D),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2.0,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xFFEE7B4D).withValues(alpha: 0.35),
                                      blurRadius: 4.0,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Text(
                                    unreadCount > 9 ? '9+' : unreadCount.toString(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 9.0,
                                      fontWeight: FontWeight.w800,
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

                  const SizedBox(width: 8.0),

                  // Crown Icon (Plans)
                  Container(
                    width: 42.0,
                    height: 42.0,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12.0),
                      onTap: () async {
                        context.pushNamed(PlansWidget.routeName);
                      },
                      child: const Center(
                        child: FaIcon(
                          FontAwesomeIcons.crown,
                          color: Color(0xFFEE7B4D),
                          size: 18.0,
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
            children: [
              // Top Title & Search Header Container
              Container(
                color: Colors.white,
                padding: const EdgeInsets.fromLTRB(16.0, 14.0, 16.0, 14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Messages',
                              style: GoogleFonts.inter(
                                fontSize: 24.0,
                                fontWeight: FontWeight.w800,
                                color: const Color(0xFF111827),
                                letterSpacing: -0.5,
                              ),
                            ),
                            const SizedBox(width: 8.0),
                            // Real-time Chat Counter Badge
                            StreamBuilder<List<ChatsRecord>>(
                              stream: queryChatsRecord(
                                queryBuilder: (chatsRecord) => chatsRecord
                                    .where('userIDs', arrayContains: currentUserReference)
                                    .orderBy('lastMessageTime', descending: true),
                              ),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) return const SizedBox.shrink();
                                final count = snapshot.data!.where((chat) {
                                  if (chat.userIDs.isEmpty) return false;
                                  final otherUsers = chat.userIDs.where((ref) => ref.id != currentUserUid);
                                  return otherUsers.isNotEmpty;
                                }).length;
                                if (count == 0) return const SizedBox.shrink();
                                return Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFFF4ED),
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: Text(
                                    '$count',
                                    style: GoogleFonts.inter(
                                      color: const Color(0xFFEE7B4D),
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        Text(
                          'Travia Chat',
                          style: GoogleFonts.inter(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF94A3B8),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12.0),

                    // Modern Search Box
                    Container(
                      height: 44.0,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(12.0),
                        border: Border.all(color: const Color(0xFFE2E8F0), width: 0.8),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.search_rounded,
                            color: Color(0xFF94A3B8),
                            size: 20.0,
                          ),
                          const SizedBox(width: 8.0),
                          Expanded(
                            child: TextField(
                              controller: _model.searchTextController,
                              focusNode: _model.searchFocusNode,
                              onChanged: (val) {
                                setState(() {
                                  _searchQuery = val.trim().toLowerCase();
                                });
                              },
                              style: GoogleFonts.inter(
                                fontSize: 13.5,
                                color: const Color(0xFF1E293B),
                              ),
                              decoration: InputDecoration(
                                hintText: 'Search conversations...',
                                hintStyle: GoogleFonts.inter(
                                  fontSize: 13.5,
                                  color: const Color(0xFF94A3B8),
                                ),
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.zero,
                              ),
                            ),
                          ),
                          if (_searchQuery.isNotEmpty)
                            GestureDetector(
                              onTap: () {
                                _model.searchTextController?.clear();
                                setState(() {
                                  _searchQuery = '';
                                });
                              },
                              child: const Icon(
                                Icons.close_rounded,
                                color: Color(0xFF94A3B8),
                                size: 18.0,
                              ),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10.0),

                    // Quick Filter Chips (All / Unread)
                    Row(
                      children: [
                        _buildFilterChip(
                          label: 'All Chats',
                          isSelected: _selectedFilter == 0,
                          onTap: () {
                            setState(() {
                              _selectedFilter = 0;
                            });
                          },
                        ),
                        const SizedBox(width: 8.0),
                        _buildFilterChip(
                          label: 'Unread Only',
                          isSelected: _selectedFilter == 1,
                          onTap: () {
                            setState(() {
                              _selectedFilter = 1;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const Divider(height: 1.0, thickness: 1.0, color: Color(0xFFE2E8F0)),

              // Chats List
              Expanded(
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
                    if (!snapshot.hasData) {
                      return const Center(
                        child: SizedBox(
                          width: 44.0,
                          height: 44.0,
                          child: SpinKitFadingCircle(
                            color: Color(0xFFEE7B4D),
                            size: 40.0,
                          ),
                        ),
                      );
                    }

                    List<ChatsRecord> listViewChatsRecordList = snapshot.data!;

                    // Filter out chats where currentUser is the only participant
                    List<ChatsRecord> filteredChats = listViewChatsRecordList.where((chat) {
                      if (chat.userIDs.isEmpty) return false;
                      List<String> participantIds = chat.userIDs.map((ref) => ref.id).toList();
                      List<String> otherParticipants = participantIds.where((id) => id != currentUserUid).toList();
                      return otherParticipants.isNotEmpty;
                    }).toList();

                    // Filter by unread tab if selected
                    if (_selectedFilter == 1) {
                      filteredChats = filteredChats.where((chat) {
                        return !chat.lastMessagesSeenBy.contains(currentUserReference);
                      }).toList();
                    }

                    // Filter by search query if non-empty
                    if (_searchQuery.isNotEmpty) {
                      filteredChats = filteredChats.where((chat) {
                        final lastMsg = chat.lastMessage.toLowerCase();
                        return lastMsg.contains(_searchQuery);
                      }).toList();
                    }

                    // Empty State
                    if (filteredChats.isEmpty) {
                      return Center(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 24.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 84.0,
                                height: 84.0,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFF4ED),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: const Color(0xFFFFD4C2),
                                    width: 1.5,
                                  ),
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.chat_bubble_outline_rounded,
                                    size: 40.0,
                                    color: Color(0xFFEE7B4D),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 18.0),
                              Text(
                                _selectedFilter == 1
                                    ? 'No Unread Messages'
                                    : (_searchQuery.isNotEmpty ? 'No Matching Chats' : 'No Conversations Yet'),
                                style: GoogleFonts.inter(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF111827),
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              Text(
                                _selectedFilter == 1
                                    ? 'You have caught up with all your messages!'
                                    : (_searchQuery.isNotEmpty
                                        ? 'Try searching with a different keyword.'
                                        : 'Connect with drivers or co-travelers to coordinate your upcoming rides.'),
                                textAlign: TextAlign.center,
                                style: GoogleFonts.inter(
                                  fontSize: 13.5,
                                  color: const Color(0xFF64748B),
                                  height: 1.4,
                                ),
                              ),
                              if (_searchQuery.isNotEmpty || _selectedFilter == 1) ...[
                                const SizedBox(height: 16.0),
                                OutlinedButton(
                                  onPressed: () {
                                    _model.searchTextController?.clear();
                                    setState(() {
                                      _searchQuery = '';
                                      _selectedFilter = 0;
                                    });
                                  },
                                  style: OutlinedButton.styleFrom(
                                    side: const BorderSide(color: Color(0xFFEE7B4D)),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
                                  ),
                                  child: Text(
                                    'Reset Filters',
                                    style: GoogleFonts.inter(
                                      color: const Color(0xFFEE7B4D),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13.0,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      );
                    }

                    return ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: filteredChats.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 10.0),
                      itemBuilder: (context, listViewIndex) {
                        final listViewChatsRecord = filteredChats[listViewIndex];
                        final otherUserRef = functions.getOtherUserRef(
                          listViewChatsRecord.userIDs.toList(),
                          currentUserReference!,
                        );

                        return StreamBuilder<UsersRecord>(
                          stream: UsersRecord.getDocument(otherUserRef),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Container(
                                height: 78.0,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16.0),
                                  border: Border.all(color: const Color(0xFFE2E8F0)),
                                ),
                                child: const Center(
                                  child: SpinKitFadingCircle(
                                    color: Color(0xFFEE7B4D),
                                    size: 24.0,
                                  ),
                                ),
                              );
                            }
                            final containerUsersRecord = snapshot.data!;
                            final isUnread = !listViewChatsRecord.lastMessagesSeenBy.contains(currentUserReference);

                            final displayName = containerUsersRecord.displayName.trim().isNotEmpty
                                ? containerUsersRecord.displayName.trim()
                                : (containerUsersRecord.userName.trim().isNotEmpty
                                    ? containerUsersRecord.userName.trim()
                                    : 'Travia User');

                            return Material(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(16.0),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(16.0),
                                onTap: () => context.pushNamed(
                                  ChatWidget.routeName,
                                  queryParameters: {
                                    'reciveChats': serializeParam(
                                      listViewChatsRecord.reference,
                                      ParamType.DocumentReference,
                                    ),
                                  }.withoutNulls,
                                ),
                                child: Ink(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(16.0),
                                    border: Border.all(
                                      color: isUnread ? const Color(0xFFFFD4C2) : const Color(0xFFE5E7EB),
                                      width: isUnread ? 1.5 : 1.0,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: isUnread
                                            ? const Color(0xFFEE7B4D).withValues(alpha: 0.06)
                                            : Colors.black.withValues(alpha: 0.03),
                                        blurRadius: 8.0,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
                                    child: Row(
                                      children: [
                                        // User Avatar with Ring & Status
                                        Stack(
                                          clipBehavior: Clip.none,
                                          children: [
                                            Container(
                                              width: 52.0,
                                              height: 52.0,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                  color: isUnread ? const Color(0xFFEE7B4D) : const Color(0xFFE2E8F0),
                                                  width: 1.5,
                                                ),
                                              ),
                                              clipBehavior: Clip.antiAlias,
                                              child: containerUsersRecord.photoUrl.isNotEmpty
                                                  ? Image.network(
                                                      containerUsersRecord.photoUrl,
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
                                            if (isUnread)
                                              Positioned(
                                                right: 0,
                                                top: 0,
                                                child: Container(
                                                  width: 13.0,
                                                  height: 13.0,
                                                  decoration: BoxDecoration(
                                                    color: const Color(0xFFEE7B4D),
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                      color: Colors.white,
                                                      width: 2.0,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                        const SizedBox(width: 14.0),

                                        // Conversation Info
                                        Expanded(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              // Top: Name + Time
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      displayName,
                                                      style: GoogleFonts.inter(
                                                        fontWeight: isUnread ? FontWeight.w700 : FontWeight.w600,
                                                        fontSize: 15.0,
                                                        color: const Color(0xFF0F172A),
                                                      ),
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 8.0),
                                                  if (listViewChatsRecord.lastMessageTime != null)
                                                    Text(
                                                      dateTimeFormat(
                                                        "relative",
                                                        listViewChatsRecord.lastMessageTime!,
                                                      ),
                                                      style: GoogleFonts.inter(
                                                        fontSize: 11.5,
                                                        fontWeight: isUnread ? FontWeight.w600 : FontWeight.w500,
                                                        color: isUnread
                                                            ? const Color(0xFFEE7B4D)
                                                            : const Color(0xFF94A3B8),
                                                      ),
                                                    ),
                                                ],
                                              ),
                                              const SizedBox(height: 4.0),

                                              // Bottom: Last message preview + Unread indicator
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      listViewChatsRecord.lastMessage.isNotEmpty
                                                          ? listViewChatsRecord.lastMessage.maybeHandleOverflow(maxChars: 38)
                                                          : 'Tap to view message',
                                                      maxLines: 1,
                                                      style: GoogleFonts.inter(
                                                        fontSize: 13.0,
                                                        fontWeight: isUnread ? FontWeight.w600 : FontWeight.w400,
                                                        color: isUnread
                                                            ? const Color(0xFF1E293B)
                                                            : const Color(0xFF64748B),
                                                      ),
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  if (isUnread) ...[
                                                    const SizedBox(width: 6.0),
                                                    Container(
                                                      padding: const EdgeInsets.symmetric(horizontal: 7.0, vertical: 2.5),
                                                      decoration: BoxDecoration(
                                                        color: const Color(0xFFEE7B4D),
                                                        borderRadius: BorderRadius.circular(10.0),
                                                      ),
                                                      child: Text(
                                                        'NEW',
                                                        style: GoogleFonts.inter(
                                                          color: Colors.white,
                                                          fontSize: 9.5,
                                                          fontWeight: FontWeight.w800,
                                                          letterSpacing: 0.3,
                                                        ),
                                                      ),
                                                    ),
                                                  ] else ...[
                                                    const SizedBox(width: 4.0),
                                                    const Icon(
                                                      Icons.chevron_right_rounded,
                                                      size: 18.0,
                                                      color: Color(0xFFCBD5E1),
                                                    ),
                                                  ],
                                                ],
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
    );
  }

  Widget _buildFilterChip({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFEE7B4D) : const Color(0xFFF1F5F9),
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(
            color: isSelected ? const Color(0xFFEE7B4D) : const Color(0xFFE2E8F0),
            width: 1.0,
          ),
        ),
        child: Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 12.5,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            color: isSelected ? Colors.white : const Color(0xFF475569),
          ),
        ),
      ),
    );
  }
}
