package com.qrcode.scan

import android.content.Context
import android.view.View
import com.qrcode.scan.view.QRCodeCallback
import com.qrcode.scan.view.QrCodeScanView
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.PluginRegistry
import io.flutter.plugin.platform.PlatformView

/**
 * @Author zack
 * @Date 2019/12/30
 * @Description 本地对应的控件
 * @Version 1.0
 */
class AndroidQrCodeView(context: Context, id: String, mRegistrar: PluginRegistry.Registrar) : PlatformView, MethodChannel.MethodCallHandler{

    private val methodChannel: MethodChannel = MethodChannel(mRegistrar.messenger(), "com.qrcode.scan/channel_$id")

    private val eventChannel: EventChannel = EventChannel(mRegistrar.messenger(), "com.qrcode.scan/event_$id")

    private var sink: EventChannel.EventSink? = null

    private val mQrCodeScanView:QrCodeScanView = QrCodeScanView(context)

    init {
        methodChannel.setMethodCallHandler(this)
        mQrCodeScanView.setActivityReference(mRegistrar.activity())
        eventChannel.setStreamHandler(object : EventChannel.StreamHandler {
            override fun onListen(o: Any?, eventSink: EventChannel.EventSink?) {
                sink = eventSink
            }

            override fun onCancel(o: Any?) {
                sink = null
            }
        })
        mQrCodeScanView.setCallback(object : QRCodeCallback {
            override fun onScanSuccess(text: String) {
                sink?.success(text)
            }

            override fun onScanFail() {
                sink?.error("0","scan fail",null)
            }

            override fun permissionDenial() {
                sink?.error("-1","permission denial",null)
            }

        })
    }

    override fun getView(): View = mQrCodeScanView

    override fun dispose() {

    }

    override fun onMethodCall(methodCall: MethodCall, result: MethodChannel.Result) {
        when {
            methodCall.method == "openTorch" -> {
                if (!mQrCodeScanView.isTorchOn()){
                    mQrCodeScanView.setTorch(true)
                }
                result.success(true)
            }
            methodCall.method == "closeTorch" -> {
                if (mQrCodeScanView.isTorchOn()){
                    mQrCodeScanView.setTorch(false)
                }
                result.success(true)
            }
            methodCall.method == "isTorchOn" -> result.success(mQrCodeScanView.isTorchOn())
            methodCall.method == "restartScan" -> {
                mQrCodeScanView.restartScanDelay(1500)
                result.success(true)
            }
        }
    }

}