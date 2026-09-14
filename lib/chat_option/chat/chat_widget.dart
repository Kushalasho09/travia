import 'package:cloud_functions/cloud_functions.dart';

import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/flutter_flow/flutter_flow_expanded_image_view.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/upload_data.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'chat_model.dart';
export 'chat_model.dart';

class ChatWidget extends StatefulWidget {
  const ChatWidget({
    super.key,
    required this.reciveChats,
  });

  final DocumentReference? reciveChats;

  static String routeName = 'chat';
  static String routePath = '/chat';

  @override
  State<ChatWidget> createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {
  late ChatModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ChatModel());

    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (widget.reciveChats != null) {
        await widget.reciveChats!.update({
          ...mapToFirestore({
            'lastMessagesSeenBy': FieldValue.arrayUnion([currentUserReference]),
          }),
        });
      }
    });

    _model.messageBoxTextController ??= TextEditingController();
    _model.messageBoxFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  Future<void> _sendChatNotification({
    required DocumentReference chatRef,
    required String senderName,
    required String message,
    required String senderId,
  }) async {
    try {
      final chatDoc = await chatRef.get();
      if (!chatDoc.exists) return;

      final chatData = chatDoc.data() as Map<String, dynamic>?;
      List<dynamic> participants = [];

      if (chatData?['userIDs'] != null) {
        participants = chatData!['userIDs'] as List<dynamic>;
      } else {
        return;
      }

      DocumentReference? recipientRef;
      for (var participant in participants) {
        if (participant is DocumentReference) {
          if (participant.id != senderId) {
            recipientRef = participant;
            break;
          }
        }
      }

      if (recipientRef == null) return;

      final recipientDoc = await recipientRef.get();
      if (!recipientDoc.exists) return;

      final recipientData = recipientDoc.data() as Map<String, dynamic>?;
      List<dynamic> fcmTokens = [];

      if (recipientData?['fcmTokens'] != null) {
        fcmTokens = recipientData!['fcmTokens'] as List<dynamic>;
      } else if (recipientData?['fcmToken'] != null) {
        fcmTokens = [recipientData!['fcmToken']];
      }

      if (fcmTokens.isEmpty) return;

      final recipientToken = fcmTokens.first as String;

      await _callCloudFunction(
        token: recipientToken,
        senderName: senderName,
        message: message,
        chatId: chatRef.id,
      );
    } catch (e) {
      // Ignored in release
    }
  }

  Future<void> _callCloudFunction({
    required String token,
    required String senderName,
    required String message,
    required String chatId,
  }) async {
    try {
      final functionsInstance = FirebaseFunctions.instance;
      await functionsInstance.httpsCallable('sendChatNotification').call({
        'token': token,
        'senderName': senderName,
        'message': message,
        'chatId': chatId,
      });
    } catch (e) {
      // Ignored in release
    }
  }

  void _showBlockUserDialog(BuildContext context, DocumentReference? otherUserRef) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        backgroundColor: Colors.white,
        title: const Row(
          children: [
            Icon(Icons.block_rounded, color: Color(0xFFE74C3C), size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Block User',
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0F172A),
              ),
            ),
          ],
        ),
        content: const Text(
          'Are you sure you want to block this user? You will no longer receive messages or ride requests from them.',
          style: TextStyle(fontSize: 13.5, color: Color(0xFF475569), height: 1.4),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel', style: TextStyle(color: Color(0xFF64748B))),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE74C3C),
              elevation: 0.0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            ),
            onPressed: () {
              Navigator.pop(dialogContext);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('User has been blocked.'),
                  backgroundColor: Color(0xFFE74C3C),
                  duration: Duration(seconds: 3),
                ),
              );
            },
            child: const Text('Block', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  void _showReportUserDialog(BuildContext context, DocumentReference? otherUserRef) {
    String selectedReason = 'Spam or Harassment';
    final TextEditingController detailsController = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
          backgroundColor: Colors.white,
          title: const Row(
            children: [
              Icon(Icons.report_problem_outlined, color: Color(0xFFF59E0B), size: 22.0),
              SizedBox(width: 8.0),
              Text(
                'Report User',
                style: TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F172A),
                ),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Select the issue you would like to report:',
                  style: TextStyle(fontSize: 13.0, color: Color(0xFF475569)),
                ),
                const SizedBox(height: 10.0),
                ...[
                  'Spam or Harassment',
                  'Inappropriate Content',
                  'Fraud or Scam',
                  'Fare / Route Dispute',
                  'Other',
                ].map((reason) => RadioListTile<String>(
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      activeColor: const Color(0xFFEE7B4D),
                      title: Text(reason, style: const TextStyle(fontSize: 13.0, color: Color(0xFF1E293B))),
                      value: reason,
                      groupValue: selectedReason,
                      onChanged: (val) {
                        if (val != null) {
                          setDialogState(() {
                            selectedReason = val;
                          });
                        }
                      },
                    )),
                const SizedBox(height: 8.0),
                TextField(
                  controller: detailsController,
                  maxLines: 2,
                  decoration: InputDecoration(
                    hintText: 'Additional details (optional)...',
                    hintStyle: const TextStyle(fontSize: 12.0, color: Color(0xFF94A3B8)),
                    filled: true,
                    fillColor: const Color(0xFFF8FAFC),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(color: Color(0xFFEE7B4D)),
                    ),
                    contentPadding: const EdgeInsets.all(10.0),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel', style: TextStyle(color: Color(0xFF64748B))),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFEE7B4D),
                elevation: 0.0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              ),
              onPressed: () {
                Navigator.pop(dialogContext);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Report submitted. Our safety team will review this.'),
                    backgroundColor: Color(0xFFEE7B4D),
                    duration: Duration(seconds: 3),
                  ),
                );
              },
              child: const Text('Submit Report', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }

  String _formatChatDate(DateTime? date) {
    if (date == null) return '';
    final now = DateTime.now();
    if (date.year == now.year && date.month == now.month && date.day == now.day) {
      return 'Today';
    }
    final yesterday = now.subtract(const Duration(days: 1));
    if (date.year == yesterday.year && date.month == yesterday.month && date.day == yesterday.day) {
      return 'Yesterday';
    }
    return dateTimeFormat("yMMMd", date);
  }

  Future<void> _sendMessage() async {
    final text = _model.messageBoxTextController?.text.trim() ?? '';
    final imageUrl = _model.uploadedFileUrl_uploadData5vy;

    if (text.isEmpty && imageUrl.isEmpty) return;

    final messageToSend = text;
    final imageToSend = imageUrl;

    // Reset input state immediately for snappy response
    safeSetState(() {
      _model.messageBoxTextController?.clear();
      _model.uploadedFileUrl_uploadData5vy = '';
      _model.uploadedLocalFile_uploadData5vy = FFUploadedFile(
        bytes: Uint8List.fromList([]),
        originalFilename: '',
      );
    });

    try {
      // 1. Save message to Firestore
      await ChatsMessagesRecord.createDoc(widget.reciveChats!).set(
        createChatsMessagesRecordData(
          message: messageToSend,
          timeSpam: getCurrentTimestamp,
          uidOfSender: currentUserReference,
          nameOfSender: currentUserDisplayName.isNotEmpty ? currentUserDisplayName : 'User',
          image: imageToSend,
        ),
      );

      // 2. Update chat document
      final lastMsgPreview = messageToSend.isNotEmpty
          ? messageToSend
          : '📷 Photo';

      await widget.reciveChats!.update({
        'lastMessage': lastMsgPreview,
        'lastMessageTime': getCurrentTimestamp,
        'lastMessageSenderId': currentUserUid,
        'lastMessageSenderName': currentUserDisplayName,
        'lastMessagesSeenBy': [currentUserReference],
      });

      // 3. Trigger push notification
      await _sendChatNotification(
        chatRef: widget.reciveChats!,
        senderName: currentUserDisplayName.isNotEmpty ? currentUserDisplayName : 'Travia User',
        message: lastMsgPreview,
        senderId: currentUserUid,
      );
    } catch (e) {
      // Handle error gracefully
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.reciveChats == null) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.5,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Color(0xFF111827)),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            'Chat',
            style: GoogleFonts.inter(color: const Color(0xFF111827), fontWeight: FontWeight.bold),
          ),
        ),
        body: Center(
          child: Text(
            'Chat not found',
            style: GoogleFonts.inter(color: const Color(0xFF64748B)),
          ),
        ),
      );
    }

    return StreamBuilder<ChatsRecord>(
      stream: ChatsRecord.getDocument(widget.reciveChats!),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: SizedBox(
                width: 44.0,
                height: 44.0,
                child: SpinKitFadingCircle(
                  color: Color(0xFFEE7B4D),
                  size: 40.0,
                ),
              ),
            ),
          );
        }

        final chatChatsRecord = snapshot.data!;
        final otherUserRef = functions.getOtherUserRef(
          chatChatsRecord.userIDs.toList(),
          currentUserReference!,
        );

        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: const Color(0xFFF8FAFC),
            appBar: AppBar(
              backgroundColor: Colors.white,
              automaticallyImplyLeading: false,
              elevation: 0.5,
              shadowColor: Colors.black.withValues(alpha: 0.04),
              leadingWidth: 48.0,
              leading: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: FlutterFlowIconButton(
                  borderRadius: 12.0,
                  buttonSize: 40.0,
                  icon: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Color(0xFF111827),
                    size: 18.0,
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              titleSpacing: 4.0,
              title: StreamBuilder<UsersRecord>(
                stream: UsersRecord.getDocument(otherUserRef),
                builder: (context, userSnapshot) {
                  final otherUser = userSnapshot.data;
                  final name = (otherUser?.displayName ?? '').trim().isNotEmpty
                      ? otherUser!.displayName.trim()
                      : ((otherUser?.userName ?? '').trim().isNotEmpty
                          ? otherUser!.userName.trim()
                          : 'Travia User');

                  return Row(
                    children: [
                      // Avatar with ring
                      Container(
                        width: 38.0,
                        height: 38.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0xFFE2E8F0),
                            width: 1.5,
                          ),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: (otherUser != null && otherUser.photoUrl.isNotEmpty)
                            ? Image.network(
                                otherUser.photoUrl,
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
                      const SizedBox(width: 10.0),
                      // Name & Status
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              style: GoogleFonts.inter(
                                fontSize: 15.0,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF111827),
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 2.0),
                            Row(
                              children: [
                                Container(
                                  width: 7.0,
                                  height: 7.0,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFF10B981),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 5.0),
                                Text(
                                  'Active on Travia',
                                  style: GoogleFonts.inter(
                                    fontSize: 11.0,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFF64748B),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
              actions: [
                // Direct Phone Call Button
                Center(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20.0),
                    onTap: () async {
                      final userDoc = await UsersRecord.getDocumentOnce(otherUserRef);
                      final phone = userDoc.phoneNumber.trim();
                      if (phone.isNotEmpty) {
                        final cleanPhone = phone.replaceAll(RegExp(r'[^0-9+]'), '');
                        final uri = Uri.parse('tel:$cleanPhone');
                        if (await canLaunchUrl(uri)) {
                          await launchUrl(uri);
                        } else {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Could not open phone dialer for $cleanPhone')),
                            );
                          }
                        }
                      } else {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Phone number is not available for this user.'),
                              backgroundColor: Color(0xFFE74C3C),
                            ),
                          );
                        }
                      }
                    },
                    child: Container(
                      width: 38.0,
                      height: 38.0,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF4ED),
                        shape: BoxShape.circle,
                        border: Border.all(color: const Color(0xFFFFD4C2)),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.call_rounded,
                          color: Color(0xFFEE7B4D),
                          size: 19.0,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 4.0),

                // Popup Menu (Block, Report)
                PopupMenuButton<String>(
                  icon: const Icon(
                    Icons.more_vert_rounded,
                    color: Color(0xFF475569),
                    size: 22.0,
                  ),
                  color: Colors.white,
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  onSelected: (value) {
                    if (value == 'block') {
                      _showBlockUserDialog(context, otherUserRef);
                    } else if (value == 'report') {
                      _showReportUserDialog(context, otherUserRef);
                    }
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'block',
                      child: Row(
                        children: [
                          Icon(Icons.block_rounded, color: Color(0xFFE74C3C), size: 18.0),
                          SizedBox(width: 10.0),
                          Text(
                            'Block User',
                            style: TextStyle(
                              color: Color(0xFF0F172A),
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const PopupMenuItem(
                      value: 'report',
                      child: Row(
                        children: [
                          Icon(Icons.flag_outlined, color: Color(0xFFF59E0B), size: 18.0),
                          SizedBox(width: 10.0),
                          Text(
                            'Report User',
                            style: TextStyle(
                              color: Color(0xFF0F172A),
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 6.0),
              ],
            ),
            body: SafeArea(
              top: false,
              bottom: true,
              child: Column(
                children: [
                  // Messages Stream
                  Expanded(
                    child: StreamBuilder<List<ChatsMessagesRecord>>(
                      stream: queryChatsMessagesRecord(
                        parent: widget.reciveChats,
                        queryBuilder: (q) => q.orderBy('timeSpam', descending: true),
                      ),
                      builder: (context, msgSnapshot) {
                        if (!msgSnapshot.hasData) {
                          return const Center(
                            child: SizedBox(
                              width: 44.0,
                              height: 44.0,
                              child: SpinKitFadingCircle(
                                color: Color(0xFFEE7B4D),
                                size: 36.0,
                              ),
                            ),
                          );
                        }

                        final messages = msgSnapshot.data!;

                        if (messages.isEmpty) {
                          return Center(
                            child: SingleChildScrollView(
                              padding: const EdgeInsets.all(24.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 72.0,
                                    height: 72.0,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFFFF4ED),
                                      shape: BoxShape.circle,
                                      border: Border.all(color: const Color(0xFFFFD4C2), width: 1.5),
                                    ),
                                    child: const Center(
                                      child: Icon(
                                        Icons.chat_bubble_outline_rounded,
                                        size: 34.0,
                                        color: Color(0xFFEE7B4D),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 16.0),
                                  Text(
                                    'No messages yet',
                                    style: GoogleFonts.inter(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFF111827),
                                    ),
                                  ),
                                  const SizedBox(height: 6.0),
                                  Text(
                                    'Coordinate pickup, luggage, or route details safely.',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.inter(
                                      fontSize: 13.0,
                                      color: const Color(0xFF64748B),
                                    ),
                                  ),
                                  const SizedBox(height: 20.0),
                                  // Quick Starter Reply Chips
                                  Wrap(
                                    spacing: 8.0,
                                    runSpacing: 8.0,
                                    alignment: WrapAlignment.center,
                                    children: [
                                      '👋 Hi, where is the pickup point?',
                                      '🚗 I am on my way!',
                                      '🧳 Can we confirm luggage space?',
                                    ].map((quickText) {
                                      return ActionChip(
                                        backgroundColor: Colors.white,
                                        side: const BorderSide(color: Color(0xFFE2E8F0)),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
                                        label: Text(
                                          quickText,
                                          style: GoogleFonts.inter(
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.w500,
                                            color: const Color(0xFF334155),
                                          ),
                                        ),
                                        onPressed: () {
                                          _model.messageBoxTextController?.text = quickText;
                                          safeSetState(() {});
                                        },
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }

                        return ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                          reverse: true,
                          itemCount: messages.length,
                          itemBuilder: (context, listViewIndex) {
                            final currentMsg = messages[listViewIndex];
                            final isMe = currentMsg.uidOfSender == currentUserReference;

                            // Calculate Date Divider
                            bool showDateDivider = false;
                            if (listViewIndex == messages.length - 1) {
                              showDateDivider = true;
                            } else {
                              final olderMsg = messages[listViewIndex + 1];
                              if (currentMsg.timeSpam != null && olderMsg.timeSpam != null) {
                                final curTime = currentMsg.timeSpam!;
                                final prevTime = olderMsg.timeSpam!;
                                showDateDivider = curTime.day != prevTime.day ||
                                    curTime.month != prevTime.month ||
                                    curTime.year != prevTime.year;
                              }
                            }

                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Optional Date Divider
                                if (showDateDivider && currentMsg.timeSpam != null)
                                  Container(
                                    margin: const EdgeInsets.symmetric(vertical: 12.0),
                                    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFE2E8F0),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    child: Text(
                                      _formatChatDate(currentMsg.timeSpam),
                                      style: GoogleFonts.inter(
                                        fontSize: 11.0,
                                        fontWeight: FontWeight.w600,
                                        color: const Color(0xFF475569),
                                      ),
                                    ),
                                  ),

                                // Message Bubble
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 3.0),
                                  child: Align(
                                    alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                                    child: ConstrainedBox(
                                      constraints: BoxConstraints(
                                        maxWidth: MediaQuery.of(context).size.width * 0.78,
                                      ),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          gradient: isMe
                                              ? const LinearGradient(
                                                  colors: [Color(0xFFEE7B4D), Color(0xFFF26835)],
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                )
                                              : null,
                                          color: isMe ? null : Colors.white,
                                          borderRadius: isMe
                                              ? const BorderRadius.only(
                                                  topLeft: Radius.circular(18.0),
                                                  topRight: Radius.circular(18.0),
                                                  bottomLeft: Radius.circular(18.0),
                                                  bottomRight: Radius.circular(4.0),
                                                )
                                              : const BorderRadius.only(
                                                  topLeft: Radius.circular(18.0),
                                                  topRight: Radius.circular(18.0),
                                                  bottomRight: Radius.circular(18.0),
                                                  bottomLeft: Radius.circular(4.0),
                                                ),
                                          border: isMe ? null : Border.all(color: const Color(0xFFE2E8F0)),
                                          boxShadow: [
                                            BoxShadow(
                                              color: isMe
                                                  ? const Color(0xFFEE7B4D).withValues(alpha: 0.22)
                                                  : Colors.black.withValues(alpha: 0.03),
                                              blurRadius: 6.0,
                                              offset: const Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                                          children: [
                                            // Image attachment if present
                                            if (currentMsg.image.isNotEmpty) ...[
                                              InkWell(
                                                onTap: () async {
                                                  await Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => FlutterFlowExpandedImageView(
                                                        image: CachedNetworkImage(
                                                          imageUrl: currentMsg.image,
                                                          fit: BoxFit.contain,
                                                        ),
                                                        allowRotation: false,
                                                        tag: currentMsg.image,
                                                        useHeroAnimation: true,
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: Hero(
                                                  tag: currentMsg.image,
                                                  child: ClipRRect(
                                                    borderRadius: BorderRadius.circular(10.0),
                                                    child: CachedNetworkImage(
                                                      imageUrl: currentMsg.image,
                                                      width: 220.0,
                                                      height: 160.0,
                                                      fit: BoxFit.cover,
                                                      errorWidget: (context, url, error) => Container(
                                                        width: 220.0,
                                                        height: 160.0,
                                                        color: const Color(0xFFE2E8F0),
                                                        child: const Icon(Icons.broken_image_rounded),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              if (currentMsg.message.isNotEmpty) const SizedBox(height: 8.0),
                                            ],

                                            // Text Message
                                            if (currentMsg.message.isNotEmpty)
                                              Text(
                                                currentMsg.message,
                                                style: GoogleFonts.inter(
                                                  fontSize: 14.5,
                                                  color: isMe ? Colors.white : const Color(0xFF1E293B),
                                                  height: 1.35,
                                                ),
                                              ),

                                            const SizedBox(height: 4.0),

                                            // Time & Read receipt
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                if (currentMsg.timeSpam != null)
                                                  Text(
                                                    dateTimeFormat("jm", currentMsg.timeSpam!),
                                                    style: GoogleFonts.inter(
                                                      fontSize: 10.5,
                                                      fontWeight: FontWeight.w500,
                                                      color: isMe
                                                          ? Colors.white.withValues(alpha: 0.85)
                                                          : const Color(0xFF94A3B8),
                                                    ),
                                                  ),
                                                if (isMe) ...[
                                                  const SizedBox(width: 4.0),
                                                  const Icon(
                                                    Icons.done_all_rounded,
                                                    size: 13.0,
                                                    color: Colors.white,
                                                  ),
                                                ],
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ),

                  // Image Preview Bar (before sending)
                  if (_model.uploadedFileUrl_uploadData5vy.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      color: Colors.white,
                      child: Row(
                        children: [
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.network(
                                  _model.uploadedFileUrl_uploadData5vy,
                                  width: 56.0,
                                  height: 56.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                top: -6.0,
                                right: -6.0,
                                child: GestureDetector(
                                  onTap: () {
                                    safeSetState(() {
                                      _model.uploadedFileUrl_uploadData5vy = '';
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(2.0),
                                    decoration: const BoxDecoration(
                                      color: Color(0xFFE74C3C),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(Icons.close, size: 14.0, color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 12.0),
                          Text(
                            'Photo attached',
                            style: GoogleFonts.inter(
                              fontSize: 13.0,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF475569),
                            ),
                          ),
                        ],
                      ),
                    ),

                  // Bottom Chat Input Bar
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: const Border(
                        top: BorderSide(color: Color(0xFFE2E8F0), width: 1.0),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.03),
                          blurRadius: 10.0,
                          offset: const Offset(0, -3),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.fromLTRB(12.0, 10.0, 12.0, 12.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // Attachment / Camera Button
                        Container(
                          width: 42.0,
                          height: 42.0,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF1F5F9),
                            borderRadius: BorderRadius.circular(21.0),
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(21.0),
                            onTap: () async {
                              final selectedMedia = await selectMediaWithSourceBottomSheet(
                                context: context,
                                maxWidth: 800.00,
                                maxHeight: 1200.00,
                                imageQuality: 86,
                                allowPhoto: true,
                              );
                              if (selectedMedia != null &&
                                  selectedMedia.every((m) => validateFileFormat(m.storagePath, context))) {
                                safeSetState(() => _model.isDataUploading_uploadData5vy = true);
                                var selectedUploadedFiles = <FFUploadedFile>[];
                                var downloadUrls = <String>[];
                                try {
                                  if (context.mounted) {
                                    showUploadMessage(
                                      context,
                                      'Uploading photo...',
                                      showLoading: true,
                                    );
                                  }
                                  selectedUploadedFiles = selectedMedia
                                      .map((m) => FFUploadedFile(
                                            name: m.storagePath.split('/').last,
                                            bytes: m.bytes,
                                            height: m.dimensions?.height,
                                            width: m.dimensions?.width,
                                            blurHash: m.blurHash,
                                            originalFilename: m.originalFilename,
                                          ))
                                      .toList();

                                  downloadUrls = (await Future.wait(
                                    selectedMedia.map(
                                      (m) async => await uploadData(m.storagePath, m.bytes),
                                    ),
                                  ))
                                      .where((u) => u != null)
                                      .map((u) => u!)
                                      .toList();
                                } finally {
                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                  }
                                  _model.isDataUploading_uploadData5vy = false;
                                }
                                if (selectedUploadedFiles.length == selectedMedia.length &&
                                    downloadUrls.length == selectedMedia.length) {
                                  safeSetState(() {
                                    _model.uploadedLocalFile_uploadData5vy = selectedUploadedFiles.first;
                                    _model.uploadedFileUrl_uploadData5vy = downloadUrls.first;
                                  });
                                } else {
                                  safeSetState(() {});
                                  if (context.mounted) {
                                    showUploadMessage(context, 'Failed to upload photo');
                                  }
                                }
                              }
                            },
                            child: const Center(
                              child: Icon(
                                Icons.camera_alt_outlined,
                                color: Color(0xFF64748B),
                                size: 20.0,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8.0),

                        // Message Text Field
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFFF1F5F9),
                              borderRadius: BorderRadius.circular(22.0),
                              border: Border.all(color: const Color(0xFFE2E8F0)),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 2.0),
                            child: TextFormField(
                              controller: _model.messageBoxTextController,
                              focusNode: _model.messageBoxFocusNode,
                              onChanged: (_) => EasyDebounce.debounce(
                                '_model.messageBoxTextController',
                                const Duration(milliseconds: 100),
                                () => safeSetState(() {}),
                              ),
                              style: GoogleFonts.inter(
                                fontSize: 14.5,
                                color: const Color(0xFF1E293B),
                              ),
                              decoration: InputDecoration(
                                hintText: 'Type a message...',
                                hintStyle: GoogleFonts.inter(
                                  fontSize: 14.0,
                                  color: const Color(0xFF94A3B8),
                                ),
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
                              ),
                              maxLines: 4,
                              minLines: 1,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8.0),

                        // Circular Send Button
                        Builder(
                          builder: (context) {
                            final hasText = _model.messageBoxTextController?.text.trim().isNotEmpty ?? false;
                            final hasImage = _model.uploadedFileUrl_uploadData5vy.isNotEmpty;
                            final canSend = hasText || hasImage;

                            return Container(
                              width: 42.0,
                              height: 42.0,
                              decoration: BoxDecoration(
                                color: canSend ? const Color(0xFFEE7B4D) : const Color(0xFFE2E8F0),
                                shape: BoxShape.circle,
                                boxShadow: canSend
                                    ? [
                                        BoxShadow(
                                          color: const Color(0xFFEE7B4D).withValues(alpha: 0.35),
                                          blurRadius: 6.0,
                                          offset: const Offset(0, 2),
                                        ),
                                      ]
                                    : null,
                              ),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(21.0),
                                onTap: canSend ? _sendMessage : null,
                                child: Center(
                                  child: Icon(
                                    Icons.send_rounded,
                                    color: canSend ? Colors.white : const Color(0xFF94A3B8),
                                    size: 19.0,
                                  ),
                                ),
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
          ),
        );
      },
    );
  }
}
