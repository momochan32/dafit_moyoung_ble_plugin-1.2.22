package com.moyoung.moyoung_ble_plugin.model;

import com.crrepa.ble.conn.bean.CRPTimingStressInfo;

import java.util.List;

public class StressHandlerBean {
    public final static int SUPPORT = 1;
    public final static int CHANGE = 2;
    public final static int HISTORY_CHANGE = 3;
    public final static int TIMING_STATE_CHANGE = 4;
    public final static int TIMING_CHANGE = 5;

    private int type;
    private boolean isSupport;
    private int value;
    private List<HistoryStressBean> list;
    private boolean state;
    private CRPTimingStressInfo timingStressInfo;

    public StressHandlerBean(int type, boolean isSupport) {
        this.type = type;
        this.isSupport = isSupport;
    }

    public StressHandlerBean(int type, int value) {
        this.type = type;
        this.value = value;
    }

    public StressHandlerBean(int type, List<HistoryStressBean> list) {
        this.type = type;
        this.list = list;
    }

    public StressHandlerBean(int type, CRPTimingStressInfo timingStressInfo) {
        this.type = type;
        this.timingStressInfo = timingStressInfo;
    }
}
