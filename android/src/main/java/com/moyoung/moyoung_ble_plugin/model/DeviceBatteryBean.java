package com.moyoung.moyoung_ble_plugin.model;

public class DeviceBatteryBean {
    public static final  int SUBSCRIBE = 1;
    public static final int DEVICEBATTERY = 2;

    private int type;
    private boolean subscribe;
    private int deviceBattery;

    public DeviceBatteryBean(int type) {
        this.type = type;
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

    public boolean isSubscribe() {
        return subscribe;
    }

    public void setSubscribe(boolean subscribe) {
        this.subscribe = subscribe;
    }

    public int getDeviceBattery() {
        return deviceBattery;
    }

    public void setDeviceBattery(int deviceBattery) {
        this.deviceBattery = deviceBattery;
    }
}
