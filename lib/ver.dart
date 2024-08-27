import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Ver extends StatefulWidget {
  final email;
  final password;

  const Ver({
    super.key,
    this.email,
    this.password,
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
          onTap: () async {
            try {
              final f0 = FirebaseAuth.instance;
              final f1 = FirebaseAuth.instance.currentUser;
              final usercridint = await f0.createUserWithEmailAndPassword(
                  email: widget.email, password: widget.password);
              await usercridint.user!.sendEmailVerification();
            } on FirebaseAuthException catch (e) {
              if (e.code == 'weak-password') {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  duration: Duration(seconds: 3),
                  content: Text('The password provided is too weak.'),
                ));
              } else if (e.code == 'email-already-in-use') {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    duration: Duration(seconds: 3),
                    content: Text(
                        'The account already exists for that email.')));
              }
            } catch (e) {
              SnackBar(
                content: Text('$e'),
              );
            }
            setState(() {});
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
