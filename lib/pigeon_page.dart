import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pigeon_example/pigeon_example.dart';

class PigeonPage extends StatefulWidget {
  const PigeonPage({super.key});

  @override
  State<PigeonPage> createState() => _PigeonPageState();
}

class _PigeonPageState extends State<PigeonPage> {
  String _platformInfo = 'Loading';
  final _pigeonExamplePlugin = PigeonExample();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    String platformInfo;
    try {
      final info = await _pigeonExamplePlugin.getPlatformInfo();
      platformInfo = 'OS: ${info.name} ${info.version}. App version: ${info.appVersion}';
    } on PlatformException {
      platformInfo = 'Failed to get platform info.';
    }
    if (!mounted) return;

    setState(() {
      _platformInfo = platformInfo;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Pigeon example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[Text(_platformInfo)],
        ),
      ),
    );
  }
}
