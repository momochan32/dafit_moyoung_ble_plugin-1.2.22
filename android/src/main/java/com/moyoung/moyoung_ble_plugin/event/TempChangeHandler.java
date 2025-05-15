package com.moyoung.moyoung_ble_plugin.event;

import android.os.Handler;
import android.os.Looper;

import com.crrepa.ble.conn.CRPBleConnection;
import com.crrepa.ble.conn.bean.CRPTempInfo;
import com.crrepa.ble.conn.listener.CRPTempChangeListener;
import com.moyoung.moyoung_ble_plugin.base.BaseConnectionEventChannelHandler;
import com.moyoung.moyoung_ble_plugin.common.GsonUtils;
import com.moyoung.moyoung_ble_plugin.model.TempChangeBean;

import io.flutter.plugin.common.MethodCall;

public class TempChangeHandler extends BaseConnectionEventChannelHandler {
    TempChangeBean bean = new TempChangeBean();
    private static final TempChangeHandler instance = new TempChangeHandler();
    public static TempChangeHandler getInstance() {
        return instance;
    }
    @Override
    public void setConnListener(CRPBleConnection connection, MethodCall call) {
        connection.setTempChangeListener(new CRPTempChangeListener() {
            public void onContinueState(boolean enable) {
                if (eventSink == null) {
                    return;
                }
                bean.setType(bean.CONTINUE_STATE);
                bean.setEnable(enable);
                String jsonStr = GsonUtils.get().toJson(bean,TempChangeBean.class);
                new Handler(Looper.getMainLooper()).post(() -> {
                    if (eventSink != null) eventSink.success(jsonStr);
                });
            }

            public void onMeasureTemp(float temp) {
                if (eventSink == null) {
                    return;
                }
                bean.setType(bean.MEASURE_TEMP);
                bean.setTemp(temp);
                String jsonStr = GsonUtils.get().toJson(bean,TempChangeBean.class);
                new Handler(Looper.getMainLooper()).post(() -> {
                    if (eventSink != null) eventSink.success(jsonStr);
                });
            }

            public void onMeasureState(boolean state) {
                if (eventSink == null) {
                    return;
                }
                bean.setType(bean.MEASURE_STATE);
                bean.setState(state);
                String jsonStr = GsonUtils.get().toJson(bean,TempChangeBean.class);
                new Handler(Looper.getMainLooper()).post(() -> {
                    if (eventSink != null) eventSink.success(jsonStr);
                });
            }

            public void onContinueTemp(CRPTempInfo tempInfo) {
                if (eventSink == null) {
                    return;
                }
                bean.setType(bean.CONTINUE_TEMP);
                bean.setTempInfo(tempInfo);
                String jsonStr = GsonUtils.get().toJson(bean,TempChangeBean.class);
                new Handler(Looper.getMainLooper()).post(() -> {
                    if (eventSink != null) eventSink.success(jsonStr);
                });
            }
        });
    }
}
