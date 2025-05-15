package com.moyoung.moyoung_ble_plugin.model;

import com.crrepa.ble.conn.bean.CRPFirmwareVersionInfo;


public class CheckFirmwareVersionBean {
    CRPFirmwareVersionInfo firmwareVersionInfo;
    Boolean isLatestVersion;

    public CheckFirmwareVersionBean() {
    }

    public CheckFirmwareVersionBean(CRPFirmwareVersionInfo firmwareVersionInfo, Boolean isLatestVersion) {
        this.firmwareVersionInfo = firmwareVersionInfo;
        this.isLatestVersion = isLatestVersion;
    }

    public CRPFirmwareVersionInfo getFirmwareVersionInfo() {
        return firmwareVersionInfo;
    }

    public void setFirmwareVersionInfo(CRPFirmwareVersionInfo firmwareVersionInfo) {
        this.firmwareVersionInfo = firmwareVersionInfo;
    }

    public Boolean getIsLatestVersion() {
        return isLatestVersion;
    }

    public void setIsLatestVersion(Boolean isLatestVersion) {
        this.isLatestVersion = isLatestVersion;
    }
}