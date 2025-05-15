package com.moyoung.moyoung_ble_plugin.event;

import android.os.Handler;
import android.os.Looper;

import com.crrepa.ble.conn.CRPBleConnection;
import com.crrepa.ble.conn.listener.CRPFindPhoneListener;
import com.moyoung.moyoung_ble_plugin.base.BaseConnectionEventChannelHandler;
import com.moyoung.moyoung_ble_plugin.common.GsonUtils;
import com.moyoung.moyoung_ble_plugin.model.FindPhoneBean;

import io.flutter.plugin.common.MethodCall;

public class FindPhoneHandler extends BaseConnectionEventChannelHandler {
    private static final FindPhoneHandler instance = new FindPhoneHandler();
    public static FindPhoneHandler getInstance() {
        return instance;
    }
    @Override
    public void setConnListener(CRPBleConnection connection, MethodCall call) {
        connection.setFindPhoneListener(new CRPFindPhoneListener() {
            @Override
            public void onFindPhone() {
                if (eventSink == null) {
                    return;
                }
                FindPhoneBean findPhoneBean = new FindPhoneBean(FindPhoneBean.FIND);
                String jsonStr = GsonUtils.get().toJson(findPhoneBean, FindPhoneBean.class);
                new Handler(Looper.getMainLooper()).post(() -> {
                    if (eventSink != null) eventSink.success(jsonStr);
                });
            }

            @Override
            public void onFindPhoneComplete() {
                if (eventSink == null) {
                    return;
                }
                FindPhoneBean findPhoneBean = new FindPhoneBean(FindPhoneBean.COMPLETE);
                String jsonStr = GsonUtils.get().toJson(findPhoneBean, FindPhoneBean.class);
                new Handler(Looper.getMainLooper()).post(() -> {
                    if (eventSink != null) eventSink.success(jsonStr);
                });
            }
        });
    }
}
