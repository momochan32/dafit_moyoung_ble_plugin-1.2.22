package com.moyoung.moyoung_ble_plugin.model;


public class FirmwareVersionBean {
    String version;
    int otaType;

    public FirmwareVersionBean(String version, int otaType) {
        this.version = version;
        this.otaType = otaType;
    }

    public FirmwareVersionBean() {
    }

    public String getVersion() {
        return version;
    }

    public void setVersion(String version) {
        this.version = version;
    }

    public int getOtaType() {
        return otaType;
    }

    public void setOtaType(int otaType) {
        this.otaType = otaType;
    }
}