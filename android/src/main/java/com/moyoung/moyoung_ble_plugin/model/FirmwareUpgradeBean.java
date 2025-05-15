package com.moyoung.moyoung_ble_plugin.model;

public class FirmwareUpgradeBean {
    public static final  int DOWNLOADSTART = 1;
    public static final int DOWNLOADCOMPLETE = 2;
    public static final int PROGRESSSTART = 3;
    public static final int PROGRESSCHANGED = 4;
    public static final int UPGRADECOMPLETED = 5;
    public static final int UPGRADEABORTED = 6;
    public static final int ERROR = 7;

    private int type;
    UpgradeErrorBean upgradeError;
    int upgradeProgress;
    boolean start;

    public FirmwareUpgradeBean(int type) {
        this.type = type;
    }

    public FirmwareUpgradeBean(int type, boolean start) {
        this.type = type;
        this.start = start;
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

    public UpgradeErrorBean getUpgradeError() {
        return upgradeError;
    }

    public void setUpgradeError(UpgradeErrorBean upgradeError) {
        this.upgradeError = upgradeError;
    }

    public int getUpgradeProgress() {
        return upgradeProgress;
    }

    public void setUpgradeProgress(int upgradeProgress) {
        this.upgradeProgress = upgradeProgress;
    }
}
