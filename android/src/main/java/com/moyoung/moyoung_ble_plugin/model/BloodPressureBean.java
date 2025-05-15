package com.moyoung.moyoung_ble_plugin.model;

import com.crrepa.ble.conn.bean.CRPBloodPressureInfo;
import com.crrepa.ble.conn.bean.CRPHistoryBloodPressureInfo;

import java.util.ArrayList;
import java.util.List;

public class BloodPressureBean {
    public static final  int CONTINUESTATE = 1;
    public static final  int PRESSURECHANGE = 2;
    public static final  int HISTORYLIST = 3;
    public static final  int CONTINUEBP = 4;

    private int type;
    private boolean continueState;
    BloodPressureChangeBean pressureChange;
    private List<CRPHistoryBloodPressureInfo> historyBPList;
    private CRPBloodPressureInfo continueBP;

    public BloodPressureBean(int type) {
        this.type =type;
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

    public boolean isContinueState() {
        return continueState;
    }

    public void setContinueState(boolean continueState) {
        this.continueState = continueState;
    }

    public BloodPressureChangeBean getPressureChange() {
        return pressureChange;
    }

    public void setPressureChange(BloodPressureChangeBean pressureChange) {
        this.pressureChange = pressureChange;
    }

    public List<CRPHistoryBloodPressureInfo> getHistoryBPList() {
        return historyBPList;
    }

    public void setHistoryBPList(List<CRPHistoryBloodPressureInfo> historyBPList) {
        this.historyBPList = historyBPList;
    }

    public CRPBloodPressureInfo getContinueBP() {
        return continueBP;
    }

    public void setContinueBP(CRPBloodPressureInfo continueBP) {
        this.continueBP = continueBP;
    }
}
