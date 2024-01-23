import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/widget/list_contact.dart';

final _firebaseMessaging = FirebaseMessaging.instance;

class ListContactScreen extends StatefulWidget {
  const ListContactScreen({super.key});

  @override
  State<ListContactScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ListContactScreen> {
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
        title: const Text('List Contact'),
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
      body: const Column(
        children: [
          Expanded(
            child: ListContact(),
          ),
          // NewMessage(),
        ],
      ),
    );
  }
}
