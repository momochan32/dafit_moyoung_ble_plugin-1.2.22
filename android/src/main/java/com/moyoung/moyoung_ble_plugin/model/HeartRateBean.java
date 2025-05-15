package com.moyoung.moyoung_ble_plugin.model;
import com.crrepa.ble.conn.bean.CRPHistoryHeartRateInfo;
import com.crrepa.ble.conn.bean.CRPMovementHeartRateInfo;
import java.util.List;

public class HeartRateBean {
    public static final  int MEASURING = 1;
    public static final int ONCEMEASURECOMPLETE = 2;
    public static final int HEARTRATE = 3;
    public static final int MEASURECOMPLETE = 4;
    public static final int HOURMEASURERESULTOF24 = 5;
    public static final int MOVEMENTMEASURERESULT = 6;


    private int type;
    private int measuring;
    private int onceMeasureComplete;
    private List<CRPHistoryHeartRateInfo> historyHRList;
    MeasureCompleteBean measureComplete;
    private HeartRateInfoBean hour24MeasureResult;
    private List<CRPMovementHeartRateInfo> trainingList;

    public HeartRateBean(int type) {
        this.type = type;
    }


    public int getMeasuring() {
        return measuring;
    }

    public void setMeasuring(int measuring) {
        this.measuring = measuring;
    }

    public int getOnceMeasureComplete() {
        return onceMeasureComplete;
    }

    public void setOnceMeasureComplete(int onceMeasureComplete) {
        this.onceMeasureComplete = onceMeasureComplete;
    }

    public List<CRPHistoryHeartRateInfo> getHistoryHRList() {
        return historyHRList;
    }

    public void setHistoryHRList(List<CRPHistoryHeartRateInfo> historyHRList) {
        this.historyHRList = historyHRList;
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

    public MeasureCompleteBean getMeasureComplete() {
        return measureComplete;
    }

    public void setMeasureComplete(MeasureCompleteBean measureComplete) {
        this.measureComplete = measureComplete;
    }

    public HeartRateInfoBean getHour24MeasureResult() {
        return hour24MeasureResult;
    }

    public void setHour24MeasureResult(HeartRateInfoBean hour24MeasureResult) {
        this.hour24MeasureResult = hour24MeasureResult;
    }

    public List<CRPMovementHeartRateInfo> getTrainingList() {
        return trainingList;
    }

    public void setTrainingList(List<CRPMovementHeartRateInfo> trainingList) {
        this.trainingList = trainingList;
    }
}
