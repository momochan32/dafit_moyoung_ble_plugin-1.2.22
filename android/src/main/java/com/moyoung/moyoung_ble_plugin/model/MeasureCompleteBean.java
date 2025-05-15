package com.moyoung.moyoung_ble_plugin.model;

import com.crrepa.ble.conn.bean.CRPHeartRateInfo;
import com.crrepa.ble.conn.type.CRPHistoryDynamicRateType;

public class MeasureCompleteBean {
    private CRPHistoryDynamicRateType historyDynamicRateType;
    private HeartRateInfoBean heartRate;

    public MeasureCompleteBean(CRPHistoryDynamicRateType historyDynamicRateType, HeartRateInfoBean heartRate) {
        this.historyDynamicRateType = historyDynamicRateType;
        this.heartRate = heartRate;
    }

    public CRPHistoryDynamicRateType getHistoryDynamicRateType() {
        return historyDynamicRateType;
    }

    public void setHistoryDynamicRateType(CRPHistoryDynamicRateType historyDynamicRateType) {
        this.historyDynamicRateType = historyDynamicRateType;
    }

    public HeartRateInfoBean getHeartRate() {
        return heartRate;
    }

    public void setHeartRate(HeartRateInfoBean heartRate) {
        this.heartRate = heartRate;
    }
}
