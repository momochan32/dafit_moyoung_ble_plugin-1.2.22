package com.moyoung.moyoung_ble_plugin.event;


import android.util.Log;

import com.crrepa.ble.conn.CRPBleConnection;
import com.crrepa.ble.conn.listener.CRPBleFirmwareUpgradeListener;
import com.crrepa.ble.ota.hs.HsDfuController;
import com.crrepa.ble.ota.jieli.JieliDfuController;
import com.crrepa.ble.ota.sifli.SifliDfuController;
import com.moyoung.moyoung_ble_plugin.base.BaseConnectionEventChannelHandler;
import com.moyoung.moyoung_ble_plugin.common.GsonUtils;
import com.moyoung.moyoung_ble_plugin.method.OTAController;
import com.moyoung.moyoung_ble_plugin.model.OTABean;

import io.flutter.plugin.common.MethodCall;

public class FileFirmwareUpgradeHandler extends BaseConnectionEventChannelHandler {
    private static final FileFirmwareUpgradeHandler instance = new FileFirmwareUpgradeHandler();

    public static FileFirmwareUpgradeHandler getInstance() {
        return instance;
    }

    HsDfuController hsDfuController;
    // realtek 要根据使用时是否冲突选择是否放开
    // RtkDfuController rtkDfuController;
    SifliDfuController sifliDfuController;
    JieliDfuController jieliDfuController;

    @Override
    public void setConnListener(CRPBleConnection connection, MethodCall call) {
        if (eventSink == null) {
            return;
        }
        String jsonStr = call.argument("otaBean");
        OTABean otaBean = GsonUtils.get().fromJson(jsonStr,
                OTABean.class);
        connection.startFirmwareUpgrade(otaBean.getType() == OTAController.START_OTA, new FirmwareUpgradeListener(eventSink));
    }

    public void setFirmwareUpgrade(CRPBleConnection connection, boolean isGoodix, MethodCall call) {
        if (eventSink == null) {
            return;
        }
        connection.startFirmwareUpgrade(isGoodix, new FirmwareUpgradeListener(eventSink));
    }

    public void setHsLazyConnListener(MethodCall call) {
        if (eventSink == null) {
            return;
        }
        String jsonStr = call.argument("otaBean");
        OTABean otaBean = GsonUtils.get().fromJson(jsonStr,
                OTABean.class);
        if (otaBean.getAddress() != null) {
            hsDfuController = HsDfuController.getInstance();
            hsDfuController.setUpgradeListener(new FirmwareUpgradeListener(eventSink));
            hsDfuController.setAddress(otaBean.getAddress());
            hsDfuController.start(true);
        }
    }

    public void setRtkUpgradeListener(MethodCall call) {
        if (eventSink == null) {
            return;
        }
        String jsonStr = call.argument("otaBean");
        OTABean otaBean = GsonUtils.get().fromJson(jsonStr,
                OTABean.class);
        if (otaBean.getAddress() != null) {
            // rtkDfuController = new RtkDfuController();
            // rtkDfuController.setUpgradeListener(new FirmwareUpgradeListener(eventSink));
            // rtkDfuController.start(otaBean.getAddress());
        }
    }

    public void setSIFLIUpgradeListener(MethodCall call) {
        if (eventSink == null) {
            return;
        }
        String jsonStr = call.argument("otaBean");
        OTABean otaBean = GsonUtils.get().fromJson(jsonStr,
                OTABean.class);
        if (otaBean.getAddress() != null) {
            sifliDfuController = new SifliDfuController();
            sifliDfuController.setUpgradeListener(new FirmwareUpgradeListener(eventSink));
            sifliDfuController.start(otaBean.getAddress());
        }
    }

    public void setJieliUpgradeListener(MethodCall call) {
        if (eventSink == null) {
            return;
        }
        String jsonStr = call.argument("otaBean");
        OTABean otaBean = GsonUtils.get().fromJson(jsonStr,
                OTABean.class);
        if (otaBean.getAddress() != null) {
            jieliDfuController = new JieliDfuController();
            jieliDfuController.setUpgradeListener(new FirmwareUpgradeListener(eventSink));
            jieliDfuController.start();
        }
    }

    public void abortHsOTA() {
        hsDfuController.abort();
    }

    public void abortRtkOTA() {
//        rtkDfuController.abort();
    }

    public void abortOTA(CRPBleConnection connection) {
        connection.abortFirmwareUpgrade();
    }

    public void abortSifliOTA() {
        sifliDfuController.abort();
    }

    public void abortJieliOTA() {
        jieliDfuController.abort();
    }

}

