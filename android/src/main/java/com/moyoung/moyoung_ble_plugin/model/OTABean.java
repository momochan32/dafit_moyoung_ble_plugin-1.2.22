package com.moyoung.moyoung_ble_plugin.model;

public class OTABean {
    private String address;
    private int type;

    public OTABean(String address, int type) {
        this.address = address;
        this.type = type;
    }

    public OTABean() {
    }

    public String getAddress() {
        return address;
    }

    public int getType() {
        return type;
    }
}
