import 'package:flutter/services.dart';

class MethodChannelExample {
  final methodChannel = const MethodChannel('method_channel_example');

  Future<String?> getPlatformVersion() async {
    return await methodChannel.invokeMethod<String>('getPlatformVersion');
  }
}
