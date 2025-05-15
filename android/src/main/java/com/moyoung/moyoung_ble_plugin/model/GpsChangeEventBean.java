package com.moyoung.moyoung_ble_plugin.model;

import com.crrepa.ble.conn.bean.CRPGpsPathInfo;
import com.crrepa.ble.conn.type.CRPEpoType;

import java.util.List;

public class GpsChangeEventBean {
    private List<Integer> list;
    private CRPGpsPathInfo gpsPathInfo;
    private CRPGpsPathInfo.Location location;
    private CRPEpoType epoType;

    public GpsChangeEventBean(List<Integer> list) {
        this.list = list;
    }

    public GpsChangeEventBean(CRPGpsPathInfo gpsPathInfo) {
        this.gpsPathInfo = gpsPathInfo;
    }

    public GpsChangeEventBean(CRPGpsPathInfo.Location location) {
        this.location = location;
    }

    public GpsChangeEventBean(CRPEpoType epoType) {
        this.epoType = epoType;
    }

    public List<Integer> getList() {
        return list;
    }

    public void setList(List<Integer> list) {
        this.list = list;
    }

    public CRPGpsPathInfo getGpsPathInfo() {
        return gpsPathInfo;
    }

    public void setGpsPathInfo(CRPGpsPathInfo gpsPathInfo) {
        this.gpsPathInfo = gpsPathInfo;
    }

    public CRPGpsPathInfo.Location getLocation() {
        return location;
    }

    public void setLocation(CRPGpsPathInfo.Location location) {
        this.location = location;
    }

    public CRPEpoType getEpoType() {
        return epoType;
    }

    public void setEpoType(CRPEpoType epoType) {
        this.epoType = epoType;
    }
}
