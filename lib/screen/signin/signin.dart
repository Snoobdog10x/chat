import 'package:chat/abstract/abstract_state.dart';
import 'package:chat/screen/home_chat/home_chat.dart';
import 'package:chat/screen/signin/signin_bloc.dart';
import 'package:flutter/material.dart';

import '../../shared_product/widget/text_input.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => SignInState();
}

class SignInState extends AbstractState<SignIn> {
  SignInBloc bloc = SignInBloc();
  @override
  bool get secure => false;

  @override
  void onCreate() {
    if (isLogged) {
      pushToScreen(HomeChat());
    }
  }

  @override
  Widget build(BuildContext context) {
    return buildScreen(
      appBarTitle: "Register",
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
              "Register",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(height: 4),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              "Enter your email password to create new account",
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
          buildButton("Submit", () {
            bloc.signup();
          }),
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

  Widget buildTextField(
    String hintText, {
    bool isPasswordField = false,
  }) {
    return TextFormField(
      obscureText: isPasswordField,
      decoration: InputDecoration(
        hintText: hintText,
      ),
    );
  }
}
