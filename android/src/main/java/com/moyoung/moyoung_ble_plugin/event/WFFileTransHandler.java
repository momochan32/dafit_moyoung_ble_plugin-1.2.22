package com.moyoung.moyoung_ble_plugin.event;

import android.os.Handler;
import android.os.Looper;
import android.util.Log;

import com.crrepa.ble.conn.CRPBleConnection;
import com.crrepa.ble.conn.bean.CRPWatchFaceInfo;
import com.crrepa.ble.conn.listener.CRPWatchFaceTransListener;
import com.moyoung.moyoung_ble_plugin.base.BaseConnectionEventChannelHandler;
import com.moyoung.moyoung_ble_plugin.common.GsonUtils;
import com.moyoung.moyoung_ble_plugin.common.MyLog; // Jika MyLog adalah wrapper Log.d Anda, tidak apa-apa
import com.moyoung.moyoung_ble_plugin.model.FileTransBean;
import com.moyoung.moyoung_ble_plugin.model.SendWatchFaceBean;

import java.io.File;

import io.flutter.plugin.common.MethodCall;

public class WFFileTransHandler extends BaseConnectionEventChannelHandler {
    // Gunakan TAG yang lebih spesifik dan konsisten untuk semua log dari kelas ini
    private final static String HANDLER_TAG = "WFFileTransHandler"; // Tag baru untuk logging
    private static final WFFileTransHandler instance = new WFFileTransHandler();

    public static WFFileTransHandler getInstance() {
        return instance;
    }

    @Override
    public void setConnListener(CRPBleConnection connection, MethodCall call) {
        String jsonInput = call.argument("sendWatchFaceBean");
        Log.i(HANDLER_TAG, "setConnListener called with input: " + jsonInput);

        if (jsonInput == null || jsonInput.isEmpty()) {
            Log.e(HANDLER_TAG, "sendWatchFaceBean argument is null or empty!");
            // Pertimbangkan untuk mengirim error kembali ke Flutter di sini jika memungkinkan
            return;
        }

        SendWatchFaceBean sendWatchFaceBean;
        try {
            sendWatchFaceBean = GsonUtils.get().fromJson(jsonInput, SendWatchFaceBean.class);
        } catch (Exception e) {
            Log.e(HANDLER_TAG, "Error parsing sendWatchFaceBean JSON: " + e.getMessage());
            // Kirim error kembali ke Flutter
             if (eventSink != null) {
                FileTransBean errorBean = new FileTransBean(FileTransBean.ERROR);
                errorBean.setError(-1001); // Kode error kustom untuk parsing JSON gagal
                String errorJson = GsonUtils.get().toJson(errorBean, FileTransBean.class);
                new Handler(Looper.getMainLooper()).post(() -> {
                    if (eventSink != null) eventSink.success(errorJson);
                });
            }
            return;
        }


        if (sendWatchFaceBean == null || sendWatchFaceBean.getWatchFaceFlutterBean() == null || sendWatchFaceBean.getWatchFaceFlutterBean().getFile() == null) {
            Log.e(HANDLER_TAG, "Parsed sendWatchFaceBean or its fields are null!");
            // Kirim error kembali ke Flutter
            if (eventSink != null) {
                FileTransBean errorBean = new FileTransBean(FileTransBean.ERROR);
                errorBean.setError(-1002); // Kode error kustom untuk data tidak valid
                String errorJson = GsonUtils.get().toJson(errorBean, FileTransBean.class);
                new Handler(Looper.getMainLooper()).post(() -> {
                    if (eventSink != null) eventSink.success(errorJson);
                });
            }
            return;
        }
        
        String filePath = sendWatchFaceBean.getWatchFaceFlutterBean().getFile();
        int timeout = sendWatchFaceBean.getTimeout();
        Log.i(HANDLER_TAG, "File path from Flutter: " + filePath + ", Timeout: " + timeout);

        File file = new File(filePath);
        if (!file.exists() || !file.canRead()) {
            Log.e(HANDLER_TAG, "File does not exist or cannot be read: " + filePath);
            if (eventSink != null) {
                FileTransBean errorBean = new FileTransBean(FileTransBean.ERROR);
                errorBean.setError(-1003); // Kode error kustom untuk file tidak valid/tidak bisa dibaca
                String errorJson = GsonUtils.get().toJson(errorBean, FileTransBean.class);
                 new Handler(Looper.getMainLooper()).post(() -> {
                    if (eventSink != null) eventSink.success(errorJson);
                });
            }
            return;
        }

        // Periksa WacthFaceType.DEFAULT. Jika SDK memiliki tipe lain (misalnya CUSTOM), pertimbangkan itu.
        CRPWatchFaceInfo customizeWatchFaceInfo = new CRPWatchFaceInfo(file, CRPWatchFaceInfo.WacthFaceType.DEFAULT);
        Log.i(HANDLER_TAG, "CRPWatchFaceInfo created. Type: DEFAULT, File: " + file.getAbsolutePath());

        // MyLog.d("MOYOUNG-WatchFace", "setConnListener: " + jsonInput); // MyLog asli

        connection.sendWatchFace(customizeWatchFaceInfo, new CRPWatchFaceTransListener() {
            @Override
            public void onInstallStateChange(boolean state) {
                // Paling penting! Gunakan Log.e atau Log.w agar menonjol di Logcat.
                Log.e(HANDLER_TAG, "!!!!!!!!!! onInstallStateChange CALLED with state: " + state + " !!!!!!!!!!");
                // MyLog.d("MOYOUNG-WatchFace", "onInstallStateChange: " + state); // MyLog asli

                if (eventSink == null) {
                    Log.w(HANDLER_TAG, "onInstallStateChange: eventSink is NULL!");
                    return;
                }
                // Mengirim event dengan tipe baru dan state
                FileTransBean transBean = new FileTransBean(FileTransBean.INSTALL_STATE_CHANGED, state);
                String jsonResponse = GsonUtils.get().toJson(transBean, FileTransBean.class);
                Log.i(HANDLER_TAG, "onInstallStateChange: Sending to Flutter: " + jsonResponse);
                new Handler(Looper.getMainLooper()).post(() -> {
                    if (eventSink != null) {
                        eventSink.success(jsonResponse);
                    } else {
                        Log.w(HANDLER_TAG, "onInstallStateChange (Handler): eventSink became NULL!");
                    }
                });
            }

            @Override
            public void onTransProgressStarting() {
                Log.i(HANDLER_TAG, "========== onTransProgressStarting CALLED ==========");
                // MyLog.d("MOYOUNG-WatchFace", "onTransProgressStarting "); // MyLog asli

                if (eventSink == null) {
                    Log.w(HANDLER_TAG, "onTransProgressStarting: eventSink is NULL!");
                    return;
                }
                FileTransBean transBean = new FileTransBean(FileTransBean.TRANSSTART);
                String jsonResponse = GsonUtils.get().toJson(transBean, FileTransBean.class);
                Log.i(HANDLER_TAG, "onTransProgressStarting: Sending to Flutter: " + jsonResponse);
                new Handler(Looper.getMainLooper()).post(() -> {
                    if (eventSink != null) {
                        eventSink.success(jsonResponse);
                    } else {
                        Log.w(HANDLER_TAG, "onTransProgressStarting (Handler): eventSink became NULL!");
                    }
                });
            }

            @Override
            public void onTransProgressChanged(int progress) {
                Log.d(HANDLER_TAG, "onTransProgressChanged: " + progress + "%"); // Log lebih standar
                // MyLog.d("MOYOUNG-WatchFace", "onTransProgressChanged: " + progress); // MyLog asli

                if (eventSink == null) {
                    Log.w(HANDLER_TAG, "onTransProgressChanged: eventSink is NULL!");
                    return;
                }
                FileTransBean transBean = new FileTransBean(FileTransBean.TRANSCHANGED);
                transBean.setProgress(progress);
                String jsonResponse = GsonUtils.get().toJson(transBean, FileTransBean.class);
                // Hindari logging setiap progress jika terlalu verbose, atau gunakan Log.v
                // Log.v(HANDLER_TAG, "onTransProgressChanged: Sending to Flutter: " + jsonResponse);
                new Handler(Looper.getMainLooper()).post(() -> {
                    if (eventSink != null) {
                        eventSink.success(jsonResponse);
                    } else {
                        Log.w(HANDLER_TAG, "onTransProgressChanged (Handler): eventSink became NULL!");
                    }
                });
            }

            @Override
            public void onTransCompleted() {
                Log.i(HANDLER_TAG, "========== onTransCompleted CALLED ==========");
                // MyLog.d("MOYOUNG-WatchFace", "onTransCompleted: "); // MyLog asli

                if (eventSink == null) {
                    Log.w(HANDLER_TAG, "onTransCompleted: eventSink is NULL!");
                    return;
                }
                FileTransBean transBean = new FileTransBean(FileTransBean.TRANSCOMPLETED);
                transBean.setProgress(100); // Pastikan progress 100 di sini
                String jsonResponse = GsonUtils.get().toJson(transBean, FileTransBean.class);
                Log.i(HANDLER_TAG, "onTransCompleted: Sending to Flutter: " + jsonResponse);
                new Handler(Looper.getMainLooper()).post(() -> {
                    if (eventSink != null) {
                        eventSink.success(jsonResponse);
                    } else {
                        Log.w(HANDLER_TAG, "onTransCompleted (Handler): eventSink became NULL!");
                    }
                });
            }

            @Override
            public void onError(int error) {
                Log.e(HANDLER_TAG, "!!!!!!!!!! onError CALLED with error code: " + error + " !!!!!!!!!!");
                // MyLog.d("MOYOUNG-WatchFace", "onError: " + error); // MyLog asli

                if (eventSink == null) {
                    Log.w(HANDLER_TAG, "onError: eventSink is NULL!");
                    return;
                }
                FileTransBean transBean = new FileTransBean(FileTransBean.ERROR);
                transBean.setError(error);
                String jsonResponse = GsonUtils.get().toJson(transBean, FileTransBean.class);
                Log.e(HANDLER_TAG, "onError: Sending to Flutter: " + jsonResponse);
                new Handler(Looper.getMainLooper()).post(() -> {
                    if (eventSink != null) {
                        eventSink.success(jsonResponse);
                    } else {
                        Log.w(HANDLER_TAG, "onError (Handler): eventSink became NULL!");
                    }
                });
            }
        }, timeout); // Menggunakan timeout dari sendWatchFaceBean
        Log.i(HANDLER_TAG, "connection.sendWatchFace() called. Waiting for callbacks...");
    }
}