import 'package:flutter/services.dart';
import 'package:federated_plugin_platform_interface/federated_plugin_platform_interface.dart';

class FederatedPluginAndroid extends FederatedPluginPlatformInterface {
  final _channel = MethodChannel('federated_plugin_android');

  static void register() {
    FederatedPluginPlatformInterface.instance = FederatedPluginAndroid();
  }

  @override
  Future<String> getLocale() async {
    return await _channel.invokeMethod('getLocale');
  }
}
