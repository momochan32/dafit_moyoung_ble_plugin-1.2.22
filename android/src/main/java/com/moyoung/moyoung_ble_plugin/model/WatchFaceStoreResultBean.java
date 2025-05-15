package com.moyoung.moyoung_ble_plugin.model;

import com.crrepa.ble.conn.bean.CRPWatchFaceStoreInfo;

public class WatchFaceStoreResultBean {
    private CRPWatchFaceStoreInfo watchFaceStoreInfo;
    private String error;

    public WatchFaceStoreResultBean() {
    }

    public WatchFaceStoreResultBean(CRPWatchFaceStoreInfo watchFaceStoreInfo, String error) {
        this.watchFaceStoreInfo = watchFaceStoreInfo;
        this.error = error;
    }

    public CRPWatchFaceStoreInfo getWatchFaceStoreInfo() {
        return watchFaceStoreInfo;
    }

    public void setWatchFaceStoreInfo(CRPWatchFaceStoreInfo watchFaceStoreInfo) {
        this.watchFaceStoreInfo = watchFaceStoreInfo;
    }

    public String getError() {
        return error;
    }

    public void setError(String error) {
        this.error = error;
    }
}
