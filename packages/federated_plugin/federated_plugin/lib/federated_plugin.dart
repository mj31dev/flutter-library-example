import 'package:federated_plugin/src/implementation_stub.dart';
import 'package:federated_plugin_platform_interface/federated_plugin_platform_interface.dart';

// Facade for federated plugin
class FederatedPlugin {
  static FederatedPluginPlatformInterface get _platform => FederatedPluginPlatformInterface.instance;

  FederatedPlugin() {
    ensureInitialized();
  }

  // Get locale from native part
  Future<String> getLocale() async {
    return _platform.getLocale();
  }
}
