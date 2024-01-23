import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/widget/list_group.dart';

final _firebaseMessaging = FirebaseMessaging.instance;

class ListGroupScreen extends StatefulWidget {
  const ListGroupScreen({super.key});

  @override
  State<ListGroupScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ListGroupScreen> {
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
        title: const Text('List Group'),
        actions: [
          IconButton(
            onPressed: () {
              _logoutAction();
            },
            icon: Icon(
              Icons.exit_to_app,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.add),
            label: const Text('New Group'),
          ),
          const SizedBox(
            height: 10,
          ),
          const Expanded(
            child: ListGroup(),
          ),
          // NewMessage(),
        ],
      ),
    );
  }
}
