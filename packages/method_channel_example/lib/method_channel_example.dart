import 'package:flutter/services.dart';

class MethodChannelExample {
  // Method channel to communicate with native part
  final methodChannel = const MethodChannel('method_channel_example');

  // Get OS version
  Future<String?> getPlatformVersion() async {
    return await methodChannel.invokeMethod<String>('getPlatformVersion');
  }
}
