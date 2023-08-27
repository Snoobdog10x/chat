import 'package:chat/shared_product/service/firebase_storage_service.dart';
import 'package:chat/shared_product/service/firestore_service.dart';
import 'package:chat/shared_product/service/local_storage_service.dart';
import 'package:chat/shared_product/service/user_service.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';

class AppStore {
  bool isReady = false;
  final UserService userService = UserService();
  final FireStoreService fireStoreService = FireStoreService();
  final FirebaseChatCore chatService = FirebaseChatCore.instance;
  final LocalStorageService localStorageService = LocalStorageService();
  final FirebaseStorageService firebaseStorageService =
      FirebaseStorageService();

  Future<void> init() async {
    await firebaseStorageService.boot();
    await fireStoreService.boot();
    await localStorageService.boot();
    await userService.boot();
    isReady = true;
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
