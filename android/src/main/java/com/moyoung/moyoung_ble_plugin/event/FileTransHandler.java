package com.moyoung.moyoung_ble_plugin.event;

import android.graphics.Bitmap;
import android.os.Handler;
import android.os.Looper;
import android.util.Log;

import com.crrepa.ble.conn.CRPBleConnection;
import com.crrepa.ble.conn.bean.CRPWatchFaceBackgroundInfo;
import com.crrepa.ble.conn.listener.CRPFileTransListener;
import com.moyoung.moyoung_ble_plugin.ErrorConstant;
import com.moyoung.moyoung_ble_plugin.base.BaseConnectionEventChannelHandler;
import com.moyoung.moyoung_ble_plugin.common.GsonUtils;
import com.moyoung.moyoung_ble_plugin.common.ImageUtils;
import com.moyoung.moyoung_ble_plugin.common.MyLog;
import com.moyoung.moyoung_ble_plugin.model.FileTransBean;
import com.moyoung.moyoung_ble_plugin.model.WatchFaceBgBean;

import io.flutter.plugin.common.MethodCall;

class FileTransHandler extends BaseConnectionEventChannelHandler {
    private static final FileTransHandler instance = new FileTransHandler();
    public static FileTransHandler getInstance() {
        return instance;
    }
    @Override
    public void setConnListener(CRPBleConnection connection, MethodCall call) {
        String jsonStr = call.argument("watchFaceBackgroundInfo");
        WatchFaceBgBean watchFaceBgBean = GsonUtils.get().fromJson(jsonStr, WatchFaceBgBean.class);
        Bitmap bitmap = ImageUtils.resizingBitmap(watchFaceBgBean.getBitmap(), watchFaceBgBean.getWidth(), watchFaceBgBean.getHeight());
        Bitmap thumbBitmap = null;
        if (watchFaceBgBean.getThumbHeight() != 0) {
            thumbBitmap = ImageUtils.resizingBitmap(watchFaceBgBean.getThumbBitmap(), watchFaceBgBean.getThumbWidth(), watchFaceBgBean.getThumbHeight());
        }
        CRPWatchFaceBackgroundInfo backgroundInfo = new CRPWatchFaceBackgroundInfo(bitmap, thumbBitmap, watchFaceBgBean.getType());
        MyLog.d("MOYOUNG-Background", "setConnListener: " + jsonStr);
        sendWatchFaceBackground(connection, backgroundInfo);
    }

    private void sendWatchFaceBackground(CRPBleConnection connection, CRPWatchFaceBackgroundInfo backgroundInfo) {
        connection.sendWatchFaceBackground(backgroundInfo, new CRPFileTransListener() {
            @Override
            public void onTransProgressStarting() {
                MyLog.d("MOYOUNG-Background", "onTransProgressStarting: start");
                if (eventSink == null) {
                    return;
                }
                FileTransBean transBean = new FileTransBean(FileTransBean.TRANSSTART);
                String bgProgress = GsonUtils.get().toJson(transBean, FileTransBean.class);
                new Handler(Looper.getMainLooper()).post(() -> {
                    if (eventSink != null) eventSink.success(bgProgress);
                });
            }

            @Override
            public void onTransProgressChanged(int progress) {
                MyLog.d("MOYOUNG-Background", "onTransProgressChanged: " + progress);
                if (eventSink == null) {
                    return;
                }
                FileTransBean transBean = new FileTransBean(FileTransBean.TRANSCHANGED);
                transBean.setProgress(progress);
                String bgProgress = GsonUtils.get().toJson(transBean, FileTransBean.class);
                new Handler(Looper.getMainLooper()).post(() -> {
                    if (eventSink != null) eventSink.success(bgProgress);
                });
            }

            @Override
            public void onTransCompleted() {
                MyLog.d("MOYOUNG-Background", "onTransCompleted: Completed");
                if (eventSink == null) {
                    return;
                }
                FileTransBean transBean = new FileTransBean(FileTransBean.TRANSCOMPLETED);
                transBean.setProgress(100);
                String bgProgress = GsonUtils.get().toJson(transBean, FileTransBean.class);
                new Handler(Looper.getMainLooper()).post(() -> {
                    if (eventSink != null) eventSink.success(bgProgress);
                });
            }

            @Override
            public void onError(int i) {
                MyLog.d("MOYOUNG-Background", "onError: " + i);
                if (eventSink == null) {
                    return;
                }
                FileTransBean transBean = new FileTransBean(FileTransBean.ERROR);
                transBean.setError(i);
                transBean.setProgress(-1);
                String bgProgress = GsonUtils.get().toJson(transBean, FileTransBean.class);
                new Handler(Looper.getMainLooper()).post(() -> {
                    if (eventSink != null) eventSink.success(bgProgress);
                });
            }
        });
    }
}

