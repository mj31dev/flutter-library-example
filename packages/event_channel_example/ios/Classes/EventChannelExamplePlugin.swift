import Flutter
import UIKit

public class EventChannelExamplePlugin: NSObject, FlutterPlugin, FlutterStreamHandler {
    
    private var batteryEventSink: FlutterEventSink?
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterEventChannel(name: "event_channel_example", binaryMessenger: registrar.messenger())
        let instance = EventChannelExamplePlugin()
        channel.setStreamHandler(instance)
    }
    
    public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        UIDevice.current.isBatteryMonitoringEnabled = true
        batteryEventSink = events
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(batteryChanged),
            name: UIDevice.batteryLevelDidChangeNotification,
            object: nil)
        
        batteryChanged(nil)
        
        return nil
    }
    
    public func onCancel(withArguments arguments: Any?) -> FlutterError? {
        batteryEventSink = nil
        NotificationCenter.default.removeObserver(self, name: UIDevice.batteryLevelDidChangeNotification, object: nil)
        return nil
    }
    
    @objc private func batteryChanged(_ notification: Notification?) {
        let level = UIDevice.current.batteryLevel
        if level >= 0 {
            batteryEventSink?(Int(round(level * 100)))
        }
    }
}
