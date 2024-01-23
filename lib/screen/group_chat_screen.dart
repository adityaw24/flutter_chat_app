import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/widget/group_chat_message.dart';
import 'package:flutter_chat_app/widget/new_group_message.dart';

final _firebaseMessaging = FirebaseMessaging.instance;

class GroupChatScreen extends StatefulWidget {
  const GroupChatScreen({
    super.key,
    required this.groupId,
    required this.groupName,
  });

  final String groupId;
  final String groupName;

  @override
  State<GroupChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<GroupChatScreen> {
  void _logoutAction() {
    FirebaseAuth.instance.signOut();
  }

  void setupPushNotifications() async {
    await _firebaseMessaging.requestPermission();

    // await _firebaseMessaging.getToken();
    _firebaseMessaging.subscribeToTopic('chat');
  }

  @override
  void initState() {
    super.initState();
    setupPushNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.groupName),
        // actions: [
        //   IconButton(
        //     onPressed: () {
        //       _logoutAction();
        //     },
        //     icon: Icon(
        //       Icons.exit_to_app,
        //       color: Theme.of(context).colorScheme.primary,
        //     ),
        //   ),
        // ],
      ),
      body: Column(
        children: [
          const Expanded(
            child: GroupChatMessage(),
          ),
          NewGroupMessage(
            groupId: widget.groupId,
          ),
        ],
      ),
    );
  }
}
