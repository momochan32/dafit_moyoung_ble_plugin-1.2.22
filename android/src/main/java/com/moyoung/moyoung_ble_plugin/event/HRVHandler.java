package com.moyoung.moyoung_ble_plugin.event;

import android.os.Handler;
import android.os.Looper;

import com.crrepa.ble.conn.CRPBleConnection;
import com.crrepa.ble.conn.bean.CRPHistoryHrvInfo;
import com.crrepa.ble.conn.listener.CRPNewHrvChangeListener;
import com.moyoung.moyoung_ble_plugin.base.BaseConnectionEventChannelHandler;
import com.moyoung.moyoung_ble_plugin.common.GsonUtils;
import com.moyoung.moyoung_ble_plugin.model.HRVHandlerBean;

import java.util.List;

import io.flutter.plugin.common.MethodCall;

public class HRVHandler extends BaseConnectionEventChannelHandler {
    private static final HRVHandler instance = new HRVHandler();
    public static HRVHandler getInstance() {
        return instance;
    }
    @Override
    public void setConnListener(CRPBleConnection connection, MethodCall call) {
        connection.setNewHrvListener(new CRPNewHrvChangeListener() {
            @Override
            public void onSupportHrv(boolean isSupport) {
                if (eventSink == null) {
                    return;
                }
                HRVHandlerBean hrvHandlerBean = new HRVHandlerBean(HRVHandlerBean.SUPPORT, isSupport);
                String jsonStr = GsonUtils.get().toJson(hrvHandlerBean, HRVHandlerBean.class);
                new Handler(Looper.getMainLooper()).post(() -> {
                    if (eventSink != null) eventSink.success(jsonStr);
                });
            }

            @Override
            public void onHrv(int value) {
                if (eventSink == null) {
                    return;
                }
                HRVHandlerBean hrvHandlerBean = new HRVHandlerBean(HRVHandlerBean.HRV, value);
                String jsonStr = GsonUtils.get().toJson(hrvHandlerBean, HRVHandlerBean.class);
                new Handler(Looper.getMainLooper()).post(() -> {
                    if (eventSink != null) eventSink.success(jsonStr);
                });
            }

            @Override
            public void onHistoryHrv(List<CRPHistoryHrvInfo> list) {
                if (eventSink == null) {
                    return;
                }
                HRVHandlerBean hrvHandlerBean = new HRVHandlerBean(HRVHandlerBean.HISTORY, list);
                String jsonStr = GsonUtils.get().toJson(hrvHandlerBean, HRVHandlerBean.class);
                new Handler(Looper.getMainLooper()).post(() -> {
                    if (eventSink != null) eventSink.success(jsonStr);
                });
            }
        });
    }
}
