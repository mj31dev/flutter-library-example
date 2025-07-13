import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:federated_plugin/federated_plugin.dart';

class FederatedPluginPage extends StatefulWidget {
  const FederatedPluginPage({super.key});

  @override
  State<FederatedPluginPage> createState() => _FederatedPluginPageState();
}

class _FederatedPluginPageState extends State<FederatedPluginPage> {
  String _locale = 'Loading';
  final _plugin = FederatedPlugin();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    String? locale;
    try {
      locale = await _plugin.getLocale();
    } on PlatformException {
      locale = 'Failed to get locale.';
    }
    if (!mounted) return;

    setState(() {
      _locale = locale ?? 'Unknown locale';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Flutter plugin example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[Text(_locale)],
        ),
      ),
    );
  }
}
