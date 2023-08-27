import 'package:chat/shared_product/service/firestore_service.dart';
import 'package:chat/shared_product/service/user_service.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';

class AppStore {
  bool isReady = false;
  UserService userService = UserService();
  FireStoreService fireStoreService = FireStoreService();
  FirebaseChatCore chatService = FirebaseChatCore.instance;

  Future<void> init() async {
    await userService.boot();
    fireStoreService.boot();
  }

  static AppStore? _instance;
  AppStore._();

  static AppStore getAppStore() {
    _instance ??= AppStore._();
    return _instance!;
  }

  void dispose() {
    userService.dispose();
    fireStoreService.dispose();
  }
}
