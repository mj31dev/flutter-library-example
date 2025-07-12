import 'package:flutter/material.dart';
import 'package:library_example/app_button.dart';
import 'package:library_example/basic_message_channel_page.dart';
import 'package:library_example/event_channel_page.dart';
import 'package:library_example/method_channel_page.dart';
import 'package:library_example/pigeon_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 16,
            children: <Widget>[
              _button(
                context: context,
                screen: () => MethodChannelPage(),
                title: 'Method channel example',
              ),
              _button(
                context: context,
                screen: () => EventChannelPage(),
                title: 'Event channel example',
              ),
              _button(
                context: context,
                screen: () => BasicMessageChannelPage(),
                title: 'Basic message channel example',
              ),
              _button(
                context: context,
                screen: () => PigeonPage(),
                title: 'Pigeon example',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _button({
    required BuildContext context,
    required String title,
    required Widget Function() screen,
  }) => AppButton(
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => screen()),
      );
    },
    title: title,
  );
}
