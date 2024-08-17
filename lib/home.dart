import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'main.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
              onTap: () async{
                await FirebaseAuth.instance.signOut();
                Navigator.of(context).pushReplacementNamed('login');
                t = false;
              },
              child: const Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Text('Sign Out',
                      style: TextStyle(color: Colors.red, fontSize: 18)),
                  SizedBox(
                    width: 15,
                  ),
                  Icon(
                    Icons.exit_to_app,
                    color: Colors.red,
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
