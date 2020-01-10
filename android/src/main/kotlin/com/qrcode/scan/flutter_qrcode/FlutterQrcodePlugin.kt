package com.qrcode.scan.flutter_qrcode

import com.qrcode.scan.AndroidQrCodeViewFactory
import com.qrcode.scan.util.QrcodeUtil
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar

class FlutterQrcodePlugin: MethodCallHandler {
  companion object {
    @JvmStatic
    fun registerWith(registrar: Registrar) {
      val channel = MethodChannel(registrar.messenger(), "com.qrcode.scan/flutter_qrcode")
      channel.setMethodCallHandler(FlutterQrcodePlugin())
      registrar.platformViewRegistry().registerViewFactory(
              "Android/scanQrCodeView", AndroidQrCodeViewFactory(registrar)
      )
    }
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    if (call.method == "getQrCodeFromFile") {
      result.success(QrcodeUtil.getQrCodeTextFromFile(call.arguments.toString()))
    }else {
      result.notImplemented()
    }
  }
}
