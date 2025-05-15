package com.moyoung.moyoung_ble_plugin.event;

import android.os.Handler;
import android.os.Looper;
import android.util.Log;

import com.crrepa.ble.conn.CRPBleConnection;
import com.crrepa.ble.conn.listener.CRPDeviceBatteryListener;
import com.moyoung.moyoung_ble_plugin.base.BaseConnectionEventChannelHandler;
import com.moyoung.moyoung_ble_plugin.common.GsonUtils;
import com.moyoung.moyoung_ble_plugin.model.DeviceBatteryBean;

import io.flutter.plugin.common.MethodCall;

public class DeviceBatteryHandler extends BaseConnectionEventChannelHandler {
    private static final DeviceBatteryHandler instance = new DeviceBatteryHandler();
    public static DeviceBatteryHandler getInstance() {
        return instance;
    }
    @Override
    public void setConnListener(CRPBleConnection connection, MethodCall call) {
        Log.i(DeviceBatteryHandler.class.getName(), "setConnListener: " + connection);
        connection.setDeviceBatteryListener(new CRPDeviceBatteryListener() {
            @Override
            public void onSubscribe(boolean subscribe) {
                Log.i(DeviceBatteryHandler.class.getName(), "onSubscribe: " + subscribe);
                if (eventSink == null) {
                    return;
                }
                DeviceBatteryBean device = new DeviceBatteryBean(DeviceBatteryBean.SUBSCRIBE);
                device.setSubscribe(subscribe);
                String jsonStr = GsonUtils.get().toJson(device, DeviceBatteryBean.class);
                new Handler(Looper.getMainLooper()).post(() -> {
                    if (eventSink != null) eventSink.success(jsonStr);
                });
            }

            @Override
            public void onDeviceBattery(int deviceBattery) {
                Log.i(DeviceBatteryHandler.class.getName(), "onDeviceBattery: " + deviceBattery);
                Log.i(DeviceBatteryHandler.class.getName(), "onDeviceBattery: " + eventSink);
                if (eventSink == null) {
                    return;
                }
                DeviceBatteryBean device = new DeviceBatteryBean(DeviceBatteryBean.DEVICEBATTERY);
                device.setDeviceBattery(deviceBattery);
                String jsonStr = GsonUtils.get().toJson(device, DeviceBatteryBean.class);
                new Handler(Looper.getMainLooper()).post(() -> {
                    if (eventSink != null) eventSink.success(jsonStr);
                });
            }
        });
    }

}

