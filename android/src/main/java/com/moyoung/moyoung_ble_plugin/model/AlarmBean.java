package com.moyoung.moyoung_ble_plugin.model;

import com.crrepa.ble.conn.bean.CRPAlarmInfo;

import java.util.List;

public class AlarmBean {
    List<CRPAlarmInfo> list;
    boolean isNew;

    public AlarmBean(List<CRPAlarmInfo> list, boolean isNew) {
        this.list = list;
        this.isNew = isNew;
    }

    public List<CRPAlarmInfo> getList() {
        return list;
    }

    public void setList(List<CRPAlarmInfo> list) {
        this.list = list;
    }

    public boolean isNew() {
        return isNew;
    }

    public void setNew(boolean aNew) {
        isNew = aNew;
    }
}
