import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:event_channel_example/event_channel_example.dart';

class EventChannelPage extends StatefulWidget {
  const EventChannelPage({super.key});

  @override
  State<EventChannelPage> createState() => _EventChannelPageState();
}

class _EventChannelPageState extends State<EventChannelPage> {
  String _battery = 'Loading';
  final _eventChannelExamplePlugin = EventChannelExample();

  @override
  void initState() {
    super.initState();
    _subscribeBattery();
  }

  void _subscribeBattery() {
    _eventChannelExamplePlugin.getBatteryLevel().listen((level) {
      setState(() {
        _battery = "$level%";
      });
    });
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
          children: <Widget>[Text(_battery)],
        ),
      ),
    );
  }
}
