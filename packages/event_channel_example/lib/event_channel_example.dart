import 'package:flutter/services.dart';

class EventChannelExample {
  final _eventChannel = EventChannel('event_channel_example');

  Stream<int> getBatteryLevel() {
    return _eventChannel.receiveBroadcastStream().map((event) => event as int);
  }
}
