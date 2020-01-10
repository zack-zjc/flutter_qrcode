package com.qrcode.scan.permission

import android.app.Fragment
import android.content.pm.PackageManager
import android.os.Build
import android.os.Bundle
import android.support.annotation.RequiresApi


/**
 * @Author zack
 * @Date 2020/1/10
 * @Description 请求权限的fragment
 * @Version 1.0
 */
class PermissionFragment : Fragment() {

    private val PERMISSIONS_REQUEST_CODE = 42

    private var callback:PermissionCallback? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        retainInstance = true
    }

    @RequiresApi(Build.VERSION_CODES.M)
    fun requestPermissions(permissions: Array<String>,callback:PermissionCallback) {
        this.callback = callback
        requestPermissions(permissions, PERMISSIONS_REQUEST_CODE)
    }

    @RequiresApi(Build.VERSION_CODES.M)
    override fun onRequestPermissionsResult(requestCode: Int, permissions: Array<String>, grantResults: IntArray) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)
        if (requestCode != PERMISSIONS_REQUEST_CODE) return
        val shouldShowRequestPermissionRationale = BooleanArray(permissions.size)
        for (i in permissions.indices) {
            shouldShowRequestPermissionRationale[i] = shouldShowRequestPermissionRationale(permissions[i])
        }
        onRequestPermissionsResult(permissions, grantResults)
    }

    /**
     * 处理回调
     */
    private fun onRequestPermissionsResult(permissions: Array<String>, grantResults: IntArray) {
        var granted = true
        for (i in permissions.indices){
            //只判断是否所有权限都赋予了
            granted = granted && (grantResults[i] == PackageManager.PERMISSION_GRANTED)
        }
        callback?.onPermissionChecked(granted)
    }

}