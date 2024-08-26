import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:untitled/ver.dart';
import 'package:untitled/ver2.dart';

class Login extends StatefulWidget {
  Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
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

  final _emailkey = GlobalKey<FormState>();
  final TextEditingController _email1 = TextEditingController();
  final TextEditingController _password1 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Login',
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
                height: 80.0,
              ),
              Form(
                  key: _emailkey,
                  child: Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _email1,
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
                        controller: _password1,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushReplacementNamed('register');
                    },
                    child: const Text(
                      ' Create one',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: const Text(
                      'forget password ',
                      style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 60,
              ),
              MaterialButton(
                onPressed: () async {
                  try {
                    final f0 = FirebaseAuth.instance;
                    final f1 = FirebaseAuth.instance.currentUser;
                    final userCarint = await f0.createUserWithEmailAndPassword(
                        email: _email1.text, password: _password1.text);
                    if (f1!.emailVerified) {
                      f1.sendEmailVerification();
                      Navigator.of(context).pushReplacementNamed('ver2');
                    }
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'user-not-found') {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          duration: Duration(seconds: 3),
                          content: Text('No user found for that email.')));
                    } else if (e.code == 'wrong-password') {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          duration: Duration(seconds: 3),
                          content:
                              Text('Wrong password provided for that user.')));
                    }
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
                    'Login',
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
