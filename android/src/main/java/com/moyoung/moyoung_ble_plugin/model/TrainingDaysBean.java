package com.moyoung.moyoung_ble_plugin.model;

import android.util.Log;

import androidx.annotation.NonNull;

import java.util.Arrays;

public class TrainingDaysBean {
    private boolean enable;
    private int[] trainingDays;

    public TrainingDaysBean(boolean enable, int[] trainingDays) {
        this.enable = enable;
        this.trainingDays = trainingDays;
    }

    public boolean getEnable() {
        return this.enable;
    }

    public void setEnable(boolean enable) {
        this.enable = enable;
    }

    public byte getTrainingDays() {
        int sum = 0;
        for (int trainingDay : trainingDays) {
            sum += Math.pow(2, trainingDay);
        }
        return (byte) sum;
    }

    public int[] getTrainingDayList() {
        return trainingDays;
    }

    public void setTrainingDays(int[] trainingDays) {
        this.trainingDays = trainingDays;
    }

    @NonNull
    public String toString() {
        return "CRPTrainingDayInfo{enable=" + this.enable + ", trainingDays=" + Arrays.toString(this.trainingDays) + '}';
    }
}
