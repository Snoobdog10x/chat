import 'package:chat/abstract/abstract_bloc.dart';
import 'package:chat/repository/user_signup.dart';
import 'package:chat/screen/home_chat/home_chat.dart';
import 'package:chat/screen/signin/signin.dart';

class SignInBloc extends AbstractBloc<SignInState> with UserSignup {
  String email = "";
  String password = "";
  String firstName = "Nguyen";
  String lastName = "Thanh";
  void signup() {
    state.startLoading();
    if (email.isEmpty || password.isEmpty) {
      state.showAlertDialog(
        title: "Register",
        content: "Please input email and password",
        confirm: () {
          state.popScreen();
        },
      );
      return;
    }

    var inputEvent = UserSignupInputEvent(email, password, firstName, lastName);
    requestUserSignup(inputEvent);
  }

  @override
  void responseUserSignup(UserSignupOutputEvent outputEvent) {
    state.stopLoading();
    if (outputEvent.exception != null) {
      state.showAlertDialog(
        title: "Register",
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
