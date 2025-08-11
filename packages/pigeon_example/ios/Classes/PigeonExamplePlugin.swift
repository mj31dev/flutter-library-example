import Flutter
import UIKit

public class PigeonExamplePlugin: NSObject, FlutterPlugin {
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let messenger = registrar.messenger()
        // Setup platform interface implementation
        PlatformInfoApiSetup.setUp(
            binaryMessenger: messenger,
            api: DefaultPlatformInfoApi(
                api: VersionFlutterApi(binaryMessenger: messenger)
            )
        )
    }
}
