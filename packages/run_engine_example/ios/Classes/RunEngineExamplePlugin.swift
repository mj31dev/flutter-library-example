import Flutter
import UIKit

public class RunEngineExamplePlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        // Method channel to communicate with flutter part
        let channel = FlutterMethodChannel(name: "run_engine_example", binaryMessenger: registrar.messenger())
        let instance = RunEngineExamplePlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "run": // Run second engine
            // Get entry point information
            guard let params = call.arguments as? [String: Any],
                  let function = params["function"] as? Int64,
                  let callbackInfo = FlutterCallbackCache.lookupCallbackInformation(function) else {
                result(FlutterMethodNotImplemented)
                return
            }
            let args = params["args"] as? [String]

            // Create new engine
            let project = FlutterDartProject()
            var flutterEngine: FlutterEngine? = FlutterEngine(
                name: "second_engine",
                project: project,
                allowHeadlessExecution: true,
            )

            // Setup entry point
            let didRun = flutterEngine!.run(
                withEntrypoint: callbackInfo.callbackName,
                libraryURI: callbackInfo.callbackLibraryPath,
                initialRoute: nil,
                entrypointArgs: args,
            )

            // Setup method channel for second engine
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
        default: // Incorrect method
            result(FlutterMethodNotImplemented)
        }
    }

    // Stop second engine
    func stop(engine: inout FlutterEngine?, channel: inout FlutterMethodChannel?) {
        engine?.destroyContext()
        engine = nil
        channel = nil
    }
}
