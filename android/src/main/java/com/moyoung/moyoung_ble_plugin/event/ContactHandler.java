package com.moyoung.moyoung_ble_plugin.event;

import android.os.Handler;
import android.os.Looper;
import android.util.Log;

import com.crrepa.ble.conn.CRPBleConnection;
import com.crrepa.ble.conn.listener.CRPContactListener;
import com.moyoung.moyoung_ble_plugin.base.BaseConnectionEventChannelHandler;
import com.moyoung.moyoung_ble_plugin.common.GsonUtils;
import com.moyoung.moyoung_ble_plugin.model.ContactListenBean;

import io.flutter.plugin.common.MethodCall;

public class ContactHandler extends BaseConnectionEventChannelHandler {
    private static final ContactHandler instance = new ContactHandler();
    public static ContactHandler getInstance() {
        return instance;
    }
    @Override
    public void setConnListener(CRPBleConnection connection, MethodCall call) {
        connection.setContactListener(new CRPContactListener() {
            @Override
            public void onSavedSuccess(int SavedSuccess) {
                if (eventSink == null) {
                    return;
                }
                ContactListenBean contact= new ContactListenBean(ContactListenBean.SAVEDSUCCESS);
                contact.setSavedSuccess(SavedSuccess);
                String jsonStr = GsonUtils.get().toJson(contact, ContactListenBean.class);
                new Handler(Looper.getMainLooper()).post(() -> {
                    if (eventSink != null) eventSink.success(jsonStr);
                });
            }

            @Override
            public void onSavedFail(int savedFail) {
                if (eventSink == null) {
                    return;
                }
                ContactListenBean contact= new ContactListenBean(ContactListenBean.SAVEDFAIL);
                contact.setSavedFail(savedFail);
                String jsonStr = GsonUtils.get().toJson(contact, ContactListenBean.class);
                new Handler(Looper.getMainLooper()).post(() -> {
                    if (eventSink != null) eventSink.success(jsonStr);
                });
            }
        });
    }
}
