package com.moyoung.moyoung_ble_plugin.model;

import com.crrepa.ble.conn.bean.CRPSleepInfo;


public class SleepBean {
    public static final int SLEEPCHANGE = 1;
    public static final int HISTORYSLEEPCHANGE = 2;
    public static final int GOALSLEEPTIMECHANGE = 3;

    private int type;
    CRPSleepInfo sleepInfo;
    HistorySleepBean historySleep;

    int goalSleepTime;

    public void setGoalSleepTime(int goalSleepTime) {
        this.goalSleepTime = goalSleepTime;
    }

    public SleepBean(int type) {
        this.type = type;
    }

    public CRPSleepInfo getSleepInfo() {
        return sleepInfo;
    }

    public void setSleepInfo(CRPSleepInfo sleepInfo) {
        this.sleepInfo = sleepInfo;
    }

    public HistorySleepBean getHistorySleep() {
        return historySleep;
    }

    public void setHistorySleep(HistorySleepBean historySleep) {
        this.historySleep = historySleep;
    }
}