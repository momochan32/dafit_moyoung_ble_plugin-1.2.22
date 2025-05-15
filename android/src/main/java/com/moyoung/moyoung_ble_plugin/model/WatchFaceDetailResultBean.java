package com.moyoung.moyoung_ble_plugin.model;

import com.crrepa.ble.conn.bean.CRPWatchFaceDetailsInfo;
import com.crrepa.ble.conn.bean.CRPWatchFaceStoreInfo;

public class WatchFaceDetailResultBean {
    private CRPWatchFaceStoreInfo.WatchFaceBean watchFaceBean;
    private CRPWatchFaceDetailsInfo watchFaceDetailsInfo;
    private String error;

    public void setWatchFaceBean(CRPWatchFaceStoreInfo.WatchFaceBean watchFaceBean) {
        this.watchFaceBean = watchFaceBean;
    }

    public void setWatchFaceDetailsInfo(CRPWatchFaceDetailsInfo watchFaceDetailsInfo) {
        this.watchFaceDetailsInfo = watchFaceDetailsInfo;
    }

    public void setError(String error) {
        this.error = error;
    }
}
