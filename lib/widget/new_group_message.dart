import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

final _firebaseAuth = FirebaseAuth.instance;
final _firebaseStorage = FirebaseStorage.instance;
final _firebaseFirestore = FirebaseFirestore.instance;

class NewGroupMessage extends StatefulWidget {
  const NewGroupMessage({
    super.key,
    required this.groupId,
  });

  final String groupId;

  @override
  State<NewGroupMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewGroupMessage> {
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _submitMessage() async {
    final enteredMessage = _messageController.text;

    if (enteredMessage.trim().isEmpty) {
      return;
    }

    _messageController.clear();
    FocusScope.of(context).unfocus();

    final user = _firebaseAuth.currentUser!;
    final userData =
        await _firebaseFirestore.collection('users').doc(user.uid).get();

    await _firebaseFirestore.collection('group-chat').add({
      'text': enteredMessage,
      'userId': user.uid,
      // 'partnerId': widget.partnerId,
      'groupId': widget.groupId,
      'username': userData.data()!['username'],
      'userImage': userData.data()!['image'],
      'createdAt': Timestamp.now(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15, left: 15, right: 1),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              textCapitalization: TextCapitalization.sentences,
              enableSuggestions: true,
              decoration: const InputDecoration(
                labelText: 'Send a message...',
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              _submitMessage();
            },
            color: Theme.of(context).colorScheme.primary,
            icon: const Icon(Icons.send),
          ),
        ],
      ),
    );
  }
}
