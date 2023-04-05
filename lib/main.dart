import 'dart:convert';

import 'package:eduease/layout/login.dart';
import 'package:eduease/utils/cache.dart';
import 'package:eduease/layout/on_bord.dart';
import 'package:eduease/layout/update_profile.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';
import 'layout/HomePage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await cache.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Edu Ease',
      home: cache.get_data("number")==null ? cache.get_data("otp_id")!=null ? Login(is_login: cache.get_data("is_login")): OnBord():MyHomePage(),
    );
  }
}


