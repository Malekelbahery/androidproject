import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'main.dart';

class Veryfine extends StatefulWidget {
  const Veryfine({
    super.key,
  });

  @override
  State<Veryfine> createState() => _VeryfineState();
}

class _VeryfineState extends State<Veryfine> {
  String s = 'Check';

  @override
  void initState() {
    // TODO: implement initState
    FirebaseAuth.instance.currentUser!.sendEmailVerification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        children: [
          const SizedBox(height: 100,),
          Text(
             '$s your email',
            style:const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 300,),
          MaterialButton(
            onPressed: () async {},
            child: Center(
              child: Container(
                alignment: Alignment.center,
                width: 150,
                height: 40,
                decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(100))),
                child: const Text(
                  'Check',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
              ),
            ),
          )
        ],
      ),
    ));
  }
}
