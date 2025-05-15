package com.moyoung.moyoung_ble_plugin.event;

import android.os.Handler;
import android.os.Looper;

import com.crrepa.ble.conn.CRPBleConnection;
import com.crrepa.ble.conn.listener.CRPBleECGChangeListener;
import com.crrepa.ble.conn.type.CRPEcgMeasureType;
import com.moyoung.moyoung_ble_plugin.base.BaseConnectionEventChannelHandler;
import com.moyoung.moyoung_ble_plugin.common.GsonUtils;
import com.moyoung.moyoung_ble_plugin.model.ECGBean;

import java.util.Date;

import io.flutter.plugin.common.MethodCall;

public class ECGHandler extends BaseConnectionEventChannelHandler {
    private static final ECGHandler instance = new ECGHandler();
    public static ECGHandler getInstance() {
        return instance;
    }
    @Override
    public void setConnListener(CRPBleConnection connection, MethodCall call) {
        String ecgMeasureType = call.argument("ecgMeasureType");
        ecgMeasureType = ecgMeasureType == null ? CRPEcgMeasureType.TI.toString() : ecgMeasureType;

        connection.setECGChangeListener(new CRPBleECGChangeListener() {
            @Override
            public void onECGChange(int[] ECGChangeInts) {
                if (eventSink == null) {
                    return;
                }

                ECGBean bean = new ECGBean(ECGBean.INTS);
                bean.setECGChangeInts(ECGChangeInts);
                String ecgStr = GsonUtils.get().toJson(bean, ECGBean.class);
                new Handler(Looper.getMainLooper()).post(() -> {
                    if(eventSink != null) eventSink.success(ecgStr);
                });
            }

            @Override
            public void onMeasureComplete() {
                if (eventSink == null) {
                    return;
                }
                ECGBean bean = new ECGBean(ECGBean.MEASURECOMPLETE);
                String ecgStr = GsonUtils.get().toJson(bean, ECGBean.class);
                new Handler(Looper.getMainLooper()).post(() -> {
                    if (eventSink != null) eventSink.success(ecgStr);
                });
            }

            @Override
            public void onTransCpmplete(Date date) {
                if (eventSink == null) {
                    return;
                }

                ECGBean bean = new ECGBean(ECGBean.DATE);
                bean.setDate(date);
                String ecgStr = GsonUtils.get().toJson(bean, ECGBean.class);
                new Handler(Looper.getMainLooper()).post(() -> {
                    if (eventSink != null) eventSink.success(ecgStr);
                });
            }

            @Override
            public void onCancel() {
                if (eventSink == null) {
                    return;
                }
                ECGBean bean = new ECGBean(ECGBean.CANCEL);
                String ecgStr = GsonUtils.get().toJson(bean, ECGBean.class);
                new Handler(Looper.getMainLooper()).post(() -> {
                    if (eventSink != null) eventSink.success(ecgStr);
                });
            }

            @Override
            public void onFail() {
                if (eventSink == null) {
                    return;
                }
                ECGBean bean = new ECGBean(ECGBean.FAIL);
                String ecgStr = GsonUtils.get().toJson(bean, ECGBean.class);
                new Handler(Looper.getMainLooper()).post(() -> {
                    if (eventSink != null) eventSink.success(ecgStr);
                });
            }
        }, CRPEcgMeasureType.valueOf(ecgMeasureType));
    }
}

