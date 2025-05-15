package com.moyoung.moyoung_ble_plugin.event;

import android.os.Handler;
import android.os.Looper;
import android.util.Log;

import com.crrepa.ble.conn.CRPBleConnection;
import com.crrepa.ble.conn.listener.CRPCameraOperationListener;
import com.moyoung.moyoung_ble_plugin.base.BaseConnectionEventChannelHandler;
import com.moyoung.moyoung_ble_plugin.common.GsonUtils;
import com.moyoung.moyoung_ble_plugin.method.ConnectionMethodHandler;
import com.moyoung.moyoung_ble_plugin.model.CameraBean;


import io.flutter.plugin.common.MethodCall;

public class CameraHandler extends BaseConnectionEventChannelHandler {
    private static final CameraHandler instance = new CameraHandler();
    public static CameraHandler getInstance() {
        return instance;
    }
    public static int delayTime = 0;
    @Override
    public void setConnListener(CRPBleConnection connection, MethodCall call) {
        connection.setCameraOperationListener((new CRPCameraOperationListener() {
            @Override
            public void onTakePhoto() {
                if (eventSink == null) {
                    return;
                }
                if (ConnectionMethodHandler.supportDelayTime) {
                    ConnectionMethodHandler.isConnectedCall = false;
                    connection.queryDelayTaking();
                } else {
                    CameraBean cameraBean = new CameraBean();
                    cameraBean.setTakePhoto("takePhoto");
                    CameraHandler.delayTime = 0;
                    cameraBean.setDelayTime(CameraHandler.delayTime);
                    String cameraStr = GsonUtils.get().toJson(cameraBean, CameraBean.class);
                    new Handler(Looper.getMainLooper()).post(() -> {
                        if (eventSink != null) eventSink.success(cameraStr);
                    });
                }
            }

            @Override
            public void onDelayTaking(int delayTime) {
                if (ConnectionMethodHandler.isConnectedCall) {
                    ConnectionMethodHandler.supportDelayTime(true);
                } else {
                    CameraHandler.delayTime = delayTime;
                    if (eventSink == null) {
                        return;
                    }
                    CameraBean cameraBean = new CameraBean();
                    cameraBean.setTakePhoto("takePhoto");
                    cameraBean.setDelayTime(delayTime);
                    String cameraStr = GsonUtils.get().toJson(cameraBean, CameraBean.class);
                    new Handler(Looper.getMainLooper()).post(() -> {
                        if (eventSink != null) eventSink.success(cameraStr);
                    });
                }
            }

            @Override
            public void onExitCamera() {

            }
        }));
    }

}

