package com.moyoung.moyoung_ble_plugin.event;

import android.os.Handler;
import android.os.Looper;
import android.util.Log;

import com.crrepa.ble.CRPBleClient;
import com.crrepa.ble.conn.CRPBleConnection;
import com.crrepa.ble.conn.listener.CRPBleConnectionStateListener;
import com.crrepa.ble.conn.listener.CRPCameraOperationListener;
import com.moyoung.moyoung_ble_plugin.base.BaseConnectionEventChannelHandler;
import com.moyoung.moyoung_ble_plugin.common.GsonUtils;
import com.moyoung.moyoung_ble_plugin.method.ConnectionMethodHandler;
import com.moyoung.moyoung_ble_plugin.model.ConnectStateBean;

import java.util.Objects;
import java.util.Timer;
import java.util.TimerTask;

import io.flutter.plugin.common.MethodCall;

class ConnectionStateHandler extends BaseConnectionEventChannelHandler {
    private final static String TAG = ConnectionStateHandler.class.getSimpleName();
    private static final ConnectionStateHandler instance = new ConnectionStateHandler();

    public static ConnectionStateHandler getInstance() {
        return instance;
    }

    @Override
    public void setConnListener(CRPBleConnection connection, MethodCall call) {
        connection.setConnectionStateListener(newState -> {
            switch (newState) {
                case CRPBleConnectionStateListener.STATE_CONNECTED:
                    ConnectionMethodHandler.isConnected = true;
                    supportDelayTime(connection);
                    if (Objects.equals(ConnectionMethodHandler.firmwareVersion, "")) {
                        ConnectionMethodHandler.queryFirmwareVersion();
                    }
                    break;
                case CRPBleConnectionStateListener.STATE_DISCONNECTED:
                    connection.close();
                    if (ConnectionMethodHandler.autoConnect) {
                        Timer timer = new Timer();
                        timer.schedule(new TimerTask() {
                            @Override
                            public void run() {
                                if (!ConnectionMethodHandler.isConnected) {
                                    ConnectionMethodHandler.getInstance().connect();
                                }
                                timer.cancel();
                            }
                        }, 3000);
                    }
                default:
                    ConnectionMethodHandler.firmwareVersion = "";
                    ConnectionMethodHandler.isConnected = false;
                    break;
            }
            ConnectStateBean connectStateBean = new ConnectStateBean();
            connectStateBean.setConnectState(newState);
            connectStateBean.setAutoConnect(ConnectionMethodHandler.autoConnect);
            String jsonStr = GsonUtils.get().toJson(connectStateBean, ConnectStateBean.class);
            // 这个事件接收对象只能放这里，不能放在前面，即便没有事件接受对象，也要获取连接状态
            if (eventSink == null) {
                return;
            }
            new Handler(Looper.getMainLooper()).post(() -> {
                if (eventSink != null) eventSink.success(jsonStr);
            });
        });
    }

    public void supportDelayTime(CRPBleConnection connection) {
        ConnectionMethodHandler.isConnectedCall = true;
        // 每次连接都要把变量先赋为默认值，因为延迟监听不一定进入
        ConnectionMethodHandler.supportDelayTime(false);
        connection.queryDelayTaking();
    }

}
