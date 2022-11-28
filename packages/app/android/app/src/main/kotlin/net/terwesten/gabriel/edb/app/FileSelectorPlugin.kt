package net.terwesten.gabriel.edb.app

import android.app.Activity
import android.content.Intent
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.PluginRegistry

class FileSelectorPlugin : FlutterPlugin, ActivityAware, PluginRegistry.ActivityResultListener {
    private var activity: Activity? = null
    private var nextRequestCode = 0
    private val saveFileRequests = mutableMapOf<Int, SaveFileRequest>()

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        MethodChannel(binding.binaryMessenger, "net.terwesten.gabriel.edb.app/file_selector")
                .setMethodCallHandler { call, result ->
                    when (call.method) {
                        "saveFile" -> saveFile(call.arguments, result)
                        else -> result.notImplemented()
                    }
                }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        // No-Op
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity
        binding.addActivityResultListener(this)
    }

    override fun onDetachedFromActivity() {
        activity = null
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        onAttachedToActivity(binding)
    }

    override fun onDetachedFromActivityForConfigChanges() {
        onDetachedFromActivity()
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?): Boolean {
        val saveFileRequest = saveFileRequests[requestCode]
        if (saveFileRequest != null) {
            finishSaveFile(saveFileRequest, resultCode, data)
            return true
        }
        return false
    }

    private fun saveFile(arguments: Any?, result: MethodChannel.Result) {
        if (arguments !is Map<*, *>) {
            return result.error("invalidArguments", null, null)
        }

        val title = arguments["title"]
        val contentType = arguments["contentType"]
        val data = arguments["data"]

        if (title !is String || contentType !is String || data !is ByteArray) {
            return result.error("invalidArguments", null, null)
        }

        val requestCode = nextRequestCode++
        saveFileRequests[requestCode] = SaveFileRequest(result, data)

        val intent = Intent(Intent.ACTION_CREATE_DOCUMENT).apply {
            addCategory(Intent.CATEGORY_OPENABLE)
            type = contentType
            putExtra(Intent.EXTRA_TITLE, title)
        }

        activity!!.startActivityForResult(intent, requestCode)
    }

    private fun finishSaveFile(request: SaveFileRequest, resultCode: Int, data: Intent?) {
        if (resultCode != Activity.RESULT_OK) {
            return request.result.error("badState", "ACTION_CREATE_DOCUMENT returned result code $resultCode", null)
        }

        activity!!.contentResolver.openOutputStream(data!!.data!!)!!.use {
            it.write(request.data)
        }

        request.result.success(null)
    }

    private class SaveFileRequest(val result: MethodChannel.Result, val data: ByteArray)

}

