package com.moyoung.moyoung_ble_plugin.model;

import com.crrepa.ble.conn.bean.CRPCalendarEventInfo;
import com.crrepa.ble.conn.bean.CRPSavedCalendarEventInfo;

import java.util.List;

public class CalendarEventBean {
    public static final int SUPPORT = 1;
    public static final int DETAILS = 2;
    public static final int STATE_AND_TIME = 3;

    private int type;
    private int maxNumber;
    private List<CRPSavedCalendarEventInfo> list;
    private boolean state;
    private int time;
    CRPCalendarEventInfo calendarEventInfo;

    public CalendarEventBean(int type, int maxNumber, List<CRPSavedCalendarEventInfo> list) {
        this.type = type;
        this.maxNumber = maxNumber;
        this.list = list;
    }

    public CalendarEventBean(int type, boolean state, int time) {
        this.type = type;
        this.state = state;
        this.time = time;
    }

    public CalendarEventBean(int type, CRPCalendarEventInfo calendarEventInfo) {
        this.type = type;
        this.calendarEventInfo = calendarEventInfo;
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

    public boolean isState() {
        return state;
    }

    public void setState(boolean state) {
        this.state = state;
    }

    public int getTime() {
        return time;
    }

    public void setTime(int time) {
        this.time = time;
    }

    public CRPCalendarEventInfo getCalendarEventInfo() {
        return calendarEventInfo;
    }

    public void setCalendarEventInfo(CRPCalendarEventInfo calendarEventInfo) {
        this.calendarEventInfo = calendarEventInfo;
    }

    public int getMaxNumber() {
        return maxNumber;
    }

    public void setMaxNumber(int maxNumber) {
        this.maxNumber = maxNumber;
    }

    public List<CRPSavedCalendarEventInfo> getList() {
        return list;
    }

    public void setList(List<CRPSavedCalendarEventInfo> list) {
        this.list = list;
    }
}
