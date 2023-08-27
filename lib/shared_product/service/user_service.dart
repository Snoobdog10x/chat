import 'dart:convert';

import 'package:chat/abstract/abstract_exception.dart';
import 'package:chat/abstract/abstract_service.dart';
import 'package:chat/shared_product/service/local_storage_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

import '../../repository/user_retrieve.dart';

class UserService extends AbstractService with UserRetrieve {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> login(String email, String password) async {
    try {
      if (isLogged()) {
        var inputEvent = UserRetrieveInputEvent(_auth.currentUser!.uid);
        requestUserRetrieve(inputEvent);
        return true;
      }

      var credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      var user = credential.user;
      if (user != null) {
        var inputEvent = UserRetrieveInputEvent(user.uid);
        requestUserRetrieve(inputEvent);
        return true;
      }

      return false;
    } on FirebaseAuthException catch (e) {
      var code = e.code;
      var message = _getMessageFromErrorCode(code);
      throw UnCatchException(message);
    }
  }

  Future<bool> signup(
    String email,
    String password, {
    String firstName = "",
    String lastName = "",
    String avatar = "",
  }) async {
    try {
      var credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user != null) {
        await appStore.chatService.createUserInFirestore(
          types.User(
            firstName: firstName,
            id: credential.user!.uid,
            imageUrl:
                'https://firebasestorage.googleapis.com/v0/b/chat-6e0a4.appspot.com/o/avatar%2Fdefault%2Fdefault.jpg?alt=media&token=5938d8c8-94bc-4378-94af-e9d6f56bfe97',
            lastName: lastName,
          ),
        );
        return true;
      }

      return false;
    } on FirebaseAuthException catch (e) {
      var code = e.code;
      var message = _getMessageFromErrorCode(code);
      throw UnCatchException(message);
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
    appStore.localStorageService.clearCache();
  }

  bool isLogged() {
    return _auth.currentUser != null;
  }

  types.User? currentUser() {
    var userString = appStore.localStorageService.getCache(CacheKey.LOCAL_USER);
    if (userString.isEmpty) return null;
    return types.User.fromJson(jsonDecode(userString));
  }

  @override
  Future<void> boot() async {
    await FirebaseAuth.instance.setPersistence(Persistence.LOCAL);
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }

  String _getMessageFromErrorCode(String code) {
    switch (code) {
      case "ERROR_EMAIL_ALREADY_IN_USE":
      case "account-exists-with-different-credential":
      case "email-already-in-use":
        return "Email already used. Go to login page.";

      case "ERROR_WRONG_PASSWORD":
      case "wrong-password":
        return "Wrong email/password combination.";

      case "ERROR_USER_NOT_FOUND":
      case "user-not-found":
        return "No user found with this email.";

      case "ERROR_USER_DISABLED":
      case "user-disabled":
        return "User disabled.";

      case "ERROR_TOO_MANY_REQUESTS":
      case "operation-not-allowed":
        return "Too many requests to log into this account.";

      case "ERROR_OPERATION_NOT_ALLOWED":
      case "operation-not-allowed":
        return "Server error, please try again later.";

      case "ERROR_INVALID_EMAIL":
      case "invalid-email":
        return "Email address is invalid.";

      default:
        return "Login failed. Please try again.";
    }
  }

  @override
  void responseUserRetrieve(UserRetrieveOutputEvent outputEvent) {
    if (outputEvent.exception != null) {
      print(outputEvent.exception!.message);
      return;
    }

    appStore.localStorageService.setCache(
      CacheKey.LOCAL_USER,
      jsonEncode(outputEvent.user!.toJson()),
    );
  }
}
