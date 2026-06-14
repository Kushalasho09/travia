import 'dart:convert';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:travia/pages/sidebar_menu/sidebar_menu_widget.dart';
import 'package:travia/profile/drive_profile/drive_profile_widget.dart';
import 'package:travia/wallet/plans/plans_widget.dart';

import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/flutter_flow/flutter_flow_expanded_image_view.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
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

    // ✅ REMOVED context.safePop() - Fixed the issue
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

  Future<void> _sendChatNotification({
    required DocumentReference chatRef,
    required String senderName,
    required String message,
    required String senderId,
  }) async {
    try {
      print('🔔 Starting chat notification...');
      print('📱 Sender ID: $senderId');

      // 1. Get chat data
      final chatDoc = await chatRef.get();
      if (!chatDoc.exists) return;

      final chatData = chatDoc.data() as Map<String, dynamic>?;

      // 2. Get participants from "userIDs" field (not "participants")
      List<dynamic> participants = [];

      if (chatData?['userIDs'] != null) {
        participants = chatData!['userIDs'] as List<dynamic>;
        print('👥 Found ${participants.length} participants in "userIDs" field');
      } else {
        print('❌ No userIDs field found');
        return;
      }

      // 3. Find recipient (other person)
      DocumentReference? recipientRef;

      for (var participant in participants) {
        if (participant is DocumentReference) {
          final participantId = participant.id;
          print('   Checking: $participantId');

          // Check if this is NOT the sender
          if (participantId != senderId) {
            recipientRef = participant;
            print('   ✅ Found recipient: $participantId');
            break;
          }
        }
      }

      if (recipientRef == null) {
        print('❌ Could not find recipient');
        print('   Sender: $senderId');
        print('   All userIDs:');
        for (var p in participants) {
          if (p is DocumentReference) {
            print('   - ${p.id}');
          }
        }
        return;
      }

      print('✅ Recipient found: ${recipientRef.path}');

      // 4. Get recipient's FCM token
      final recipientDoc = await recipientRef.get();
      if (!recipientDoc.exists) {
        print('❌ Recipient document does not exist');
        return;
      }

      final recipientData = recipientDoc.data() as Map<String, dynamic>?;

      // Get FCM tokens
      List<dynamic> fcmTokens = [];

      if (recipientData?['fcmTokens'] != null) {
        fcmTokens = recipientData!['fcmTokens'] as List<dynamic>;
        print('📱 Found ${fcmTokens.length} FCM tokens');
      }
      else if (recipientData?['fcmToken'] != null) {
        // Single token
        final singleToken = recipientData!['fcmToken'];
        fcmTokens = [singleToken];
        print('📱 Found single FCM token');
      }
      else {
        print('⚠️ No FCM tokens found in recipient document');
        return;
      }

      if (fcmTokens.isEmpty) {
        print('⚠️ Recipient has no FCM tokens');
        return;
      }

      final recipientToken = fcmTokens.first as String;
      print('📱 Using token: ${recipientToken.substring(0, min(30, recipientToken.length))}...');

      // 5. Call Cloud Function
      await _callCloudFunction(
        token: recipientToken,
        senderName: senderName,
        message: message,
        chatId: chatRef.id,
      );

    } catch (e) {
      print('❌ Error: $e');
    }
  }

  Future<void> _debugChatStructure() async {
    try {
      final chatDoc = await widget.reciveChats!.get();
      print('=== CHAT DOCUMENT DEBUG ===');
      print('Document ID: ${chatDoc.id}');
      print('Document Path: ${chatDoc.reference.path}');

      final data = chatDoc.data() as Map<String, dynamic>?;

      if (data == null) {
        print('❌ Chat document has no data');
        return;
      }

      print('All fields:');
      data.forEach((key, value) {
        print('  "$key": $value (${value.runtimeType})');
      });

      // Check participants specifically
      if (data['participants'] != null) {
        final participants = data['participants'];
        print('\n📱 Participants field details:');
        print('  Type: ${participants.runtimeType}');

        if (participants is List) {
          print('  Length: ${participants.length}');
          for (int i = 0; i < participants.length; i++) {
            final p = participants[i];
            print('  [$i]: $p (${p.runtimeType})');

            if (p is DocumentReference) {
              print('      Path: ${p.path}');
              print('      ID: ${p.id}');
            }
          }
        }
      }

      print('=== END DEBUG ===');

    } catch (e) {
      print('❌ Debug error: $e');
    }
  }

  Future<void> _callCloudFunction({
    required String token,
    required String senderName,
    required String message,
    required String chatId,
  }) async {
    try {
      print('📤 Calling Cloud Function...');

      final functions = FirebaseFunctions.instance;

      final result = await functions
          .httpsCallable('sendChatNotification')
          .call({
        'token': token,
        'senderName': senderName,
        'message': message,
        'chatId': chatId,
      });

      final data = result.data as Map<String, dynamic>;

      if (data['success'] == true) {
        print('✅ Notification sent successfully!');
        print('   Message ID: ${data['messageId']}');

        // Show success feedback
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('💬 Notification sent'),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
            ),
          );
        }
      } else {
        print('❌ Cloud Function error: ${data['message']}');
      }

    } catch (e) {
      print('❌ Cloud Function call failed: $e');

      // Fallback: Show user message was sent
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('💬 Message sent'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  Future<void> _triggerChatNotification({
    required DocumentReference chatDocRef,
    required String senderName,
    required String message,
    required String senderId,
  }) async {
    try {
      // 1. Get chat to find the other user
      final chatDoc = await chatDocRef.get();
      if (!chatDoc.exists) return;

      final chatData = chatDoc.data() as Map<String, dynamic>?;
      final participants = chatData?['participants'] as List<dynamic>? ?? [];

      // 2. Find the recipient (other person in chat)
      DocumentReference? recipientRef;

      for (var participant in participants) {
        if (participant is DocumentReference) {
          final participantPath = participant.path;
          // Find who is NOT the sender
          if (!participantPath.contains(senderId)) {
            recipientRef = participant;
            break;
          }
        }
      }

      if (recipientRef == null) return;

      // 3. Get recipient's info
      final recipientDoc = await recipientRef.get();
      if (!recipientDoc.exists) return;

      final recipientData = recipientDoc.data() as Map<String, dynamic>?;
      final recipientEmail = recipientData?['email'] ?? '';

      // 4. Save data for your existing campaign
      await FirebaseFirestore.instance
          .collection('chat_notifications')
          .add({
        'type': 'chat_message',
        'sender': senderName,
        'recipient_email': recipientEmail,
        'message': message,
        'chat_id': chatDocRef.id,
        'timestamp': FieldValue.serverTimestamp(),
      });

      print('✅ Chat notification saved for campaign');

    } catch (e) {
      print('❌ Error: $e');
    }
  }



  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ✅ Added null check for reciveChats
    if (widget.reciveChats == null) {
      return Scaffold(
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: Center(
          child: Text(
            'Chat not found',
            style: FlutterFlowTheme.of(context).bodyLarge,
          ),
        ),
      );
    }

    return StreamBuilder<ChatsRecord>(
      stream: ChatsRecord.getDocument(widget.reciveChats!),
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

        final chatChatsRecord = snapshot.data!;

        return WillPopScope(
          onWillPop: () async {
            // ✅ Fixed back navigation - removed the pop from initState
            Navigator.of(context).pop();
            return false;
          },
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: Scaffold(
              key: scaffoldKey,
              backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
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
                    }
                  },
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
                          // // Notification Icon
                          // Stack(
                          //   children: [
                          //     InkWell(
                          //       splashColor: Colors.transparent,
                          //       focusColor: Colors.transparent,
                          //       hoverColor: Colors.transparent,
                          //       highlightColor: Colors.transparent,
                          //       onTap: () async {
                          //         // TODO: Add notification page route
                          //         // context.pushNamed('NotificationsPage');
                          //       },
                          //       child: Container(
                          //         width: 40.0,
                          //         height: 40.0,
                          //         decoration: BoxDecoration(
                          //           shape: BoxShape.circle,
                          //           color: Colors.transparent,
                          //         ),
                          //         child: Icon(
                          //           Icons.notifications_outlined,
                          //           color: Color(0xFF283B5E),
                          //           size: 24.0,
                          //         ),
                          //       ),
                          //     ),
                          //     Positioned(
                          //       right: 0,
                          //       top: 0,
                          //       child: Container(
                          //         width: 16.0,
                          //         height: 16.0,
                          //         decoration: BoxDecoration(
                          //           color: Colors.red,
                          //           shape: BoxShape.circle,
                          //           border: Border.all(
                          //             color: Color(0xFFF4F4F4),
                          //             width: 2.0,
                          //           ),
                          //         ),
                          //         child: Center(
                          //           child: Text(
                          //             '3',
                          //             style: TextStyle(
                          //               color: Colors.white,
                          //               fontSize: 10.0,
                          //               fontWeight: FontWeight.w600,
                          //             ),
                          //           ),
                          //         ),
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          // SizedBox(width: 10.0),
                          // Crown Icon
                          InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              context.pushNamed(PlansWidget.routeName);
                            },
                            child: CircleAvatar(
                              radius: 20,
                              backgroundColor: Color(0xFF283B5E),
                              child: Padding(
                                padding: const EdgeInsets.only(right: 2),
                                child: Icon(
                                  FontAwesomeIcons.crown,
                                  color: Colors.white,
                                  size: 18.0,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10.0),
                          // Profile Avatar
                          Container(
                            width: 40.0,
                            height: 40.0,
                            decoration: BoxDecoration(
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
                                        errorBuilder: (context, error, stackTrace) {
                                          return Image.asset(
                                            'assets/images/userIconTravia.png',
                                            fit: BoxFit.cover,
                                          );
                                        },
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
                child: Align(
                  alignment: AlignmentDirectional(0.0, 0.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 16.0, 16.0, 0.0),
                          child: StreamBuilder<List<ChatsMessagesRecord>>(
                            stream: queryChatsMessagesRecord(
                              parent: widget.reciveChats,
                              queryBuilder: (chatsMessagesRecord) =>
                                  chatsMessagesRecord.orderBy('timeSpam',
                                      descending: true),
                            ),
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
                              List<ChatsMessagesRecord>
                              listViewChatsMessagesRecordList =
                              snapshot.data!;

                              if (listViewChatsMessagesRecordList.isEmpty) {
                                return Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.chat_bubble_outline,
                                        size: 64.0,
                                        color: Color(0xFF283B5E).withOpacity(0.5),
                                      ),
                                      SizedBox(height: 16.0),
                                      Text(
                                        'No messages yet',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                          fontFamily: 'Inter',
                                          color: Color(0xFF666666),
                                        ),
                                      ),
                                      Text(
                                        'Start the conversation',
                                        style: FlutterFlowTheme.of(context)
                                            .bodySmall
                                            .override(
                                          fontFamily: 'Inter',
                                          color: Color(0xFF999999),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }

                              return ListView.builder(
                                padding: EdgeInsets.zero,
                                reverse: true,
                                primary: false,
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: listViewChatsMessagesRecordList.length,
                                itemBuilder: (context, listViewIndex) {
                                  final listViewChatsMessagesRecord =
                                  listViewChatsMessagesRecordList[
                                  listViewIndex];
                                  return Padding(
                                    padding: EdgeInsets.symmetric(vertical: 4.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        // Received messages (from others)
                                        if (listViewChatsMessagesRecord.uidOfSender != currentUserReference)
                                          Align(
                                            alignment: AlignmentDirectional(-1.0, 0.0),
                                            child: ConstrainedBox(
                                              constraints: BoxConstraints(
                                                maxWidth: MediaQuery.of(context).size.width * 0.75,
                                              ),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Color(0x4DE9E9E7),
                                                  borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(16.0),
                                                    topRight: Radius.circular(16.0),
                                                    bottomRight: Radius.circular(16.0),
                                                    bottomLeft: Radius.circular(4.0),
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.all(12.0),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      if (listViewChatsMessagesRecord.image != null &&
                                                          listViewChatsMessagesRecord.image != '')
                                                        InkWell(
                                                          onTap: () async {
                                                            await Navigator.push(
                                                              context,
                                                              PageTransition(
                                                                type: PageTransitionType.fade,
                                                                child: FlutterFlowExpandedImageView(
                                                                  image: CachedNetworkImage(
                                                                    imageUrl: listViewChatsMessagesRecord.image!,
                                                                    fit: BoxFit.contain,
                                                                  ),
                                                                  allowRotation: false,
                                                                  tag: listViewChatsMessagesRecord.image!,
                                                                  useHeroAnimation: true,
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                          child: Hero(
                                                            tag: listViewChatsMessagesRecord.image!,
                                                            child: ClipRRect(
                                                              borderRadius: BorderRadius.circular(8.0),
                                                              child: CachedNetworkImage(
                                                                imageUrl: listViewChatsMessagesRecord.image!,
                                                                width: 200.0,
                                                                height: 150.0,
                                                                fit: BoxFit.cover,
                                                                errorWidget: (context, url, error) =>
                                                                    Container(
                                                                      width: 200.0,
                                                                      height: 150.0,
                                                                      color: Colors.grey[200],
                                                                      child: Icon(Icons.broken_image),
                                                                    ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      if (listViewChatsMessagesRecord.message != null &&
                                                          listViewChatsMessagesRecord.message != '')
                                                        Padding(
                                                          padding: listViewChatsMessagesRecord.image != null &&
                                                              listViewChatsMessagesRecord.image != ''
                                                              ? EdgeInsets.only(top: 8.0)
                                                              : EdgeInsets.zero,
                                                          child: Text(
                                                            listViewChatsMessagesRecord.message,
                                                            style: FlutterFlowTheme.of(context)
                                                                .bodyMedium
                                                                .override(
                                                              fontFamily: 'Inter',
                                                              color: FlutterFlowTheme.of(context).primaryText,
                                                            ),
                                                          ),
                                                        ),
                                                      SizedBox(height: 4.0),
                                                      Text(
                                                        dateTimeFormat(
                                                          "relative",
                                                          listViewChatsMessagesRecord.timeSpam!,
                                                        ),
                                                        style: FlutterFlowTheme.of(context)
                                                            .labelSmall
                                                            .override(
                                                          fontFamily: 'Inter',
                                                          color: FlutterFlowTheme.of(context).secondaryText,
                                                          fontSize: 11.0,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        // Sent messages (from current user)
                                        if (listViewChatsMessagesRecord.uidOfSender == currentUserReference)
                                          Align(
                                            alignment: AlignmentDirectional(1.0, 0.0),
                                            child: ConstrainedBox(
                                              constraints: BoxConstraints(
                                                maxWidth: MediaQuery.of(context).size.width * 0.75,
                                              ),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Color(0xFFF2F4EF),
                                                  borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(16.0),
                                                    topRight: Radius.circular(16.0),
                                                    bottomLeft: Radius.circular(16.0),
                                                    bottomRight: Radius.circular(4.0),
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.all(12.0),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.end,
                                                    children: [
                                                      if (listViewChatsMessagesRecord.image != null &&
                                                          listViewChatsMessagesRecord.image != '')
                                                        InkWell(
                                                          onTap: () async {
                                                            await Navigator.push(
                                                              context,
                                                              PageTransition(
                                                                type: PageTransitionType.fade,
                                                                child: FlutterFlowExpandedImageView(
                                                                  image: CachedNetworkImage(
                                                                    imageUrl: listViewChatsMessagesRecord.image!,
                                                                    fit: BoxFit.contain,
                                                                  ),
                                                                  allowRotation: false,
                                                                  tag: listViewChatsMessagesRecord.image!,
                                                                  useHeroAnimation: true,
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                          child: Hero(
                                                            tag: listViewChatsMessagesRecord.image!,
                                                            child: ClipRRect(
                                                              borderRadius: BorderRadius.circular(8.0),
                                                              child: CachedNetworkImage(
                                                                imageUrl: listViewChatsMessagesRecord.image!,
                                                                width: 200.0,
                                                                height: 150.0,
                                                                fit: BoxFit.cover,
                                                                errorWidget: (context, url, error) =>
                                                                    Container(
                                                                      width: 200.0,
                                                                      height: 150.0,
                                                                      color: Colors.grey[200],
                                                                      child: Icon(Icons.broken_image),
                                                                    ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      if (listViewChatsMessagesRecord.message != null &&
                                                          listViewChatsMessagesRecord.message != '')
                                                        Padding(
                                                          padding: listViewChatsMessagesRecord.image != null &&
                                                              listViewChatsMessagesRecord.image != ''
                                                              ? EdgeInsets.only(top: 8.0)
                                                              : EdgeInsets.zero,
                                                          child: Text(
                                                            listViewChatsMessagesRecord.message,
                                                            style: FlutterFlowTheme.of(context)
                                                                .bodyMedium
                                                                .override(
                                                              fontFamily: 'Inter',
                                                              color: FlutterFlowTheme.of(context).primaryText,
                                                            ),
                                                          ),
                                                        ),
                                                      SizedBox(height: 4.0),
                                                      Text(
                                                        dateTimeFormat(
                                                          "relative",
                                                          listViewChatsMessagesRecord.timeSpam!,
                                                        ),
                                                        style: FlutterFlowTheme.of(context)
                                                            .labelSmall
                                                            .override(
                                                          fontFamily: 'Inter',
                                                          color: FlutterFlowTheme.of(context).secondaryText,
                                                          fontSize: 11.0,
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
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(0.0, 1.0),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                FlutterFlowTheme.of(context).primaryBackground,
                                Color(0x00FFFFFF)
                              ],
                              stops: [0.0, 1.0],
                              begin: AlignmentDirectional(0.0, -1.0),
                              end: AlignmentDirectional(0, 1.0),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 12.0, 16.0, 16.0),
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 8.0,
                                    color: Color(0x1A000000),
                                    offset: Offset(
                                      0.0,
                                      -2.0,
                                    ),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(24.0),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(12.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    FlutterFlowIconButton(
                                      borderRadius: 20.0,
                                      buttonSize: 40.0,
                                      fillColor:
                                      FlutterFlowTheme.of(context).accent1,
                                      icon: Icon(
                                        Icons.add,
                                        color:
                                        FlutterFlowTheme.of(context).primary,
                                        size: 20.0,
                                      ),
                                      onPressed: () async {
                                        final selectedMedia =
                                        await selectMediaWithSourceBottomSheet(
                                          context: context,
                                          maxWidth: 800.00,
                                          maxHeight: 1200.00,
                                          imageQuality: 86,
                                          allowPhoto: true,
                                        );
                                        if (selectedMedia != null &&
                                            selectedMedia.every((m) =>
                                                validateFileFormat(
                                                    m.storagePath, context))) {
                                          safeSetState(() =>
                                          _model.isDataUploading_uploadData5vy =
                                          true);
                                          var selectedUploadedFiles =
                                          <FFUploadedFile>[];

                                          var downloadUrls = <String>[];
                                          try {
                                            showUploadMessage(
                                              context,
                                              'Uploading file...',
                                              showLoading: true,
                                            );
                                            selectedUploadedFiles = selectedMedia
                                                .map((m) => FFUploadedFile(
                                              name: m.storagePath
                                                  .split('/')
                                                  .last,
                                              bytes: m.bytes,
                                              height:
                                              m.dimensions?.height,
                                              width: m.dimensions?.width,
                                              blurHash: m.blurHash,
                                              originalFilename:
                                              m.originalFilename,
                                            ))
                                                .toList();

                                            downloadUrls = (await Future.wait(
                                              selectedMedia.map(
                                                    (m) async => await uploadData(
                                                    m.storagePath, m.bytes),
                                              ),
                                            ))
                                                .where((u) => u != null)
                                                .map((u) => u!)
                                                .toList();
                                          } finally {
                                            ScaffoldMessenger.of(context)
                                                .hideCurrentSnackBar();
                                            _model.isDataUploading_uploadData5vy = false;
                                          }
                                          if (selectedUploadedFiles.length ==
                                              selectedMedia.length &&
                                              downloadUrls.length ==
                                                  selectedMedia.length) {
                                            safeSetState(() {
                                              _model.uploadedLocalFile_uploadData5vy =
                                                  selectedUploadedFiles.first;
                                              _model.uploadedFileUrl_uploadData5vy =
                                                  downloadUrls.first;
                                            });
                                            showUploadMessage(
                                                context, 'Success!');
                                          } else {
                                            safeSetState(() {});
                                            showUploadMessage(
                                                context, 'Failed to upload data');
                                            return;
                                          }
                                        }
                                      },
                                    ),
                                    Expanded(
                                      child: TextFormField(
                                        controller:
                                        _model.messageBoxTextController,
                                        focusNode: _model.messageBoxFocusNode,
                                        onChanged: (_) => EasyDebounce.debounce(
                                          '_model.messageBoxTextController',
                                          Duration(milliseconds: 0),
                                              () => safeSetState(() {}),
                                        ),
                                        autofocus: false,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          hintText: 'Type a message...',
                                          hintStyle: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                            fontFamily: 'Inter',
                                            color:
                                            FlutterFlowTheme.of(context)
                                                .secondaryText,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: FlutterFlowTheme.of(context)
                                                  .containerBG,
                                              width: 0.0,
                                            ),
                                            borderRadius:
                                            BorderRadius.circular(20.0),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFF4DABF7),
                                              width: 0.0,
                                            ),
                                            borderRadius:
                                            BorderRadius.circular(20.0),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0x00000000),
                                              width: 0.0,
                                            ),
                                            borderRadius:
                                            BorderRadius.circular(20.0),
                                          ),
                                          focusedErrorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0x00000000),
                                              width: 0.0,
                                            ),
                                            borderRadius:
                                            BorderRadius.circular(20.0),
                                          ),
                                          filled: true,
                                          fillColor: FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                          contentPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              16.0, 12.0, 40.0, 12.0),
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                          fontFamily: 'Inter',
                                          fontSize: 16.0,
                                        ),
                                        maxLines: null,
                                        minLines: 1,
                                        validator: _model
                                            .messageBoxTextControllerValidator
                                            .asValidator(context),
                                      ),
                                    ),
                                    // FlutterFlowIconButton(
                                    //   borderRadius: 20.0,
                                    //   buttonSize: 40.0,
                                    //   fillColor:
                                    //   FlutterFlowTheme.of(context).primary,
                                    //   disabledColor: FlutterFlowTheme.of(context)
                                    //       .containerBG,
                                    //   icon: Icon(
                                    //     Icons.send,
                                    //     color: FlutterFlowTheme.of(context).info,
                                    //     size: 20.0,
                                    //   ),
                                    //   onPressed: ((_model.uploadedFileUrl_uploadData5vy ==
                                    //       null ||
                                    //       _model.uploadedFileUrl_uploadData5vy == '') &&
                                    //       (_model.messageBoxTextController
                                    //           .text ==
                                    //           null ||
                                    //           _model.messageBoxTextController
                                    //               .text ==
                                    //               ''))
                                    //       ? null
                                    //       : () async {
                                    //     await ChatsMessagesRecord.createDoc(
                                    //         widget.reciveChats!)
                                    //         .set(
                                    //         createChatsMessagesRecordData(
                                    //           message: _model
                                    //               .messageBoxTextController
                                    //               .text,
                                    //           timeSpam: getCurrentTimestamp,
                                    //           uidOfSender: currentUserReference,
                                    //           nameOfSender:
                                    //           currentUserDisplayName,
                                    //           image: _model.uploadedFileUrl_uploadData5vy,
                                    //         ));
                                    //
                                    //     await widget.reciveChats!.update({
                                    //       ...createChatsRecordData(
                                    //         lastMessage: _model
                                    //             .messageBoxTextController
                                    //             .text,
                                    //         lastMessageTime:
                                    //         getCurrentTimestamp,
                                    //       ),
                                    //       ...mapToFirestore(
                                    //         {
                                    //           'lastMessagesSeenBy':
                                    //           FieldValue.delete(),
                                    //         },
                                    //       ),
                                    //     });
                                    //
                                    //     await widget.reciveChats!.update({
                                    //       ...mapToFirestore(
                                    //         {
                                    //           'lastMessagesSeenBy':
                                    //           FieldValue.arrayUnion([
                                    //             currentUserReference
                                    //           ]),
                                    //         },
                                    //       ),
                                    //     });
                                    //     safeSetState(() {
                                    //       _model.messageBoxTextController
                                    //           !.clear();
                                    //       _model.uploadedFileUrl_uploadData5vy = '';
                                    //       _model.uploadedLocalFile_uploadData5vy =
                                    //           FFUploadedFile(
                                    //             bytes: Uint8List.fromList([]),
                                    //             originalFilename: '',
                                    //           );
                                    //     });
                                    //   },
                                    // ),
                                    FlutterFlowIconButton(
                                      borderRadius: 20.0,
                                      buttonSize: 40.0,
                                      fillColor: FlutterFlowTheme.of(context).primary,
                                      disabledColor: FlutterFlowTheme.of(context).containerBG,
                                      icon: Icon(
                                        Icons.send,
                                        color: FlutterFlowTheme.of(context).info,
                                        size: 20.0,
                                      ),
                                      onPressed: ((_model.uploadedFileUrl_uploadData5vy == null ||
                                          _model.uploadedFileUrl_uploadData5vy == '') &&
                                          (_model.messageBoxTextController.text == null ||
                                              _model.messageBoxTextController.text == ''))
                                          ? null
                                          : () async {
                                        // 1. Save the message to Firestore
                                        await ChatsMessagesRecord.createDoc(widget.reciveChats!)
                                            .set(createChatsMessagesRecordData(
                                          message: _model.messageBoxTextController.text,
                                          timeSpam: getCurrentTimestamp,
                                          uidOfSender: currentUserReference,
                                          nameOfSender: currentUserDisplayName,
                                          image: _model.uploadedFileUrl_uploadData5vy,
                                        ));

                                        // 2. Update chat document - THIS AUTOMATICALLY TRIGGERS THE FIREBASE FUNCTION
                                        await widget.reciveChats!.update({
                                          'lastMessage': _model.messageBoxTextController.text,
                                          'lastMessageTime': getCurrentTimestamp,
                                          'lastMessageSenderId': currentUserUid, // ← THIS IS CRITICAL
                                          'lastMessageSenderName': currentUserDisplayName, // ← ADD THIS LINE
                                          // Issue 2 Fix: Reset seen-by to ONLY the sender so the recipient
                                          // gets the unread dot badge on their bottom nav Chat icon
                                          'lastMessagesSeenBy': [currentUserReference],
                                        });


                                        // 3. Clear input
                                        safeSetState(() {
                                          _model.messageBoxTextController!.clear();
                                          _model.uploadedFileUrl_uploadData5vy = '';
                                          _model.uploadedLocalFile_uploadData5vy = FFUploadedFile(
                                            bytes: Uint8List.fromList([]),
                                            originalFilename: '',
                                          );
                                        });
                                        print('✅ Message sent with sender ID: $currentUserUid');

                                        print('✅ Message sent. Firebase will send notification automatically.');
                                      },
                                    ),                                  ].divide(SizedBox(width: 8.0)),
                                ),
                              ),
                            ),
                          ),
                        ),
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



class NotificationTestWidget extends StatelessWidget {
  static String routeName = 'Notifiction-Test-widget';
  static String routePath = '/notificationTestWidget';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: _testNotificationSetup,
          child: Text('Test Notification Setup'),
        ),
        ElevatedButton(
          onPressed: _checkFCMToken,
          child: Text('Check FCM Token'),
        ),
        ElevatedButton(
          onPressed: _requestPermission,
          child: Text('Request Permission'),
        ),
      ],
    );
  }

  Future<void> _testNotificationSetup() async {
    try {
      // Test 1: Check Firebase Messaging instance
      final messaging = FirebaseMessaging.instance;
      print('✅ FirebaseMessaging instance available');

      // Test 2: Check permissions
      final settings = await messaging.getNotificationSettings();
      print('📱 Notification Settings: $settings');

      // Test 3: Get FCM token
      final token = await messaging.getToken();
      print('🔑 FCM Token: ${token ?? "No token"}');

      // Test 4: Check if app can receive notifications
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        print('📨 Foreground Message Received: ${message.notification?.title}');
      });

      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        print('📱 App opened from notification: ${message.data}');
      });

      print('✅ Notification setup appears to be working');
    } catch (e) {
      print('❌ Notification setup error: $e');
    }
  }

  Future<void> _checkFCMToken() async {
    try {
      final token = await FirebaseMessaging.instance.getToken();
      print('🔑 Current FCM Token: $token');

      if (token == null) {
        print('⚠️ No FCM token received. Possible issues:');
        print('   - Firebase not initialized properly');
        print('   - Missing google-services.json/GoogleService-Info.plist');
        print('   - Internet connection issues');
      } else {
        print('✅ FCM Token obtained successfully');

        // Check if token is being saved to user document
        final currentUser = FirebaseAuth.instance.currentUser;
        if (currentUser != null) {
          final userDoc = await FirebaseFirestore.instance
              .collection('users')
              .doc(currentUser.uid)
              .get();

          final userData = userDoc.data();
          final savedTokens = userData?['fcmTokens'] as List<dynamic>? ?? [];
          final hasToken = savedTokens.contains(token);

          print('📄 Token saved in Firestore: ${hasToken ? "✅" : "❌"}');
        }
      }
    } catch (e) {
      print('❌ Error getting FCM token: $e');
    }
  }

  Future<void> _requestPermission() async {
    try {
      final settings = await FirebaseMessaging.instance.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      print('🔔 Permission Status:');
      print('   Alert: ${settings.alert}');
      print('   Badge: ${settings.badge}');
      print('   Sound: ${settings.sound}');
      print('   Authorization status: ${settings.authorizationStatus}');

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        print('✅ Notification permission granted');
      } else {
        print('⚠️ Notification permission not fully granted');
      }
    } catch (e) {
      print('❌ Permission request error: $e');
    }
  }
}



class NotificationTestDialog extends StatefulWidget {
  @override
  _NotificationTestDialogState createState() => _NotificationTestDialogState();
}

class _NotificationTestDialogState extends State<NotificationTestDialog> {
  String _status = 'Testing...';
  String _fcmToken = '';
  bool _isTesting = false;
  String _testResult = '';
  List<String> _logs = [];

  @override
  void initState() {
    super.initState();
    _testNotificationSetup();

    // Set up notification listeners
    _setupNotificationListeners();
  }

  void _setupNotificationListeners() {
    // Listen for foreground notifications
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _addLog('📨 Foreground notification received!');
      _addLog('Title: ${message.notification?.title}');
      _addLog('Body: ${message.notification?.body}');

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('📨 Received: ${message.notification?.title}'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 3),
          ),
        );
      }
    });

    // Listen for when app is opened from notification
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _addLog('📱 App opened from notification');
      _addLog('Data: ${message.data}');
    });
  }

  void _addLog(String message) {
    setState(() {
      _logs.insert(0, '${DateTime.now().toString().substring(11, 19)}: $message');
      if (_logs.length > 10) _logs.removeLast();
    });
    print(message);
  }

  Future<void> _testNotificationSetup() async {
    setState(() => _isTesting = true);
    _addLog('Starting notification test...');

    try {
      // Get FCM token
      final token = await FirebaseMessaging.instance.getToken();
      _fcmToken = token ?? 'No token';

      if (token != null) {
        _addLog('✅ FCM Token: ${token}...');
        _addLog('✅ Token length: ${token.length} chars');

        // Check permissions
        final settings = await FirebaseMessaging.instance.getNotificationSettings();
        _addLog('📱 Authorization: ${settings.authorizationStatus}');

        setState(() {
          _status = '✅ Ready!\nToken: ${token.substring(0, 20)}...';
        });

      } else {
        _addLog('❌ No FCM token received');
        setState(() => _status = '❌ No token received');
      }

    } catch (e) {
      _addLog('❌ Error: $e');
      setState(() => _status = '❌ Error: ${e.toString()}');
    } finally {
      setState(() => _isTesting = false);
    }
  }

  Future<void> _sendTestNotification() async {
    if (_fcmToken.isEmpty) {
      _showResult('❌ No FCM token available');
      return;
    }

    setState(() {
      _isTesting = true;
      _testResult = 'Sending test notification...';
      _addLog('Creating test notification in Firestore...');
    });

    try {
      // Now this should work since we fixed Firestore rules
      await FirebaseFirestore.instance.collection('test_notifications').add({
        'token': _fcmToken,
        'title': '🔔 Test Notification',
        'body': 'Hello from Travia App!',
        'timestamp': FieldValue.serverTimestamp(),
        'status': 'pending',
        'sentBy': FirebaseAuth.instance.currentUser?.uid,
      });

      _addLog('✅ Test notification queued in Firestore');
      _showResult('✅ Test notification queued!\nIf Cloud Function is set up, it will be sent.');

      // Also show Firebase Console instructions
      _showFirebaseConsoleInstructions();

    } catch (e) {
      _addLog('❌ Firestore error: $e');
      _showResult('❌ Firestore error: $e\n\nCheck your Firestore rules.');

      // Still show Firebase Console option
      _showFirebaseConsoleInstructions();
    } finally {
      setState(() => _isTesting = false);
    }
  }
  Future<Map<String, dynamic>> _sendTestViaCloudFunction(String token) async {
    try {
      // Try to create a test notification document in Firestore
      // This will trigger a Cloud Function if you have one set up
      await FirebaseFirestore.instance.collection('test_notifications').add({
        'token': token,
        'title': '🔔 Test Notification',
        'body': 'This is a test notification from Travia App!',
        'timestamp': FieldValue.serverTimestamp(),
        'type': 'test',
        'status': 'pending',
      });

      return {
        'success': true,
        'message': 'Test queued. If Cloud Function is set up, notification will be sent.'
      };

    } catch (e) {
      return {
        'success': false,
        'message': 'Firestore error: $e. Use Firebase Console to send test.'
      };
    }
  }

  void _showFirebaseConsoleInstructions() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('📱 Send Test via Firebase Console'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Your FCM Token:'),
              SizedBox(height: 8),
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: SelectableText(
                  _fcmToken,
                  style: TextStyle(fontSize: 9, fontFamily: 'monospace'),
                ),
              ),
              SizedBox(height: 16),
              Text('Steps:', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              _buildStep(1, 'Go to Firebase Console'),
              _buildStep(2, 'Select "traviaapp" project'),
              _buildStep(3, 'Go to Cloud Messaging'),
              _buildStep(4, 'Click "Send your first message"'),
              _buildStep(5, 'Click "Send test message"'),
              _buildStep(6, 'Paste the token above'),
              _buildStep(7, 'Add Title: "Test Notification"'),
              _buildStep(8, 'Add Body: "Hello from Travia!"'),
              _buildStep(9, 'Click "Test"'),
              SizedBox(height: 16),
              Text('This will send a real notification instantly!'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
          TextButton(
            onPressed: () {
              Clipboard.setData(ClipboardData(text: _fcmToken));
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('✅ Token copied!')),
              );
              Navigator.pop(context);
            },
            child: Text('Copy Token'),
          ),
        ],
      ),
    );
  }

  Widget _buildStep(int number, String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                '$number',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          ),
          SizedBox(width: 8),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }

  void _showResult(String message) {
    setState(() {
      _testResult = message;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status Card
            Card(
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.info, color: Colors.blue, size: 18),
                        SizedBox(width: 8),
                        Text('Status', style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                    SizedBox(height: 8),
                    _isTesting
                        ? Row(children: [
                      // CircularProgressIndicator(: 16),
                      SizedBox(width: 8),
                      Text('Testing...')
                    ])
                        : Text(
                      _status,
                      style: TextStyle(
                        color: _status.contains('✅') ? Colors.green :
                        _status.contains('❌') ? Colors.red : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Logs
            if (_logs.isNotEmpty) ...[
              SizedBox(height: 12),
              Card(
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.list, color: Colors.grey, size: 18),
                          SizedBox(width: 8),
                          Text('Event Logs', style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                      SizedBox(height: 8),
                      Container(
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: EdgeInsets.all(8),
                        child: ListView.builder(
                          reverse: true,
                          itemCount: _logs.length,
                          itemBuilder: (context, index) => Text(
                            _logs[index],
                            style: TextStyle(fontSize: 10, fontFamily: 'monospace'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],

            // Test Result
            if (_testResult.isNotEmpty) ...[
              SizedBox(height: 12),
              Card(
                color: _testResult.contains('✅') ? Colors.green[50] :
                _testResult.contains('❌') ? Colors.red[50] : Colors.yellow[50],
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Test Result:', style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(height: 8),
                      Text(_testResult),
                    ],
                  ),
                ),
              ),
            ],

            SizedBox(height: 16),

            // Buttons Section
            Column(
              children: [
                // Send Test Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    icon: Icon(Icons.notifications_active, size: 20),
                    label: Text('Send Test Notification'),
                    onPressed: _isTesting ? null : _sendTestNotification,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF283B5E), // Your app color
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 12),

                // Row of small buttons
                Row(
                  children: [
                    // Copy Token Button
                    Expanded(
                      child: OutlinedButton.icon(
                        icon: Icon(Icons.copy, size: 16),
                        label: Text('Copy Token'),
                        onPressed: _fcmToken.isEmpty || _fcmToken == 'No token'
                            ? null
                            : () {
                          Clipboard.setData(ClipboardData(text: _fcmToken));
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('✅ Token copied!'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(width: 12),

                    // Firebase Console Button
                    Expanded(
                      child: OutlinedButton.icon(
                        icon: Icon(Icons.open_in_browser, size: 16),
                        label: Text('Open Console'),
                        onPressed: _fcmToken.isEmpty || _fcmToken == 'No token'
                            ? null
                            : _showFirebaseConsoleInstructions,
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 12),

                // Retest Button
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    icon: Icon(Icons.refresh, size: 16),
                    label: Text('Refresh Status'),
                    onPressed: _isTesting ? null : _testNotificationSetup,
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 16),

            // Quick Instructions
            Card(
              elevation: 0,
              color: Colors.blue[50],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '💡 How to Test Notifications:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF283B5E),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '1. Click "Send Test Notification" above\n'
                          '2. If that doesn\'t work, click "Open Console"\n'
                          '3. Copy the FCM token\n'
                          '4. Go to Firebase Console → Cloud Messaging\n'
                          '5. Send test message with the token\n'
                          '6. Check your device for notification',
                      style: TextStyle(fontSize: 13),
                    ),
                  ],
                ),
              ),
            ),

            // Token Preview
            if (_fcmToken.isNotEmpty && _fcmToken != 'No token') ...[
              SizedBox(height: 16),
              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: Colors.grey[300]!),
                ),
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '🔑 FCM Token:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Colors.grey[700],
                        ),
                      ),
                      SizedBox(height: 8),
                      GestureDetector(
                        onTap: () {
                          Clipboard.setData(ClipboardData(text: _fcmToken));
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('✅ Token copied!')),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.grey[50],
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey[200]!),
                          ),
                          child: SelectableText(
                            _fcmToken,
                            style: TextStyle(
                              fontSize: 9,
                              fontFamily: 'monospace',
                              color: Colors.grey[800],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Tap to copy full token',
                        style: TextStyle(fontSize: 10, color: Colors.grey[500]),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
// Add this import at top of your file
