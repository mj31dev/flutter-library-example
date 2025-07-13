import 'package:flutter/services.dart';
import 'package:federated_plugin_platform_interface/federated_plugin_platform_interface.dart';

class FederatedPluginIos extends FederatedPluginPlatformInterface {
  final _channel = MethodChannel('federated_plugin_ios');

  static void register() {
    FederatedPluginPlatformInterface.instance = FederatedPluginIos();
  }

  @override
  Future<String> getLocale() async {
    return await _channel.invokeMethod('get_locale');
  }
}
