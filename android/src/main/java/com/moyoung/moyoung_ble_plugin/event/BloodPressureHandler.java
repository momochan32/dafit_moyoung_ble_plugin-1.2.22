package com.moyoung.moyoung_ble_plugin.event;

import android.os.Handler;
import android.os.Looper;
import android.util.Log;

import com.crrepa.ble.conn.CRPBleConnection;
import com.crrepa.ble.conn.bean.CRPBloodPressureInfo;
import com.crrepa.ble.conn.bean.CRPHistoryBloodPressureInfo;
import com.crrepa.ble.conn.listener.CRPBloodPressureChangeListener;
import com.moyoung.moyoung_ble_plugin.base.BaseConnectionEventChannelHandler;
import com.moyoung.moyoung_ble_plugin.common.GsonUtils;
import com.moyoung.moyoung_ble_plugin.model.BloodPressureBean;
import com.moyoung.moyoung_ble_plugin.model.BloodPressureChangeBean;

import java.util.List;

import io.flutter.plugin.common.MethodCall;

public class BloodPressureHandler extends BaseConnectionEventChannelHandler {
    private static final BloodPressureHandler instance = new BloodPressureHandler();
    public static BloodPressureHandler getInstance() {
        return instance;
    }
    @Override
    public void setConnListener(CRPBleConnection connection, MethodCall call) {
        connection.setBloodPressureChangeListener(new CRPBloodPressureChangeListener() {
                    @Override
                    public void onContinueState(boolean continueState) {
                        if (eventSink == null) {
                            return;
                        }
                        BloodPressureBean bloodPressureBean = new BloodPressureBean(BloodPressureBean.CONTINUESTATE);
                        bloodPressureBean.setContinueState(continueState);
                        String bpStr = GsonUtils.get().toJson(bloodPressureBean, BloodPressureBean.class);
                        new Handler(Looper.getMainLooper()).post(() -> {
                            if (eventSink != null) eventSink.success(bpStr);
                        });
                    }

                    @Override
                    public void onBloodPressureChange(int sbp, int dbp) {

                        if (eventSink == null) {
                            return;
                        }
                        BloodPressureBean bloodPressureBean = new BloodPressureBean(BloodPressureBean.PRESSURECHANGE);
                        BloodPressureChangeBean pressureChangeBean = new BloodPressureChangeBean(sbp,dbp);
                        bloodPressureBean.setPressureChange(pressureChangeBean);
                        String bpStr = GsonUtils.get().toJson(bloodPressureBean, BloodPressureBean.class);
                        new Handler(Looper.getMainLooper()).post(() -> {
                            if (eventSink != null) eventSink.success(bpStr);
                        });
                    }

                    @Override
                    public void onHistoryBloodPressure(List<CRPHistoryBloodPressureInfo> historyBPList) {
                        if (eventSink == null) {
                            return;
                        }
                        BloodPressureBean bloodPressureBean = new BloodPressureBean(BloodPressureBean.HISTORYLIST);
                        bloodPressureBean.setHistoryBPList(historyBPList);
                        String bpStr = GsonUtils.get().toJson(bloodPressureBean, BloodPressureBean.class);
                        new Handler(Looper.getMainLooper()).post(() -> {
                            if (eventSink != null) eventSink.success(bpStr);
                        });
                    }

                    @Override
                    public void onContinueBloodPressure(CRPBloodPressureInfo crpBloodPressureInfo) {
                        if (eventSink == null) {
                            return;
                        }
                        BloodPressureBean bloodPressureBean = new BloodPressureBean(BloodPressureBean.CONTINUEBP);
                        bloodPressureBean.setContinueBP(crpBloodPressureInfo);
                        String bpStr = GsonUtils.get().toJson(bloodPressureBean, BloodPressureBean.class);
                        new Handler(Looper.getMainLooper()).post(() -> {
                            if (eventSink != null) eventSink.success(bpStr);
                        });
                    }
                }
        );
    }


}
