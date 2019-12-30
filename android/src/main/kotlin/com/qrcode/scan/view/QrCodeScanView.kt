package com.qrcode.scan.view

import android.app.Activity
import android.content.Context
import android.util.AttributeSet
import android.view.*
import android.widget.FrameLayout
import com.qrcode.scan.camera.CameraManager
import com.qrcode.scan.decoding.CaptureActivityHandler
import com.qrcode.scan.flutter_qrcode.R

/**
 * @Author zack
 * @Date 2019/12/30
 * @Description 扫码控件
 * @Version 1.0
 */
class QrCodeScanView @JvmOverloads constructor(context: Context, attributes: AttributeSet? =null, defStyleAttr: Int = 0)
    : FrameLayout(context,attributes,defStyleAttr),SurfaceHolder.Callback ,QRCodeCalback {

    private var captureActivityHandler: CaptureActivityHandler? = null
    private val surfaceView: SurfaceView
    private val viewfinderView: View
    private var callback:QRCodeCalback?=null
    private var hasSurface: Boolean = false

    init {
        val layoutView = LayoutInflater.from(context).inflate(R.layout.layout_qrcode_view,this)
        surfaceView = layoutView.findViewById(R.id.id_qrcode_surface)
        viewfinderView = layoutView.findViewById(R.id.id_qrcode_viewfinder)
        val surfaceHolder = surfaceView?.holder
        surfaceHolder?.addCallback(this)
        surfaceHolder?.setType(SurfaceHolder.SURFACE_TYPE_PUSH_BUFFERS)
        CameraManager.init(context.applicationContext)
        if (context is Activity){
            val window = context.window
            window?.addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON)
        }
    }

    /**
     * 设置扫码callback
     */
    fun setCallback(callback:QRCodeCalback){
        this.callback = callback
    }

    override fun onScanSuccess(text: String) {
        callback?.onScanSuccess(text)
    }

    override fun onScanFail() {
        callback?.onScanFail()
    }

    /**
     * 延时重新扫描
     */
    fun restartScanDelay(time: Long) {
        postDelayed({
            captureActivityHandler?.obtainMessage(R.id.restart_preview)?.sendToTarget()
            },time)
    }

    /**
     * 初始化相机
     */
    private fun initCamera() {
        if (hasSurface){
            try {
                val surfaceHolder = surfaceView.holder
                surfaceHolder?.let {
                    CameraManager.get()?.openDriver(it)
                }
            } catch (e: Exception) {
                e.printStackTrace()
                return
            }
            if (captureActivityHandler == null) {
                captureActivityHandler = CaptureActivityHandler(this)
            }
            viewfinderView.postInvalidate()
        }
    }

    /**
     * 打开照明
     */
    fun setTorch(enabled: Boolean) {
        CameraManager.get()?.setTorch(enabled)
    }

    /**
     * 照明是否打开
     */
    fun isTorchOn(): Boolean {
        return CameraManager.get()?.isTorchOn()?:false
    }

    override fun surfaceCreated(p0: SurfaceHolder?) {
        if (!hasSurface) {
            hasSurface = true
            initCamera()
        }
    }

    override fun surfaceDestroyed(p0: SurfaceHolder?) {
        hasSurface = false
        captureActivityHandler?.quitSynchronously()
        captureActivityHandler?.removeCallbacksAndMessages(null)
        CameraManager.get()?.closeDriver()
        captureActivityHandler = null
    }

    override fun surfaceChanged(p0: SurfaceHolder?, p1: Int, p2: Int, p3: Int) = Unit

}