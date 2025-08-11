import 'package:flutter/services.dart';

class BasicMessageChannelExample {
  // Setup basic message channel to communicate with native part
  final channel = const BasicMessageChannel(
    'basic_message_channel_example',
    StringCodec(),
  );

  Future<String?> getVolumeLevel({required Function(String) onUpdate}) {
    // Setup a handler for messages from the native part
    channel.setMessageHandler((message) async {
      if (message != null) {
        final parts = message.split(":");
        if (parts.length >= 2 && parts[0] == "orientation_update") {
          onUpdate(parts[1]);
        }
      }
      return "";
    });
    // Send message to native part
    return channel.send('get_orientation');
  }
}
