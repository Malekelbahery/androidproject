import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Ver2 extends StatefulWidget {
  final email;
  final password;
  const Ver2({
    super.key, this.email, this.password,
  });

  @override
  State<Ver2> createState() => _Ver2State();
}

class _Ver2State extends State<Ver2> {
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
                Navigator.of(context).pushReplacementNamed('login');
              },
              icon: const Icon(Icons.arrow_back))
        ],
      ),
      body: Center(
        child: InkWell(
          onTap: () async {
            if (FirebaseAuth.instance.currentUser!.emailVerified) {
              Navigator.of(context).pushReplacementNamed('home');
            } else {
              if (t == 1) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    duration: Duration(seconds: 3),
                    content: Text('Error: re-create your email')));
                FirebaseAuth.instance.signOut();
                Navigator.of(context).pushReplacementNamed('login');
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    duration: Duration(seconds: 3),
                    content: Text('Please check your email')));
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
              'Tap to Next page',
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
