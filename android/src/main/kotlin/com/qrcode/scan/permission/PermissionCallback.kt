package com.qrcode.scan.permission

/**
 * @Author zack
 * @Date 2020/1/10
 * @Description 权限申请的回调
 * @Version 1.0
 */
interface PermissionCallback {

    /**
     * 回调返回检查权限结果
     */
    fun onPermissionChecked(granted:Boolean)

}