import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Ver extends StatefulWidget {
  const Ver({
    super.key,
  });

  @override
  State<Ver> createState() => _VerState();
}

class _VerState extends State<Ver> {
  int t = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Verified your email',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('register');
              },
              icon: const Icon(Icons.arrow_back))
        ],
      ),
      body: Center(
        child: InkWell(
          onTap: () {
            setState(() {});
            if (FirebaseAuth.instance.currentUser!.emailVerified) {
              Navigator.of(context).pushReplacementNamed('home');
            } else {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  duration: Duration(seconds: 3),
                  content: Text('Please check your email')));
              if (t == 1) {
                FirebaseAuth.instance.currentUser!.delete();
                Navigator.of(context).pushReplacementNamed('login');
              }
              t++;
            }
          },
          child: Container(
            alignment: Alignment.center,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(100)),
                color: Colors.black),
            height: 40,
            width: 220,
            child: const Text(
              'Tap to Next Page',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
