import 'package:flutter/services.dart';

class BasicMessageChannelExample {
  final channel = const BasicMessageChannel(
    'basic_message_channel_example',
    StringCodec(),
  );

  Future<String?> getVolumeLevel({required Function(String) onUpdate}) {
    channel.setMessageHandler((message) async {
      if (message != null) {
        final parts = message.split(":");
        if (parts.length >= 2 && parts[0] == "orientation_update") {
          onUpdate(parts[1]);
        }
      }
      return "";
    });
    return channel.send('get_orientation');
  }
}
