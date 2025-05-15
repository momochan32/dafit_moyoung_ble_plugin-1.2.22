package com.moyoung.moyoung_ble_plugin.model;

public class ConnectBean {
    private String address;
    private boolean autoConnect;

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public boolean isAutoConnect() {
        return autoConnect;
    }

    public void setAutoConnect(boolean autoConnect) {
        this.autoConnect = autoConnect;
    }
}
