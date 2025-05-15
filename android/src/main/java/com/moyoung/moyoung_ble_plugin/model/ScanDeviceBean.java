package com.moyoung.moyoung_ble_plugin.model;

import com.crrepa.ble.scan.bean.CRPScanDevice;

public class ScanDeviceBean {
    boolean isCompleted;
    String address;
    String name;
    byte[] mScanRecord;
    int mRssi;
    int platform;

    public ScanDeviceBean(boolean isCompleted, String address, String name, byte[] mScanRecord, int mRssi, int platform) {
        this.isCompleted = isCompleted;
        this.address = address;
        this.name = name;
        this.mScanRecord = mScanRecord;
        this.mRssi = mRssi;
        this.platform = platform;
    }

    public static ScanDeviceBean covert(boolean isCompleted, CRPScanDevice device, int platform) {
        if (isCompleted) {
            return new ScanDeviceBean(
                    true,
                    "",
                    "",
                    new byte[0],
                    -1,
                    platform);
        } else {
            return new ScanDeviceBean(
                    false,
                    device.getDevice().getAddress(),
                    device.getDevice().getName(),
                    device.getScanRecord(),
                    device.getRssi(),
                    platform);
        }
    }
}
