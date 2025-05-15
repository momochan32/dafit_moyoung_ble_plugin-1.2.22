package com.moyoung.moyoung_ble_plugin.model;

import com.crrepa.ble.conn.bean.CRPWatchFaceStoreTagInfo;

import java.util.List;

public class WatchFaceStoreTagListResultBean {
    private List<CRPWatchFaceStoreTagInfo> list;
    private String error;

    public WatchFaceStoreTagListResultBean(List<CRPWatchFaceStoreTagInfo> list, String error) {
        this.list = list;
        this.error = error;
    }
}
