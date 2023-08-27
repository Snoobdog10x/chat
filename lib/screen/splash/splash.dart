import 'package:chat/abstract/abstract_state.dart';
import 'package:chat/screen/home_chat/home_chat.dart';
import 'package:chat/screen/login/login.dart';
import 'package:chat/screen/splash/splash_bloc.dart';
import 'package:flutter/material.dart';

import '../../abstract/appstore.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => SplashState();
}

class SplashState extends AbstractState<Splash> {
  SplashBloc bloc = SplashBloc();
  @override
  bool get secure => false;

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  Future<void> onCreate() async {
    await AppStore.getAppStore().init();
    if (isLogged) {
      pushToScreen(HomeChat());
      return;
    }
    pushToScreen(Login());
  }
}
