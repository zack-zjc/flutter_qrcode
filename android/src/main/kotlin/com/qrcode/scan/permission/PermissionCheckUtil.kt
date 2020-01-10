package com.qrcode.scan.permission

import android.annotation.TargetApi
import android.app.Activity
import android.app.FragmentManager
import android.os.Build
import android.support.annotation.RequiresApi


/**
 * @Author zack
 * @Date 2020/1/10
 * @Description 权限申请界面
 * @Version 1.0
 */
object PermissionCheckUtil {

    private val TAG = PermissionCheckUtil::class.java.simpleName

    private var permissionFragment:PermissionFragment? = null

    /**
     * 获取注入fragment的单例
     */
    @TargetApi(Build.VERSION_CODES.N)
    fun getInstance(activity: Activity):PermissionCheckUtil{
        permissionFragment = findRxPermissionsFragment(activity.fragmentManager)
        if (permissionFragment == null){
            permissionFragment = PermissionFragment()
            activity.fragmentManager.beginTransaction().add(permissionFragment, TAG).commitNow()
        }
        return this
    }

    private fun findRxPermissionsFragment(fragmentManager: FragmentManager): PermissionFragment? {
        return fragmentManager.findFragmentByTag(TAG) as PermissionFragment?
    }

    @RequiresApi(Build.VERSION_CODES.M)
    fun requestPermission(permissions: Array<String>,callback: PermissionCallback){
        permissionFragment?.requestPermissions(permissions,callback)
    }

}