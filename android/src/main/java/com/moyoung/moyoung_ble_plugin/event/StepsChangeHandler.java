package com.moyoung.moyoung_ble_plugin.event;

import android.os.Handler;
import android.os.Looper;

import com.crrepa.ble.conn.CRPBleConnection;
import com.crrepa.ble.conn.bean.CRPStepInfo;
import com.crrepa.ble.conn.listener.CRPStepChangeListener;
import com.crrepa.ble.conn.type.CRPHistoryDay;
import com.moyoung.moyoung_ble_plugin.base.BaseConnectionEventChannelHandler;
import com.moyoung.moyoung_ble_plugin.common.GsonUtils;
import com.moyoung.moyoung_ble_plugin.model.HistoryStepsBean;
import com.moyoung.moyoung_ble_plugin.model.HistoryStepsChangeBean;
import com.moyoung.moyoung_ble_plugin.model.StepsChangeBean;

import io.flutter.plugin.common.MethodCall;

public class StepsChangeHandler extends BaseConnectionEventChannelHandler {
    private static final StepsChangeHandler instance = new StepsChangeHandler();
    public static StepsChangeHandler getInstance() {
        return instance;
    }
    @Override
    public void setConnListener(CRPBleConnection connection, MethodCall call) {
        connection.setStepChangeListener(new CRPStepChangeListener() {
            @Override
            public void onStepChange(CRPStepInfo stepInfo) {
                if (eventSink == null) {
                    return;
                }
                StepsChangeBean stepsChangeBean = new StepsChangeBean();
                stepsChangeBean.setType(StepsChangeBean.STEP_CHANGE);
                stepsChangeBean.setStepsInfo(stepInfo);
                String stepsStr = GsonUtils.get().toJson(stepsChangeBean, StepsChangeBean.class);
                new Handler(Looper.getMainLooper()).post(() -> {
                    if (eventSink != null) eventSink.success(stepsStr);
                });
            }

            @Override
            public void onHistoryStepChange(CRPHistoryDay historyDay, CRPStepInfo stepsInfo) {
                if (eventSink == null) {
                    return;
                }
                HistoryStepsBean historyStepsInfo = new HistoryStepsBean();
                historyStepsInfo.setHistoryDay(historyDay);
                historyStepsInfo.setStepsInfo(stepsInfo);
                HistoryStepsChangeBean historyStepsChangeBean = new HistoryStepsChangeBean();
                historyStepsChangeBean.setType(HistoryStepsChangeBean.HISTORY_STEP_CHANGE);
                historyStepsChangeBean.setHistoryStepsInfo(historyStepsInfo);
                String stepsStr = GsonUtils.get().toJson(historyStepsChangeBean, HistoryStepsChangeBean.class);
                new Handler(Looper.getMainLooper()).post(() -> {
                    if (eventSink != null) eventSink.success(stepsStr);
                });
            }
        });
    }

}
