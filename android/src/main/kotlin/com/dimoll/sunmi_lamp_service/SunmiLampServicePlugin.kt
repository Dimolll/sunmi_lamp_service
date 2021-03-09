package com.dimoll.sunmi_lamp_service

import androidx.annotation.NonNull
import io.flutter.Log

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar

/** SunmiLampServicePlugin */
class SunmiLampServicePlugin : FlutterPlugin, MethodCallHandler {
    private lateinit var channel: MethodChannel
    private var service = SunmiLampService()

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "sunmi_lamp_service")
        channel.setMethodCallHandler(this)
        service.connectService(flutterPluginBinding.applicationContext)
        Log.d("dimoll", "onAttachedToEngine")

    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        when (call.method) {
            "startForLoop" -> {
                val lamp = call.argument<String>("lamp")
                val status = call.argument<Int>("status")
                Log.d("dimoll", "startForLoop ${call.arguments}")

                startForLoop(status!!, lamp!!)
                result.success(true)
            }
            "startForSingle" -> {
                val lamp = call.argument<String>("lamp")
                val status = call.argument<Int>("status")

                Log.d("dimoll", "startForSigle ${call.arguments}")

                startForSingle(status!!, lamp!!)
                result.success(true)
            }
            "closeAllLamp" -> {
                Log.d("dimoll", "closeAllLamp")
                closeAllLamp()
                result.success(true)
            }
            else -> {
                result.notImplemented()
            }
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
        service.dispose(binding.applicationContext)
    }

    private fun startForLoop(status: Int, lamp: String) = service.startForLoop(status, lamp)
    private fun startForSingle(status: Int, lamp: String) = service.startForSigle(status, lamp)
    private fun closeAllLamp() = service.closeAllLamp()

}
