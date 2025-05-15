package com.moyoung.moyoung_ble_plugin.callback;

import com.crrepa.ble.conn.bean.CRPAlarmInfo;
import com.crrepa.ble.conn.callback.CRPAlarmCallback;
import com.moyoung.moyoung_ble_plugin.common.GsonUtils;
import com.moyoung.moyoung_ble_plugin.model.AlarmBean;

import java.util.List;

import io.flutter.plugin.common.MethodChannel;

public class AlarmCallback implements CRPAlarmCallback {

    private final MethodChannel.Result result;

    public AlarmCallback(MethodChannel.Result result) {
        this.result = result;
    }

    @Override
    public void onAlarmList(List<CRPAlarmInfo> list) {
        AlarmBean alarmBean = new AlarmBean(list, false);
        String str = GsonUtils.get().toJson(alarmBean, AlarmBean.class);
        result.success(str);
    }

    @Override
    public void onNewAlarmList(List<CRPAlarmInfo> list) {
        AlarmBean alarmBean = new AlarmBean(list, true);
        String str = GsonUtils.get().toJson(alarmBean, AlarmBean.class);
        result.success(str);
    }
}
