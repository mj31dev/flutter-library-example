import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:method_channel_example/method_channel_example.dart';

class MethodChannelPage extends StatefulWidget {
  const MethodChannelPage({super.key});

  @override
  State<MethodChannelPage> createState() => _MethodChannelPageState();
}

class _MethodChannelPageState extends State<MethodChannelPage> {
  String _platformVersion = 'Loading';
  final _methodChannelExamplePlugin = MethodChannelExample();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    String? platformVersion;
    try {
      platformVersion = await _methodChannelExamplePlugin.getPlatformVersion();
      if (platformVersion != null) {
        platformVersion = 'Running on: $platformVersion';
      }
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion ?? 'Unknown platform version';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Method channel example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[Text(_platformVersion)],
        ),
      ),
    );
  }
}
