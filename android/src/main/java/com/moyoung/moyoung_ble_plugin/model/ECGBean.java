package com.moyoung.moyoung_ble_plugin.model;

import java.util.Date;

public class ECGBean {
    public static final int INTS = 1;
    public static final int MEASURECOMPLETE = 2;
    public static final int DATE = 3;
    public static final int CANCEL = 4;
    public static final int FAIL = 5;


    private int type;
    private int[] ECGChangeInts;
    private Date date;


    public ECGBean(int type) {
        this.type = type;
    }

    public int[] getECGChangeInts() {
        return ECGChangeInts;
    }

    public void setECGChangeInts(int[] ECGChangeInts) {
        this.ECGChangeInts = ECGChangeInts;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

}