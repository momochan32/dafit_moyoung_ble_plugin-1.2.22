package com.moyoung.moyoung_ble_plugin.model;

import com.crrepa.ble.conn.bean.CRPJieliSupportWatchFaceInfo;
import com.crrepa.ble.conn.bean.CRPSupportWatchFaceInfo;

public class WatchFaceBean {
    public static String DEFAULT = "DEFAULT";
    public static String SIFLI = "SIFLI";
    public static String JIELI = "JIELI";

    private String type;
    private CRPSupportWatchFaceInfo supportWatchFaceInfo;
    private SifliSupportWatchFaceBean sifliSupportWatchFaceInfo;
    private CRPJieliSupportWatchFaceInfo jieliSupportWatchFaceInfo;

    public WatchFaceBean(String type) {
        this.type = type;
    }

    public CRPSupportWatchFaceInfo getSupportWatchFaceInfo() {
        return supportWatchFaceInfo;
    }

    public void setSupportWatchFaceInfo(CRPSupportWatchFaceInfo supportWatchFaceInfo) {
        this.supportWatchFaceInfo = supportWatchFaceInfo;
    }

    public SifliSupportWatchFaceBean getSifliSupportWatchFaceInfo() {
        return sifliSupportWatchFaceInfo;
    }

    public void setSifliSupportWatchFaceInfo(SifliSupportWatchFaceBean sifliSupportWatchFaceInfo) {
        this.sifliSupportWatchFaceInfo = sifliSupportWatchFaceInfo;
    }

    public CRPJieliSupportWatchFaceInfo getJieliSupportWatchFaceInfo() {
        return jieliSupportWatchFaceInfo;
    }

    public void setJieliSupportWatchFaceInfo(CRPJieliSupportWatchFaceInfo jieliSupportWatchFaceInfo) {
        this.jieliSupportWatchFaceInfo = jieliSupportWatchFaceInfo;
    }
}
