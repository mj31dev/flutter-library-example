import 'package:plugin_platform_interface/plugin_platform_interface.dart';

abstract class FederatedPluginPlatformInterface extends PlatformInterface {
  FederatedPluginPlatformInterface() : super(token: _token);

  static final Object _token = Object();

  static FederatedPluginPlatformInterface _instance = _PlaceholderImplementation();

  static FederatedPluginPlatformInterface get instance => _instance;

  static set instance(FederatedPluginPlatformInterface instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String> getLocale() {
    throw UnimplementedError('getLocale() has not been implemented.');
  }
}

class _PlaceholderImplementation extends FederatedPluginPlatformInterface {}