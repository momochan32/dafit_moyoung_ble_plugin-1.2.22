package com.moyoung.moyoung_ble_plugin.model;

import com.crrepa.ble.conn.bean.CRPSleepInfo;
import com.crrepa.ble.conn.type.CRPHistoryDay;

public class HistorySleepBean {
    private int timeType;
    private CRPSleepInfo sleepInfo;
    private CRPHistoryDay historyDay;

    public HistorySleepBean(int timeType, CRPSleepInfo sleepInfo) {
        this.timeType = timeType;
        this.sleepInfo = sleepInfo;
    }

    public HistorySleepBean(CRPHistoryDay historyDay, CRPSleepInfo sleepInfo) {
        this.historyDay = historyDay;
        this.sleepInfo = sleepInfo;
    }

    public int getTimeType() {
        return timeType;
    }

    public void setTimeType(int timeType) {
        this.timeType = timeType;
    }

    public CRPSleepInfo getleepInfo() {
        return sleepInfo;
    }

    public void setSleepInfo(CRPSleepInfo sleepInfo) {
        sleepInfo = sleepInfo;
    }
}
