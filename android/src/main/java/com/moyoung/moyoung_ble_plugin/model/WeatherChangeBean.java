package com.moyoung.moyoung_ble_plugin.model;

public class WeatherChangeBean {
    private int type;
    private int tempUnit;

    public static final int UPDATE_WEATHER = 1;
    public static final int TEMP_UNIT_CHANGE = 2;

    public WeatherChangeBean(int type, int tempUnit) {
        this.type = type;
        this.tempUnit = tempUnit;
    }

    public WeatherChangeBean() {
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

    public int getTempUnit() {
        return tempUnit;
    }

    public void setTempUnit(int tempUnit) {
        this.tempUnit = tempUnit;
    }
}
