package com.moyoung.moyoung_ble_plugin.model;

public class FileTransBean {
    public static final  int TRANSSTART = 1;
    public static final int TRANSCHANGED = 2;
    public static final int TRANSCOMPLETED = 3;
    public static final int ERROR = 4;

    private int progress;
    private int error;
    private int type;
    private boolean state;

    public FileTransBean() {

    }

    public FileTransBean(int type) {
        this.type = type;
    }


    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

    public int getProgress() {
        return progress;
    }

    public void setProgress(int progress) {
        this.progress = progress;
    }

    public int getError() {
        return error;
    }

    public void setError(int error) {
        this.error = error;
    }

    public boolean getState() { return this.state; };

    public void setState(boolean state) {
        this.state = state;
    }
}
