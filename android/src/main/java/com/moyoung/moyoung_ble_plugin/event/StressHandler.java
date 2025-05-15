package com.moyoung.moyoung_ble_plugin.event;

import android.os.Handler;
import android.os.Looper;

import androidx.annotation.NonNull;

import com.crrepa.ble.conn.CRPBleConnection;
import com.crrepa.ble.conn.bean.CRPHistoryStressInfo;
import com.crrepa.ble.conn.bean.CRPTimingStressInfo;
import com.crrepa.ble.conn.listener.CRPStressListener;
import com.moyoung.moyoung_ble_plugin.base.BaseConnectionEventChannelHandler;
import com.moyoung.moyoung_ble_plugin.common.GsonUtils;
import com.moyoung.moyoung_ble_plugin.model.HistoryStressBean;
import com.moyoung.moyoung_ble_plugin.model.StressHandlerBean;

import java.util.ArrayList;
import java.util.List;

import io.flutter.plugin.common.MethodCall;

public class StressHandler extends BaseConnectionEventChannelHandler {
    private static final StressHandler instance = new StressHandler();
    public static StressHandler getInstance() {
        return instance;
    }
    @Override
    public void setConnListener(CRPBleConnection connection, MethodCall call) {
        connection.setStressListener(new CRPStressListener() {
            @Override
            public void onSupportStress(boolean isSupport) {
                if (eventSink == null) {
                    return;
                }
                StressHandlerBean stressHandler = new StressHandlerBean(StressHandlerBean.SUPPORT, isSupport);
                String jsonStr = GsonUtils.get().toJson(stressHandler, StressHandlerBean.class);
                new Handler(Looper.getMainLooper()).post(() -> {
                    if (eventSink != null) eventSink.success(jsonStr);
                });
            }

            @Override
            public void onStressChange(int value) {
                if (eventSink == null) {
                    return;
                }
                StressHandlerBean stressHandler = new StressHandlerBean(StressHandlerBean.CHANGE, value);
                String jsonStr = GsonUtils.get().toJson(stressHandler, StressHandlerBean.class);
                new Handler(Looper.getMainLooper()).post(() -> {
                    if (eventSink != null) eventSink.success(jsonStr);
                });
            }

            @Override
            public void onHistoryStressChange(List<CRPHistoryStressInfo> list) {
                if (eventSink == null) {
                    return;
                }
                StressHandlerBean stressHandler = getStressHandlerBean(list);
                String jsonStr = GsonUtils.get().toJson(stressHandler, StressHandlerBean.class);
                new Handler(Looper.getMainLooper()).post(() -> {
                    if (eventSink != null) eventSink.success(jsonStr);
                });
            }

            @NonNull
            private StressHandlerBean getStressHandlerBean(List<CRPHistoryStressInfo> list) {
                List<HistoryStressBean> historyStressList = new ArrayList<>();
                for (int i = 0; i < list.size(); i++) {
                    long time = list.get(i).getDate().getTime();
                    if (time > 1000000000) {
                        time = time / 1000;
                    }
                    HistoryStressBean stressBean = new HistoryStressBean(time, list.get(i).getStress());
                    historyStressList.add(stressBean);
                }
                StressHandlerBean stressHandler = new StressHandlerBean(StressHandlerBean.HISTORY_CHANGE, historyStressList);
                return stressHandler;
            }

            @Override
            public void onTimingStressStateChange(boolean state) {
                if (eventSink == null) {
                    return;
                }
                StressHandlerBean stressHandler = new StressHandlerBean(StressHandlerBean.TIMING_STATE_CHANGE, state);
                String jsonStr = GsonUtils.get().toJson(stressHandler, StressHandlerBean.class);
                new Handler(Looper.getMainLooper()).post(() -> {
                    if (eventSink != null) eventSink.success(jsonStr);
                });
            }

            @Override
            public void onTimingStressChange(CRPTimingStressInfo timingStressInfo) {
                if (eventSink == null) {
                    return;
                }
                StressHandlerBean stressHandler = new StressHandlerBean(StressHandlerBean.TIMING_CHANGE, timingStressInfo);
                String jsonStr = GsonUtils.get().toJson(stressHandler, StressHandlerBean.class);
                new Handler(Looper.getMainLooper()).post(() -> {
                    if (eventSink != null) eventSink.success(jsonStr);
                });
            }
        });
    }
}
