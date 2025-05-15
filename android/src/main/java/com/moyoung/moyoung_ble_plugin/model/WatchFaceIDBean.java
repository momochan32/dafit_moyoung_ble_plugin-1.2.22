package com.moyoung.moyoung_ble_plugin.model;

import com.crrepa.ble.conn.bean.CRPWatchFaceStoreInfo;

public class WatchFaceIDBean {
    private int code;
    private CRPWatchFaceStoreInfo.WatchFaceBean watchFace;
    private String error;

    public WatchFaceIDBean(int code) {
        this.code = code;
    }

    public WatchFaceIDBean() {
    }

    public CRPWatchFaceStoreInfo.WatchFaceBean getWatchFace() {
        return watchFace;
    }

    public void setWatchFace(CRPWatchFaceStoreInfo.WatchFaceBean watchFace) {
        this.watchFace = watchFace;
    }

    public String getError() {
        return error;
    }

    public void setError(String error) {
        this.error = error;
    }
}
