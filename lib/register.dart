import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled/Abbreviations/googlebutton.dart';
import 'Abbreviations/textform.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
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
                      CustomText(
                        controll: _name,
                        text: 'username',
                        validator: (val) {
                          if (val == '') {
                            return 'please entre the password';
                          }
                          return null;
                        },
                        type: TextInputType.name,
                        passwordtf: false,
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      CustomText(
                        controll: _email,
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
                        controll: _password,
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
                  if (_emailkey1.currentState!.validate()) {
                    try {
                      final credential = await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                              email: _email.text, password: _password.text);
                      FirebaseAuth.instance.currentUser!
                          .sendEmailVerification();
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          duration: Duration(seconds: 3),
                          content: Text('please check your email')));
                      Navigator.of(context).pushReplacementNamed('login');
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
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
                      print(e);
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        duration: Duration(seconds: 3),
                        content:
                            Text('Enter your name and email and password')));
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
              const Googlebutton()
            ],
          ),
        ),
      ),
    );
  }
}
