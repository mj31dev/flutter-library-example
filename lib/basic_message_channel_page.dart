import 'package:flutter/material.dart';
import 'package:basic_message_channel_example/basic_message_channel_example.dart';

class BasicMessageChannelPage extends StatefulWidget {
  const BasicMessageChannelPage({super.key});

  @override
  State<BasicMessageChannelPage> createState() =>
      _BasicMessageChannelPageState();
}

class _BasicMessageChannelPageState extends State<BasicMessageChannelPage> {
  String _level = 'Loading';
  final _plugin = BasicMessageChannelExample();

  @override
  void initState() {
    super.initState();
    _subscribeBattery();
  }

  void _subscribeBattery() async {
    final level = await _plugin.getVolumeLevel(
      onUpdate: (level) {
        setState(() {
          _level = level;
        });
      },
    );
    if (level != null) {
      setState(() {
        _level = level;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Event channel example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[Text(_level)],
        ),
      ),
    );
  }
}
