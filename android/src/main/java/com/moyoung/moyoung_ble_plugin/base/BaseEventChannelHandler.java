package com.moyoung.moyoung_ble_plugin.base;

import android.util.Log;
import io.flutter.plugin.common.EventChannel;

public abstract class BaseEventChannelHandler extends BaseChannelHandler implements EventChannel.StreamHandler {
    private final static String TAG = BaseEventChannelHandler.class.getSimpleName();

    protected EventChannel.EventSink eventSink;
    private String belongChl;

    @Override
    public void onListen(Object arguments, EventChannel.EventSink events) {
        eventSink = events;
    }

    @Override
    public void onCancel(Object arguments) {
        eventSink = null;
    }

    public String getBelongChl() {
        return belongChl;
    }

    public void setBelongChl(String belongChl) {
        this.belongChl = belongChl;
    }
}
