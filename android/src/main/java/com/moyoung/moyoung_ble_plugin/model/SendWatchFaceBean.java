package com.moyoung.moyoung_ble_plugin.model;

import com.crrepa.ble.conn.bean.CRPWatchFaceInfo;

public class SendWatchFaceBean {
    private WatchFaceFlutterBean watchFaceFlutterBean;
    private CRPWatchFaceInfo.WacthFaceType type;
    private int timeout;

    public SendWatchFaceBean(WatchFaceFlutterBean watchFaceFlutterBean, int timeout) {
        this.watchFaceFlutterBean = watchFaceFlutterBean;
        this.timeout = timeout;
    }

    public SendWatchFaceBean(CRPWatchFaceInfo.WacthFaceType type) {
        this.type = type;
    }

    public SendWatchFaceBean() {
    }

    public WatchFaceFlutterBean getWatchFaceFlutterBean() {
        return watchFaceFlutterBean;
    }

    public void setWatchFaceFlutterBean(WatchFaceFlutterBean watchFaceFlutterBean) {
        this.watchFaceFlutterBean = watchFaceFlutterBean;
    }

    public CRPWatchFaceInfo.WacthFaceType getType() { return type; }

    public int getTimeout() {
        return timeout;
    }

    public void setTimeout(int timeout) {
        this.timeout = timeout;
    }
}
