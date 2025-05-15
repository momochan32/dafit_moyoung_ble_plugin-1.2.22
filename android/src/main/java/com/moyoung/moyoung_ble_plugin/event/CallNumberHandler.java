package com.moyoung.moyoung_ble_plugin.event;

import android.os.Handler;
import android.os.Looper;
import android.util.Log;

import com.crrepa.ble.conn.CRPBleConnection;
import com.moyoung.moyoung_ble_plugin.base.BaseConnectionEventChannelHandler;

import io.flutter.plugin.common.MethodCall;

public class CallNumberHandler extends BaseConnectionEventChannelHandler {
    private static final CallNumberHandler instance = new CallNumberHandler();
    public static CallNumberHandler getInstance() {
        return instance;
    }
    @Override
    public void setConnListener(CRPBleConnection connection, MethodCall call) {
        connection.setCallNumberListener(number -> {
            Log.i(CallNumberHandler.class.getName(), "setConnListener: " + eventSink);
            if (eventSink == null) {
                return;
            }
            new Handler(Looper.getMainLooper()).post(() -> {
                if (eventSink != null) eventSink.success(number);
            });
        });
    }
}
