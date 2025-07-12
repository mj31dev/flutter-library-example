import Flutter
import UIKit

public class PigeonExamplePlugin: NSObject, FlutterPlugin {
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let messanger = registrar.messenger()
        PlatformInfoApiSetup.setUp(
            binaryMessenger: messanger,
            api: DefaultPlatformInfoApi(
                api: VersionFlutterApi(binaryMessenger: messanger)
            )
        )
    }
}
