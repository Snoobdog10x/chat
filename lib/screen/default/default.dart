import 'package:chat/abstract/abstract_bloc.dart';
import 'package:chat/abstract/abstract_state.dart';
import 'package:chat/screen/default/default_bloc.dart';
import 'package:flutter/material.dart';

import '../../abstract/appstore.dart';
import '../home_chat/home_chat.dart';
import '../login/login.dart';
import '../signin/signin.dart';
import '../splash/splash.dart';

class Default extends StatefulWidget {
  const Default({super.key});

  @override
  State<Default> createState() => DefaultState();
}

class DefaultState extends AbstractState<Default> {
  @override
  DefaultBloc bloc = DefaultBloc();
  @override
  bool get secure => false;

  Widget buildButton(Widget screen, String screenName) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      child: TextButton(
        onPressed: () {
          pushToScreen(screen, isReplace: true);
        },
        child: Text(screenName),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          buildButton(Splash(), "splash"),
          buildButton(Login(), "Login"),
          buildButton(SignIn(), "SignUp"),
          buildButton(HomeChat(), "Home"),
          TextButton(
            child: Text("logout"),
            onPressed: () {
              appStore.userService.logout();
            },
          ),
        ],
      ),
    );
  }

  @override
  Future<void> onCreate() async {
    await AppStore.getAppStore().init();
  }
  
  @override
  void onReady() {
    // TODO: implement onReady
  }
}
