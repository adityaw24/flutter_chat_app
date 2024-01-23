import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/widget/message_bubble.dart';

final _firebaseFirestore = FirebaseFirestore.instance;
final _firebaseAuth = FirebaseAuth.instance;

class GroupChatMessage extends StatelessWidget {
  const GroupChatMessage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final authUser = _firebaseAuth.currentUser!;

    return StreamBuilder(
      stream: _firebaseFirestore
          .collection('group-chat')
          // .where('partnerId', isEqualTo: partnerId)
          // .where('userId', isEqualTo: authUser.uid)
          .orderBy(
            'createdAt',
            descending: true,
          )
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text('No message'),
          );
        }

        if (snapshot.hasError) {
          return const Center(
            child: Text('Something went wrong'),
          );
        }

        final loadedMessage = snapshot.data!.docs;

        return ListView.builder(
          padding: const EdgeInsets.only(
            bottom: 40,
            left: 15,
            right: 15,
          ),
          reverse: true,
          itemCount: loadedMessage.length,
          itemBuilder: (context, index) {
            final chatMessage = loadedMessage[index].data();
            final nextChatMessage = index + 1 < loadedMessage.length
                ? loadedMessage[index + 1].data()
                : null;

            final currentMessageUserId = chatMessage['userId'];
            final nextMessageUserId =
                nextChatMessage != null ? nextChatMessage['userId'] : null;
            final nextUserIsSame = nextMessageUserId == currentMessageUserId;

            if (nextUserIsSame) {
              return MessageBubble.next(
                message: chatMessage['text'],
                isMe: authUser.uid == currentMessageUserId,
              );
            } else {
              return MessageBubble.first(
                userImage: chatMessage['userImage'],
                username: chatMessage['username'],
                message: chatMessage['text'],
                isMe: authUser.uid == currentMessageUserId,
              );
            }
          },
        );
      },
    );
  }
}
