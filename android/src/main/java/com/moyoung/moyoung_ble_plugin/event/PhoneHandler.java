package com.moyoung.moyoung_ble_plugin.event;

import android.Manifest;
import android.content.Context;
import android.content.pm.PackageManager;
import android.os.Build;
import android.os.Handler;
import android.os.Looper;
import android.telecom.TelecomManager;

import androidx.core.app.ActivityCompat;

import com.crrepa.ble.conn.CRPBleConnection;
import com.crrepa.ble.conn.type.CRPPhoneOperationType;
import com.moyoung.moyoung_ble_plugin.base.BaseConnectionEventChannelHandler;

import java.lang.reflect.Method;

import io.flutter.plugin.common.MethodCall;

class PhoneHandler extends BaseConnectionEventChannelHandler {
    private static final PhoneHandler instance = new PhoneHandler();

    public static PhoneHandler getInstance() {
        return instance;
    }

    @Override
    public void setConnListener(CRPBleConnection connection, MethodCall call) {
        connection.setPhoneOperationListener(operationChange -> {
            if (eventSink == null) {
                return;
            }
//            挂断电话
            if (operationChange == CRPPhoneOperationType.REJECT_INCOMING) {
                killPhoneCall();
            }
            new Handler(Looper.getMainLooper()).post(() -> {
                if (eventSink != null) eventSink.success(operationChange);
            });
        });
    }

    private void killPhoneCall() {
        try {
            tryEndCall();
            TelecomManager telecomManager = (TelecomManager) context.getSystemService(Context.TELECOM_SERVICE);
            Class<?> classTelephony = Class.forName(telecomManager.getClass().getName());
            Method methodGetITelephony = classTelephony.getDeclaredMethod("getITelephony");
            methodGetITelephony.setAccessible(true);
            Object telephonyInterface = methodGetITelephony.invoke(telecomManager);
            assert telephonyInterface != null;
            Class<?> telephonyInterfaceClass = Class.forName(telephonyInterface.getClass().getName());
            Method methodEndCall = telephonyInterfaceClass.getDeclaredMethod("endCall");
            methodEndCall.invoke(telephonyInterface);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void tryEndCall() {
        try {
            TelecomManager telecomManager = (TelecomManager) context.getSystemService(Context.TELECOM_SERVICE);
            if (telecomManager != null) {
                if (ActivityCompat.checkSelfPermission(context, Manifest.permission.ANSWER_PHONE_CALLS) != PackageManager.PERMISSION_GRANTED) {
                    // TODO: Consider calling
                    //    ActivityCompat#requestPermissions
                    // here to request the missing permissions, and then overriding
                    //   public void onRequestPermissionsResult(int requestCode, String[] permissions,
                    //                                          int[] grantResults)
                    // to handle the case where the user grants the permission. See the documentation
                    // for ActivityCompat#requestPermissions for more details.
                    return;
                }
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) {
                    telecomManager.endCall();
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}

