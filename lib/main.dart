import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:untitled/ver.dart';
import 'package:untitled/ver2.dart';
import 'login.dart';
import 'register.dart';
import 'home.dart';

bool t = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyDBtZ_NBAmfYOFshE7OZ68F15Kek7ypPgk",
          appId: "com.example.untitled",
          messagingSenderId: "258475356217",
          projectId: "test-e7939"));
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('===============================User is currently signed out!');
      } else {
        print('===============================User is signed in!');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: FirebaseAuth.instance.currentUser != null &&
              FirebaseAuth.instance.currentUser!.emailVerified
          ? const Home()
          : Login(),
      routes: {
        'login': (context) => Login(),
        'register': (context) => const Register(),
        'home': (context) => const Home(),
        'ver' : (context) => const Ver(),
        'ver2' : (context) => const Ver2(),
      },
    );
  }
}
