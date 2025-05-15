package com.moyoung.moyoung_ble_plugin.model;

import java.util.HashMap;
import java.util.Map;

public class NotificationBean {
    private String title;
    private String message;
    private int type;
    private int versionCode;
    private boolean isHs;
    private boolean isSmallScreen;

    public String getMessage() {
        return title + ":" + message;
    }

    public int getType() {
        return type;
    }

    public int getVersionCode() {
        return versionCode;
    }

    public boolean isHs() {
        return isHs;
    }

    public boolean isSmallScreen() {
        return isSmallScreen;
    }
}
