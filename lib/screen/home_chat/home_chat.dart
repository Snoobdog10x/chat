import 'package:chat/abstract/abstract_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';

import '../../abstract/abstract_state.dart';
import 'home_chat_bloc.dart';

class HomeChat extends StatefulWidget {
  const HomeChat({super.key});

  @override
  AbstractState<HomeChat> createState() => HomeChatState();
}

class HomeChatState extends AbstractState<HomeChat> {
  @override
  HomeChatBloc bloc = HomeChatBloc();

  @override
  void onCreate() {}

  @override
  Widget build(BuildContext context) {
    return buildScreen(
      body: Container(),
    );
  }
}
