package com.example.basic_message_channel_example

import android.content.Context
import android.content.res.Configuration
import android.view.OrientationEventListener
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.BasicMessageChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.StringCodec

/** BasicMessageChannelExamplePlugin */
class BasicMessageChannelExamplePlugin : FlutterPlugin {
    private lateinit var channel: BasicMessageChannel<String>
    private var context: Context? = null
    private var orientationEventListener: OrientationEventListener? = null

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        context = flutterPluginBinding.applicationContext
        channel = BasicMessageChannel(
            flutterPluginBinding.binaryMessenger,
            "basic_message_channel_example",
            StringCodec.INSTANCE
        )
        setupChannel()
        startOrientationObserver()
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        stopOrientationObserver()
        context = null
    }

    private fun setupChannel() {
        channel.setMessageHandler { message, reply ->
            if (message == "get_orientation") {
                reply.reply(currentOrientation())
            } else {
                reply.reply("Unknown command")
            }
        }
    }

    private fun currentOrientation(): String {
        val orientation = context?.resources?.configuration?.orientation
        return when (orientation) {
            Configuration.ORIENTATION_LANDSCAPE -> "Landscape"
            Configuration.ORIENTATION_PORTRAIT -> "Portrait"
            else -> "Undefined"
        }
    }

    private fun startOrientationObserver() {
        orientationEventListener = object : OrientationEventListener(context) {
            override fun onOrientationChanged(orientation: Int) {
                val info = currentOrientation()
                channel.send("orientation_update:$info")
            }
        }
        orientationEventListener?.enable()
    }

    private fun stopOrientationObserver() {
        orientationEventListener?.disable()
    }
}
