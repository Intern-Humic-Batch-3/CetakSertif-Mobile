package com.humic.humic_mobile

import android.content.Intent
import android.media.MediaScannerConnection
import android.net.Uri
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.humic.app/media_scanner"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "scanFile") {
                val path = call.argument<String>("path")
                if (path != null) {
                    // Scan file untuk menambahkannya ke galeri
                    MediaScannerConnection.scanFile(
                        context,
                        arrayOf(path),
                        null
                    ) { _, uri ->
                        // File berhasil ditambahkan ke galeri
                        result.success(true)
                    }
                } else {
                    result.error("INVALID_ARGUMENT", "Path tidak boleh null", null)
                }
            } else {
                result.notImplemented()
            }
        }
    }
}