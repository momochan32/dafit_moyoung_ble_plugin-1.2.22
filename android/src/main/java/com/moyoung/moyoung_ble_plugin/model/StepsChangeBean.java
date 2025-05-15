package com.moyoung.moyoung_ble_plugin.model;

import com.crrepa.ble.conn.bean.CRPStepInfo;
import com.crrepa.ble.conn.type.CRPHistoryDay;

public class StepsChangeBean {
    private CRPStepInfo stepsInfo;
    private CRPHistoryDay historyDay;
    private int type;

    public static final int STEP_CHANGE = 1;

    public StepsChangeBean(CRPStepInfo stepsInfo, CRPHistoryDay historyDay, int timeType) {
        this.stepsInfo = stepsInfo;
        this.historyDay = historyDay;
        this.type = timeType;
    }

    public StepsChangeBean() {
    }

    public CRPStepInfo getStepsInfo() {
        return stepsInfo;
    }

    public void setStepsInfo(CRPStepInfo stepsInfo) {
        this.stepsInfo = stepsInfo;
    }

    public CRPHistoryDay getHistoryDay() {return historyDay;}

    public void setHistoryDay(CRPHistoryDay historyDay) {
        this.historyDay = historyDay;
    }

    public int getType() {
        return type;
    }

    public void setType(int timeType) {
        this.type = timeType;
    }
}
