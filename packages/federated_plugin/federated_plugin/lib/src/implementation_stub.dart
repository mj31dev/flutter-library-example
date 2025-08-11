import 'dart:io' show Platform;
import 'package:federated_plugin_android/federated_plugin_android.dart';
import 'package:federated_plugin_ios/federated_plugin_ios.dart';

// Initializing the correct implementation of the interface depending on the platform
void ensureInitialized() {
  if (Platform.isIOS) {
    FederatedPluginIos.register();
  } else if (Platform.isAndroid) {
    FederatedPluginAndroid.register();
  } else {
    throw UnsupportedError('Unsupported platform');
  }
}