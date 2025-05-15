package com.moyoung.moyoung_ble_plugin.event;

import android.os.Handler;
import android.os.Looper;
import android.util.Log;

import com.crrepa.ble.conn.CRPBleConnection;
import com.crrepa.ble.conn.bean.CRPHeartRateInfo;
import com.crrepa.ble.conn.bean.CRPHistoryHeartRateInfo;
import com.crrepa.ble.conn.bean.CRPMovementHeartRateInfo;
import com.crrepa.ble.conn.listener.CRPHeartRateChangeListener;
import com.crrepa.ble.conn.type.CRPHistoryDay;
import com.crrepa.ble.conn.type.CRPHistoryDynamicRateType;
import com.moyoung.moyoung_ble_plugin.base.BaseConnectionEventChannelHandler;
import com.moyoung.moyoung_ble_plugin.common.GsonUtils;
import com.moyoung.moyoung_ble_plugin.model.HeartRateBean;
import com.moyoung.moyoung_ble_plugin.model.HeartRateInfoBean;
import com.moyoung.moyoung_ble_plugin.model.MeasureCompleteBean;

import java.util.ArrayList;
import java.util.List;

import io.flutter.plugin.common.MethodCall;

public class HeartRateHandler extends BaseConnectionEventChannelHandler {
    private static final HeartRateHandler instance = new HeartRateHandler();

    public static HeartRateHandler getInstance() {
        return instance;
    }

    @Override
    public void setConnListener(CRPBleConnection connection, MethodCall call) {
        connection.setHeartRateChangeListener(new CRPHeartRateChangeListener() {
            @Override
            public void onMeasuring(int measuring) {
                if (eventSink == null) {
                    return;
                }
                HeartRateBean heartRateBean = new HeartRateBean(HeartRateBean.MEASURING);
                heartRateBean.setMeasuring(measuring);
                String heartRateStr = GsonUtils.get().toJson(heartRateBean, HeartRateBean.class);
                new Handler(Looper.getMainLooper()).post(() -> {
                    if (eventSink != null) eventSink.success(heartRateStr);
                });
            }

            @Override
            public void onOnceMeasureComplete(int onceMeasureComplete) {
                if (eventSink == null) {
                    return;
                }
                HeartRateBean heartRateBean = new HeartRateBean(HeartRateBean.ONCEMEASURECOMPLETE);
                heartRateBean.setOnceMeasureComplete(onceMeasureComplete);
                String heartRateStr = GsonUtils.get().toJson(heartRateBean, HeartRateBean.class);
                new Handler(Looper.getMainLooper()).post(() -> {
                    if (eventSink != null) eventSink.success(heartRateStr);
                });
            }

            @Override
            public void onHistoryHeartRate(List<CRPHistoryHeartRateInfo> historyHRList) {
                if (eventSink == null) {
                    return;
                }
                HeartRateBean heartRateBean = new HeartRateBean(HeartRateBean.HEARTRATE);
                heartRateBean.setHistoryHRList(historyHRList);
                String heartRateStr = GsonUtils.get().toJson(heartRateBean, HeartRateBean.class);
                new Handler(Looper.getMainLooper()).post(() -> {
                    if (eventSink != null) eventSink.success(heartRateStr);
                });
            }

            @Override
            public void onMeasureComplete(CRPHistoryDynamicRateType historyDynamicRateType,
                                          CRPHeartRateInfo heartRateInfo) {
                if (eventSink == null) {
                    return;
                }
                HeartRateInfoBean heartRateInfoBean = new HeartRateInfoBean(heartRateInfo.getStartTime() / 1000, heartRateInfo.getHeartRateList(),
                        heartRateInfo.getTimeInterval(), heartRateInfo.isAllDay() ? 1 : 0, heartRateInfo.getHistoryDay());
                MeasureCompleteBean measureComplete = new MeasureCompleteBean(
                        historyDynamicRateType, heartRateInfoBean);
                HeartRateBean heartRateBean = new HeartRateBean(HeartRateBean.MEASURECOMPLETE);
                heartRateBean.setMeasureComplete(measureComplete);
                String heartRateStr = GsonUtils.get().toJson(heartRateBean, HeartRateBean.class);
                new Handler(Looper.getMainLooper()).post(() -> {
                    if (eventSink != null) eventSink.success(heartRateStr);
                });
            }

            @Override
            public void on24HourMeasureResult(CRPHeartRateInfo heartRateInfo) {
                if (eventSink == null) {
                    return;
                }

                HeartRateInfoBean heartRateInfoBean = new HeartRateInfoBean(heartRateInfo.getStartTime() / 1000, heartRateInfo.getHeartRateList(),
                        heartRateInfo.getTimeInterval(), heartRateInfo.isAllDay() ? 1 : 0, heartRateInfo.getHistoryDay());
                HeartRateBean heartRateBean = new HeartRateBean(HeartRateBean.HOURMEASURERESULTOF24);
                heartRateBean.setHour24MeasureResult(heartRateInfoBean);
                String heartRateStr = GsonUtils.get().toJson(heartRateBean, HeartRateBean.class);
                new Handler(Looper.getMainLooper()).post(() -> {
                    if (eventSink != null) eventSink.success(heartRateStr);
                });
            }

            @Override
            public void onMovementMeasureResult(List<CRPMovementHeartRateInfo> movementMeasureList) {
                if (eventSink == null) {
                    return;
                }
                HeartRateBean heartRateBean = new HeartRateBean(HeartRateBean.MOVEMENTMEASURERESULT);
                List<CRPMovementHeartRateInfo> _movementMeasureList = new ArrayList<>();
                for (int i = 0; i < movementMeasureList.size(); i++) {
                    if (movementMeasureList.get(i).getStartTime() > 1000000000) {
                        long startTime = movementMeasureList.get(i).getStartTime() / 1000;
                        long endTime = movementMeasureList.get(i).getEndTime() / 1000;
                        movementMeasureList.get(i).setStartTime(startTime);
                        movementMeasureList.get(i).setEndTime(endTime);
                        _movementMeasureList.add(movementMeasureList.get(i));
                    }
                }
                heartRateBean.setTrainingList(_movementMeasureList);
                String heartRateStr = GsonUtils.get().toJson(heartRateBean, HeartRateBean.class);
                new Handler(Looper.getMainLooper()).post(() -> {
                    if (eventSink != null) eventSink.success(heartRateStr);
                });
            }
        });
    }

}

