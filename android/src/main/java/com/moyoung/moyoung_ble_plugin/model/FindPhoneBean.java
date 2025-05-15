package com.moyoung.moyoung_ble_plugin.model;

public class FindPhoneBean {
    public final static int FIND = 1;
    public final static int COMPLETE = 2;

    private int type;

    public FindPhoneBean(int type) {
        this.type = type;
    }
}
