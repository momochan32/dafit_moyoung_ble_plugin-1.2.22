package com.moyoung.moyoung_ble_plugin.event;

import android.app.Activity;
import android.os.Handler;
import android.os.Looper;

import com.crrepa.ble.conn.listener.CRPBleFirmwareUpgradeListener;
import com.moyoung.moyoung_ble_plugin.common.GsonUtils;
import com.moyoung.moyoung_ble_plugin.model.FirmwareUpgradeBean;
import com.moyoung.moyoung_ble_plugin.model.UpgradeErrorBean;

import io.flutter.plugin.common.EventChannel;

public class FirmwareUpgradeListener implements CRPBleFirmwareUpgradeListener {
    protected EventChannel.EventSink eventSink;
    protected Activity activity;

    public FirmwareUpgradeListener(EventChannel.EventSink eventSink) {
        this.eventSink = eventSink;
        this.activity = activity;
    }

    @Override
    public void onFirmwareDownloadStarting() {
        if (eventSink == null) {
            return;
        }
        FirmwareUpgradeBean firmwareUpgrade = new FirmwareUpgradeBean(FirmwareUpgradeBean.DOWNLOADSTART);
        String jsonStr = GsonUtils.get().toJson(firmwareUpgrade, FirmwareUpgradeBean.class);
        new Handler(Looper.getMainLooper()).post(() -> {
            if (eventSink != null) eventSink.success(jsonStr);
        });
    }

    @Override
    public void onFirmwareDownloadComplete() {
        if (eventSink == null) {
            return;
        }
        FirmwareUpgradeBean firmwareUpgrade = new FirmwareUpgradeBean(FirmwareUpgradeBean.DOWNLOADCOMPLETE);
        String jsonStr = GsonUtils.get().toJson(firmwareUpgrade, FirmwareUpgradeBean.class);
        new Handler(Looper.getMainLooper()).post(() -> {
            if (eventSink != null) eventSink.success(jsonStr);
        });
    }

    @Override
    public void onUpgradeProgressStarting(boolean start) {
        if (eventSink == null) {
            return;
        }
        FirmwareUpgradeBean firmwareUpgrade = new FirmwareUpgradeBean(FirmwareUpgradeBean.PROGRESSSTART, start);
        String jsonStr = GsonUtils.get().toJson(firmwareUpgrade, FirmwareUpgradeBean.class);
        new Handler(Looper.getMainLooper()).post(() -> {
            if (eventSink != null) eventSink.success(jsonStr);
        });
    }

    @Override
    public void onUpgradeProgressChanged(int OTAProgressInt, float OTAProgressFloat) {
        if (eventSink == null) {
            return;
        }
        FirmwareUpgradeBean firmwareUpgrade = new FirmwareUpgradeBean(FirmwareUpgradeBean.PROGRESSCHANGED);
        firmwareUpgrade.setUpgradeProgress(OTAProgressInt);
        String jsonStr = GsonUtils.get().toJson(firmwareUpgrade, FirmwareUpgradeBean.class);
        new Handler(Looper.getMainLooper()).post(() -> {
            if (eventSink != null) eventSink.success(jsonStr);
        });
    }

    @Override
    public void onUpgradeCompleted() {
        if (eventSink == null) {
            return;
        }
        FirmwareUpgradeBean firmwareUpgrade = new FirmwareUpgradeBean(FirmwareUpgradeBean.UPGRADECOMPLETED);
        String jsonStr = GsonUtils.get().toJson(firmwareUpgrade, FirmwareUpgradeBean.class);
        new Handler(Looper.getMainLooper()).post(() -> {
            if (eventSink != null) eventSink.success(jsonStr);
        });
    }

    @Override
    public void onUpgradeAborted() {
        if (eventSink == null) {
            return;
        }
        FirmwareUpgradeBean firmwareUpgrade = new FirmwareUpgradeBean(FirmwareUpgradeBean.UPGRADEABORTED);
        String jsonStr = GsonUtils.get().toJson(firmwareUpgrade, FirmwareUpgradeBean.class);
        new Handler(Looper.getMainLooper()).post(() -> {
            if (eventSink != null) eventSink.success(jsonStr);
        });
    }

    @Override
    public void onError(int error, String errorContent) {
        if (eventSink == null) {
            return;
        }
        UpgradeErrorBean upgradeError = new UpgradeErrorBean(error,errorContent);
        FirmwareUpgradeBean firmwareUpgrade = new FirmwareUpgradeBean(FirmwareUpgradeBean.ERROR);
        firmwareUpgrade.setUpgradeError(upgradeError);
        String jsonStr = GsonUtils.get().toJson(firmwareUpgrade, FirmwareUpgradeBean.class);
        new Handler(Looper.getMainLooper()).post(() -> {
            if (eventSink != null) eventSink.success(jsonStr);
        });
    }
}
