package com.moyoung.moyoung_ble_plugin.event;

import android.os.Handler;
import android.os.Looper;

import com.crrepa.ble.conn.CRPBleConnection;
import com.moyoung.moyoung_ble_plugin.base.BaseConnectionEventChannelHandler;

import io.flutter.plugin.common.MethodCall;

class DeviceRssiHandler extends BaseConnectionEventChannelHandler {
    private static final DeviceRssiHandler instance = new DeviceRssiHandler();
    public static DeviceRssiHandler getInstance() {
        return instance;
    }
    @Override
    public void setConnListener(CRPBleConnection connection, MethodCall call) {
        connection.setDeviceRssiListener(deviceRssi -> {
            if (eventSink == null) {
                return;
            }
            new Handler(Looper.getMainLooper()).post(() -> {
                if (eventSink != null) eventSink.success(deviceRssi);
            });
        });

    }

}

