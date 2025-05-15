package com.moyoung.moyoung_ble_plugin.event;

import android.os.Handler;
import android.os.Looper;

import com.crrepa.ble.conn.CRPBleConnection;
import com.crrepa.ble.conn.bean.CRPGpsPathInfo;
import com.crrepa.ble.conn.listener.CRPGpsChangeListener;
import com.crrepa.ble.conn.type.CRPEpoType;
import com.moyoung.moyoung_ble_plugin.base.BaseConnectionEventChannelHandler;
import com.moyoung.moyoung_ble_plugin.common.GsonUtils;
import com.moyoung.moyoung_ble_plugin.model.GpsChangeEventBean;

import java.util.List;

import io.flutter.plugin.common.MethodCall;

public class GpsChangeEventHandler extends BaseConnectionEventChannelHandler  {
    private static final GpsChangeEventHandler instance = new GpsChangeEventHandler();
    public static GpsChangeEventHandler getInstance() {
        return instance;
    }
    @Override
    public void setConnListener(CRPBleConnection connection, MethodCall call) {
        connection.setGpsChangeListener(new CRPGpsChangeListener() {
            @Override
            public void onHistoryGpsPathChange(List<Integer> list) {
                if (eventSink == null) {
                    return;
                }
                GpsChangeEventBean gpsChangeEventBean = new GpsChangeEventBean(list);
                String jsonStr = GsonUtils.get().toJson(gpsChangeEventBean, GpsChangeEventBean.class);
                new Handler(Looper.getMainLooper()).post(() -> {
                    if (eventSink != null) eventSink.success(jsonStr);
                });
            }

            @Override
            public void onGpsPathChange(CRPGpsPathInfo gpsPathInfo) {
                if (eventSink == null) {
                    return;
                }
                GpsChangeEventBean gpsChangeEventBean = new GpsChangeEventBean(gpsPathInfo);
                String jsonStr = GsonUtils.get().toJson(gpsChangeEventBean, GpsChangeEventBean.class);
                new Handler(Looper.getMainLooper()).post(() -> {
                    if (eventSink != null) eventSink.success(jsonStr);
                });
            }

            @Override
            public void onLocationChanged(CRPGpsPathInfo.Location location) {
                if (eventSink == null) {
                    return;
                }
                GpsChangeEventBean gpsChangeEventBean = new GpsChangeEventBean(location);
                String jsonStr = GsonUtils.get().toJson(gpsChangeEventBean, GpsChangeEventBean.class);
                new Handler(Looper.getMainLooper()).post(() -> {
                    if (eventSink != null) eventSink.success(jsonStr);
                });
            }

            @Override
            public void onUpdateEpoChange(CRPEpoType epoType) {
                if (eventSink == null) {
                    return;
                }
                GpsChangeEventBean gpsChangeEventBean = new GpsChangeEventBean(epoType);
                String jsonStr = GsonUtils.get().toJson(gpsChangeEventBean, GpsChangeEventBean.class);
                new Handler(Looper.getMainLooper()).post(() -> {
                    if (eventSink != null) eventSink.success(jsonStr);
                });
            }
        });
    }
}
