import 'package:chat/abstract/appstore.dart';
import 'package:chat/screen/home_chat/home_chat.dart';
import 'package:chat/screen/login/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await AppStore.getAppStore().init();
  runApp(
    const MaterialApp(
      home: Login(),
    ),
  );
}
