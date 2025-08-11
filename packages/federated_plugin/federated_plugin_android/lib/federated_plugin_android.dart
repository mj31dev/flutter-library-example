import 'package:flutter/services.dart';
import 'package:federated_plugin_platform_interface/federated_plugin_platform_interface.dart';

// Platform interface implementation for Android
class FederatedPluginAndroid extends FederatedPluginPlatformInterface {
  // Method channel to communicate with native part
  final _channel = MethodChannel('federated_plugin_android');

  // Set platform interface implementation
  static void register() {
    FederatedPluginPlatformInterface.instance = FederatedPluginAndroid();
  }

  // Get locale from native part
  @override
  Future<String> getLocale() async {
    return await _channel.invokeMethod('getLocale');
  }
}
