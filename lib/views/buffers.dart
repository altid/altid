import 'package:flutter/material.dart';
import 'package:altid/src/buffer.dart';
//import 'package:altid/src/service.dart';
import 'package:altid/views/menu.dart' as menu;

class CreateWidget extends StatelessWidget {
  const CreateWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Set;
    //Service service = arguments.first;
    Buffer buffer = arguments.last;
    TextEditingController _inputController = TextEditingController();

    return Scaffold(
      drawer: menu.build(),
      appBar: AppBar(
        title: Text(buffer.name),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(5),
              scrollDirection: Axis.vertical,
              // Probably becomes a stream instead, since we want subs for data changes
              child: Text(
                buffer.main
              ),
            ),
          ),
          TextField(
            onSubmitted: (String value) {
              buffer.Write(value);
              _inputController.clear();
            },
            autofocus: true,
            controller: _inputController,
            textInputAction: TextInputAction.newline,
            textAlignVertical: TextAlignVertical.center,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.arrow_right),
            ),
          ),
        ], 
      )
    );
  }
}
