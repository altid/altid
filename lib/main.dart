import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:altid/src/service.dart';
import 'package:altid/views/buffers.dart' as buffers;
import 'package:altid/views/service.dart' as services;
import 'package:altid/views/settings.dart' as settings;
import 'package:altid/views/landing.dart' as landing;
import 'package:altid/views/about.dart' as about;

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => Services(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        cupertinoOverrideTheme: const CupertinoThemeData(
          textTheme: CupertinoTextThemeData(
            dateTimePickerTextStyle: TextStyle(color: Colors.blue, fontSize: 16),
            pickerTextStyle: TextStyle(color: Colors.blue, fontSize: 12),
          ),
        ),
        primarySwatch: Colors.blueGrey,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const landing.Welcome(),
        '/service/buffer': (context) => const buffers.CreateWidget(),
        '/service/create': (context) => const services.CreateWidget(),
        '/settings': (context) => const settings.CreateWidget(),
        '/about': (context) => const about.CreateWidget(),
      }
    );
  }
}
