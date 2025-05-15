package com.moyoung.moyoung_ble_plugin;



import static android.content.Context.RECEIVER_EXPORTED;

import android.annotation.SuppressLint;
import android.bluetooth.BluetoothAdapter;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.Build;
import android.util.Log;

import com.moyoung.moyoung_ble_plugin.method.ConnectionMethodHandler;


public class BLEStateReceiver extends BroadcastReceiver {
    private final static String TAG = BLEStateReceiver.class.getSimpleName();
    private static final String BLE_STATE_OFF = "android.bluetooth.BluetoothAdapter.STATE_OFF";
    private static final String BLE_STATE_ON = "android.bluetooth.BluetoothAdapter.STATE_ON";
    private static final BLEStateReceiver receiver = new BLEStateReceiver();

    private static ConnectionMethodHandler connectionMethodHandler;

    /**
     * 注册
     */
    public static void register(Context context) {
        IntentFilter filter = new IntentFilter();
        filter.setPriority(Integer.MAX_VALUE);
        // 监视蓝牙关闭和打开的状态
        filter.addAction(BluetoothAdapter.ACTION_STATE_CHANGED);
        filter.addAction(BLE_STATE_OFF);
        filter.addAction(BLE_STATE_ON);
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
            context.registerReceiver(receiver, filter, RECEIVER_EXPORTED);
        } else {
            context.registerReceiver(receiver, filter);
        }
    }

    /**
     * 注销
     */
    public static void unregister(Context context) {
        context.unregisterReceiver(receiver);
    }

    @Override
    public void onReceive(final Context context, Intent intent) {
        checkBLEState(context, intent);
    }

    /**
     * 检测蓝牙状态
     */
    private synchronized void checkBLEState(Context context, Intent intent) {
        int BLEState = intent.getIntExtra(BluetoothAdapter.EXTRA_STATE, 0);
        switch (BLEState) {
            case BluetoothAdapter.STATE_ON:
//                Log.i(TAG, "Bluetooth is on(蓝牙已经打开)");
                connectionMethodHandler.autoConnect(context, true);
                break;
            case BluetoothAdapter.STATE_TURNING_OFF:
//                Log.i(TAG, "checkBLEState(正在关闭蓝牙): ");
                connectionMethodHandler.autoConnect(context, false);
                break;
        }
    }

    public static void setConnectionMethodHandler(ConnectionMethodHandler handler) {
        connectionMethodHandler = handler;
    }
}
