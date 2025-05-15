package com.moyoung.moyoung_ble_plugin.model;

import com.crrepa.ble.conn.bean.CRPHistoryHrvInfo;

import java.util.List;

public class HRVHandlerBean {
    public final static int SUPPORT = 1;
    public final static int HRV = 2;
    public final static int HISTORY = 3;

    private int type;
    private boolean isSupport;
    private int value;
    private List<CRPHistoryHrvInfo> list;

    public HRVHandlerBean(int type, boolean isSupport) {
        this.type = type;
        this.isSupport = isSupport;
    }

    public HRVHandlerBean(int type, int value) {
        this.type = type;
        this.value = value;
    }

    public HRVHandlerBean(int type, List<CRPHistoryHrvInfo> list) {
        this.type = type;
        this.list = list;
    }
}
