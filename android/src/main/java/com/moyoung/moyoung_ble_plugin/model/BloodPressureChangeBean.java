package com.moyoung.moyoung_ble_plugin.model;

public class BloodPressureChangeBean {
    private int sbp;
    private int dbp;

    public BloodPressureChangeBean(int sbp, int sdp) {
        this.sbp = sbp;
        this.dbp = sdp;
    }

    public int getSbp() {
        return sbp;
    }

    public void setSbp(int sbp) {
        this.sbp = sbp;
    }

    public int getDbp() {
        return dbp;
    }

    public void setDbp(int dbp) {
        this.dbp = dbp;
    }
}
