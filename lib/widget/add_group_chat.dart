import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/widget/user_image_picker.dart';

final _firebaseAuth = FirebaseAuth.instance;
final _firebaseStorage = FirebaseStorage.instance;
final _firebaseFirestore = FirebaseFirestore.instance;

class AddGroupChat extends StatefulWidget {
  const AddGroupChat({super.key});

  @override
  State<AddGroupChat> createState() => _AddGroupChatState();
}

class _AddGroupChatState extends State<AddGroupChat> {
  File? _selectedImage;
  var _enteredGroupName = '';
  bool _isSubmit = false;
  final _form = GlobalKey<FormState>();

  void _handlerSubmit() async {
    final isValid = _form.currentState!.validate();

    if (!isValid || _selectedImage == null) {
      // _closeModal();
      return;
    }

    _form.currentState!.save();

    setState(() {
      _isSubmit = true;
    });

    FocusScope.of(context).unfocus();

    final user = _firebaseAuth.currentUser!;

    final group = await _firebaseFirestore.collection('list-group').add({
      'name': _enteredGroupName,
      'image': '',
      'createdAt': Timestamp.now(),
      'createdBy': user.email,
    });
    // .catchError((onError) {
    //   ScaffoldMessenger.of(context).clearSnackBars();
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(
    //       content: Text('Failed to create new group: $onError'),
    //     ),
    //   );
    // });
    final storageRef =
        _firebaseStorage.ref().child('group-images').child('${group.id}.jpeg');

    await storageRef.putFile(_selectedImage!);
    final imageUrl = await storageRef.getDownloadURL();

    await _firebaseFirestore.collection('list-group').doc(group.id).update({
      'image': imageUrl,
    });

    setState(() {
      _isSubmit = false;
    });

    _closeModal();
  }

  void _closeModal() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final _keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    // return LayoutBuilder(
    //   builder: (context, constraints) {
    // final _width = constraints.maxWidth;

    return Padding(
      padding: EdgeInsets.fromLTRB(16, 16, 16, _keyboardSpace + 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Add New Group',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
          const SizedBox(
            height: 24,
          ),
          Form(
            key: _form,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  UserImagePicker(
                    onSelectedImage: (selectedImage) {
                      setState(() {
                        _selectedImage = selectedImage;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Group Name',
                    ),
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Enter valid group name';
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      _enteredGroupName = newValue!;
                    },
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  if (_isSubmit) const CircularProgressIndicator.adaptive(),
                  if (!_isSubmit)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            // print(_handlerAmount.text);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.secondary,
                          ),
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onSecondary,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 28,
                        ),
                        ElevatedButton(
                          onPressed: _handlerSubmit,
                          child: const Text('Save'),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
    //   },
    // );
  }
}
