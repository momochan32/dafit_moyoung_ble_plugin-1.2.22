package com.moyoung.moyoung_ble_plugin.model;

import com.crrepa.ble.conn.bean.CRPBloodOxygenInfo;
import com.crrepa.ble.conn.bean.CRPHistoryBloodOxygenInfo;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class BloodOxygenBean {

    public static final  int CONTINUESTATE = 1;
    public static final int TIMINGMEASURE = 2;
    public static final int BLOODOXYGEN = 3;
    public static final int HISTORYLIST = 4;
    public static final int CONTINUEBO = 5;

    private int type;
    private boolean continueState;
    private int timingMeasure;
    private int bloodOxygen;
    private List<BloodOxygenHistoryBean> historyList;
    private CRPBloodOxygenInfo continueBO;


    public BloodOxygenBean(int type) {
        this.type = type;
    }


    public boolean isContinueState() {
        return continueState;
    }

    public void setContinueState(boolean continueState) {
        this.continueState = continueState;
    }

    public int getTimingMeasure() {
        return timingMeasure;
    }

    public void setTimingMeasure(int timingMeasure) {
        this.timingMeasure = timingMeasure;
    }

    public int getBloodOxygen() {
        return bloodOxygen;
    }

    public void setBloodOxygen(int bloodOxygen) {
        this.bloodOxygen = bloodOxygen;
    }

    public List<BloodOxygenHistoryBean> getHistoryList() {
        return historyList;
    }

    public void setHistoryList(List<CRPHistoryBloodOxygenInfo> historyList) {
        this.historyList = new ArrayList<>();
        for (int i = 0; i < historyList.size(); i++) {
            CRPHistoryBloodOxygenInfo historyBloodOxygenInfo = historyList.get(i);
            Date date = historyBloodOxygenInfo.getDate();
            BloodOxygenHistoryBean bloodOxygenHistoryBean = new BloodOxygenHistoryBean(String.valueOf(date.getTime()), historyBloodOxygenInfo.getBo());
            this.historyList.add(bloodOxygenHistoryBean);
        }
    }

    public CRPBloodOxygenInfo getContinueBO() {
        return continueBO;
    }

    public void setContinueBO(CRPBloodOxygenInfo continueBO) {
        this.continueBO = continueBO;
    }
}

