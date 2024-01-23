import 'package:flutter_chat_app/models/group_chat.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GroupChatNotifier extends StateNotifier<GroupChat> {
  GroupChatNotifier()
      : super(
          GroupChat(
            id: '',
            name: '',
            image: '',
          ),
        );

  void setGroupChat({
    required String id,
    required String name,
    required String image,
  }) {
    final newGroupChat = GroupChat(
      id: id,
      name: name,
      image: image,
    );

    state = newGroupChat;
  }
}

final groupChatProvider = StateNotifierProvider<GroupChatNotifier, GroupChat>(
  (ref) => GroupChatNotifier(),
);
