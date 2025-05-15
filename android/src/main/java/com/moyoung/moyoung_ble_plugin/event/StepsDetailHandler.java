package com.moyoung.moyoung_ble_plugin.event;

import android.os.Handler;
import android.os.Looper;

import com.crrepa.ble.conn.CRPBleConnection;
import com.crrepa.ble.conn.bean.CRPActionDetailsInfo;
import com.crrepa.ble.conn.bean.CRPStepsCategoryInfo;
import com.crrepa.ble.conn.listener.CRPActionDetailsChangeListener;
import com.moyoung.moyoung_ble_plugin.base.BaseConnectionEventChannelHandler;
import com.moyoung.moyoung_ble_plugin.common.GsonUtils;
import com.moyoung.moyoung_ble_plugin.model.ActionDetailsBean;

import io.flutter.plugin.common.MethodCall;

public class StepsDetailHandler extends BaseConnectionEventChannelHandler {
    private static final StepsDetailHandler instance = new StepsDetailHandler();
    public static StepsDetailHandler getInstance() {
        return instance;
    }
    @Override
    public void setConnListener(CRPBleConnection connection, MethodCall call) {
        connection.setActionDetailsListener(new CRPActionDetailsChangeListener() {
            @Override
            public void onStepsCategoryChange(CRPStepsCategoryInfo stepsCategoryInfo) {
                if (eventSink == null) {
                    return;
                }
                ActionDetailsBean actionDetailsBean = new ActionDetailsBean(ActionDetailsBean.STEPSCATEGORYCHANGE);
                actionDetailsBean.setStepsCategoryInfo(stepsCategoryInfo);
                String actionDetailsStr = GsonUtils.get().toJson(actionDetailsBean, ActionDetailsBean.class);
                new Handler(Looper.getMainLooper()).post(() -> {
                    if (eventSink != null) eventSink.success(actionDetailsStr);
                });
            }

            @Override
            public void onActionDetailsChange(CRPActionDetailsInfo actionDetailsInfo) {
                if (eventSink == null) {
                    return;
                }
                ActionDetailsBean actionDetailsBean = new ActionDetailsBean(ActionDetailsBean.ACTIONDETAILSCHANGE);
                actionDetailsBean.setActionDetailsInfo(actionDetailsInfo);
                String actionDetailsStr = GsonUtils.get().toJson(actionDetailsBean, ActionDetailsBean.class);
                new Handler(Looper.getMainLooper()).post(() -> {
                    if (eventSink != null) eventSink.success(actionDetailsStr);
                });
            }
        });
    }

}
