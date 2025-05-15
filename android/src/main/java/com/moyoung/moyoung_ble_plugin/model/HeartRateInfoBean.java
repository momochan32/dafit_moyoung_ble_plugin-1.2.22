package com.moyoung.moyoung_ble_plugin.model;

import com.crrepa.ble.conn.type.CRPHistoryDay;

import java.util.List;

public class HeartRateInfoBean {
    private long startTime;
    private List<Integer> heartRateList;
    private int timeInterval;
    private int isAllDay;
    private CRPHistoryDay historyDay;

    public HeartRateInfoBean(long startTime, List<Integer> heartRateList, int timeInterval, int isAllDay, CRPHistoryDay historyDay) {
        this.startTime = startTime;
        this.heartRateList = heartRateList;
        this.timeInterval = timeInterval;
        this.isAllDay = isAllDay;
        this.historyDay = historyDay;
    }

    public HeartRateInfoBean() {
    }

    public long getStartTime() {
        return startTime;
    }

    public void setStartTime(long startTime) {
        this.startTime = startTime;
    }

    public List<Integer> getHeartRateList() {
        return heartRateList;
    }

    public void setHeartRateList(List<Integer> heartRateList) {
        this.heartRateList = heartRateList;
    }

    public int getTimeInterval() {
        return timeInterval;
    }

    public void setTimeInterval(int timeInterval) {
        this.timeInterval = timeInterval;
    }

    public int getIsAllDay() {
        return isAllDay;
    }

    public void setIsAllDay(int isAllDay) {
        this.isAllDay = isAllDay;
    }

    public CRPHistoryDay getHistoryDay() {
        return historyDay;
    }

    public void setHistoryDay(CRPHistoryDay historyDay) {
        this.historyDay = historyDay;
    }
}
