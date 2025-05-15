package com.moyoung.moyoung_ble_plugin.event;

import android.content.Context;

import com.moyoung.moyoung_ble_plugin.base.BaseConnectionEventChannelHandler;

import java.util.ArrayList;
import java.util.List;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.EventChannel;

import static com.moyoung.moyoung_ble_plugin.ChannelNames.EVENT_BATTERY_SAVING;
import static com.moyoung.moyoung_ble_plugin.ChannelNames.EVENT_BLOOD_OXYGEN;
import static com.moyoung.moyoung_ble_plugin.ChannelNames.EVENT_BLOOD_PRESSURE;
import static com.moyoung.moyoung_ble_plugin.ChannelNames.EVENT_CALENDAR_EVENT;
import static com.moyoung.moyoung_ble_plugin.ChannelNames.EVENT_CALL_NUMBER;
import static com.moyoung.moyoung_ble_plugin.ChannelNames.EVENT_CAMERA;
import static com.moyoung.moyoung_ble_plugin.ChannelNames.EVENT_CONTACT;
import static com.moyoung.moyoung_ble_plugin.ChannelNames.EVENT_DEVICE_BATTERY;
import static com.moyoung.moyoung_ble_plugin.ChannelNames.EVENT_DEVICE_RSSI;
import static com.moyoung.moyoung_ble_plugin.ChannelNames.EVENT_FIND_PHONE;
import static com.moyoung.moyoung_ble_plugin.ChannelNames.EVENT_GPS_CHANGE_EVENT;
import static com.moyoung.moyoung_ble_plugin.ChannelNames.EVENT_HEART_RATE;
import static com.moyoung.moyoung_ble_plugin.ChannelNames.EVENT_NEW_HRV;
import static com.moyoung.moyoung_ble_plugin.ChannelNames.EVENT_SOS_CHANGE;
import static com.moyoung.moyoung_ble_plugin.ChannelNames.EVENT_STRESS;
import static com.moyoung.moyoung_ble_plugin.ChannelNames.EVENT_TRAINING_STATE;
import static com.moyoung.moyoung_ble_plugin.ChannelNames.EVENT_PHONE;
import static com.moyoung.moyoung_ble_plugin.ChannelNames.EVENT_SLEEP_CHANGE;
import static com.moyoung.moyoung_ble_plugin.ChannelNames.EVENT_CONNECTION_STATE;
import static com.moyoung.moyoung_ble_plugin.ChannelNames.EVENT_STEPS_DETAIL;
import static com.moyoung.moyoung_ble_plugin.ChannelNames.EVENT_STEPS_CHANGE;
import static com.moyoung.moyoung_ble_plugin.ChannelNames.EVENT_TEMP_CHANGE;
import static com.moyoung.moyoung_ble_plugin.ChannelNames.EVENT_TRAIN;
import static com.moyoung.moyoung_ble_plugin.ChannelNames.EVENT_WEATHER_CHANGE;
import static com.moyoung.moyoung_ble_plugin.ChannelNames.EVENT_CONTACT_AVATAR;
import static com.moyoung.moyoung_ble_plugin.ChannelNames.EVENT_ECG;
import static com.moyoung.moyoung_ble_plugin.ChannelNames.EVENT_FILE_TRANS;
import static com.moyoung.moyoung_ble_plugin.ChannelNames.EVENT_FIRMWARE_UPGRADE;
import static com.moyoung.moyoung_ble_plugin.ChannelNames.EVENT_WF_FILE_TRANS;

public class ConnEveChlRegister {
    private final static String TAG = ConnEveChlRegister.class.getSimpleName();

    private final List<EventChannel> eveChlList = new ArrayList<>();
    public final List<BaseConnectionEventChannelHandler> defaultConnHandlerList = new ArrayList<>();
    private final List<BaseConnectionEventChannelHandler> connLazyHandlerList = new ArrayList<>();
    private static BinaryMessenger binaryMgr;

    private static final ConnEveChlRegister instance = new ConnEveChlRegister();

    public static ConnEveChlRegister getInstance(BinaryMessenger binaryMessenger) {
        binaryMgr = binaryMessenger;
        return instance;
    }

    public void register() {
        registerEveChl(ConnectionStateHandler.getInstance(), EVENT_CONNECTION_STATE);
        registerEveChl(StepsChangeHandler.getInstance(), EVENT_STEPS_CHANGE);
        registerEveChl(DeviceBatteryHandler.getInstance(), EVENT_DEVICE_BATTERY);
        registerEveChl(WeatherChangeHandler.getInstance(), EVENT_WEATHER_CHANGE);
        registerEveChl(StepsDetailHandler.getInstance(), EVENT_STEPS_DETAIL);
        registerEveChl(SleepChangeHandler.getInstance(), EVENT_SLEEP_CHANGE);
        registerLazyEveChl(FileFirmwareUpgradeHandler.getInstance(), EVENT_FIRMWARE_UPGRADE);
        registerEveChl(HeartRateHandler.getInstance(), EVENT_HEART_RATE);
        registerEveChl(BloodPressureHandler.getInstance(), EVENT_BLOOD_PRESSURE);
        registerEveChl(BloodOxygenHandler.getInstance(), EVENT_BLOOD_OXYGEN);
        registerEveChl(CameraHandler.getInstance(), EVENT_CAMERA);
        registerEveChl(PhoneHandler.getInstance(), EVENT_PHONE);
        registerEveChl(DeviceRssiHandler.getInstance(), EVENT_DEVICE_RSSI);
        registerLazyEveChl(FileTransHandler.getInstance(), EVENT_FILE_TRANS);
        registerLazyEveChl(WFFileTransHandler.getInstance(), EVENT_WF_FILE_TRANS);
        registerLazyEveChl(ECGHandler.getInstance(), EVENT_ECG);
        registerLazyEveChl(ContactAvatarHandler.getInstance(), EVENT_CONTACT_AVATAR);
        registerLazyEveChl(CallNumberHandler.getInstance(), EVENT_CALL_NUMBER);
        registerEveChl(FindPhoneHandler.getInstance(), EVENT_FIND_PHONE);
        registerEveChl(TrainingStateHandler.getInstance(), EVENT_TRAINING_STATE);
        registerEveChl(TempChangeHandler.getInstance(), EVENT_TEMP_CHANGE);
        registerEveChl(ContactHandler.getInstance(), EVENT_CONTACT);
        registerEveChl(BatterySavingHandler.getInstance(), EVENT_BATTERY_SAVING);
        registerEveChl(TrainHandler.getInstance(), EVENT_TRAIN);
        registerEveChl(SosHandler.getInstance(), EVENT_SOS_CHANGE);
        registerEveChl(HRVHandler.getInstance(), EVENT_NEW_HRV);
        registerEveChl(StressHandler.getInstance(), EVENT_STRESS);
        registerEveChl(CalendarEventHandler.getInstance(), EVENT_CALENDAR_EVENT);
        registerEveChl(GpsChangeEventHandler.getInstance(), EVENT_GPS_CHANGE_EVENT);
    }

    public void unregister() {
        for (EventChannel eventChannel : eveChlList) {
            eventChannel.setStreamHandler(null);
        }
    }

    public void bindActivity(Context context) {
        for (BaseConnectionEventChannelHandler chlHandler : defaultConnHandlerList) {
            chlHandler.bindActivity(context);
        }
        for (BaseConnectionEventChannelHandler chlHandler : connLazyHandlerList) {
            chlHandler.bindActivity(context);
        }
    }

    public BaseConnectionEventChannelHandler getEveChlHandler(String chlName) {
        for (BaseConnectionEventChannelHandler baseConnEveChlHandler : defaultConnHandlerList) {
            if (chlName.equals(baseConnEveChlHandler.getBelongChl())) {
                return baseConnEveChlHandler;
            }
        }

        return null;
    }

    public BaseConnectionEventChannelHandler getLazyEveChlHandler(String chlName) {
        for (BaseConnectionEventChannelHandler baseConnLazyEveChlHandler : connLazyHandlerList) {
            if (chlName.equals(baseConnLazyEveChlHandler.getBelongChl())) {
                return baseConnLazyEveChlHandler;
            }
        }

        return null;
    }

    private void registerEveChl(BaseConnectionEventChannelHandler eveChlHandler, String chlName) {
        EventChannel bleConnectEveChl = new EventChannel(binaryMgr, chlName);
        bleConnectEveChl.setStreamHandler(eveChlHandler);

        eveChlHandler.setBelongChl(chlName);

        eveChlList.add(bleConnectEveChl);
        defaultConnHandlerList.add(eveChlHandler);
    }

    private void registerLazyEveChl(BaseConnectionEventChannelHandler lazyEveChlHandler, String chlName) {
        EventChannel bleConnectEveChl = new EventChannel(binaryMgr, chlName);
        bleConnectEveChl.setStreamHandler(lazyEveChlHandler);

        lazyEveChlHandler.setBelongChl(chlName);

        eveChlList.add(bleConnectEveChl);
        connLazyHandlerList.add(lazyEveChlHandler);
    }
}
