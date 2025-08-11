import 'package:flutter/services.dart';

class EventChannelExample {
  // Setup event channel to receive values from native part
  final _eventChannel = EventChannel('event_channel_example');

  // Listening to battery level
  Stream<int> getBatteryLevel() {
    return _eventChannel.receiveBroadcastStream().map((event) => event as int);
  }
}
