package com.moyoung.moyoung_ble_plugin.event;

import android.os.Handler;
import android.os.Looper;
import android.util.Log;

import com.crrepa.ble.conn.CRPBleConnection;
import com.crrepa.ble.conn.bean.CRPBloodOxygenInfo;
import com.crrepa.ble.conn.bean.CRPHistoryBloodOxygenInfo;
import com.crrepa.ble.conn.listener.CRPBloodOxygenChangeListener;
import com.moyoung.moyoung_ble_plugin.base.BaseConnectionEventChannelHandler;
import com.moyoung.moyoung_ble_plugin.common.GsonUtils;
import com.moyoung.moyoung_ble_plugin.model.BloodOxygenBean;

import java.util.List;

import io.flutter.plugin.common.MethodCall;

public class BloodOxygenHandler extends BaseConnectionEventChannelHandler {
    private static final BloodOxygenHandler instance = new BloodOxygenHandler();
    public static BloodOxygenHandler getInstance() {
        return instance;
    }
    @Override
    public void setConnListener(CRPBleConnection connection, MethodCall call) {
        connection.setBloodOxygenChangeListener(new CRPBloodOxygenChangeListener() {
            @Override
            public void onContinueState(boolean continueState) {
                if (eventSink == null) {
                    return;
                }
                BloodOxygenBean bloodOxygenBean = new BloodOxygenBean(BloodOxygenBean.CONTINUESTATE);
                bloodOxygenBean.setContinueState(continueState);
                String boStr = GsonUtils.get().toJson(bloodOxygenBean, BloodOxygenBean.class);
                new Handler(Looper.getMainLooper()).post(() -> {
                    if (eventSink != null) eventSink.success(boStr);
                });
            }

            @Override
            public void onTimingMeasure(int timingMeasure) {
                if (eventSink == null) {
                    return;
                }
                BloodOxygenBean bloodOxygenBean = new BloodOxygenBean(BloodOxygenBean.TIMINGMEASURE);
                bloodOxygenBean.setTimingMeasure(timingMeasure);
                String boStr = GsonUtils.get().toJson(bloodOxygenBean, BloodOxygenBean.class);
                new Handler(Looper.getMainLooper()).post(() -> {
                    if (eventSink != null) eventSink.success(boStr);
                });
            }

            @Override
            public void onBloodOxygen(int bloodOxygen) {
                if (eventSink == null) {
                    return;
                }
                BloodOxygenBean bloodOxygenBean = new BloodOxygenBean(BloodOxygenBean.BLOODOXYGEN);
                bloodOxygenBean.setBloodOxygen(bloodOxygen);
                String boStr = GsonUtils.get().toJson(bloodOxygenBean, BloodOxygenBean.class);
                new Handler(Looper.getMainLooper()).post(() -> {
                    if (eventSink != null) eventSink.success(boStr);
                });
            }

            @Override
            public void onHistoryBloodOxygen(List<CRPHistoryBloodOxygenInfo> historyBOList) {
                if (eventSink == null) {
                    return;
                }
                BloodOxygenBean bloodOxygenBean = new BloodOxygenBean(BloodOxygenBean.HISTORYLIST);
                bloodOxygenBean.setHistoryList(historyBOList);
                String boStr = GsonUtils.get().toJson(bloodOxygenBean, BloodOxygenBean.class);
                new Handler(Looper.getMainLooper()).post(() -> {
                    if (eventSink != null) eventSink.success(boStr);
                });
            }

            @Override
            public void onContinueBloodOxygen(CRPBloodOxygenInfo crpBloodOxygenInfo) {
                if (eventSink == null) {
                    return;
                }
                BloodOxygenBean bloodOxygenBean = new BloodOxygenBean(BloodOxygenBean.CONTINUEBO);
                bloodOxygenBean.setContinueBO(crpBloodOxygenInfo);
                String boStr = GsonUtils.get().toJson(bloodOxygenBean, BloodOxygenBean.class);
                new Handler(Looper.getMainLooper()).post(() -> {
                    if (eventSink != null) eventSink.success(boStr);
                });
            }
        });
    }

}

