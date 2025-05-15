package com.moyoung.moyoung_ble_plugin.model;

public class BloodOxygenHistoryBean {
    private String date;
    private int bo;

    public BloodOxygenHistoryBean(String date, int bo) {
        this.date = date;
        this.bo = bo;
    }

    public String getDate() {
        return this.date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public int getBo() {
        return this.bo;
    }

    public void setBo(int var1) {
        this.bo = var1;
    }

    public String toString() {
        return "CRPHistoryBloodOxygenInfo{date=" + this.date + ", bo=" + this.bo + '}';
    }
}
