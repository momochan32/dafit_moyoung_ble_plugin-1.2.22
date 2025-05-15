package com.moyoung.moyoung_ble_plugin.event;

import android.os.Handler;
import android.os.Looper;
import android.util.Log;

import com.crrepa.ble.conn.CRPBleConnection;
import com.moyoung.moyoung_ble_plugin.base.BaseConnectionEventChannelHandler;

import io.flutter.plugin.common.MethodCall;

public class BatterySavingHandler extends BaseConnectionEventChannelHandler {
    private static final BatterySavingHandler instance = new BatterySavingHandler();
    public static BatterySavingHandler getInstance() {
        return instance;
    }
    @Override
    public void setConnListener(CRPBleConnection connection, MethodCall call) {
        connection.setBatterySavingListener(batterSaving -> {
            if (eventSink == null) {
                return;
            }
            new Handler(Looper.getMainLooper()).post(() -> {
                if (eventSink != null) eventSink.success(batterSaving);
            });
        });
    }
}
