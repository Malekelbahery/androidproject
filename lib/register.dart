import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:untitled/ver.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  int t = 0;

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

  final _emailkey1 = GlobalKey<FormState>();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool s = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sign Up',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: ListView(
            children: [
              const SizedBox(
                height: 20.0,
              ),
              SizedBox(
                  width: 120,
                  height: 120,
                  child: Image.asset(
                    'images/F100.png',
                    fit: BoxFit.contain,
                  )),
              const SizedBox(
                height: 60.0,
              ),
              Form(
                  key: _emailkey1,
                  child: Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.name,
                        controller: _name,
                        decoration: const InputDecoration(
                          hintText: 'username',
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                            borderSide:
                                BorderSide(color: Colors.black, width: 2.5),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _email,
                        decoration: const InputDecoration(
                          hintText: 'email',
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                            borderSide:
                                BorderSide(color: Colors.black, width: 2.5),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      TextFormField(
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        controller: _password,
                        decoration: const InputDecoration(
                          hintText: 'password',
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0)),
                              borderSide:
                                  BorderSide(color: Colors.black, width: 2.5)),
                        ),
                      ),
                    ],
                  )),
              const SizedBox(
                height: 8.0,
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushReplacementNamed('login');
                },
                child: const Text(
                  ' Login',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              MaterialButton(
                onPressed: () async {
                  try {
                    if (t == 0) {
                      final credential = await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                              email: _email.text, password: _password.text);
                      FirebaseAuth.instance.currentUser!
                          .sendEmailVerification();
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          duration: Duration(seconds: 3),
                          content: Text('please check your email')));
                    }
                    t++;
                    if (FirebaseAuth.instance.currentUser!.emailVerified) {
                      Navigator.of(context).pushReplacementNamed('home');
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          duration: Duration(seconds: 3),
                          content: Text(
                            'Success to create an acount',
                            style: TextStyle(color: Colors.green),
                          )));
                    } else {
                      if (t >= 3) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                duration: Duration(seconds: 3),
                                content: Text('error: re-create an acount')));
                        t = 0;
                        FirebaseAuth.instance.currentUser!.delete();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                duration: Duration(seconds: 3),
                                content: Text('please check your email')));
                      }
                    }
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
                },
                child: Container(
                  alignment: Alignment.center,
                  width: 250,
                  height: 50,
                  decoration: const BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.all(Radius.circular(100))),
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {},
                    child: Container(
                        padding: const EdgeInsets.all(5),
                        width: 50,
                        height: 50,
                        decoration: const BoxDecoration(
                            color: Colors.black,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Image.asset(
                          'images/A100.png',
                          fit: BoxFit.cover,
                        )),
                  ),
                  InkWell(
                    onTap: () {
                      signInWithGoogle();
                      Navigator.of(context).pushReplacementNamed('home');
                    },
                    child: Container(
                        padding: const EdgeInsets.all(5),
                        width: 50,
                        height: 50,
                        decoration: const BoxDecoration(
                            color: Colors.black,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Image.asset(
                          'images/G40.png',
                          fit: BoxFit.cover,
                        )),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                        padding: const EdgeInsets.all(5),
                        width: 50,
                        height: 50,
                        decoration: const BoxDecoration(
                            color: Colors.black,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Image.asset(
                          'images/FC100.png',
                          fit: BoxFit.cover,
                        )),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
