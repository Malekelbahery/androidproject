import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled/Abbreviations/googlebutton.dart';
import 'Abbreviations/textform.dart';

class Login extends StatefulWidget {
  Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _emailkey = GlobalKey<FormState>();
  final TextEditingController _email1 = TextEditingController();
  final TextEditingController _password1 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Login',
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
                      CustomText(
                        controll: _email1,
                        text: 'email',
                        validator: (val) {
                          if (val == '') {
                            return 'please entre the password';
                          }
                          return null;
                        },
                        type: TextInputType.emailAddress,
                        passwordtf: false,
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      CustomText(
                        controll: _password1,
                        text: 'password',
                        validator: (val) {
                          if (val == '') {
                            return 'please entre the password';
                          }
                          return null;
                        },
                        type: TextInputType.visiblePassword,
                        passwordtf: true,
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
                    onTap: () async {
                      if (_email1.text.isNotEmpty) {
                        await FirebaseAuth.instance
                            .sendPasswordResetEmail(email: _email1.text);
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                duration: Duration(seconds: 3),
                                content: Text('Please check your email')));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                duration: Duration(seconds: 3),
                                content: Text('Enter the email')));
                      }
                    },
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
                  if (_emailkey.currentState!.validate()) {
                    try {
                      final credential = await FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                              email: _email1.text, password: _password1.text);
                      if (FirebaseAuth.instance.currentUser != null &&
                          FirebaseAuth.instance.currentUser!.emailVerified) {
                        Navigator.of(context).pushReplacementNamed('home');
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                                duration: Duration(seconds: 3),
                                content: Text(
                                  'Login successfull',
                                  style: TextStyle(color: Colors.green),
                                )));
                      } else {
                        FirebaseAuth.instance.currentUser!
                            .sendEmailVerification();
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                duration: Duration(seconds: 3),
                                content: Text('please check your email')));
                      }
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found') {
                        print('1');
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                duration: Duration(seconds: 3),
                                content:
                                    Text('No user found for that email.')));
                      } else if (e.code == 'wrong-password') {
                        print(2);
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                duration: Duration(seconds: 3),
                                content: Text(
                                    'Wrong password provided for that user.')));
                      }
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        duration: Duration(seconds: 3),
                        content: Text('Enter your email and password')));
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
              const Googlebutton()
            ],
          ),
        ),
      ),
    );
  }
}
