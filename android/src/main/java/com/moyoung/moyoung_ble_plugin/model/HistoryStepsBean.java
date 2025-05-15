package com.moyoung.moyoung_ble_plugin.model;

import com.crrepa.ble.conn.bean.CRPStepInfo;
import com.crrepa.ble.conn.type.CRPHistoryDay;

public class HistoryStepsBean {
    private CRPHistoryDay historyDay;
    private CRPStepInfo stepsInfo;

    public CRPHistoryDay getHistoryDay() {
        return historyDay;
    }

    public void setHistoryDay(CRPHistoryDay historyDay) {
        this.historyDay = historyDay;
    }

    public CRPStepInfo getStepsInfo() {
        return stepsInfo;
    }

    public void setStepsInfo(CRPStepInfo stepsInfo) {
        this.stepsInfo = stepsInfo;
    }

}
