package com.moyoung.moyoung_ble_plugin.common;

import android.content.Context;
import android.text.TextUtils;
import android.util.Log;

import com.moyoung.moyoung_ble_plugin.PhoneStateReceiver;
import com.moyoung.moyoung_ble_plugin.method.ConnectionMethodHandler;

public class IncomingNumberManager {
    private final static String TAG = IncomingNumberManager.class.getSimpleName();

    private IncomingNumberManager() {
    }

    public static IncomingNumberManager getInstance() {
        return Holder.INSTANCE;
    }

    private static class Holder {
        private static final IncomingNumberManager INSTANCE = new IncomingNumberManager();
    }

    /**
     * 来电号码
     *
     * @param context
     * @param number
     */
    public void sendIncomingNumber(Context context, final String number, ConnectionMethodHandler handler) {
        if (TextUtils.isEmpty(number)) {
            return;
        }

        String contactName = null;
        try {
            contactName = ContactUtils.getContactName(context, number);
        } catch (Exception e) {
            e.printStackTrace();
        }
        if (!TextUtils.isEmpty(contactName)) {
            handler.sendIncomingNumber(contactName);
        } else {
            handler.sendIncomingNumber(number);
        }
    }


    /**
     * 挂断电话
     */
    public void endCall(ConnectionMethodHandler handler) {
        handler.sendCall0ffHook();
    }
}

