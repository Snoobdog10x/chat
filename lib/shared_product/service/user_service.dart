import 'package:chat/abstract/abstract_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class UserService extends AbstractService {
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<bool> login(String email, String password) async {
    var credential =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    return credential.user != null;
  }

  Future<bool> signin(
    String email,
    String password, {
    String firstName = "",
    String lastName = "",
    String avatar = "",
  }) async {
    var credential = await auth.createUserWithEmailAndPassword(
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
  }

  @override
  Future<void> boot() async {
    await FirebaseAuth.instance.setPersistence(Persistence.LOCAL);
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }
}
