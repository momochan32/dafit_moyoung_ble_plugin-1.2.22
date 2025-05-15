package com.moyoung.moyoung_ble_plugin.event;

import android.os.Handler;
import android.os.Looper;
import android.util.Log;

import com.crrepa.ble.conn.CRPBleConnection;
import com.crrepa.ble.conn.bean.CRPWatchFaceInfo;
import com.crrepa.ble.conn.listener.CRPWatchFaceTransListener;
import com.moyoung.moyoung_ble_plugin.base.BaseConnectionEventChannelHandler;
import com.moyoung.moyoung_ble_plugin.common.GsonUtils;
import com.moyoung.moyoung_ble_plugin.common.MyLog;
import com.moyoung.moyoung_ble_plugin.model.FileTransBean;
import com.moyoung.moyoung_ble_plugin.model.SendWatchFaceBean;

import java.io.File;

import io.flutter.plugin.common.MethodCall;

public class WFFileTransHandler extends BaseConnectionEventChannelHandler {
    private final static String TAG = WFFileTransHandler.class.getSimpleName();
    private static final WFFileTransHandler instance = new WFFileTransHandler();

    public static WFFileTransHandler getInstance() {
        return instance;
    }

    @Override
    public void setConnListener(CRPBleConnection connection, MethodCall call) {
        String jsonStr = call.argument("sendWatchFaceBean");
        SendWatchFaceBean sendWatchFaceBean = GsonUtils.get().fromJson(jsonStr, SendWatchFaceBean.class);
        File file = new File(sendWatchFaceBean.getWatchFaceFlutterBean().getFile());
        CRPWatchFaceInfo customizeWatchFaceInfo = new CRPWatchFaceInfo(file, CRPWatchFaceInfo.WacthFaceType.DEFAULT);
        MyLog.d("MOYOUNG-WatchFace", "setConnListener: " + jsonStr);

        connection.sendWatchFace(customizeWatchFaceInfo, new CRPWatchFaceTransListener() {
            @Override
            public void onInstallStateChange(boolean state) {
                MyLog.d("MOYOUNG-WatchFace", "onInstallStateChange: " + state);
                if (eventSink == null) {
                    return;
                }
                FileTransBean transBean = new FileTransBean();
                transBean.setState(state);
                String jsonStr = GsonUtils.get().toJson(transBean, FileTransBean.class);
                new Handler(Looper.getMainLooper()).post(() -> {
                    if (eventSink != null) eventSink.success(jsonStr);
                });
            }

            @Override
            public void onTransProgressStarting() {
                MyLog.d("MOYOUNG-WatchFace", "onTransProgressStarting ");
                if (eventSink == null) {
                    return;
                }
                FileTransBean transBean = new FileTransBean(FileTransBean.TRANSSTART);
                String jsonStr = GsonUtils.get().toJson(transBean, FileTransBean.class);
                new Handler(Looper.getMainLooper()).post(() -> {
                    if (eventSink != null) eventSink.success(jsonStr);
                });
            }

            @Override
            public void onTransProgressChanged(int progress) {
                MyLog.d("MOYOUNG-WatchFace", "onTransProgressChanged: " + progress);
                if (eventSink == null) {
                    return;
                }
                FileTransBean transBean = new FileTransBean(FileTransBean.TRANSCHANGED);
                transBean.setProgress(progress);
                String jsonStr = GsonUtils.get().toJson(transBean, FileTransBean.class);
                new Handler(Looper.getMainLooper()).post(() -> {
                    if (eventSink != null) eventSink.success(jsonStr);
                });
            }

            @Override
            public void onTransCompleted() {
                MyLog.d("MOYOUNG-WatchFace", "onTransCompleted: ");
                if (eventSink == null) {
                    return;
                }
                FileTransBean transBean = new FileTransBean(FileTransBean.TRANSCOMPLETED);
                transBean.setProgress(100);
                String jsonStr = GsonUtils.get().toJson(transBean, FileTransBean.class);
                new Handler(Looper.getMainLooper()).post(() -> {
                    if (eventSink != null) eventSink.success(jsonStr);
                });
            }

            @Override
            public void onError(int error) {
                MyLog.d("MOYOUNG-WatchFace", "onError: " + error);
                if (eventSink == null) {
                    return;
                }
                FileTransBean transBean = new FileTransBean(FileTransBean.ERROR);
                transBean.setError(error);
                String jsonStr = GsonUtils.get().toJson(transBean, FileTransBean.class);
                new Handler(Looper.getMainLooper()).post(() -> {
                    if (eventSink != null) eventSink.success(jsonStr);
                });
            }
        }, sendWatchFaceBean.getTimeout());
    }
}

