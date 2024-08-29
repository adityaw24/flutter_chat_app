import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/screen/group_chat_screen.dart';

final _firebaseAuth = FirebaseAuth.instance;
final _firebaseStorage = FirebaseStorage.instance;
final _firebaseFirestore = FirebaseFirestore.instance;

class ListGroup extends StatefulWidget {
  const ListGroup({super.key});

  @override
  State<ListGroup> createState() => _ListChatState();
}

class _ListChatState extends State<ListGroup> {
  @override
  Widget build(BuildContext context) {
    // final authUser = _firebaseAuth.currentUser!;

    void goChat(String groupId, String groupName) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => GroupChatScreen(
            groupId: groupId,
            groupName: groupName,
          ),
        ),
      );
    }

    return StreamBuilder(
      stream: _firebaseFirestore
          .collection('list-group')
          // .where(FieldPath.documentId, isNotEqualTo: authUser.uid)
          .orderBy(
            'name',
            descending: false,
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
            child: Text('No group found!'),
          );
        }

        if (snapshot.hasError) {
          return const Center(
            child: Text('Something went wrong'),
          );
        }

        final loadedGroup = snapshot.data!.docs;

        return ListView.builder(
          // padding: const EdgeInsets.only(
          //   bottom: 40,
          //   left: 15,
          //   right: 15,
          // ),
          itemCount: loadedGroup.length,
          itemBuilder: (context, index) {
            final groups = loadedGroup[index].data();

            return Padding(
              padding: const EdgeInsets.symmetric(
                // horizontal: 15,
                vertical: 8,
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                    groups['image'],
                  ),
                  backgroundColor:
                      Theme.of(context).colorScheme.primary.withAlpha(180),
                  radius: 30,
                ),
                title: Text(
                  groups['name'],
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                ),
                onTap: () {
                  goChat(loadedGroup[index].id, groups['name']);
                },
              ),
            );
          },
        );
      },
    );
  }
}
