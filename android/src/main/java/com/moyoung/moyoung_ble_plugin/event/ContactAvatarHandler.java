package com.moyoung.moyoung_ble_plugin.event;

import android.os.Handler;
import android.os.Looper;
import android.util.Log;

import com.crrepa.ble.conn.CRPBleConnection;
import com.crrepa.ble.conn.listener.CRPFileTransListener;
import com.moyoung.moyoung_ble_plugin.base.BaseConnectionEventChannelHandler;
import com.moyoung.moyoung_ble_plugin.common.GsonUtils;
import com.moyoung.moyoung_ble_plugin.model.ContactBean;
import com.moyoung.moyoung_ble_plugin.model.FileTransBean;

import io.flutter.plugin.common.MethodCall;

public class ContactAvatarHandler extends BaseConnectionEventChannelHandler {
    private final static String TAG = ContactAvatarHandler.class.getSimpleName();
    private static final ContactAvatarHandler instance = new ContactAvatarHandler();
    public static ContactAvatarHandler getInstance() {
        return instance;
    }
    @Override
    public void setConnListener(CRPBleConnection connection, MethodCall call) {
        String jsonStr = call.argument("contactAvatarBean");
        ContactBean contactBean = GsonUtils.get().fromJson(jsonStr, ContactBean.class);
        boolean isWidth = contactBean.getAvatar().getWidth() == contactBean.getWidth();
        boolean isHeight = contactBean.getAvatar().getHeight() == contactBean.getHeight();
        if (isHeight && isWidth) {
            connection.sendContactAvatar(contactBean.getId(), contactBean.getAvatar(),
                    contactBean.getTimeout(), new CRPFileTransListener() {
                        @Override
                        public void onTransProgressStarting() {
                            if (eventSink == null) {
                                return;
                            }
                            FileTransBean transLazy = new FileTransBean(FileTransBean.TRANSSTART);
                            String jsonStr = GsonUtils.get().toJson(transLazy, FileTransBean.class);
                            new Handler(Looper.getMainLooper()).post(() -> {
                                if (eventSink != null) eventSink.success(jsonStr);
                            });
                        }

                        @Override
                        public void onTransProgressChanged(int progress) {
                            if (eventSink == null) {
                                return;
                            }
                            FileTransBean transLazy = new FileTransBean(FileTransBean.TRANSCHANGED);
                            transLazy.setProgress(progress);
                            String jsonStr = GsonUtils.get().toJson(transLazy, FileTransBean.class);
                            new Handler(Looper.getMainLooper()).post(() -> {
                                if (eventSink != null) eventSink.success(jsonStr);
                            });
                        }

                        @Override
                        public void onTransCompleted() {
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
                    });
        }
    }
}
