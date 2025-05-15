package com.moyoung.moyoung_ble_plugin.event;

import android.annotation.SuppressLint;
import android.os.Handler;
import android.os.Looper;
import android.util.Log;

import com.crrepa.ble.conn.CRPBleConnection;
import com.crrepa.ble.conn.listener.CRPMovementStateListener;
import com.moyoung.moyoung_ble_plugin.base.BaseConnectionEventChannelHandler;

import io.flutter.plugin.common.MethodCall;

public class TrainingStateHandler extends BaseConnectionEventChannelHandler {
    private static final TrainingStateHandler instance = new TrainingStateHandler();
    public static TrainingStateHandler getInstance() {
        return instance;
    }
    @Override
    public void setConnListener(CRPBleConnection connection, MethodCall call) {
        connection.setMovementStateListener(new CRPMovementStateListener() {
            @Override
            public void onMeasureState(int measureState) {
                if (eventSink == null) {
                    return;
                }
                new Handler(Looper.getMainLooper()).post(() -> {
                    if (eventSink != null) eventSink.success(measureState);
                });
            }

            @Override
            public void onMeasuring(int measuring) {
                if (eventSink == null) {
                    return;
                }
                new Handler(Looper.getMainLooper()).post(() -> {
                    if (eventSink != null) eventSink.success(measuring);
                });
            }

            @Override
            public void onStartSuccess(int i) {

            }

            @Override
            public void onStartFailed() {

            }
        });
    }
}
