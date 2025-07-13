import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:library_example/app_button.dart';
import 'package:run_engine_example/run_engine_example.dart';

class RunEnginePage extends StatefulWidget {
  const RunEnginePage({super.key});

  @override
  State<RunEnginePage> createState() => _RunEnginePageState();
}

class _RunEnginePageState extends State<RunEnginePage> {
  String _state = 'Waiting';
  final _runEngineExamplePlugin = RunEngineExample();

  @override
  void initState() {
    super.initState();
  }

  Future<void> _runEngine() async {
    String state;
    try {
      await _runEngineExamplePlugin.runSecondEngine(['started from flutter']);
      state = 'Run success';
    } on PlatformException {
      state = 'Error';
    }
    if (!mounted) return;

    setState(() {
      _state = state;
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
          spacing: 16,
          children: <Widget>[
            Text(_state),
            Padding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
              child: AppButton(title: 'Run engine', onPressed: _runEngine),
            ),
          ],
        ),
      ),
    );
  }
}
