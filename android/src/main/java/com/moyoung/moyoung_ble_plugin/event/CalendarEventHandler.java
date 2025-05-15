package com.moyoung.moyoung_ble_plugin.event;

import android.os.Handler;
import android.os.Looper;

import com.crrepa.ble.conn.CRPBleConnection;
import com.crrepa.ble.conn.bean.CRPCalendarEventInfo;
import com.crrepa.ble.conn.bean.CRPSavedCalendarEventInfo;
import com.crrepa.ble.conn.listener.CRPCalendarEventListener;
import com.moyoung.moyoung_ble_plugin.base.BaseConnectionEventChannelHandler;
import com.moyoung.moyoung_ble_plugin.common.GsonUtils;
import com.moyoung.moyoung_ble_plugin.model.CalendarEventBean;

import java.util.List;

import io.flutter.plugin.common.MethodCall;

public class CalendarEventHandler extends BaseConnectionEventChannelHandler {
    private static final CalendarEventHandler instance = new CalendarEventHandler();
    public static CalendarEventHandler getInstance() {
        return instance;
    }
    @Override
    public void setConnListener(CRPBleConnection connection, MethodCall call) {
        connection.setCalendarEventListener(new CRPCalendarEventListener() {
            @Override
            public void onSupportEvent(int maxNumber, List<CRPSavedCalendarEventInfo> list) {
                if (eventSink == null) {
                    return;
                }
                CalendarEventBean calendarEventBean = new CalendarEventBean(CalendarEventBean.SUPPORT, maxNumber, list);
                String jsonStr = GsonUtils.get().toJson(calendarEventBean, CalendarEventBean.class);
                new Handler(Looper.getMainLooper()).post(() -> {
                    if (eventSink != null) eventSink.success(jsonStr);
                });
            }

            @Override
            public void onEvent(CRPCalendarEventInfo calendarEventInfo) {
                if (eventSink == null) {
                    return;
                }
                CalendarEventBean calendarEventBean = new CalendarEventBean(CalendarEventBean.DETAILS, calendarEventInfo);
                String jsonStr = GsonUtils.get().toJson(calendarEventBean, CalendarEventBean.class);
                new Handler(Looper.getMainLooper()).post(() -> {
                    if (eventSink != null) eventSink.success(jsonStr);
                });
            }

            @Override
            public void onEventReminderTime(boolean state, int time) {
                if (eventSink == null) {
                    return;
                }
                CalendarEventBean calendarEventBean = new CalendarEventBean(CalendarEventBean.STATE_AND_TIME, state, time);
                String jsonStr = GsonUtils.get().toJson(calendarEventBean, CalendarEventBean.class);
                new Handler(Looper.getMainLooper()).post(() -> {
                    if (eventSink != null) eventSink.success(jsonStr);
                });
            }
        });
    }
}
