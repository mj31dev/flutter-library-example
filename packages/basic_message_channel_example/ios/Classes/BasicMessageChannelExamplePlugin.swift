import Flutter
import UIKit
import AVFoundation

public class BasicMessageChannelExamplePlugin: NSObject, FlutterPlugin {
    private let channel: FlutterBasicMessageChannel
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        // Setup basic message channel to communicate with flutter part
        let channel = FlutterBasicMessageChannel(
            name: "basic_message_channel_example",
            binaryMessenger: registrar.messenger(),
            codec: FlutterStringCodec.sharedInstance()
        )
        let instance = BasicMessageChannelExamplePlugin(channel: channel)
        instance.setupChannel()
        instance.startOrientationObserver()
        registrar.publish(instance)
    }
    
    init(channel: FlutterBasicMessageChannel) {
        self.channel = channel
    }
    
    // Setup a handler for messages from the flutter part
    private func setupChannel() {
        channel.setMessageHandler {  [weak self] message, reply in
            if message as? String == "get_orientation" {
                reply(self?.currentOrientation())
            } else {
                reply("Unknown command")
            }
        }
    }

    // Get current orientation
    private func currentOrientation() -> String {
        let orientation = UIApplication.shared.windows.first?.windowScene?.interfaceOrientation
        switch orientation {
        case .portrait, .portraitUpsideDown:
            return "Portrait"
        case .landscapeLeft, .landscapeRight:
            return "Landscape"
        default:
            return "Undefined"
        }
    }

    // Listen for orientation change
    private func startOrientationObserver() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(orientationChanged),
            name: UIDevice.orientationDidChangeNotification,
            object: nil
        )
        UIDevice.current.beginGeneratingDeviceOrientationNotifications()
    }

    // Receive orientation change notification
    @objc private func orientationChanged() {
        let info = currentOrientation()
        // Send message to flutter part
        channel.sendMessage(String(format: "orientation_update:%@", info))
    }
}
