import 'package:chat/screen/default/default.dart';
import 'package:chat/screen/home_chat/home_chat.dart';
import 'package:chat/screen/login/login.dart';
import 'package:chat/screen/signin/signin.dart';
import 'package:chat/screen/splash/splash.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'abstract/appstore.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // if (kDebugMode) {
  //   runApp(
  //     const MaterialApp(
  //       debugShowCheckedModeBanner: false,
  //       home: Default(),
  //     ),
  //   );
  //   return;
  // }

  runApp(
    const MaterialApp(
      home: Splash(),
    ),
  );
}
