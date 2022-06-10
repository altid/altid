import 'package:flutter/material.dart';
import 'package:altid/src/buffer.dart';
import 'package:altid/src/service.dart';
import 'package:altid/views/menu.dart' as menu;

class CreateWidget extends StatefulWidget {
  const CreateWidget({Key? key}) : super(key: key);

  @override
  State<CreateWidget> createState() => _CreateWidgetState();
}

class _CreateWidgetState extends State<CreateWidget> {
  late TextEditingController inputController;
  
  @override
  void initState() {
    inputController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Set;
    Service service = arguments.first;
    Buffer buffer = arguments.last;

    return Scaffold(
      drawer: menu.build(),
      appBar: AppBar(
        title: Text(buffer.name),
        actions: [
          PopupMenuButton<int>(
            onSelected: (item) => menuSelected(context, item),
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 1,
                child: Text('Settings'),
              ),
              const PopupMenuItem(
                value: 2,
                child: Text('About'),
              ),
            ],
          ),
        ],
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
              service.write(value);
              inputController.clear();
            },
            onEditingComplete: () {},
            autofocus: true,
            controller: inputController,
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

void menuSelected(context, item) {
  switch(item) {
    case 0:
      break;
    case 1:
      Navigator.pushNamed(context, '/settings');
      break;
    case 2:
      Navigator.pushNamed(context, '/about');
      break;
  }
}
