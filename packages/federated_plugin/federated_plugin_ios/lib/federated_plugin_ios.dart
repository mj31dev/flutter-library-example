import 'package:flutter/services.dart';
import 'package:federated_plugin_platform_interface/federated_plugin_platform_interface.dart';

// Platform interface implementation for iOS
class FederatedPluginIos extends FederatedPluginPlatformInterface {
  // Method channel to communicate with native part
  final _channel = MethodChannel('federated_plugin_ios');

  // Set platform interface implementation
  static void register() {
    FederatedPluginPlatformInterface.instance = FederatedPluginIos();
  }

  // Get locale from native part
  @override
  Future<String> getLocale() async {
    return await _channel.invokeMethod('get_locale');
  }
}
