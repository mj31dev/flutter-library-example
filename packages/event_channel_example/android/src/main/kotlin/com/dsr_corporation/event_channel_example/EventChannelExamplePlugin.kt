package com.dsr_corporation.event_channel_example

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.os.BatteryManager
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.EventChannel.EventSink
import io.flutter.plugin.common.EventChannel.StreamHandler

class EventChannelExamplePlugin: FlutterPlugin {

  private var context: Context? = null
  private var eventChannel: EventChannel? = null
  private var batteryReceiver: BroadcastReceiver? = null

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    context = flutterPluginBinding.applicationContext
    eventChannel = EventChannel(flutterPluginBinding.flutterEngine.dartExecutor.binaryMessenger, "event_channel_example")
    eventChannel?.setStreamHandler(
      object : EventChannel.StreamHandler {
        override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
          batteryReceiver = createBatteryReceiver(events)
          context?.registerReceiver(batteryReceiver, IntentFilter(Intent.ACTION_BATTERY_CHANGED))
        }

        override fun onCancel(arguments: Any?) {
          context?.unregisterReceiver(batteryReceiver)
          batteryReceiver = null
        }
      }
    )
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    context?.unregisterReceiver(batteryReceiver)
    eventChannel?.setStreamHandler(null)
    batteryReceiver = null
    eventChannel = null
    context = null
  }

  private fun createBatteryReceiver(events: EventChannel.EventSink?): BroadcastReceiver {
    return object : BroadcastReceiver() {
      override fun onReceive(context: Context?, intent: Intent?) {
        val level = intent?.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) ?: -1
        val scale = intent?.getIntExtra(BatteryManager.EXTRA_SCALE, -1) ?: -1
        if (level != -1 && scale != -1) {
          val batteryPct = level * 100 / scale
          events?.success(batteryPct)
        }
      }
    }
  }
}
