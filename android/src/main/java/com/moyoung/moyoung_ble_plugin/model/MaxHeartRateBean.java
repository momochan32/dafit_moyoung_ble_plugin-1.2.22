package com.moyoung.moyoung_ble_plugin.model;

public class MaxHeartRateBean {
    private int heartRate;
    private boolean enable;

    public MaxHeartRateBean(int heartRate, boolean enable) {
        this.heartRate = heartRate;
        this.enable = enable;
    }

    public MaxHeartRateBean() {
    }

    public byte getHeartRate() {
        return (byte) heartRate;
    }

    public void setHeartRate(int heartRate) {
        this.heartRate = heartRate;
    }

    public boolean getEnable() {
        return enable;
    }

    public void setEnable(boolean enable) {
        this.enable = enable;
    }
}
