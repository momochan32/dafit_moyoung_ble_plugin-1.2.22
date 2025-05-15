package com.moyoung.moyoung_ble_plugin.model;

public class HistoryStepsChangeBean {
    private int type;
    private HistoryStepsBean historyStepsInfo;
    public static final int HISTORY_STEP_CHANGE = 2;

    public void setType(int type) {
        this.type = type;
    }

    public void setHistoryStepsInfo(HistoryStepsBean historyStepsInfo) {
        this.historyStepsInfo = historyStepsInfo;
    }
}
