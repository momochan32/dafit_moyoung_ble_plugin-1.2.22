package com.moyoung.moyoung_ble_plugin.model;

import com.crrepa.ble.conn.bean.CRPTempInfo;

public class TempChangeBean {
    private int type;
    private boolean enable;
    private float temp;
    private boolean state;
    private CRPTempInfo tempInfo;

    public static final int CONTINUE_STATE = 1;
    public static final int MEASURE_TEMP = 2;
    public static final int MEASURE_STATE = 3;
    public static final int CONTINUE_TEMP = 4;

    public TempChangeBean(int type, boolean enable, float temp, boolean state, CRPTempInfo tempInfo) {
        this.type = type;
        this.enable = enable;
        this.temp = temp;
        this.state = state;
        this.tempInfo = tempInfo;
    }

    public TempChangeBean() {
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

    public boolean isEnable() {
        return enable;
    }

    public void setEnable(boolean enable) {
        this.enable = enable;
    }

    public float getTemp() {
        return temp;
    }

    public void setTemp(float temp) {
        this.temp = temp;
    }

    public boolean isState() {
        return state;
    }

    public void setState(boolean state) {
        this.state = state;
    }

    public CRPTempInfo getTempInfo() {
        return tempInfo;
    }

    public void setTempInfo(CRPTempInfo tempInfo) {
        this.tempInfo = tempInfo;
    }
}
