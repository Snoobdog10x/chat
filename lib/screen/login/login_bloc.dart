import 'package:chat/abstract/abstract_bloc.dart';
import 'package:chat/screen/home_chat/home_chat.dart';

import '../../repository/user_login.dart';

class LoginBloc extends AbstractBloc with UserLogin {
  String email = "";
  String password = "";

  void login() {
    state.startLoading();
    var inputEvent = UserLoginInputEvent(email, password);
    requestUserLogin(inputEvent);
  }

  @override
  void responseUserLogin(UserLoginOutputEvent outputEvent) {
    state.stopLoading();
    if (outputEvent.exception != null) {
      print(outputEvent.exception);
      return;
    }

    state.pushToScreen(HomeChat());
  }
}
