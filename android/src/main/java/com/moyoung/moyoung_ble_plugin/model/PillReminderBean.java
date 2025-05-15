package com.moyoung.moyoung_ble_plugin.model;

import com.crrepa.ble.conn.bean.CRPPillReminderInfo;

import java.util.List;

public class PillReminderBean {
    private int supportCount;
    private List<CRPPillReminderInfo> list;

    public PillReminderBean(int supportCount, List<CRPPillReminderInfo> list) {
        this.supportCount = supportCount;
        this.list = list;
    }

    public PillReminderBean() {
    }

    public int getSupportCount() {
        return supportCount;
    }

    public void setSupportCount(int supportCount) {
        this.supportCount = supportCount;
    }

    public List<CRPPillReminderInfo> getList() {
        return list;
    }

    public void setList(List<CRPPillReminderInfo> list) {
        this.list = list;
    }
}
