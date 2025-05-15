package com.moyoung.moyoung_ble_plugin.event;

import android.os.Handler;
import android.os.Looper;
import android.util.Log;

import com.crrepa.ble.conn.CRPBleConnection;
import com.crrepa.ble.conn.bean.CRPSleepInfo;
import com.crrepa.ble.conn.listener.CRPSleepChangeListener;
import com.crrepa.ble.conn.type.CRPHistoryDay;
import com.moyoung.moyoung_ble_plugin.base.BaseConnectionEventChannelHandler;
import com.moyoung.moyoung_ble_plugin.common.GsonUtils;
import com.moyoung.moyoung_ble_plugin.model.HistorySleepBean;
import com.moyoung.moyoung_ble_plugin.model.SleepBean;

import java.util.ArrayList;

import io.flutter.plugin.common.MethodCall;

public class SleepChangeHandler extends BaseConnectionEventChannelHandler {
    private static final SleepChangeHandler instance = new SleepChangeHandler();
    public static SleepChangeHandler getInstance() {
        return instance;
    }
    @Override
    public void setConnListener(CRPBleConnection connection, MethodCall call) {
        connection.setSleepChangeListener(new CRPSleepChangeListener() {
            @Override
            public void onSleepChange(CRPSleepInfo sleepInfo) {
                if (eventSink == null) {
                    return;
                }
                if (sleepInfo.getDetails() == null) {
                    sleepInfo.setDetails(new ArrayList<>());
                }
                SleepBean sleepBean = new SleepBean(SleepBean.SLEEPCHANGE);
                sleepBean.setSleepInfo(sleepInfo);
                String sleepStr = GsonUtils.get().toJson(sleepBean, SleepBean.class);
                new Handler(Looper.getMainLooper()).post(() -> {
                    if (eventSink != null) eventSink.success(sleepStr);
                });
            }

            @Override
            public void onHistorySleepChange(CRPHistoryDay historyDay, CRPSleepInfo sleepInfo) {
                if (eventSink == null) {
                    return;
                }
                if (sleepInfo.getDetails() == null) {
                    sleepInfo.setDetails(new ArrayList<>());
                }
                HistorySleepBean historySleep = new HistorySleepBean(historyDay, sleepInfo);
                SleepBean sleepBean = new SleepBean(SleepBean.HISTORYSLEEPCHANGE);
                sleepBean.setHistorySleep(historySleep);
                String sleepStr = GsonUtils.get().toJson(sleepBean, SleepBean.class);
                new Handler(Looper.getMainLooper()).post(() -> {
                    if (eventSink != null) eventSink.success(sleepStr);
                });
            }

            @Override
            public void onGoalSleepTime(int goalSleepTime) {
                if (eventSink == null) {
                    return;
                }
                SleepBean sleepBean = new SleepBean(SleepBean.GOALSLEEPTIMECHANGE);
                sleepBean.setGoalSleepTime(goalSleepTime);
                String sleepStr = GsonUtils.get().toJson(sleepBean, SleepBean.class);
                new Handler(Looper.getMainLooper()).post(() -> {
                    if (eventSink != null) eventSink.success(sleepStr);
                });
            }
        });
    }

}
