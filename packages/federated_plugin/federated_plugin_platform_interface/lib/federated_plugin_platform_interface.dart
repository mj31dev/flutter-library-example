import 'package:plugin_platform_interface/plugin_platform_interface.dart';

// Platform interface
abstract class FederatedPluginPlatformInterface extends PlatformInterface {
  FederatedPluginPlatformInterface() : super(token: _token);

  static final Object _token = Object();

  static FederatedPluginPlatformInterface _instance = _PlaceholderImplementation();

  // Get platform interface implementation
  static FederatedPluginPlatformInterface get instance => _instance;

  // Set platform interface implementation
  static set instance(FederatedPluginPlatformInterface instance) {
    // Verify implementation
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  // Get locale from native part
  Future<String> getLocale() {
    throw UnimplementedError('getLocale() has not been implemented.');
  }
}

class _PlaceholderImplementation extends FederatedPluginPlatformInterface {}