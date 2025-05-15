package com.moyoung.moyoung_ble_plugin.event;

import android.os.Handler;
import android.os.Looper;
import android.util.Log;

import com.crrepa.ble.conn.CRPBleConnection;
import com.crrepa.ble.conn.listener.CRPWeatherChangeListener;
import com.moyoung.moyoung_ble_plugin.base.BaseConnectionEventChannelHandler;
import com.moyoung.moyoung_ble_plugin.common.GsonUtils;
import com.moyoung.moyoung_ble_plugin.model.FileTransBean;
import com.moyoung.moyoung_ble_plugin.model.WeatherChangeBean;

import io.flutter.plugin.common.MethodCall;

public class WeatherChangeHandler extends BaseConnectionEventChannelHandler {
    private static final WeatherChangeHandler instance = new WeatherChangeHandler();
    public static WeatherChangeHandler getInstance() {
        return instance;
    }
    @Override
    public void setConnListener(CRPBleConnection connection, MethodCall call) {
        connection.setWeatherChangeListener(new CRPWeatherChangeListener() {
            @Override
            public void onUpdateWeather() {
                if (eventSink == null) {
                    return;
                }
                WeatherChangeBean bean = new WeatherChangeBean();
                bean.setType(WeatherChangeBean.UPDATE_WEATHER);
                String jsonStr = GsonUtils.get().toJson(bean, WeatherChangeBean.class);
                new Handler(Looper.getMainLooper()).post(() -> {
                    if (eventSink != null) eventSink.success(jsonStr);
                });
            }

            @Override
            public void onTempUnitChange(int tempUnit) {
                if (eventSink == null) {
                    return;
                }
                WeatherChangeBean bean = new WeatherChangeBean();
                bean.setType(WeatherChangeBean.TEMP_UNIT_CHANGE);
                bean.setTempUnit(tempUnit);
                String jsonStr = GsonUtils.get().toJson(bean, WeatherChangeBean.class);
                new Handler(Looper.getMainLooper()).post(() -> {
                    if (eventSink != null) eventSink.success(jsonStr);
                });
            }
        });
    }

}

