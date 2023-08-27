import 'package:chat/abstract/abstract_bloc.dart';
import 'package:chat/abstract/abstract_state.dart';
import 'package:chat/screen/login/login_bloc.dart';
import 'package:chat/screen/signin/signin.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../shared_product/widget/text_input.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => LoginState();
}

class LoginState extends AbstractState<Login> {
  @override
  late LoginBloc bloc = LoginBloc();
  @override
  void onCreate() {}

  @override
  Widget build(BuildContext context) {
    return buildScreen(
      appBarTitle: "Login",
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: screenHeight * 0.17),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              "Login",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(height: 4),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              "Enter your email password to login",
            ),
          ),
          SizedBox(height: 16),
          TextInput(
            hintText: "Email",
            onTextChange: (value) {
              bloc.email = value;
            },
          ),
          SizedBox(height: 16),
          TextInput(
            hintText: "Password",
            isPasswordField: true,
            onTextChange: (value) {
              bloc.password = value;
            },
          ),
          SizedBox(height: 16),
          buildButton("Login", () {
            bloc.login();
          }),
          SizedBox(height: 16),
          buildCreateAccount()
        ],
      ),
    );
  }

  Widget buildCreateAccount() {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(text: "Don't have account? "),
          TextSpan(
            text: "Create",
            style: TextStyle(color: Colors.blue),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                pushToScreen(SignIn());
              },
          )
        ],
      ),
    );
  }

  static Widget buildButton(String text, void Function() onTap) {
    return Container(
      height: 35,
      width: double.maxFinite,
      child: OutlinedButton(
        onPressed: onTap,
        style: const ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Colors.blue),
            side: MaterialStatePropertyAll(BorderSide.none)),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}
