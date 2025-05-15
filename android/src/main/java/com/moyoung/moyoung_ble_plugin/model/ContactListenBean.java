package com.moyoung.moyoung_ble_plugin.model;

public class ContactListenBean {

    public static final  int SAVEDSUCCESS = 1;
    public static final int SAVEDFAIL = 2;

    private int type;
    private int savedSuccess;
    private int savedFail;


    public ContactListenBean(int type) {
        this.type = type;
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

    public int getSavedSuccess() {
        return savedSuccess;
    }

    public void setSavedSuccess(int savedSuccess) {
        this.savedSuccess = savedSuccess;
    }

    public int getSavedFail() {
        return savedFail;
    }

    public void setSavedFail(int savedFail) {
        this.savedFail = savedFail;
    }
}
