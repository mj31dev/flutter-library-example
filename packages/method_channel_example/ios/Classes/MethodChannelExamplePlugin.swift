import Flutter
import UIKit

public class MethodChannelExamplePlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    // Setup method channel to communicate with flutter part
    let channel = FlutterMethodChannel(name: "method_channel_example", binaryMessenger: registrar.messenger())
    let instance = MethodChannelExamplePlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getPlatformVersion": // Get iOS version
      result("iOS " + UIDevice.current.systemVersion)
    default: // Incorrect method
      result(FlutterMethodNotImplemented)
    }
  }
}
