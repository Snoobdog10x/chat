import 'package:chat/abstract/abstract_bloc.dart';
import 'package:chat/screen/home_chat/home_chat.dart';
import 'package:chat/screen/login/login.dart';

import '../../repository/user_login.dart';

class LoginBloc extends AbstractBloc<LoginState> with UserLogin {
  String email = "";
  String password = "";

  void login() {
    if (email.isEmpty || password.isEmpty) {
      state.showAlertDialog(
        title: "Login",
        content: "Please input email and password",
        confirm: () {
          state.popScreen();
        },
      );
      return;
    }
    state.startLoading();
    var inputEvent = UserLoginInputEvent(email, password);
    requestUserLogin(inputEvent);
  }

  @override
  void responseUserLogin(UserLoginOutputEvent outputEvent) {
    state.stopLoading();
    if (outputEvent.exception != null) {
      state.showAlertDialog(
        title: "Login",
        content: outputEvent.exception!.message,
        confirm: () {
          state.popScreen();
        },
      );
      return;
    }

    state.pushToScreen(HomeChat(), isReplace: true);
  }
}
