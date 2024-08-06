package com.example.lamp_platform_code

import android.os.Bundle
import android.util.Log
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import android.hardware.camera2.CameraAccessException
import android.hardware.camera2.CameraManager

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.device.lamp_control/lamp"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call, result ->
                if (call.method == "toggleLamp") {
                    val turnOn = call.argument<Boolean>("turnOn") ?: false
                    val success = toggleLamp(turnOn)
                    result.success(success)
                } else {
                    result.notImplemented()
                }
            }
    }

    private fun toggleLamp(turnOn: Boolean): Boolean {
        val cameraManager = getSystemService(CAMERA_SERVICE) as CameraManager
        return try {
            val cameraId = cameraManager.cameraIdList[0]
            cameraManager.setTorchMode(cameraId, turnOn)
            true
        } catch (e: CameraAccessException) {
            Log.e("MainActivity", "Failed to toggle lamp: ${e.message}")
            false
        }
    }
}
