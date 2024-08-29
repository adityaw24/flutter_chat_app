import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/screen/chat_screen.dart';

final _firebaseAuth = FirebaseAuth.instance;
final _firebaseStorage = FirebaseStorage.instance;
final _firebaseFirestore = FirebaseFirestore.instance;

class ListContact extends StatefulWidget {
  const ListContact({super.key});

  @override
  State<ListContact> createState() => _ListChatState();
}

class _ListChatState extends State<ListContact> {
  @override
  Widget build(BuildContext context) {
    final authUser = _firebaseAuth.currentUser!;

    void goChat(String userId) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ChatScreen(userId: userId),
        ),
      );
    }

    return StreamBuilder(
      stream: _firebaseFirestore
          .collection('users')
          .where(FieldPath.documentId, isNotEqualTo: authUser.uid)
          // .orderBy(
          //   'username',
          //   descending: false,
          // )
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text('No chat found!'),
          );
        }

        if (snapshot.hasError) {
          return const Center(
            child: Text('Something went wrong'),
          );
        }

        final loadedUser = snapshot.data!.docs;

        return ListView.builder(
          // padding: const EdgeInsets.only(
          //   bottom: 40,
          //   left: 15,
          //   right: 15,
          // ),
          itemCount: loadedUser.length,
          itemBuilder: (context, index) {
            final users = loadedUser[index].data();

            return ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(
                  users['image'],
                ),
                backgroundColor:
                    Theme.of(context).colorScheme.primary.withAlpha(180),
                radius: 30,
              ),
              title: Text(
                users['username'],
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
              onTap: () {
                goChat(loadedUser[index].id);
              },
            );
          },
        );
      },
    );
  }
}
