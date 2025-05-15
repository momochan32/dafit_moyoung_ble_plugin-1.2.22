package com.moyoung.moyoung_ble_plugin.event;

import android.os.Handler;
import android.os.Looper;
import android.text.TextUtils;

import com.crrepa.ble.scan.CRPScanRecordParser;
import com.crrepa.ble.scan.bean.CRPScanDevice;
import com.crrepa.ble.scan.bean.CRPScanRecordInfo;
import com.crrepa.ble.scan.callback.CRPScanCallback;
import com.moyoung.moyoung_ble_plugin.base.BaseEventChannelHandler;
import com.moyoung.moyoung_ble_plugin.common.GsonUtils;
import com.moyoung.moyoung_ble_plugin.model.ScanDeviceBean;

import java.util.List;

public class ScanDeviceHandler extends BaseEventChannelHandler {
    private static final int SCAN_PERIOD = 10 * 1000;

    public void startScan() {
        startScan(SCAN_PERIOD);
    }

    public void startScan(int scanPeriod) {
        bleClient.scanDevice(new CRPScanCallback() {
            @Override
            public void onScanning(CRPScanDevice device) {
                if (eventSink == null) {
                    return;
                }
                if (TextUtils.isEmpty(device.getDevice().getName())) {
                    return;
                }

                int platform;
                if (CRPScanRecordParser.parseScanRecord(device.getScanRecord()) == null) return;
                CRPScanRecordInfo.McuPlatform mcuPlatform = CRPScanRecordParser.parseScanRecord(device.getScanRecord()).getPlatform();

                if (mcuPlatform == null) return;
                switch (mcuPlatform) {
                    case PLATFORM_NONE:
                        platform = 0;
                        break;
                    case PLATFORM_NORDIC:
                        platform = 1;
                        break;
                    case PLATFORM_HUNTERSUN:
                        platform = 2;
                        break;
                    case PLATFORM_REALTEK:
                        platform = 3;
                        break;
                    case PLATFORM_GOODIX:
                        platform = 4;
                        break;
                    case PLATFORM_SIFLI:
                        platform = 5;
                        break;
                    case PLATFORM_JIELI:
                        platform = 6;
                        break;
                    default:
                        platform = -1;
                }

                ScanDeviceBean scanDeviceBean = ScanDeviceBean.covert(false, device, platform);
                String jsonStr = GsonUtils.get().toJson(scanDeviceBean, ScanDeviceBean.class);
                new Handler(Looper.getMainLooper()).post(() -> {
                    if (eventSink != null) eventSink.success(jsonStr);
                });
            }

            @Override
            public void onScanComplete(List<CRPScanDevice> list) {
                if (eventSink == null) {
                    return;
                }
                ScanDeviceBean scanDeviceBean = ScanDeviceBean.covert(true, null, -1);
                String jsonStr = GsonUtils.get().toJson(scanDeviceBean, ScanDeviceBean.class);
                new Handler(Looper.getMainLooper()).post(() -> {
                    if (eventSink != null) eventSink.success(jsonStr);
                });
            }
        }, scanPeriod);

    }
}
