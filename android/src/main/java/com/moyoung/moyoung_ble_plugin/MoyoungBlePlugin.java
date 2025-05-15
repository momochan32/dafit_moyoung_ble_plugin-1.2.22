package com.moyoung.moyoung_ble_plugin;

import android.app.NotificationChannel;
import android.util.Log;

import com.moyoung.moyoung_ble_plugin.method.ScanMethodHandler;
import com.moyoung.moyoung_ble_plugin.event.ScanDeviceHandler;
import com.moyoung.moyoung_ble_plugin.event.ConnEveChlRegister;
import com.moyoung.moyoung_ble_plugin.method.ConnectionMethodHandler;

import androidx.annotation.NonNull;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodChannel;

import static com.moyoung.moyoung_ble_plugin.ChannelNames.EVENT_SCAN_DEVICE;
import static com.moyoung.moyoung_ble_plugin.ChannelNames.METHOD_SCAN_DEVICE;
import static com.moyoung.moyoung_ble_plugin.ChannelNames.METHOD_CONNECTION;

/**
 * MoyoungBlePlugin
 */
public class MoyoungBlePlugin implements FlutterPlugin {
    
    private final static String TAG = MoyoungBlePlugin.class.getSimpleName();
    private BinaryMessenger binaryMgr;
    private MethodChannel bleScanMethodChannel;
    private EventChannel bleScanEveChl;
    private ScanMethodHandler bleMethodHandler;
    private MethodChannel connMethodChannel;
    private ConnectionMethodHandler connectionMethodHandler;

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding binding) {
//        Log.i(TAG, "onAttachedToEngine: Registering channels(注册通道)");
        binaryMgr = binding.getBinaryMessenger();
        ScanDeviceHandler scanEventHandler = registerScanEveChl();
        registerBleScanMethodChl(scanEventHandler);

        registerConnMethodChl();

        bleMethodHandler.bindActivity(binding.getApplicationContext());
        connectionMethodHandler.bindActivity(binding.getApplicationContext());
        PhoneStateReceiver.register(binding.getApplicationContext());
        BLEStateReceiver.register(binding.getApplicationContext());
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
//        Log.i(TAG, "onDetachedFromEngine: Logout channel(注销通道)");
//        bleMethodHandler.unbindMethodChannel(bleScanMethodChannel, bleScanEveChl);
//        connectionMethodHandler.unbindChannel(connMethodChannel);
//        开启前台服务时，会重新进入onAttachedToEngine生命周期，
//        进入UI进程时(也就是退出前台服务时)，会进入onDetachedFromEngine会进入生命周期，
//        导致在UI进程中无法监听
//        PhoneStateReceiver.unregister(binding.getApplicationContext());
//        BLEStateReceiver.unregister(binding.getApplicationContext());
    }

    private void registerBleScanMethodChl(ScanDeviceHandler scanEventHandler) {
        bleMethodHandler = new ScanMethodHandler(scanEventHandler);
        bleScanMethodChannel = new MethodChannel(binaryMgr, METHOD_SCAN_DEVICE);
        bleScanMethodChannel.setMethodCallHandler(bleMethodHandler);
    }

    private void registerConnMethodChl() {
        ConnEveChlRegister connEveChlRegister = ConnEveChlRegister.getInstance(binaryMgr);
        connEveChlRegister.register();

        connectionMethodHandler = ConnectionMethodHandler.getInstance(connEveChlRegister);
        connMethodChannel = new MethodChannel(binaryMgr, METHOD_CONNECTION);
        connMethodChannel.setMethodCallHandler(connectionMethodHandler);

        PhoneStateReceiver.setConnectionMethodHandler(connectionMethodHandler);
        BLEStateReceiver.setConnectionMethodHandler(connectionMethodHandler);
    }

    private ScanDeviceHandler registerScanEveChl() {
        ScanDeviceHandler scanEventHandler = new ScanDeviceHandler();
        bleScanEveChl = new EventChannel(binaryMgr, EVENT_SCAN_DEVICE);
        bleScanEveChl.setStreamHandler(scanEventHandler);

        return scanEventHandler;
    }
}
