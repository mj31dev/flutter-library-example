package com.dsr_corporation.run_engine_example

import android.content.Context
import android.os.Handler
import android.os.Looper
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.dart.DartExecutor
import io.flutter.embedding.engine.loader.FlutterLoader
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.view.FlutterCallbackInformation

/** RunEngineExamplePlugin */
class RunEngineExamplePlugin : FlutterPlugin, MethodCallHandler {

    private var flutterEngine: FlutterEngine? = null
    private var backgroundChannel: MethodChannel? = null
    private var context: Context? = null
    private val flutterLoader = FlutterLoader()

    private lateinit var channel: MethodChannel

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        this.context = flutterPluginBinding.applicationContext
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "run_engine_example")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        if (call.method == "run") { // Run second engine
            val context = this.context ?: run {
                result.notImplemented()
                return
            }
            // Get entry point information
            val args = call.arguments as? Map<*, *>
            val rawHandle = (args?.get("function") as? Long) ?: run {
                result.notImplemented()
                return
            }
            val callbackInfo = FlutterCallbackInformation.lookupCallbackInformation(rawHandle)
            if (callbackInfo == null) {
                result.notImplemented()
                return
            }

            val dartArgs = args["args"] as? List<String>

            // Create new engine
            val flutterEngine = FlutterEngine(context.applicationContext)
            this.flutterEngine = flutterEngine
            if (!flutterLoader.initialized()) {
                flutterLoader.startInitialization(context)
            }
            // Setup entry point
            flutterLoader.ensureInitializationCompleteAsync(
                /* applicationContext = */ context,
                /* args = */ null,
                /* callbackHandler = */ Handler(Looper.getMainLooper()),
                /* callback = */ {
                    executeEngine(flutterEngine, dartArgs, callbackInfo)
                }
            )

            result.success(true)
        } else { // Incorrect method
            result.notImplemented()
        }
    }

    private fun executeEngine(
        engine: FlutterEngine,
        args: List<String>?,
        callbackInfo: FlutterCallbackInformation,
    ) {
        // Run second engine
        val dartBundlePath = flutterLoader.findAppBundlePath()
        engine.dartExecutor.executeDartEntrypoint(
            DartExecutor.DartEntrypoint(
                dartBundlePath,
                callbackInfo.callbackLibraryPath,
                callbackInfo.callbackName,
            ),
            args
        )

        // Setup method channel for second engine
        backgroundChannel =
            MethodChannel(engine.dartExecutor.binaryMessenger, "run_engine_example_second_channel")
        backgroundChannel?.setMethodCallHandler { call, result ->
            if (call.method == "stop") {
                stop()
                result.success(null)
            } else {
                result.notImplemented()
            }
        }
    }

    // Stop second engine
    private fun stop() {
        flutterEngine?.destroy()
        flutterEngine = null
        backgroundChannel = null
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        stop()
        channel.setMethodCallHandler(null)
    }
}
