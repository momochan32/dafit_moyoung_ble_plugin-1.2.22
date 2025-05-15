package com.moyoung.moyoung_ble_plugin.event;

import android.os.Handler;
import android.os.Looper;
import android.util.Log;

import com.crrepa.ble.conn.CRPBleConnection;
import com.crrepa.ble.conn.bean.CRPHistoryTrainingInfo;
import com.crrepa.ble.conn.bean.CRPTrainingInfo;
import com.crrepa.ble.conn.bean.CRPTrainingRealtimeInfo;
import com.crrepa.ble.conn.listener.CRPTrainingChangeListener;
import com.moyoung.moyoung_ble_plugin.base.BaseConnectionEventChannelHandler;
import com.moyoung.moyoung_ble_plugin.common.GsonUtils;
import com.moyoung.moyoung_ble_plugin.model.TrainBean;

import java.util.ArrayList;
import java.util.List;

import io.flutter.plugin.common.MethodCall;

public class TrainHandler extends BaseConnectionEventChannelHandler {
    private static final TrainHandler instance = new TrainHandler();

    public static TrainHandler getInstance() {
        return instance;
    }
    public ArrayList<CRPTrainingInfo> arrayList = new ArrayList<>();
    public ArrayList<Integer> idList = new ArrayList<>();

    @Override
    public void setConnListener(CRPBleConnection connection, MethodCall call) {
        connection.setTrainingListener(new CRPTrainingChangeListener() {
            @Override
            public void onHistoryTrainingChange(List<CRPHistoryTrainingInfo> historyTrainList) {
                if (eventSink == null) {
                    return;
                }
                if (arrayList.size() > 0) arrayList.clear();
                ArrayList<CRPHistoryTrainingInfo> list = new ArrayList<>();
                for (int i = 0; i < historyTrainList.size(); i++) {
                    CRPHistoryTrainingInfo historyTrainingInfo = historyTrainList.get(i);
                    list.add(new CRPHistoryTrainingInfo(
                            historyTrainingInfo.getId(),
                            historyTrainingInfo.getStartTime() / 1000,
                            historyTrainingInfo.getType()));
//                        这里不能循环调用，只能调用一次，循环调用数据会有出现数据一样的问题
                    if (i == 0) {
                        connection.queryTraining(historyTrainingInfo.getId());
                    } else {
                        idList.add(historyTrainingInfo.getId());
                    }
                }
                TrainBean trainBean = new TrainBean();
                trainBean.setType(TrainBean.HISTORY_TRAINING_CHANGE);
                trainBean.setHistoryTrainList(list);
                String jsonStr = GsonUtils.get().toJson(trainBean, TrainBean.class);
                new Handler(Looper.getMainLooper()).post(() -> {
                    if (eventSink != null) eventSink.success(jsonStr);
                });
            }

            @Override
            public void onTrainingChange(CRPTrainingInfo info) {
                if (eventSink == null) {
                    return;
                }
                info.setStartTime(info.getStartTime() / 1000);
                info.setEndTime(info.getEndTime() / 1000);
                if (idList.size() > 0) {
                    arrayList.add(info);
                    connection.queryTraining(idList.get(0));
                    idList.remove(0);
                } else {
                    arrayList.add(info);
                    TrainBean trainBean = new TrainBean();
                    trainBean.setType(TrainBean.TRAINING_CHANGE);
                    trainBean.setTrainingList(arrayList);
                    String jsonStr = GsonUtils.get().toJson(trainBean, TrainBean.class);
                    arrayList.clear();
                    new Handler(Looper.getMainLooper()).post(() -> {
                        if (eventSink != null) eventSink.success(jsonStr);
                    });
                }
            }

            @Override
            public void onRealtimeTrainingChange(CRPTrainingRealtimeInfo trainingRealtimeInfo) {

            }
        });
    }
}
