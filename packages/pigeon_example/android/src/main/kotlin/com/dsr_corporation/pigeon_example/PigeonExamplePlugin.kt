package com.dsr_corporation.pigeon_example

import PlatformInfoApi
import VersionFlutterApi
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** PigeonExamplePlugin */
class PigeonExamplePlugin : FlutterPlugin {
    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        val messenger = flutterPluginBinding.binaryMessenger
        PlatformInfoApi.setUp(messenger, DefaultPlatformInfoApi(VersionFlutterApi(messenger)))
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        PlatformInfoApi.setUp(binding.binaryMessenger, null)
    }
}
