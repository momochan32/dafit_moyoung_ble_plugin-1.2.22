package com.moyoung.moyoung_ble_plugin.method;

import static com.moyoung.moyoung_ble_plugin.ChannelNames.EVENT_FIRMWARE_UPGRADE;

import android.util.Log;

import com.crrepa.ble.conn.CRPBleConnection;
import com.crrepa.ble.ota.hs.HsDfuController;
import com.moyoung.moyoung_ble_plugin.event.ConnEveChlRegister;
import com.moyoung.moyoung_ble_plugin.event.FileFirmwareUpgradeHandler;

import io.flutter.plugin.common.MethodCall;

public class OTAController {
    private int type;
    private FileFirmwareUpgradeHandler handler;
    private MethodCall call;
    private CRPBleConnection bleConnection;
    public static final int START_OTA = 0;
    public static final int START_NORDIC_OTA = 1;
    public static final int START_HS_OTA = 2;
    public static final int START_RTK_OTA = 3;
    public static final int START_GOODIX_OTA = 4;
    public static final int START_SIFLI_OTA = 5;
    public static final int START_JIELI_OTA = 6;

    public OTAController(int type, ConnEveChlRegister connEveChlRegister, MethodCall call, CRPBleConnection bleConnection) {
        this.type = type;
        this.handler = (FileFirmwareUpgradeHandler) connEveChlRegister.getLazyEveChlHandler(EVENT_FIRMWARE_UPGRADE);
        this.call = call;
        this.bleConnection = bleConnection;
    }

    public OTAController() {
    }

    public OTAController(int type) {
        this.type = type;
    }

    public OTAController(ConnEveChlRegister connEveChlRegister) {
        this.handler = (FileFirmwareUpgradeHandler) connEveChlRegister.getLazyEveChlHandler(EVENT_FIRMWARE_UPGRADE);
    }

    public void startOTA() {
        if (this.handler != null) {

            switch (this.type) {
                case START_HS_OTA:
                    this.handler.setHsLazyConnListener(call);
                    break;
                case START_RTK_OTA:
                    this.handler.setRtkUpgradeListener(call);
                    break;
                case START_NORDIC_OTA:
                    this.handler.setFirmwareUpgrade(bleConnection, false, call);
                    break;
                case START_GOODIX_OTA:
                    this.handler.setFirmwareUpgrade(bleConnection, true, call);
                    break;
                case START_SIFLI_OTA:
                    this.handler.setSIFLIUpgradeListener(call);
                    break;
                case START_JIELI_OTA:
                    this.handler.setJieliUpgradeListener(call);
                    break;
            }
        }
    }

    public void abortOTA() {
        if (this.handler != null) {

            switch (this.type) {
                case START_HS_OTA:
                    this.handler.abortHsOTA();
                    break;
                case START_RTK_OTA:
                    this.handler.abortRtkOTA();
                    break;
                case START_NORDIC_OTA:
                case START_GOODIX_OTA:
                    this.handler.abortOTA(bleConnection);
                    break;
                case START_SIFLI_OTA:
                    this.handler.abortSifliOTA();
                    break;
                case START_JIELI_OTA:
                    this.handler.abortJieliOTA();
                    break;
            }
        }
    }

}
