import Flutter
import UIKit

public class FederatedPluginIosPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    // Setup method channel to communicate with flutter part
    let channel = FlutterMethodChannel(name: "federated_plugin_ios", binaryMessenger: registrar.messenger())
    let instance = FederatedPluginIosPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "get_locale": // Get locale from native part
      result(Locale.current.identifier)
    default: // Incorrect method
      result(FlutterMethodNotImplemented)
    }
  }
}
