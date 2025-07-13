import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class RunEngineExample {
  final methodChannel = const MethodChannel('run_engine_example');

  Future<bool> runSecondEngine([List<String>? args]) async {
    final function = PluginUtilities.getCallbackHandle(
      _secondEngine,
    )?.toRawHandle();
    final result = await methodChannel.invokeMethod<bool>("run", {
      "function": function,
      "args": args,
    });
    return result == true;
  }
}

@pragma('vm:entry-point')
void _secondEngine(List<String>? args) {
  WidgetsFlutterBinding.ensureInitialized();
  print('Hello from second engine: ${args}');
  final methodChannel = MethodChannel('run_engine_example_second_channel');
}
