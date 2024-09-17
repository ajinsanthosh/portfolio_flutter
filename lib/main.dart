// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyA9QOrR3UmCNO1N19nGPvOdWV74V4ppcqM",
            authDomain: "adithyan-r.firebaseapp.com",
            projectId: "adithyan-r",
            storageBucket: "adithyan-r.appspot.com",
            messagingSenderId: "430092930297",
            appId: "1:430092930297:web:32a6b954045542ce50e628"));
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Adithyan R',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: customPrimaryColor,
        scaffoldBackgroundColor: Colors.black,
        primaryColor: const Color(0xFFff9800),
        iconTheme: const IconThemeData(color: Color(0xFFff9800)),
        buttonTheme: const ButtonThemeData(
          textTheme: ButtonTextTheme.primary,
          buttonColor: Color(0xFFff9800),
        ),
        textTheme: GoogleFonts.poppinsTextTheme().apply(
          bodyColor: Colors.white,
          displayColor: Colors.white,
        ),
      ),
      home: const HomeScrn(),
    );
  }
}
