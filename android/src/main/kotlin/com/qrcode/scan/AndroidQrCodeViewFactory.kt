package com.qrcode.scan

import android.content.Context
import io.flutter.plugin.common.PluginRegistry
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

/**
 * @Author zack
 * @Date 2019/12/30
 * @Description viewFactory
 * @Version 1.0
 */
class AndroidQrCodeViewFactory(private val registrar: PluginRegistry.Registrar) : PlatformViewFactory(StandardMessageCodec.INSTANCE) {

    override fun create(context: Context?, id: Int, param: Any?): PlatformView =
            AndroidQrCodeView(context!!, id.toString(), this.registrar)
}