package com.moyoung.moyoung_ble_plugin.method;

import static android.content.Context.LOCATION_SERVICE;

import android.app.Activity;
import android.bluetooth.BluetoothAdapter;
import android.content.Context;
import android.content.Intent;
import android.location.LocationManager;
import android.provider.Settings;
import android.util.Log;

import com.moyoung.moyoung_ble_plugin.base.BaseChannelHandler;
import com.moyoung.moyoung_ble_plugin.common.PermissionUtils;
import com.moyoung.moyoung_ble_plugin.event.ScanDeviceHandler;

import java.util.Map;

import androidx.annotation.NonNull;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

import static com.moyoung.moyoung_ble_plugin.common.PermissionUtils.PERMISSION_UPDATE_BAND_CONFIG;

public class ScanMethodHandler extends BaseChannelHandler implements MethodChannel.MethodCallHandler {
    private final ScanDeviceHandler bleScanEveHandler;
    private static final int REQUEST_ENABLE_BT = 0X123;

    public ScanMethodHandler(ScanDeviceHandler bleScanEveHandler) {
        this.bleScanEveHandler = bleScanEveHandler;
    }

    @Override
    public void bindActivity(Context context) {
        super.bindActivity(context);
        bleScanEveHandler.bindActivity(context);
    }

    public void unbindMethodChannel(MethodChannel methodChannel, EventChannel eventChannel) {
        methodChannel.setMethodCallHandler(null);
        eventChannel.setStreamHandler(null);
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        switch (call.method) {
            case "startScan" :
                startScan(call, result);
                break;
            case "cancelScan" :
                cancelScan(result);
                break;
        }
    }

    private void startScan(MethodCall call, MethodChannel.Result result) {
//        boolean isNoPermissions = !PermissionUtils.hasSelfPermissions(
//                context.getApplicationContext(), PERMISSION_UPDATE_BAND_CONFIG);
//        if (isNoPermissions) {
//            sendNoPermissionMsg(result);
//            return;
//        }

        if (!checkBluetoothEnable() && !checkGPSEnable()) {
            return;
        }

        Integer scanPeriod = call.argument("scanPeriod");
        if (scanPeriod == null || scanPeriod <= 0) {
            bleScanEveHandler.startScan();
        } else {
            bleScanEveHandler.startScan(scanPeriod);
        }
        result.success(true);
    }

    public void cancelScan(MethodChannel.Result result) {
        bleClient.cancelScan();
        result.success(null);
    }

    private boolean checkBluetoothEnable() {
        return bleClient.isBluetoothEnable();
    }

    private void sendNoPermissionMsg(MethodChannel.Result result) {
        Map<String, String> noPermissionMsgMap = PermissionUtils.getNoPermissionsMsg(
                context.getApplicationContext(), PERMISSION_UPDATE_BAND_CONFIG);

        if (noPermissionMsgMap == null) {
            return;
        }

        String errorCode = noPermissionMsgMap.get("errorCode");
        String errorMessage = noPermissionMsgMap.get("errorMessage");
        result.error(errorCode, errorMessage, "omit");
    }

    public boolean checkGPSEnable() {
        Boolean isGPS = isGPSEnabled(context.getApplicationContext());
        if (!isGPS) {
            dynamicEnableGPS((Activity) context, REQUEST_ENABLE_BT);
        }
        return isGPS;
    }

    public boolean isGPSEnabled(Context context) {
        LocationManager systemService = (LocationManager) context.getSystemService(LOCATION_SERVICE);
        return systemService.isProviderEnabled(LocationManager.GPS_PROVIDER);
    }

    public void dynamicEnableGPS(Activity activity, int requestCode) {
        Intent intent = new Intent();
        intent.setAction(Settings.ACTION_LOCATION_SOURCE_SETTINGS);
        activity.startActivityForResult(intent, requestCode);
    }
}
