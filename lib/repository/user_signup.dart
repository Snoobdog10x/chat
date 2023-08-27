import 'package:chat/abstract/abstract_event.dart';
import 'package:chat/abstract/abstract_exception.dart';
import 'package:chat/abstract/appstore.dart';

import '../abstract/abstract_repository.dart';

class UserSignupInputEvent extends InputEvent {
  String email;
  String password;
  String firstName;
  String lastName;
  String? avatar;

  UserSignupInputEvent(
    this.email,
    this.password,
    this.firstName,
    this.lastName, {
    this.avatar,
  });
}

class UserSignupOutputEvent extends OutputEvent {}

abstract mixin class UserSignup {
  AppStore get appStore;

  void requestUserSignup(UserSignupInputEvent inputEvent) async {
    UserSignupOutputEvent outputEvent = UserSignupOutputEvent();
    try {
      var email = inputEvent.email;
      var password = inputEvent.password;
      var firstName = inputEvent.firstName;
      var lastName = inputEvent.lastName;
      await appStore.userService.signup(
        email,
        password,
        firstName: firstName,
        lastName: lastName,
      );
      responseUserSignup(outputEvent);
    } on AbstractException catch (e) {
      outputEvent.exception = e;
      responseUserSignup(outputEvent);
    }
  }

  void responseUserSignup(UserSignupOutputEvent outputEvent);
}
