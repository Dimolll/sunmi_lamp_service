package com.dimoll.sunmi_lamp_service

import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.content.ServiceConnection
import android.os.IBinder
import android.os.RemoteException
import com.sunmi.statuslampmanager.IStateLamp
import io.flutter.Log


class SunmiLampService {
    private val con: ServiceConnection = object : ServiceConnection {
        override fun onServiceConnected(name: ComponentName, service: IBinder) {
            mService = IStateLamp.Stub.asInterface(service)
            val unused = mService
            Log.d("dimoll", "Service Connected.")
        }

        override fun onServiceDisconnected(name: ComponentName) {
            Log.d("dimoll", "Service Disconnected.")
            mService = null
            val unused = mService
        }
    }

    var mService: IStateLamp? = null

    fun connectService(ctx: Context) {
        val intent = Intent()
        intent.setPackage("com.sunmi.statuslampmanager")
        intent.action = "com.sunmi.statuslamp.service"
        ctx.startService(intent)
        ctx.bindService(intent, con, 1)
        Log.d("dimoll", "connectService")

    }

    fun dispose(ctx: Context) {
        mService?.closeAllLamp()
        ctx.unbindService(con)
    }

    @Throws(RemoteException::class)
    fun startForLoop(status: Int, lamp: String?) =
            mService!!.controlLampForLoop(status, 1000, 500, lamp)


    @Throws(RemoteException::class)
    fun startForSigle(status: Int, lamp: String?) =
            mService!!.controlLamp(status, lamp)


    fun closeAllLamp() =
            mService!!.closeAllLamp()
}