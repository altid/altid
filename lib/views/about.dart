import 'package:flutter/material.dart';


class CreateWidget extends StatelessWidget {
  const CreateWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
      ),
      body: const Center(
        child: Text('Welcome!'),
      ),
    );
  }
}
