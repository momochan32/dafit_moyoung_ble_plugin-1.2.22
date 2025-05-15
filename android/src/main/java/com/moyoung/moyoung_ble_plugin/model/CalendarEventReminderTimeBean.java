package com.moyoung.moyoung_ble_plugin.model;

public class CalendarEventReminderTimeBean {
    private boolean enable;
    private int minutes;

    public boolean isEnable() {
        return enable;
    }

    public void setEnable(boolean enable) {
        this.enable = enable;
    }

    public int getMinutes() {
        return minutes;
    }

    public void setMinutes(int minutes) {
        this.minutes = minutes;
    }
}
