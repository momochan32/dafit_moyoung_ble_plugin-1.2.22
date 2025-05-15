package com.moyoung.moyoung_ble_plugin.model;

public class UpgradeErrorBean {
    private int error;
    private String errorContent;

    public UpgradeErrorBean(int error, String errorContent) {
        this.error = error;
        this.errorContent = errorContent;
    }

    public int getError() {
        return error;
    }

    public void setError(int error) {
        this.error = error;
    }

    public String getErrorContent() {
        return errorContent;
    }

    public void setErrorContent(String errorContent) {
        this.errorContent = errorContent;
    }
}
