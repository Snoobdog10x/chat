import 'package:chat/abstract/abstract_bloc.dart';
import 'package:chat/screen/home_chat/home_chat.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class HomeChatBloc extends AbstractBloc<HomeChatState> {
  types.User get currentUser => appStore.userService.currentUser();
}
