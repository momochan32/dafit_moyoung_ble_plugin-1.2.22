package com.moyoung.moyoung_ble_plugin.model;

public class HistoryStressBean {
    private long date;
    private int stress;

    public HistoryStressBean(long var1, int var2) {
        this.date = var1;
        this.stress = var2;
    }

    public long getDate() {
        return this.date;
    }

    public void setDate(long var1) {
        this.date = var1;
    }

    public int getStress() {
        return this.stress;
    }

    public void setStress(int var1) {
        this.stress = var1;
    }

    public String toString() {
        return "HistoryStressBean{date=" + this.date + ", stress=" + this.stress + '}';
    }
}
