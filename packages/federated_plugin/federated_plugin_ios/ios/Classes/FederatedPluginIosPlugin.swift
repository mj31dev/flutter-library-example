import Flutter
import UIKit

public class FederatedPluginIosPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "federated_plugin_ios", binaryMessenger: registrar.messenger())
    let instance = FederatedPluginIosPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "get_locale":
      result(Locale.current.identifier)
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}
