package com.moyoung.moyoung_ble_plugin.model;

import com.crrepa.ble.conn.bean.CRPHistoryTrainingInfo;
import com.crrepa.ble.conn.bean.CRPTrainingInfo;

import java.util.ArrayList;
import java.util.List;

public class TrainBean {
    private int type;
    private List<CRPHistoryTrainingInfo> historyTrainList;
    private ArrayList<CRPTrainingInfo> trainingList;
    public static final int HISTORY_TRAINING_CHANGE = 1;
    public static final int TRAINING_CHANGE = 2;

    public TrainBean(int type, List<CRPHistoryTrainingInfo> historyTrainList) {
        this.type = type;
        this.historyTrainList = historyTrainList;
    }

    public TrainBean() {
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

    public List<CRPHistoryTrainingInfo> getHistoryTrainList() {
        return historyTrainList;
    }

    public void setHistoryTrainList(List<CRPHistoryTrainingInfo> historyTrainList) {
        this.historyTrainList = historyTrainList;
    }

    public ArrayList<CRPTrainingInfo> getTrainingList() {
        return trainingList;
    }

    public void setTrainingList(ArrayList<CRPTrainingInfo> trainingList) {
        this.trainingList = trainingList;
    }
}
