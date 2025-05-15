package com.moyoung.moyoung_ble_plugin.base;

import android.app.Activity;
import android.content.Context;

import com.crrepa.ble.CRPBleClient;


public abstract class BaseChannelHandler {

    protected Context context;
    protected CRPBleClient bleClient;

    public void bindActivity(Context context) {
        this.context = context;
        bleClient = CRPBleClient.create(context.getApplicationContext());
    }
}
