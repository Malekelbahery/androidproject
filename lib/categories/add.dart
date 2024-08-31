import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddCotegory extends StatefulWidget {
  const AddCotegory({super.key});

  @override
  State<AddCotegory> createState() => _AddCotegoryState();
}

class _AddCotegoryState extends State<AddCotegory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('add note'),
      ),
    );
  }
}
