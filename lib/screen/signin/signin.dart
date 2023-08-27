import 'package:chat/abstract/abstract_state.dart';
import 'package:chat/screen/signin/signin_bloc.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => SignInState();
}

class SignInState extends AbstractState<SignIn> {
  SignInBloc bloc = SignInBloc();
  @override
  void onCreate() {
    // TODO: implement onCreate
  }

  @override
  Widget build(BuildContext context) {
    return buildScreen(
      appBarTitle: "Register",
    );
  }

  Widget buildBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 16),
          buildTextField("Email"),
          SizedBox(height: 16),
          buildTextField("Password", isPasswordField: true),
          SizedBox(height: 16),
          Container(
            height: 35,
            width: double.maxFinite,
            child: OutlinedButton(
              onPressed: () {},
              style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.blue),
                  side: MaterialStatePropertyAll(BorderSide.none)),
              child: const Text(
                "Register",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                ),
              ),
            ),
          ),
        ],
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
