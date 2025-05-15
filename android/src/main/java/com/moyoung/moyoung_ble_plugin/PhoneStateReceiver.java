package com.moyoung.moyoung_ble_plugin;

import static android.content.Context.RECEIVER_EXPORTED;

import android.app.Service;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.Build;
import android.telephony.TelephonyManager;
import android.util.Log;

import com.moyoung.moyoung_ble_plugin.common.IncomingNumberManager;
import com.moyoung.moyoung_ble_plugin.method.ConnectionMethodHandler;


/**
 * Created by bill on 2017/12/1.
 * 来电监听
 */

public class PhoneStateReceiver extends BroadcastReceiver {
    private final static String TAG = PhoneStateReceiver.class.getSimpleName();
    private static final String PHONE_STATE_RECEIVED = "android.intent.action.PHONE_STATE";
    private static int previousState = TelephonyManager.CALL_STATE_IDLE;

    private static final PhoneStateReceiver receiver = new PhoneStateReceiver();

    private static ConnectionMethodHandler connectionMethodHandler;

    /**
     * 注册
     *
     */
    public static void register(Context context) {
        IntentFilter filter = new IntentFilter();
        filter.setPriority(Integer.MAX_VALUE);
        filter.addAction(PHONE_STATE_RECEIVED);
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
            context.registerReceiver(receiver, filter, RECEIVER_EXPORTED);
        } else {
            context.registerReceiver(receiver, filter);
        }
    }

    /**
     * 注销
     *
     */
    public static void unregister(Context context) {
        context.unregisterReceiver(receiver);
    }

    public static void setConnectionMethodHandler(ConnectionMethodHandler handler) {
        connectionMethodHandler = handler;
    }

    @Override
    public void onReceive(final Context context, Intent intent) {
        checkPhoneState(context, intent);
    }

    /**
     * 检测电话状态
     *
     */
    private synchronized void checkPhoneState(Context context, Intent intent) {
        TelephonyManager telephonyManager = (TelephonyManager) context
                .getSystemService(Service.TELEPHONY_SERVICE);
        int callState = telephonyManager.getCallState();
        switch (callState) {
            case TelephonyManager.CALL_STATE_RINGING:   // 电话进来时
                String incomingNumber = intent.getStringExtra(TelephonyManager.EXTRA_INCOMING_NUMBER);
                IncomingNumberManager.getInstance().sendIncomingNumber(context, incomingNumber, connectionMethodHandler);
                break;
            case TelephonyManager.CALL_STATE_OFFHOOK:   // 接起电话时
            case TelephonyManager.CALL_STATE_IDLE:      //无任何状态时
                if (previousState == TelephonyManager.CALL_STATE_RINGING) {
                    sendCallOffHook();
                }
                break;
        }

        previousState = callState;
    }

    /**
     * 电话停止消息
     */
    private void sendCallOffHook() {
        IncomingNumberManager.getInstance().endCall(connectionMethodHandler);
    }
}
