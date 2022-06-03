import 'package:flutter/material.dart';
import 'package:altid/src/buffer.dart';
import 'package:altid/src/service.dart';

class CreateWidget extends StatelessWidget {
  const CreateWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Set;
    Service service = arguments.first;
    Buffer buffer = arguments.last;

    return Scaffold(
      appBar: AppBar(
        title: Text(buffer.name),
      ),
    );
  }
}
