import Flutter
import UIKit

public class RunEngineExamplePlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "run_engine_example", binaryMessenger: registrar.messenger())
        let instance = RunEngineExamplePlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "run":
            guard let params = call.arguments as? [String: Any],
                  let function = params["function"] as? Int64,
                  let callbackInfo = FlutterCallbackCache.lookupCallbackInformation(function) else {
                result(FlutterMethodNotImplemented)
                return
            }
            let args = params["args"] as? [String]
            let project = FlutterDartProject()
            var flutterEngine: FlutterEngine? = FlutterEngine(
                name: "second_engine",
                project: project,
                allowHeadlessExecution: true,
            )
            let didRun = flutterEngine!.run(
                withEntrypoint: callbackInfo.callbackName,
                libraryURI: callbackInfo.callbackLibraryPath,
                initialRoute: nil,
                entrypointArgs: args,
            )
            var backgroundMethodChannel: FlutterMethodChannel? = FlutterMethodChannel(
                name: "run_engine_example_second_channel",
                binaryMessenger: flutterEngine!.binaryMessenger
            )
            backgroundMethodChannel?.setMethodCallHandler { [weak self] (call, result) in
                if call.method == "stop" {
                    self?.stop(engine: &flutterEngine, channel: &backgroundMethodChannel)
                }
            }
            result(didRun)
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
    func stop(engine: inout FlutterEngine?, channel: inout FlutterMethodChannel?) {
        engine?.destroyContext()
        engine = nil
        channel = nil
    }
}
