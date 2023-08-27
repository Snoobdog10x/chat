import 'package:chat/abstract/abstract_bloc.dart';
import 'package:chat/screen/chat_room/chat_room.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class ChatRoomBloc extends AbstractBloc<ChatRoomState> {
  late types.User user = appStore.userService.currentUser();
}
