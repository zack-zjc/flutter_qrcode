package com.qrcode.scan.view

/**
 * author:zack
 * Date:2019/4/22
 * Description:扫描结果处理
 */
interface QRCodeCallback {

  fun onScanSuccess(text: String)

  fun onScanFail()

  fun permissionDenial()

}