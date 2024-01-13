import 'package:eploy/HomeScreen.dart';
import 'package:eploy/Onboard.dart';
import 'package:eploy/SigninScreen.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    User? user = FirebaseAuth.instance.currentUser;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HOMIO',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: user == null ? const Onboard() : const HomeScreen(),
    );
  }
}

