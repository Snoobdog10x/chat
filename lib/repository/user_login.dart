import 'package:chat/abstract/abstract_event.dart';
import 'package:chat/abstract/abstract_exception.dart';
import 'package:chat/abstract/appstore.dart';

import '../abstract/abstract_repository.dart';

class UserLoginInputEvent extends InputEvent {
  String email;
  String password;
  UserLoginInputEvent(this.email, this.password);
}

class UserLoginOutputEvent extends OutputEvent {}

abstract mixin class UserLogin {
  AppStore get appStore;

  void requestUserLogin(UserLoginInputEvent inputEvent) async {
    UserLoginOutputEvent outputEvent = UserLoginOutputEvent();
    try {
      var email = inputEvent.email;
      var password = inputEvent.password;
      await appStore.userService.login(email, password);
      responseUserLogin(outputEvent);
    } on AbstractException catch (e) {
      outputEvent.exception = e;
      responseUserLogin(outputEvent);
    }
  }

  void responseUserLogin(UserLoginOutputEvent outputEvent);
}
