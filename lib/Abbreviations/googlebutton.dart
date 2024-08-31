import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Googlebutton extends StatefulWidget {
  const Googlebutton({super.key});

  @override
  State<Googlebutton> createState() => _GooglebuttonState();
}

class _GooglebuttonState extends State<Googlebutton> {
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        signInWithGoogle();
        Navigator.of(context).pushReplacementNamed('home');
      },
      child: Container(
        padding: const EdgeInsets.all(5),
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                padding: const EdgeInsets.all(7),
                width: 40,
                height: 40,
                decoration:const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                ),
                child: Image.asset(
                  'images/G40.png',
                  fit: BoxFit.cover,
                )),
            const Text(
              '  Sign In With Google  ',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
