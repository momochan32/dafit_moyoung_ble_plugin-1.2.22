package com.moyoung.moyoung_ble_plugin.model;

import com.crrepa.ble.conn.bean.CRPWatchFaceStoreRequestInfo;

public class WatchFaceStoreListBean {

    private CRPWatchFaceStoreRequestInfo watchFaceStoreTagList;
    private int tagId;

    public WatchFaceStoreListBean(CRPWatchFaceStoreRequestInfo watchFaceStoreTagList, int tagId) {
        this.watchFaceStoreTagList = watchFaceStoreTagList;
        this.tagId = tagId;
    }

    public CRPWatchFaceStoreRequestInfo getWatchFaceStoreTagList() {
        return watchFaceStoreTagList;
    }

    public int getTagId() {
        return tagId;
    }
}
