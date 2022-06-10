import 'package:flutter/material.dart';
import 'package:altid/views/menu.dart' as menu;

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<Welcome> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Welcome> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Services"),
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
      extendBodyBehindAppBar: true,
      drawer: menu.build(),
      body: const Center(child: Text("Welcome! Select a Service from the menu to continue")),
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