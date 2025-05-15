package com.moyoung.moyoung_ble_plugin.model;

public class ConnectStateBean {
    private boolean autoConnect;
    private int connectState;

    public boolean isAutoConnect() {
        return autoConnect;
    }

    public void setAutoConnect(boolean autoConnect) {
        this.autoConnect = autoConnect;
    }

    public int getConnectState() {
        return connectState;
    }

    public void setConnectState(int connectState) {
        this.connectState = connectState;
    }
}
