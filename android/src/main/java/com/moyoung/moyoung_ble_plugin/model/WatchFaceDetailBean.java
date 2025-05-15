package com.moyoung.moyoung_ble_plugin.model;

import com.crrepa.ble.conn.type.CRPWatchFaceStoreType;

import java.util.List;

public class WatchFaceDetailBean {
    private CRPWatchFaceStoreType storeType;
    private int id;
    private List<Integer> supportWatchFaceList;
    private String firmwareVersion;
    private int apiVersion;
    private int feature;
    private int maxSize;

    public CRPWatchFaceStoreType getStoreType() {
        return storeType;
    }

    public int getId() {
        return id;
    }

    public List<Integer> getSupportWatchFaceList() {
        return supportWatchFaceList;
    }

    public String getFirmwareVersion() {
        return firmwareVersion;
    }

    public int getApiVersion() {
        return apiVersion;
    }

    public int getFeature() {
        return feature;
    }

    public int getMaxSize() {
        return maxSize;
    }
}
