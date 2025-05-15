package com.moyoung.moyoung_ble_plugin.method;

import android.content.Context;

import com.crrepa.ble.CRPBleClient;
import com.crrepa.ble.conn.CRPBleConnection;
import com.crrepa.ble.conn.CRPBleDevice;
import com.crrepa.ble.conn.bean.CRPAlarmInfo;
import com.crrepa.ble.conn.bean.CRPCalendarEventInfo;
import com.crrepa.ble.conn.bean.CRPContactConfigInfo;
import com.crrepa.ble.conn.bean.CRPContactInfo;
import com.crrepa.ble.conn.bean.CRPDailyGoalsInfo;
import com.crrepa.ble.conn.bean.CRPDrinkWaterPeriodInfo;
import com.crrepa.ble.conn.bean.CRPElectronicCardCountInfo;
import com.crrepa.ble.conn.bean.CRPElectronicCardInfo;
import com.crrepa.ble.conn.bean.CRPFirmwareVersionInfo;
import com.crrepa.ble.conn.bean.CRPFutureWeatherInfo;
import com.crrepa.ble.conn.bean.CRPHandWashingPeriodInfo;
import com.crrepa.ble.conn.bean.CRPJieliSupportWatchFaceInfo;
import com.crrepa.ble.conn.bean.CRPJieliWatchFaceInfo;
import com.crrepa.ble.conn.bean.CRPMessageInfo;
import com.crrepa.ble.conn.bean.CRPPeriodTimeInfo;
import com.crrepa.ble.conn.bean.CRPPhysiologcalPeriodInfo;
import com.crrepa.ble.conn.bean.CRPPillReminderInfo;
import com.crrepa.ble.conn.bean.CRPSedentaryReminderPeriodInfo;
import com.crrepa.ble.conn.bean.CRPSifliSupportWatchFaceInfo;
import com.crrepa.ble.conn.bean.CRPSupportWatchFaceInfo;
import com.crrepa.ble.conn.bean.CRPTodayWeatherInfo;
import com.crrepa.ble.conn.bean.CRPTrainingDayInfo;
import com.crrepa.ble.conn.bean.CRPUserInfo;
import com.crrepa.ble.conn.bean.CRPWatchFaceDetailsInfo;
import com.crrepa.ble.conn.bean.CRPWatchFaceDetailsRequestInfo;
import com.crrepa.ble.conn.bean.CRPWatchFaceLayoutInfo;
import com.crrepa.ble.conn.bean.CRPWatchFaceStoreInfo;
import com.crrepa.ble.conn.bean.CRPWatchFaceStoreRequestInfo;
import com.crrepa.ble.conn.bean.CRPWatchFaceStoreTagInfo;
import com.crrepa.ble.conn.callback.CRPDeviceDisplayTimeCallback;
import com.crrepa.ble.conn.callback.CRPDeviceFirmwareVersionCallback;
import com.crrepa.ble.conn.callback.CRPDeviceNewFirmwareVersionCallback;
import com.crrepa.ble.conn.callback.CRPDeviceSupportWatchFaceCallback;
import com.crrepa.ble.conn.callback.CRPTrainingDayGoalsCallback;
import com.crrepa.ble.conn.callback.CRPWatchFaceDeleteCallback;
import com.crrepa.ble.conn.callback.CRPWatchFaceDetailsCallback;
import com.crrepa.ble.conn.callback.CRPWatchFaceStoreCallback;
import com.crrepa.ble.conn.callback.CRPWatchFaceStoreTagCallback;
import com.crrepa.ble.conn.type.CRPBleMessageType;
import com.crrepa.ble.conn.type.CRPBloodOxygenTimeType;
import com.crrepa.ble.conn.type.CRPDeviceLanguageType;
import com.crrepa.ble.conn.type.CRPDeviceVersionType;
import com.crrepa.ble.conn.type.CRPHeartRateType;
import com.crrepa.ble.conn.type.CRPHistoryDay;
import com.crrepa.ble.conn.type.CRPHistoryDynamicRateType;
import com.crrepa.ble.conn.type.CRPMetricSystemType;
import com.crrepa.ble.conn.type.CRPMovementHeartRateStateType;
import com.crrepa.ble.conn.type.CRPMusicPlayerStateType;
import com.crrepa.ble.conn.type.CRPStressDate;
import com.crrepa.ble.conn.type.CRPTempTimeType;
import com.crrepa.ble.conn.type.CRPTimeSystemType;
import com.crrepa.ble.conn.type.CRPTimingTempState;
import com.crrepa.ble.conn.type.CRPVibrationStrength;
import com.crrepa.ble.conn.type.CRPWatchFaceType;
import com.moyoung.moyoung_ble_plugin.base.BaseChannelHandler;
import com.moyoung.moyoung_ble_plugin.base.BaseConnectionEventChannelHandler;
import com.moyoung.moyoung_ble_plugin.callback.AlarmCallback;
import com.moyoung.moyoung_ble_plugin.common.GsonUtils;
import com.moyoung.moyoung_ble_plugin.common.MyLog;
import com.moyoung.moyoung_ble_plugin.event.ConnEveChlRegister;
import com.moyoung.moyoung_ble_plugin.model.BrightnessBean;
import com.moyoung.moyoung_ble_plugin.model.CalendarEventReminderTimeBean;
import com.moyoung.moyoung_ble_plugin.model.CheckFirmwareVersionBean;
import com.moyoung.moyoung_ble_plugin.model.ConnectBean;
import com.moyoung.moyoung_ble_plugin.model.ContactBean;
import com.moyoung.moyoung_ble_plugin.model.DeviceLanguageBean;
import com.moyoung.moyoung_ble_plugin.model.FirmwareVersionBean;
import com.moyoung.moyoung_ble_plugin.model.MaxHeartRateBean;
import com.moyoung.moyoung_ble_plugin.model.MenstrualCycleBean;
import com.moyoung.moyoung_ble_plugin.model.NotificationBean;
import com.moyoung.moyoung_ble_plugin.model.OTABean;
import com.moyoung.moyoung_ble_plugin.model.PeriodTimeBean;
import com.moyoung.moyoung_ble_plugin.model.PillReminderBean;
import com.moyoung.moyoung_ble_plugin.model.SifliSupportWatchFaceBean;
import com.moyoung.moyoung_ble_plugin.model.TrainingDaysBean;
import com.moyoung.moyoung_ble_plugin.model.WatchFaceBean;
import com.moyoung.moyoung_ble_plugin.model.WatchFaceDetailBean;
import com.moyoung.moyoung_ble_plugin.model.WatchFaceDetailResultBean;
import com.moyoung.moyoung_ble_plugin.model.WatchFaceIDBean;
import com.moyoung.moyoung_ble_plugin.model.WatchFaceStoreBean;
import com.moyoung.moyoung_ble_plugin.model.WatchFaceStoreListBean;
import com.moyoung.moyoung_ble_plugin.model.WatchFaceStoreResultBean;
import com.moyoung.moyoung_ble_plugin.model.WatchFaceStoreTagListResultBean;

import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;

import androidx.annotation.NonNull;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

import static com.moyoung.moyoung_ble_plugin.ChannelNames.EVENT_CONTACT_AVATAR;
import static com.moyoung.moyoung_ble_plugin.ChannelNames.EVENT_ECG;
import static com.moyoung.moyoung_ble_plugin.ChannelNames.EVENT_FILE_TRANS;
import static com.moyoung.moyoung_ble_plugin.ChannelNames.EVENT_WF_FILE_TRANS;


public class ConnectionMethodHandler extends BaseChannelHandler implements MethodChannel.MethodCallHandler {
    private final static String TAG = ConnectionMethodHandler.class.getSimpleName();

    private static ConnEveChlRegister connEveChlRegister;
    private CRPBleDevice bleDevice;
    private static CRPBleConnection bleConnection;
    public static boolean autoConnect = false;
    public static boolean enableBLE = true;
    public static boolean isConnected = false;
    // 用于控制是否打开通话
    public static boolean enableIncomingNumber = false;
    // 是否支持延迟拍照
    public static boolean supportDelayTime = false;
    // 是否是连接的时候调用
    public static boolean isConnectedCall = false;
    // 连接地址
    public static String address = "";
    // 保存连接通道
    public static MethodCall connectionStatecall = null;
    public static String firmwareVersion = "";

    private static final ConnectionMethodHandler instance = new ConnectionMethodHandler();

    public static ConnectionMethodHandler getInstance(ConnEveChlRegister register) {
        connEveChlRegister = register;
        return instance;
    }

    ;

    public static ConnectionMethodHandler getInstance() {
        return instance;
    }

    ;

    @Override
    public void bindActivity(Context context) {
        super.bindActivity(context);
        connEveChlRegister.bindActivity(context);
    }

    public void unbindChannel(MethodChannel methodChannel) {
        methodChannel.setMethodCallHandler(null);
        connEveChlRegister.unregister();
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        if ("checkBluetoothEnable".equals(call.method)) {
            checkBluetoothEnable(result);
            return;
        }

        if ("connect".equals(call.method)) {
            connect(call, context.getApplicationContext());
            result.success(null);
            return;
        }

        if (bleConnection == null) {
            if ("isConnected".equals(call.method)) {
                isConnected(call, result);
            }
            return;
        }

        switch (call.method) {
            case "disconnect":
                disconnect(result);
                break;
            case "closeGatt":
                closeGatt(result);
                break;
            case "isConnected":
                isConnected(call, result);
                break;
            case "queryTime":
                bleConnection.syncTime();
                result.success(null);
                break;
            case "sendTimeSystem":
                sendTimeSystem(call);
                result.success(null);
                break;
            case "queryFirmwareVersion":
                queryFirmwareVersion(result);
                break;
            case "queryTimeSystem":
                queryTimeSystem(result);
                break;
            case "checkFirmwareVersion":
                checkFirmwareVersion(call, result);
                break;
            case "queryDeviceBattery":
                queryDeviceBattery();
                result.success(null);
                break;
            case "subscribeDeviceBattery":
                subscribeDeviceBattery();
                result.success(null);
                break;
            case "sendUserInfo":
                sendUserInfo(call);
                result.success(null);
                break;
            case "sendStepLength":
                sendStepLength(call);
                result.success(null);
                break;
            case "sendTodayWeather":
                sendTodayWeather(call);
                result.success(null);
                break;
            case "sendFutureWeather":
                sendFutureWeather(call);
                result.success(null);
                break;
            case "querySteps":
                querySteps();
                result.success(null);
                break;
            case "queryHistorySteps":
                queryHistorySteps(call);
                result.success(null);
                break;
            case "queryStepsDetail":
                queryStepsDetail(call);
                result.success(null);
                break;
            case "querySleep":
                querySleep();
                result.success(null);
                break;
            case "queryRemSleep":
                queryRemSleep();
                result.success(null);
                break;
            case "sendGoalSleepTime":
                sendGoalSleepTime(call);
                result.success(null);
                break;
            case "queryGoalSleepTime":
                queryGoalSleepTime();
                result.success(null);
                break;
            case "queryHistorySleep":
                queryHistorySleep(call);
                result.success(null);
                break;
            case "startOTA":
                startOTA(call);
                result.success(null);
                break;
            case "abortOTA":
                abortOTA(call);
                result.success(null);
                break;
            case "queryDeviceOtaStatus":
                queryDeviceOtaStatus(result);
                break;
            case "queryHsOtaAddress":
                queryHsOtaAddress(result);
                break;
            case "enableHsOta":
                enableHsOta();
                result.success(null);
                break;
            case "queryOtaType":
                queryOtaType(result);
                break;
            case "queryUnitSystem":
                queryUnitSystem(result);
                break;
            case "sendUnitSystem":
                sendUnitSystem(call);
                result.success(null);
                break;
            case "sendQuickView":
                sendQuickView(call);
                result.success(null);
                break;
            case "queryQuickView":
                queryQuickView(result);
                break;
            case "sendQuickViewTime":
                sendQuickViewTime(call);
                result.success(null);
                break;
            case "queryQuickViewTime":
                queryQuickViewTime(result);
                break;
            case "sendGoalSteps":
                sendGoalSteps(call);
                result.success(null);
                break;
            case "queryGoalSteps":
                queryGoalSteps(result);
                break;
            case "sendDailyGoals":
                sendDailyGoals(call);
                result.success(null);
                break;
            case "queryDailyGoals":
                queryDailyGoals(result);
                break;
            case "sendTrainingDayGoals":
                sendTrainingDayGoals(call);
                result.success(null);
                break;
            case "queryTrainingDayGoals":
                queryTrainingDayGoals(result);
                break;
            case "sendTrainingDays":
                sendTrainingDays(call);
                result.success(null);
                break;
            case "queryTrainingDay":
                queryTrainingDay(result);
                break;
            case "sendDisplayWatchFace":
                sendDisplayWatchFace(call);
                result.success(null);
                break;
            case "queryDisplayWatchFace":
                queryDisplayWatchFace(result);
                break;
            case "queryWatchFaceLayout":
                queryWatchFaceLayout(result);
                break;
            case "sendWatchFaceLayout":
                sendWatchFaceLayout(call);
                result.success(null);
                break;
            case "queryJieliWatchFaceInfo":
                queryJieliWatchFaceInfo(result);
                break;
            case "querySupportWatchFace":
                querySupportWatchFace(result);
                break;
            case "queryAvailableStorage":
                queryAvailableStorage(call,result);
                break;
            case "queryWatchFaceStoreTagList":
                queryWatchFaceStoreTagList(call, result);
                break;
            case "queryWatchFaceStoreList":
                queryWatchFaceStoreList(call, result);
                break;
            case "queryWatchFaceDetail":
                queryWatchFaceDetail(call, result);
                break;
            case "queryWatchFaceStore":
                queryWatchFaceStore(call, result);
                break;
            case "queryWatchFaceOfID":
                queryWatchFaceOfID(call, result);
                break;
            case "sendWatchFace":
                sendWatchFace(call);
                break;
            case "sendWatchFaceId":
                sendWatchFaceId(call);
                break;
            case "abortWatchFace":
                abortWatchFace();
                break;
            case "deleteWatchFace":
                deleteWatchFace(call, result);
                break;
//            case "sendAlarm":
//                sendAlarm(call);
//                break;
//            case "queryAllAlarm":
//                queryAllAlarm(result);
//                break;
            case "sendNewAlarm":
                sendNewAlarm(call);
                break;
            case "deleteNewAlarm":
                deleteNewAlarm(call);
                break;
            case "deleteAllNewAlarm":
                deleteAllNewAlarm();
                break;
            case "queryAllNewAlarm":
                queryAllNewAlarm(result);
                break;
            case "queryLastDynamicRate":
                queryLastDynamicRate(call);
                break;
            case "enableTimingMeasureHeartRate":
                enableTimingMeasureHeartRate(call);
                break;
            case "disableTimingMeasureHeartRate":
                disableTimingMeasureHeartRate();
                break;
            case "queryTimingMeasureHeartRate":
                queryTimingMeasureHeartRate(result);
                break;
            case "queryTodayHeartRate":
                queryTodayHeartRate(call);
                break;
            case "queryPastHeartRate":
                queryPastHeartRate(call);
                break;
            case "queryTrainingHeartRate":
                queryTrainingHeartRate();
                break;
            case "startMeasureOnceHeartRate":
                startMeasureOnceHeartRate();
                break;
            case "stopMeasureOnceHeartRate":
                stopMeasureOnceHeartRate();
                break;
            case "queryHistoryHeartRate":
                queryHistoryHeartRate();
                break;
            case "startMeasureBloodPressure":
                startMeasureBloodPressure();
                break;
            case "stopMeasureBloodPressure":
                stopMeasureBloodPressure();
                break;
            case "enableContinueBloodPressure":
                enableContinueBloodPressure();
                break;
            case "disableContinueBloodPressure":
                disableContinueBloodPressure();
                break;
            case "queryContinueBloodPressureState":
                queryContinueBloodPressureState();
                break;
            case "queryLast24HourBloodPressure":
                queryLast24HourBloodPressure();
                break;
            case "queryHistoryBloodPressure":
                queryHistoryBloodPressure();
                break;
            case "startMeasureBloodOxygen":
                startMeasureBloodOxygen();
                break;
            case "stopMeasureBloodOxygen":
                stopMeasureBloodOxygen();
                break;
            case "enableTimingMeasureBloodOxygen":
                enableTimingMeasureBloodOxygen(call);
                break;
            case "disableTimingMeasureBloodOxygen":
                disableTimingMeasureBloodOxygen();
                break;
            case "queryTimingBloodOxygenMeasureState":
                queryTimingBloodOxygenMeasureState();
                break;
            case "queryTimingBloodOxygen":
                queryTimingBloodOxygen(call);
                break;
            case "enableContinueBloodOxygen":
                enableContinueBloodOxygen();
                break;
            case "disableContinueBloodOxygen":
                disableContinueBloodOxygen();
                break;
            case "queryContinueBloodOxygenState":
                queryContinueBloodOxygenState();
                break;
            case "queryLast24HourBloodOxygen":
                queryLast24HourBloodOxygen();
                break;
            case "queryHistoryBloodOxygen":
                queryHistoryBloodOxygen();
                break;
            case "enterCameraView":
                enterCameraView();
                break;
            case "exitCameraView":
                exitCameraView();
                break;
            case "readDeviceRssi":
                readDeviceRssi();
                break;
            case "setECGChangeListener":
                setECGChangeListener(call);
                break;
            case "startECGMeasure":
                startECGMeasure();
                break;
            case "stopECGMeasure":
                stopECGMeasure();
                break;
            case "isNewECGMeasurementVersion":
                isNewECGMeasurementVersion(result);
                break;
            case "queryLastMeasureECGData":
                queryLastMeasureECGData();
                break;
            case "sendECGHeartRate":
                sendECGHeartRate(call);
                break;
            case "sendWatchFaceBackground":
                sendWatchFaceBackground(call);
                result.success(null);
                break;
            case "abortWatchFaceBackground":
                abortWatchFaceBackground();
                result.success(null);
                break;
            case "sendDeviceLanguage":
                sendDeviceLanguage(call);
                result.success(null);
                break;
            case "queryDeviceVersion":
                queryDeviceVersion(result);
                break;
            case "queryDeviceLanguage":
                queryDeviceLanguage(result);
                break;
            case "sendOtherMessageState":
                sendOtherMessageState(call);
                result.success(null);
                break;
            case "queryOtherMessageState":
                queryOtherMessageState(result);
                break;
            case "sendMessage":
                sendMessage(call);
                result.success(null);
                break;
            case "endCall":
                endCall();
                result.success(null);
                break;
            case "sendCallContactName":
                sendCallContactName(call);
                result.success(null);
                break;
            case "queryMessageList":
                queryMessageList(result);
                break;
            case "sendSedentaryReminder":
                sendSedentaryReminder(call);
                result.success(null);
                break;
            case "querySedentaryReminderPeriod":
                querySedentaryReminderPeriod(result);
                break;
            case "sendSedentaryReminderPeriod":
                sendSedentaryReminderPeriod(call);
                result.success(null);
                break;
            case "querySedentaryReminder":
                querySedentaryReminder(result);
                break;
            case "findDevice":
                findDevice();
                result.success(null);
                break;
            case "shutDown":
                shutDown();
                result.success(null);
                break;
            case "reset":
                reset();
                result.success(null);
                break;
            case "sendDoNotDisturbTime":
                sendDoNotDisturbTime(call);
                result.success(null);
                break;
            case "queryDoNotDisturbTime":
                queryDoNotDisturbTime(result);
                break;
            case "sendBreathingLight":
                sendBreathingLight(call);
                result.success(null);
                break;
            case "queryBreathingLight":
                queryBreathingLight(result);
                break;
            case "sendMenstrualCycle":
                sendMenstrualCycle(call);
                result.success(null);
                break;
            case "queryMenstrualCycle":
                queryMenstrualCycle(result);
                break;
            case "startFindPhone":
                startFindPhone();
                result.success(null);
                break;
            case "stopFindPhone":
                stopFindPhone();
                result.success(null);
                break;
            case "setPlayerState":
                setPlayerState(call);
                result.success(null);
                break;
            case "sendSongTitle":
                sendSongTitle(call);
                result.success(null);
                break;
            case "sendLyrics":
                sendLyrics(call);
                result.success(null);
                break;
            case "closePlayerControl":
                closePlayerControl();
                result.success(null);
                break;
            case "sendCurrentVolume":
                sendCurrentVolume(call);
                result.success(null);
                break;
            case "sendMaxVolume":
                sendMaxVolume(call);
                result.success(null);
                break;
            case "enableDrinkWaterReminder":
                enableDrinkWaterReminder(call);
                result.success(null);
                break;
            case "disableDrinkWaterReminder":
                disableDrinkWaterReminder();
                result.success(null);
                break;
            case "queryDrinkWaterReminderPeriod":
                queryDrinkWaterReminderPeriod(result);
                break;
            case "setMaxHeartRate":
                setMaxHeartRate(call);
                result.success(null);
                break;
            case "queryMaxHeartRate":
                queryMaxHeartRate(result);
                break;
            case "startTraining":
                startTraining(call);
                result.success(null);
                break;
            case "setTrainingState":
                setTrainingState(call);
                result.success(null);
                break;
            case "getProtocolVersion":
                getProtocolVersion(result);
                break;
            case "startMeasureTemp":
                startMeasureTemp();
                result.success(null);
                break;
            case "stopMeasureTemp":
                stopMeasureTemp();
                result.success(null);
                break;
            case "enableTimingMeasureTemp":
                enableTimingMeasureTemp();
                result.success(null);
                break;
            case "disableTimingMeasureTemp":
                disableTimingMeasureTemp();
                result.success(null);
                break;
            case "queryTimingMeasureTempState":
                queryTimingMeasureTempState(result);
                break;
            case "queryTimingMeasureTemp":
                queryTimingMeasureTemp(call);
                result.success(null);
                break;
            case "sendDisplayTime":
                sendDisplayTime(call);
                result.success(null);
                break;
            case "queryDisplayTime":
                queryDisplayTime(result);
                break;
            case "enableHandWashingReminder":
                enableHandWashingReminder(call);
                result.success(null);
                break;
            case "disableHandWashingReminder":
                disableHandWashingReminder();
                result.success(null);
                break;
            case "queryHandWashingReminderPeriod":
                queryHandWashingReminderPeriod(result);
                break;
            case "sendLocalCity":
                sendLocalCity(call);
                result.success(null);
                break;
            case "sendTempUnit":
                sendTempUnit(call);
                result.success(null);
                break;
            case "queryTempUnit":
                queryTempUnit();
                result.success(null);
                break;
            case "sendBrightness":
                sendBrightness(call);
                result.success(null);
                break;
            case "queryBrightness":
                queryBrightness(result);
                break;
            case "queryBtAddress":
                queryBtAddress(result);
                break;
            case "checkSupportQuickContact":
                checkSupportQuickContact(result);
                break;
            case "queryContactCount":
                queryContactCount(result);
                break;
            case "queryContactNumberSymbol":
                queryContactNumberSymbol(result);
                break;
            case "sendContact":
                sendContact(call);
                result.success(null);
                break;
            case "sendContactAvatar":
                sendContactAvatar(call);
                result.success(null);
                break;
            case "deleteContact":
                deleteContact(call);
                result.success(null);
                break;
            case "deleteContactAvatar":
                deleteContactAvatar(call);
                result.success(null);
                break;
            case "clearContact":
                clearContact();
                result.success(null);
                break;
            case "queryBatterySaving":
                queryBatterySaving();
                result.success(null);
                break;
            case "sendBatterySaving":
                sendBatterySaving(call);
                result.success(null);
                break;
            case "queryPillReminder":
                queryPillReminder(result);
                break;
            case "sendPillReminder":
                sendPillReminder(call);
                result.success(null);
                break;
            case "deletePillReminder":
                deletePillReminder(call);
                result.success(null);
                break;
            case "clearPillReminder":
                clearPillReminder();
                result.success(null);
                break;
            case "queryWakeState":
                queryWakeState(result);
                break;
            case "querySupportStress":
                querySupportStress();
                result.success(null);
                break;
            case "startMeasureStress":
                startMeasureStress();
                result.success(null);
                break;
            case "stopMeasureStress":
                stopMeasureStress();
                result.success(null);
                break;
            case "queryHistoryStress":
                queryHistoryStress();
                result.success(null);
                break;
            case "enableTimingStress":
                enableTimingStress();
                result.success(null);
                break;
            case "disableTimingStress":
                disableTimingStress();
                result.success(null);
                break;
            case "queryTimingStressState":
                queryTimingStressState();
                result.success(null);
                break;
            case "queryTimingStress":
                queryTimingStress(call);
                result.success(null);
                break;
            case "queryElectronicCardCount":
                queryElectronicCardCount(result);
                break;
            case "sendElectronicCard":
                sendElectronicCard(call);
                result.success(null);
                break;
            case "deleteElectronicCard":
                deleteElectronicCard(call);
                result.success(null);
                break;
            case "queryElectronicCard":
                queryElectronicCard(call, result);
                break;
            case "sendElectronicCardList":
                sendElectronicCardList(call);
                result.success(null);
                break;
            case "sendWakeState":
                sendWakeState(call);
                result.success(null);
                break;
            case "queryHistoryTraining":
                queryHistoryTraining();
                result.success(null);
                break;
            case "queryTraining":
                queryTraining(call);
                result.success(null);
                break;
            case "sendGsensorCalibration":
                sendGsensorCalibration();
                result.success(null);
                break;
            case "enableContinueTemp":
                enableContinueTemp();
                result.success(null);
                break;
            case "disableContinueTemp":
                disableContinueTemp();
                result.success(null);
                break;
            case "queryContinueTempState":
                queryContinueTempState();
                result.success(null);
                break;
            case "queryLast24HourTemp":
                queryLast24HourTemp();
                result.success(null);
                break;
            case "createBond":
                createBond(call, result);
                break;
            case "querySupportNewHrv":
                querySupportNewHrv();
                result.success(null);
                break;
            case "startMeasureNewHrv":
                startMeasureNewHrv();
                result.success(null);
                break;
            case "stopMeasureNewHrv":
                stopMeasureNewHrv();
                result.success(null);
                break;
            case "queryHistoryNewHrv":
                queryHistoryNewHrv();
                result.success(null);
                break;
            case "querySupportCalendarEvent":
                querySupportCalendarEvent();
                result.success(null);
                break;
            case "sendCalendarEvent":
                sendCalendarEvent(call);
                result.success(null);
                break;
            case "deleteCalendarEvent":
                deleteCalendarEvent(call);
                result.success(null);
                break;
            case "queryCalendarEvent":
                queryCalendarEvent(call);
                result.success(null);
                break;
            case "sendCalendarEventReminderTime":
                sendCalendarEventReminderTime(call);
                result.success(null);
                break;
            case "queryCalendarEventReminderTime":
                queryCalendarEventReminderTime();
                result.success(null);
                break;
            case "clearCalendarEvent":
                clearCalendarEvent();
                result.success(null);
                break;
            case "sendVibrationStrength":
                sendVibrationStrength(call);
                result.success(null);
                break;
            case "queryVibrationStrength":
                queryVibrationStrength(result);
                break;
            case "enableIncomingNumber":
                enableIncomingNumber(call, result);
                break;
            default:
                result.notImplemented();
        }
    }

    private void queryVibrationStrength(MethodChannel.Result result) {
        bleConnection.queryVibrationStrength(vibrationStrength -> {
            String jsonStr = GsonUtils.get().toJson(vibrationStrength, CRPVibrationStrength.class);
            result.success(jsonStr);
        });
    }

    private void sendVibrationStrength(MethodCall call) {
        Integer value = call.argument("value");
        assert value != null;
        bleConnection.sendVibrationStrength(CRPVibrationStrength.getInstance(value.byteValue()));
    }

    private void clearCalendarEvent() {
        bleConnection.clearCalendarEvent();
    }

    private void queryCalendarEventReminderTime() {
        bleConnection.queryCalendarEventReminderTime();
    }

    private void sendCalendarEventReminderTime(MethodCall call) {
        String jsonStr = call.argument("calendarEventReminderTime");
        CalendarEventReminderTimeBean calendarEventReminderTime = GsonUtils.get().fromJson(jsonStr, CalendarEventReminderTimeBean.class);
        bleConnection.sendCalendarEventReminderTime(calendarEventReminderTime.isEnable(), calendarEventReminderTime.getMinutes());
    }

    private void queryCalendarEvent(MethodCall call) {
        Integer id = call.argument("id");
        id = id == null ? -1 : id;
        bleConnection.queryCalendarEvent(id);
    }

    private void deleteCalendarEvent(MethodCall call) {
        Integer id = call.argument("id");
        id = id == null ? -1 : id;
        bleConnection.deleteCalendarEvent(id);
    }

    private void sendCalendarEvent(MethodCall call) {
        String jsonStr = call.argument("calenderEventInfo");
        CRPCalendarEventInfo calendarEventInfo = GsonUtils.get().fromJson(jsonStr, CRPCalendarEventInfo.class);
        bleConnection.sendCalendarEvent(calendarEventInfo);
    }

    private void querySupportCalendarEvent() {
        bleConnection.querySupportCalendarEvent();
    }

    private void queryHistoryNewHrv() {
        bleConnection.queryHistoryNewHrv();
    }

    private void stopMeasureNewHrv() {
        bleConnection.stopMeasureNewHrv();
    }

    private void startMeasureNewHrv() {
        bleConnection.startMeasureNewHrv();
    }

    private void querySupportNewHrv() {
        bleConnection.querySupportNewHrv();
    }

    private void createBond(MethodCall call, MethodChannel.Result result) {
        String str = call.argument("keys");
        assert str != null;
        String[] keysStr = str.split(",");
        byte[] keys = new byte[keysStr.length];
        for (int i = 0; i < keysStr.length; i++) {
            keys[i] = Byte.parseByte(keysStr[i]);
        }
        bleConnection.createBond(keys, result::success);
    }

    private void queryLast24HourTemp() {
        bleConnection.queryLast24HourTemp();
    }

    private void queryContinueTempState() {
        bleConnection.queryContinueTempState();
    }

    private void disableContinueTemp() {
        bleConnection.disableContinueTemp();
    }

    private void enableContinueTemp() {
        bleConnection.enableContinueTemp();
    }

    private void sendGsensorCalibration() {
        bleConnection.sendGsensorCalibration();
    }

    private void queryTraining(MethodCall call) {
        Integer id = call.argument("id");
        id = id == null ? -1 : id;
        bleConnection.queryTraining(id);
    }

    private void queryHistoryTraining() {
        bleConnection.queryHistoryTraining();
    }

    private void sendWakeState(MethodCall call) {
        Boolean enable = call.argument("enable");
        enable = enable != null && enable;
        bleConnection.sendTapToWakeState(enable);
    }

    private void queryWakeState(MethodChannel.Result result) {
        bleConnection.queryTapToWakeState(result::success);
    }

    private void querySupportStress() {
        bleConnection.querySupportStress();
    }

    private void startMeasureStress() {
        bleConnection.startMeasureStress();
    }

    private void stopMeasureStress() {
        bleConnection.stopMeasureStress();
    }

    private void queryHistoryStress() {
        bleConnection.queryHistoryStress();
    }

    private void enableTimingStress() {
        bleConnection.enableTimingStress();
    }

    private void disableTimingStress() {
        bleConnection.disableTimingStress();
    }

    private void queryTimingStressState() {
        bleConnection.queryTimingStressState();
    }

    private void queryTimingStress(MethodCall call) {
        String jsonStr = call.argument("stressDate");
        jsonStr = jsonStr == null ? CRPStressDate.TODAY.toString() : jsonStr;
        bleConnection.queryTimingStress(CRPStressDate.valueOf(jsonStr));
    }

    private void queryElectronicCardCount(MethodChannel.Result result) {
        bleConnection.queryElectronicCardCount(electronicCardCountInfo -> {
            String jsonStr = GsonUtils.get().toJson(electronicCardCountInfo, CRPElectronicCardCountInfo.class);
            result.success(jsonStr);
        });
    }

    private void sendElectronicCard(MethodCall call) {
        String jsonStr = call.argument("electronicCardInfo");
        CRPElectronicCardInfo electronicCardInfo = GsonUtils.get().fromJson(jsonStr, CRPElectronicCardInfo.class);
        bleConnection.sendElectronicCard(electronicCardInfo);
    }

    private void deleteElectronicCard(MethodCall call) {
        Integer id = call.argument("id");
        id = id == null ? -1 : id;
        bleConnection.deleteElectronicCard(id);
    }

    private void queryElectronicCard(MethodCall call, MethodChannel.Result result) {
        Integer id = call.argument("id");
        id = id == null ? -1 : id;
        bleConnection.queryElectronicCard(id, electronicCardInfo -> {
            String jsonStr = GsonUtils.get().toJson(electronicCardInfo, CRPElectronicCardInfo.class);
            result.success(jsonStr);
        });
    }

    private void sendElectronicCardList(MethodCall call) {
        String jsonStr = call.argument("idList");
        if (jsonStr == null) return;
        String[] strArr = jsonStr.substring(1, jsonStr.length() - 1).split(",");
        ArrayList<Integer> idList = new ArrayList<>(strArr.length);
        for (String s : strArr) {
            idList.add(Integer.valueOf(s));
        }
        bleConnection.sendElectronicCardList(idList);
    }

    private void clearPillReminder() {
        bleConnection.clearPillReminder();
    }

    private void deletePillReminder(MethodCall call) {
        Integer id = call.argument("id");
        id = id == null ? -1 : id;
        bleConnection.deletePillReminder(id);
    }

    private void sendPillReminder(MethodCall call) {
        String jsonStr = call.argument("pillReminderInfo");
        CRPPillReminderInfo pillReminderInfo = GsonUtils.get().fromJson(jsonStr,
                CRPPillReminderInfo.class);
        bleConnection.sendPillReminder(pillReminderInfo);
    }

    private void queryPillReminder(MethodChannel.Result result) {
        bleConnection.queryPillReminder((supportCount, list) -> {
            PillReminderBean pillReminderBean = new PillReminderBean();
            pillReminderBean.setSupportCount(supportCount);
            pillReminderBean.setList(list);
            String jsonStr = GsonUtils.get().toJson(pillReminderBean, PillReminderBean.class);
            result.success(jsonStr);
        });
    }

    private void sendBatterySaving(MethodCall call) {
        Boolean enable = call.argument("enable");
        enable = enable != null && enable;
        bleConnection.sendBatterySaving(enable);
    }

    private void queryBatterySaving() {
        bleConnection.queryBatterySaving();
    }

    private void clearContact() {
        bleConnection.clearContact();
    }

    private void deleteContact(MethodCall call) {
        Integer index = call.argument("index");
        if (index != null) {
            bleConnection.deleteContact(index);
        }
    }

    private void deleteContactAvatar(MethodCall call) {
        Integer index = call.argument("index");
        if (index != null) {
            bleConnection.deleteContactAvatar(index);
        }
    }

    private void sendContact(MethodCall call) {
        String jsonStr = call.argument("contactBean");
        ContactBean contactBean = GsonUtils.get().fromJson(jsonStr,
                ContactBean.class);
        CRPContactInfo crpContactInfo = new CRPContactInfo(
                contactBean.getId(),
                contactBean.getWidth(),
                contactBean.getHeight(),
                contactBean.getAddress(),
                contactBean.getName(),
                contactBean.getNumber());
        bleConnection.sendContact(crpContactInfo);
    }

    private void sendContactAvatar(MethodCall call) {
        BaseConnectionEventChannelHandler lazyEveChlHandler
                = connEveChlRegister.getLazyEveChlHandler(EVENT_CONTACT_AVATAR);
        if (lazyEveChlHandler != null) {
            lazyEveChlHandler.setConnListener(bleConnection, call);
        }
    }

    private void queryContactNumberSymbol(MethodChannel.Result result) {
        bleConnection.queryContactNumberSymbol(result::success);
    }

    private void queryContactCount(MethodChannel.Result result) {
        bleConnection.queryContactCount(result::success);
    }

    private void checkSupportQuickContact(MethodChannel.Result result) {
        bleConnection.checkSupportQuickContact(contactConfigInfo -> {
            String jsonStr = GsonUtils.get().toJson(contactConfigInfo, CRPContactConfigInfo.class);
            result.success(jsonStr);
        });
    }

    private void queryBtAddress(MethodChannel.Result result) {
        bleConnection.queryBtAddress(result::success);
    }

    private void queryBrightness(MethodChannel.Result result) {
        bleConnection.queryBrightness((current, max) -> {
            BrightnessBean brightness = new BrightnessBean(current, max);
            String jsonStr = GsonUtils.get().toJson(brightness, BrightnessBean.class);
            result.success(jsonStr);
        });
    }

    private void sendBrightness(MethodCall call) {
        Integer brightness = call.argument("brightness");
        brightness = brightness == null ? -1 : brightness;
        bleConnection.sendBrightness(brightness);
    }

    private void queryTempUnit() {
        bleConnection.queryTempUnit();
    }

    private void sendTempUnit(MethodCall call) {
        Integer temp = call.argument("temp");
        temp = temp == null ? 1 : temp;
        bleConnection.sendTempUnit(temp.byteValue());
    }

    private void sendLocalCity(MethodCall call) {
        String city = call.argument("city");
        bleConnection.sendLocalCity(city);
    }

    private void queryHandWashingReminderPeriod(MethodChannel.Result result) {
        bleConnection.queryHandWashingReminderPeriod(handWashingPeriodInfo -> {
            String jsonStr = GsonUtils.get().toJson(handWashingPeriodInfo, CRPHandWashingPeriodInfo.class);
            result.success(jsonStr);
        });
    }

    private void disableHandWashingReminder() {
        CRPHandWashingPeriodInfo handWashingPeriodInfo = new CRPHandWashingPeriodInfo(false, 0, 0, 0, 0);
        bleConnection.sendHandWashingReminder(handWashingPeriodInfo);
    }

    private void enableHandWashingReminder(MethodCall call) {
        String jsonStr = call.argument("handWashingPeriodInfo");
        CRPHandWashingPeriodInfo handWashingPeriodInfo = GsonUtils.get().fromJson(jsonStr,
                CRPHandWashingPeriodInfo.class);
        bleConnection.sendHandWashingReminder(handWashingPeriodInfo);
    }

    private void queryDisplayTime(MethodChannel.Result result) {
        bleConnection.queryDisplayTime(new CRPDeviceDisplayTimeCallback() {
            @Override
            public void onSupportAlwayOn(boolean b) {

            }

            @Override
            public void onDisplayTime(int time) {
                result.success(time);
            }
        });
    }

    private void sendDisplayTime(MethodCall call) {
        Integer time = call.argument("time");
        if (time != null && time % 5 == 0 && 0 < time && time <= 30) {
            bleConnection.sendDisplayTime(time);
        }
    }

    private void queryTimingMeasureTemp(MethodCall call) {
        String tempTimeType = call.argument("tempTimeType");
        tempTimeType = tempTimeType == null ? "TODAY" : tempTimeType;
        bleConnection.queryTimingMeasureTemp(CRPTempTimeType.valueOf(tempTimeType));
    }

    private void queryTimingMeasureTempState(MethodChannel.Result result) {
        bleConnection.queryTimingMeasureTempState(timingTempState -> {
            String jsonStr = GsonUtils.get().toJson(timingTempState, CRPTimingTempState.class);
            result.success(jsonStr);
        });
    }

    private void disableTimingMeasureTemp() {
        bleConnection.disableTimingMeasureTemp();
    }

    private void enableTimingMeasureTemp() {
        bleConnection.enableTimingMeasureTemp();
    }

    private void stopMeasureTemp() {
        bleConnection.stopMeasureTemp();
    }

    private void startMeasureTemp() {
        bleConnection.startMeasureTemp();
    }

    private void setTrainingState(MethodCall call) {
        Integer training = call.argument("training");
        training = training == null ? CRPMovementHeartRateStateType.MOVEMENT_COMPLETE : training;
        bleConnection.setMovementState(training.byteValue());
    }

    private void startTraining(MethodCall call) {
        Integer type = call.argument("type");
        type = type == null ? 0 : type;
        bleConnection.startMovement(type.byteValue());
    }

    private void queryMaxHeartRate(MethodChannel.Result result) {
        bleConnection.queryMaxHeartRate((heartRate, enable) -> {
            MaxHeartRateBean maxHeartRate = new MaxHeartRateBean(heartRate, enable);
            String jsonStr = GsonUtils.get().toJson(maxHeartRate, MaxHeartRateBean.class);
            result.success(jsonStr);
        });
    }

    private void setMaxHeartRate(MethodCall call) {
        String jsonStr = call.argument("maxHeartRateBean");
        MaxHeartRateBean maxHeartRate = GsonUtils.get().fromJson(jsonStr,
                MaxHeartRateBean.class);
        bleConnection.setMaxHeartRate(maxHeartRate.getHeartRate(), maxHeartRate.getEnable());
    }

    private void queryDrinkWaterReminderPeriod(MethodChannel.Result result) {
        bleConnection.queryDrinkWaterReminderPeriod(drinkWaterPeriodInfo -> {
            String jsonStr = GsonUtils.get().toJson(drinkWaterPeriodInfo, CRPDrinkWaterPeriodInfo.class);
            result.success(jsonStr);
        });
    }

    private void disableDrinkWaterReminder() {
        CRPDrinkWaterPeriodInfo drinkWaterPeriodInfo = new CRPDrinkWaterPeriodInfo(false, 0, 0, 0, 0);
        bleConnection.sendDrinkWaterReminder(drinkWaterPeriodInfo);
    }

    private void enableDrinkWaterReminder(MethodCall call) {
        String jsonStr = call.argument("drinkWaterPeriodInfo");
        CRPDrinkWaterPeriodInfo drinkWaterPeriodInfo = GsonUtils.get().fromJson(jsonStr,
                CRPDrinkWaterPeriodInfo.class);
        bleConnection.sendDrinkWaterReminder(drinkWaterPeriodInfo);
    }

    private void sendMaxVolume(MethodCall call) {
        Integer volume = call.argument("volume");
        volume = volume == null ? 0 : volume;
        bleConnection.sendMaxVolume(volume);
    }

    private void sendCurrentVolume(MethodCall call) {
        Integer volume = call.argument("volume");
        volume = volume == null ? 0 : volume;
        bleConnection.sendCurrentVolume(volume);
    }

    private void closePlayerControl() {
        bleConnection.closeMusicControl();
    }

    private void sendLyrics(MethodCall call) {
        bleConnection.sendLyrics(call.argument("lyrics"));
    }

    private void sendSongTitle(MethodCall call) {
        bleConnection.sendSongTitle(call.argument("title"));
    }

    private void setPlayerState(MethodCall call) {
        Integer type = call.argument("musicPlayerStateType");
        type = type == null ? CRPMusicPlayerStateType.MUSIC_PLAYER_PAUSE : type;
        bleConnection.setMusicPlayerState(type.byteValue());
    }

    private void stopFindPhone() {
        bleConnection.stopFindPhone();
    }

    private void startFindPhone() {
        bleConnection.startFindPhone();
    }

    private void sendMenstrualCycle(MethodCall call) {
        String jsonStr = call.argument("menstrualCycleBean");

        MenstrualCycleBean menstrualCycleBean = GsonUtils.get().fromJson(jsonStr,
                MenstrualCycleBean.class);
        bleConnection.sendPhysiologcalPeriod(MenstrualCycleBean.convert(menstrualCycleBean));
    }

    private void queryMenstrualCycle(MethodChannel.Result result) {
        bleConnection.queryPhysiologcalPeriod(physiologcalPeriodInfo -> {
            String jsonStr = GsonUtils.get().toJson(physiologcalPeriodInfo, CRPPhysiologcalPeriodInfo.class);
            result.success(jsonStr);
        });
    }

    private void getProtocolVersion(MethodChannel.Result result) {
        String jsonStr = GsonUtils.get().toJson(bleConnection.getProtocolVersion());
        result.success(jsonStr);
    }

    private void sendFutureWeather(MethodCall call) {
        String jsonStr = call.argument("futureWeatherInfo");
        CRPFutureWeatherInfo futureWeatherInfo = GsonUtils.get().fromJson(jsonStr,
                CRPFutureWeatherInfo.class);
        bleConnection.sendFutureWeather(futureWeatherInfo);
    }

    private void sendTodayWeather(MethodCall call) {
        String jsonStr = call.argument("todayWeatherInfo");
        CRPTodayWeatherInfo todayWeatherInfo = GsonUtils.get().fromJson(jsonStr,
                CRPTodayWeatherInfo.class);
        bleConnection.sendTodayWeather(todayWeatherInfo);
    }

    private void sendStepLength(MethodCall call) {
        Integer stepLength = call.argument("stepLength");
        stepLength = stepLength == null ? -1 : stepLength;
        bleConnection.sendStepLength(stepLength.byteValue());
    }

    private void sendUserInfo(MethodCall call) {
        String jsonStr = call.argument("userInfo");
        CRPUserInfo userInfo = GsonUtils.get().fromJson(jsonStr, CRPUserInfo.class);
        bleConnection.sendUserInfo(userInfo);
    }

    private void sendTimeSystem(@NonNull MethodCall call) {
        Integer timeSystemType = call.argument("timeSystemType");
        timeSystemType = timeSystemType == null ? CRPTimeSystemType.TIME_SYSTEM_12 : timeSystemType;

        bleConnection.sendTimeSystem(timeSystemType.byteValue());
    }

    private void queryTimeSystem(MethodChannel.Result result) {
        bleConnection.queryTimeSystem(result::success);
    }

    private void queryDeviceBattery() {
        bleConnection.queryDeviceBattery();
    }

    private void subscribeDeviceBattery() {
        bleConnection.subscribeDeviceBattery();
    }

    private void queryFirmwareVersion(MethodChannel.Result result) {
        bleConnection.queryFrimwareVersion(new CRPDeviceFirmwareVersionCallback() {
            @Override
            public void onDeviceFirmwareVersion(String firmwareVersion) {
                ConnectionMethodHandler.firmwareVersion = firmwareVersion;
                result.success(firmwareVersion);
            }

            @Override
            public void onDeviceCustomizeVersion(String s) {
                result.success(s);
            }
        });
    }

    public static void queryFirmwareVersion() {
        bleConnection.queryFrimwareVersion(new CRPDeviceFirmwareVersionCallback() {
            @Override
            public void onDeviceFirmwareVersion(String firmwareVersion) {
                ConnectionMethodHandler.firmwareVersion = firmwareVersion;
            }

            @Override
            public void onDeviceCustomizeVersion(String s) {

            }
        });
    }

    private void checkFirmwareVersion(MethodCall call, MethodChannel.Result result) {
        String jsonStr = call.argument("firmwareVersion");
        FirmwareVersionBean firmwareVersionBean = GsonUtils.get().fromJson(jsonStr, FirmwareVersionBean.class);

        if (bleConnection == null) {
            result.success(null);
            return;
        }

        bleConnection.checkFirmwareVersion(new CRPDeviceNewFirmwareVersionCallback() {
            @Override
            public void onNewFirmwareVersion(CRPFirmwareVersionInfo firmwareVersionInfo) {
                CheckFirmwareVersionBean firmwareVersionBean = new CheckFirmwareVersionBean();
                firmwareVersionBean.setIsLatestVersion(false);
                firmwareVersionBean.setFirmwareVersionInfo(firmwareVersionInfo);
                String jsonStr = GsonUtils.get().toJson(firmwareVersionBean, CheckFirmwareVersionBean.class);
                result.success(jsonStr);
            }

            @Override
            public void onLatestVersion() {
                CheckFirmwareVersionBean firmwareVersionBean = new CheckFirmwareVersionBean();
                firmwareVersionBean.setIsLatestVersion(true);
                String jsonStr = GsonUtils.get().toJson(firmwareVersionBean, CheckFirmwareVersionBean.class);
                result.success(jsonStr);
            }
        }, firmwareVersionBean.getVersion(), firmwareVersionBean.getOtaType());
    }

    private void setConnListener() {
        for (BaseConnectionEventChannelHandler handler : connEveChlRegister.defaultConnHandlerList) {
            handler.setConnListener(bleConnection, ConnectionMethodHandler.connectionStatecall);
        }
    }

    public void connect(@NonNull MethodCall call, Context context) {
        String jsonStr = call.argument("connectInfo");
        MyLog.d("MOYOUNG-method", "connect entrance:" + jsonStr);
        ConnectBean connectBean = GsonUtils.get().fromJson(jsonStr, ConnectBean.class);
        if (isConnected(connectBean.getAddress())) return;
        autoConnect = connectBean.isAutoConnect();
        address = connectBean.getAddress();
        bleDevice = CRPBleClient.create(context.getApplicationContext()).getBleDevice(address);
        if (bleDevice == null && isConnected(address)) return;
        bleConnection = bleDevice.connect();
        if (bleConnection == null) {
            return;
        }

        ConnectionMethodHandler.connectionStatecall = call;
        setConnListener();
    }

    public void autoConnect(Context context, boolean enableBLE) {
        MyLog.d("MOYOUNG-method", "autoConnect");
        if (enableBLE) {
            ConnectionMethodHandler.enableBLE = true;
            if (autoConnect) {
                if (bleDevice == null) {
                    bleDevice = CRPBleClient.create(context).getBleDevice(address);
                    if (bleDevice == null) return;
                }
                if (isConnected(address)) return;
                bleConnection = bleDevice.connect();
                if (bleConnection != null) {
                    setConnListener();
                }
            }
        } else {
            ConnectionMethodHandler.enableBLE = false;
            if (bleDevice == null) getBleDevice();
            if (bleDevice != null && isConnected) {
                bleDevice.disconnect();
                isConnected = false;
                setConnListener();
            }
        }
    }

    public void connect() {
        MyLog.d("MOYOUNG-method", "connect");
        if (bleDevice == null) {
            bleDevice = CRPBleClient.create(context.getApplicationContext()).getBleDevice(address);
        }
        if (bleDevice == null && isConnected(address)) return;
        bleConnection = bleDevice.connect();
    }

    private void isConnected(MethodCall call, MethodChannel.Result result) {
        String address = call.argument("address");
        result.success(isConnected(address));
    }

    public boolean isConnected(String address) {
        CRPBleDevice mBleDevice = bleClient.getBleDevice(address);
        return isConnected || (mBleDevice != null && mBleDevice.isConnected());
    }

    private void checkBluetoothEnable(MethodChannel.Result result) {
        if (bleClient != null) {
            result.success(bleClient.isBluetoothEnable());
        } else {
            result.success(false);
        }
    }

    private void disconnect(MethodChannel.Result result) {
        if (bleDevice == null) {
            getBleDevice();
        }
        if (bleDevice != null) {
            bleDevice.disconnect();
            isConnected = false;
            autoConnect = false;
            ConnectionMethodHandler.connectionStatecall = null;
            ConnectionMethodHandler.firmwareVersion = "";
            result.success(true);
        } else {
            result.success(false);
        }
    }

    private void closeGatt(MethodChannel.Result result) {
        if (bleConnection != null) {
            bleConnection.close();
            bleConnection = null;
            result.success(true);
        } else {
            result.success(false);
        }
    }

    private void querySteps() {
        bleConnection.syncStep();
    }

    private void queryHistorySteps(MethodCall call) {
        Integer historyTimeType = call.argument("historyTimeType");
        historyTimeType = historyTimeType == null ?
                0 : historyTimeType;
        bleConnection.queryHistoryStep(CRPHistoryDay.getInstance(historyTimeType.byteValue()));
    }

    private void queryStepsDetail(MethodCall call) {
        Integer stepsDetailDateType = call.argument("stepsDetailDateType");
        stepsDetailDateType = stepsDetailDateType == null ?
                CRPHistoryDay.YESTERDAY.getValue() : stepsDetailDateType;
        bleConnection.queryStepsCategory(CRPHistoryDay.getInstance(stepsDetailDateType.byteValue()));
    }

    private void querySleep() {
        bleConnection.syncSleep();
    }

    private void queryRemSleep() {
        bleConnection.syncRemSleep();
    }

    private void sendGoalSleepTime(MethodCall call) {
        Integer goalTime = call.argument("goalTime");
        goalTime = goalTime == null ?
                100 : goalTime;
        bleConnection.sendGoalSleepTime(goalTime);
    }

    private void queryGoalSleepTime() {
        bleConnection.queryGoalSleepTime();
    }

    private void queryHistorySleep(MethodCall call) {
        Integer historyTimeType = call.argument("historyTimeType");
        historyTimeType = historyTimeType == null ?
                0 : historyTimeType;
        bleConnection.queryHistorySleep(CRPHistoryDay.getInstance(historyTimeType.byteValue()));
    }

    private void startOTA(MethodCall call) {
        String jsonStr = call.argument("otaBean");
        OTABean otaBean = GsonUtils.get().fromJson(jsonStr,
                OTABean.class);
        OTAController otaController = new OTAController(otaBean.getType(), connEveChlRegister, call, bleConnection);
        otaController.startOTA();
    }

    private void abortOTA(MethodCall call) {
        Integer type = call.argument("type");
        type = type == null ? OTAController.START_GOODIX_OTA : type;
        OTAController otaController = new OTAController(type, connEveChlRegister, call, bleConnection);
        otaController.abortOTA();
    }

    private void queryDeviceOtaStatus(MethodChannel.Result result) {
        bleConnection.queryDeviceDfuStatus(result::success);
    }

    private void queryHsOtaAddress(MethodChannel.Result result) {
        bleConnection.queryHsDfuAddress(result::success);
    }

    private void enableHsOta() {
        bleConnection.enableHsDfu();
    }

    private void queryOtaType(MethodChannel.Result result) {
        bleConnection.queryDfuType(result::success);
    }

    private void queryUnitSystem(MethodChannel.Result result) {
        bleConnection.queryMetricSystem(result::success);
    }

    private void sendUnitSystem(MethodCall call) {
        Integer metricSystemType = call.argument("metricSystemType");
        metricSystemType = metricSystemType == null ?
                CRPMetricSystemType.METRIC_SYSTEM : metricSystemType;

        bleConnection.sendMetricSystem(metricSystemType.byteValue());
    }

    private void sendQuickView(MethodCall call) {
        Boolean quickViewState = call.argument("quickViewState");
        quickViewState = quickViewState != null && quickViewState;

        bleConnection.sendQuickView(quickViewState);
    }

    private void queryQuickView(MethodChannel.Result result) {
        bleConnection.queryQuickView(result::success);
    }

    private void sendQuickViewTime(MethodCall call) {
        String jsonStr = call.argument("periodTimeInfo");
        CRPPeriodTimeInfo periodTimeInfo = GsonUtils.get().fromJson(jsonStr,
                CRPPeriodTimeInfo.class);

        bleConnection.sendQuickViewTime(periodTimeInfo);
    }

    private void queryQuickViewTime(MethodChannel.Result result) {
        bleConnection.queryQuickViewTime((int periodTimeType, CRPPeriodTimeInfo periodTimeInfo) -> {
            PeriodTimeBean quickViewTime = new PeriodTimeBean(periodTimeType, periodTimeInfo);
            String jsonStr = GsonUtils.get().toJson(quickViewTime, PeriodTimeBean.class);
            result.success(jsonStr);
        });
    }

    private void sendGoalSteps(MethodCall call) {
        Integer goalSteps = call.argument("goalSteps");
        goalSteps = goalSteps == null ? 8000 : goalSteps;

        bleConnection.sendGoalSteps(goalSteps);
    }

    private void queryGoalSteps(MethodChannel.Result result) {
        bleConnection.queryGoalStep(result::success);
    }

    private void sendDailyGoals(MethodCall call) {
        String jsonStr = call.argument("dailyGoals");
        CRPDailyGoalsInfo dailyGoalsInfo = GsonUtils.get().fromJson(jsonStr,
                CRPDailyGoalsInfo.class);
        bleConnection.sendDailyGoals(dailyGoalsInfo);
    }

    private void queryDailyGoals(MethodChannel.Result result) {
        bleConnection.queryDailyGoals(dailyGoalsInfo -> {
            String jsonStr = GsonUtils.get().toJson(dailyGoalsInfo, CRPDailyGoalsInfo.class);
            result.success(jsonStr);
        });
    }

    private void sendTrainingDayGoals(MethodCall call) {
        String jsonStr = call.argument("dailyGoals");
        CRPDailyGoalsInfo dailyGoalsInfo = GsonUtils.get().fromJson(jsonStr,
                CRPDailyGoalsInfo.class);
        bleConnection.sendTrainingDayGoals(dailyGoalsInfo);
    }

    private void queryTrainingDayGoals(MethodChannel.Result result) {
        bleConnection.queryTrainingDayGoals(new CRPTrainingDayGoalsCallback() {
            @Override
            public void onTrainingDayGoals(CRPDailyGoalsInfo dailyGoalsInfo) {
                String jsonStr = GsonUtils.get().toJson(dailyGoalsInfo, CRPDailyGoalsInfo.class);
                result.success(jsonStr);
            }

            @Override
            public void onTrainingDays(CRPTrainingDayInfo trainingDayInfo) {
            }
        });
    }

    private void sendTrainingDays(MethodCall call) {
        String jsonStr = call.argument("trainingDay");
        TrainingDaysBean trainingDays = GsonUtils.get().fromJson(jsonStr,
                TrainingDaysBean.class);
        CRPTrainingDayInfo trainingDayInfo = new CRPTrainingDayInfo(trainingDays.getEnable(), trainingDays.getTrainingDays());
        bleConnection.sendTrainingDays(trainingDayInfo);
    }

    private void queryTrainingDay(MethodChannel.Result result) {
        bleConnection.queryTrainingDay(new CRPTrainingDayGoalsCallback() {
            @Override
            public void onTrainingDayGoals(CRPDailyGoalsInfo dailyGoalsInfo) {
            }

            @Override
            public void onTrainingDays(CRPTrainingDayInfo trainingDayInfo) {
                byte trainingDays = trainingDayInfo.getTrainingDays();
                StringBuilder trainingDaysStr = new StringBuilder(Integer.toBinaryString(trainingDays));
                trainingDaysStr.reverse();
                List<Integer> list = new ArrayList<>();
                for (int i = trainingDaysStr.length() - 1; i >= 0; i--) {
                    if (trainingDaysStr.charAt(i) == '1') {
                        list.add(i);
                    }
                }
                int[] trainingDayList = new int[list.size()];
                for (int i = 0; i < list.size(); i++) {
                    trainingDayList[i] = list.get(i);
                }
                TrainingDaysBean trainingDay = new TrainingDaysBean(trainingDayInfo.isEnable(), trainingDayList);
                String jsonStr = GsonUtils.get().toJson(trainingDay, TrainingDaysBean.class);
                result.success(jsonStr);

            }
        });
    }

    private void sendDisplayWatchFace(MethodCall call) {
        Integer watchFaceType = call.argument("watchFaceType");
        watchFaceType = watchFaceType == null ? CRPWatchFaceType.FIRST_WATCH_FACE : watchFaceType;

        bleConnection.sendDisplayWatchFace(watchFaceType.byteValue());
    }

    private void queryDisplayWatchFace(MethodChannel.Result result) {
        bleConnection.queryDisplayWatchFace(result::success);
    }

    private void queryWatchFaceLayout(MethodChannel.Result result) {
        bleConnection.queryWatchFaceLayout(crpWatchFaceLayoutInfo -> {
            // 获取到的是手表的rgb565的int，需要转成一般颜色rgb888的int
            int textColor = crpWatchFaceLayoutInfo.getTextColor();
            StringBuilder stringBuilder = new StringBuilder(Integer.toBinaryString(textColor));
            while (stringBuilder.length() < 16) {
                stringBuilder.insert(0, "0");
            }
            String rgb565Binary = stringBuilder.toString();
            String red = rgb565Binary.substring(0, 5);
            String green = rgb565Binary.substring(5, 11);
            String blue = rgb565Binary.substring(11);
            int reg888 = Integer.valueOf(red + "000" + green + "00" + blue + "000", 2);
            crpWatchFaceLayoutInfo.setTextColor(reg888);
            String jsonStr = GsonUtils.get().toJson(crpWatchFaceLayoutInfo, CRPWatchFaceLayoutInfo.class);
            result.success(jsonStr);
        });
    }

    private void sendWatchFaceLayout(MethodCall call) {
        String jsonStr = call.argument("watchFaceLayoutInfo");
        CRPWatchFaceLayoutInfo watchFaceLayoutInfo = GsonUtils.get().fromJson(jsonStr, CRPWatchFaceLayoutInfo.class);

        bleConnection.sendWatchFaceLayout(watchFaceLayoutInfo);
    }

    private void abortWatchFaceBackground() {
        bleConnection.abortWatchFaceBackground();
    }

    private void sendWatchFaceBackground(MethodCall call) {
        MyLog.d("MOYOUNG-method", "sendWatchFaceBackground Listener");
        BaseConnectionEventChannelHandler lazyEveChlHandler
                = connEveChlRegister.getLazyEveChlHandler(EVENT_FILE_TRANS);
        if (lazyEveChlHandler != null) {
            lazyEveChlHandler.setConnListener(bleConnection, call);
        }
    }

    private void queryJieliWatchFaceInfo(MethodChannel.Result result) {
        bleConnection.queryJieliWatchFaceInfo(jieliWatchFaceInfo -> {
            String jsonStr = GsonUtils.get().toJson(jieliWatchFaceInfo, CRPJieliWatchFaceInfo.class);
            result.success(jsonStr);
        });
    }

    private void querySupportWatchFace(MethodChannel.Result result) {
        bleConnection.querySupportWatchFace(new CRPDeviceSupportWatchFaceCallback() {
            @Override
            public void onSupportWatchFace(CRPSupportWatchFaceInfo supportWatchFaceInfo) {
                WatchFaceBean watchFaceBean = new WatchFaceBean(WatchFaceBean.DEFAULT);
                watchFaceBean.setSupportWatchFaceInfo(supportWatchFaceInfo);
                String jsonStr = GsonUtils.get().toJson(watchFaceBean, WatchFaceBean.class);
                result.success(jsonStr);
            }

            @Override
            public void onSifliSupportWatchFace(CRPSifliSupportWatchFaceInfo sifliSupportWatchFaceInfo) {
                WatchFaceBean watchFaceBean = new WatchFaceBean(WatchFaceBean.SIFLI);
                List<Integer> typeList = new ArrayList<>();
                typeList.add(sifliSupportWatchFaceInfo.getType());
                SifliSupportWatchFaceBean sifliSupportWatchFaceBean = new SifliSupportWatchFaceBean(typeList);
                List<SifliSupportWatchFaceBean.SifliWatchFace> sifliWatchFaceList = new ArrayList<>();
                List<CRPSifliSupportWatchFaceInfo.WatchFace> watchFaceList = sifliSupportWatchFaceInfo.getList();
                for (int i = 0; i < watchFaceList.size(); i++) {
                    CRPSifliSupportWatchFaceInfo.WatchFace watchFace = watchFaceList.get(i);
                    sifliWatchFaceList.add(new SifliSupportWatchFaceBean.SifliWatchFace(watchFace.getState().toString(), watchFace.getId()));
                }
                sifliSupportWatchFaceBean.setList(sifliWatchFaceList);
                watchFaceBean.setSifliSupportWatchFaceInfo(sifliSupportWatchFaceBean);
                String jsonStr = GsonUtils.get().toJson(watchFaceBean, WatchFaceBean.class);
                result.success(jsonStr);
            }

            @Override
            public void onJieliSupportWatchFace(CRPJieliSupportWatchFaceInfo jieliSupportWatchFaceInfo) {
                WatchFaceBean watchFaceBean = new WatchFaceBean(WatchFaceBean.JIELI);
                watchFaceBean.setJieliSupportWatchFaceInfo(jieliSupportWatchFaceInfo);
                String jsonStr = GsonUtils.get().toJson(watchFaceBean, WatchFaceBean.class);
                result.success(jsonStr);
            }
        });
    }

    private void queryWatchFaceStoreTagList(MethodCall call, MethodChannel.Result result) {
        String jsonStr = call.argument("watchFaceStoreTagList");
        CRPWatchFaceStoreRequestInfo watchFaceStoreRequestInfo = GsonUtils.get().fromJson(jsonStr, CRPWatchFaceStoreRequestInfo.class);
        bleConnection.queryWatchFaceStoreTagList(watchFaceStoreRequestInfo, new CRPWatchFaceStoreTagCallback() {
            @Override
            public void onWatchFaceStoreTagChange(List<CRPWatchFaceStoreTagInfo> list) {
                WatchFaceStoreTagListResultBean watchFaceStoreTagListResult = new WatchFaceStoreTagListResultBean(list, "");
                String jsonStr = GsonUtils.get().toJson(watchFaceStoreTagListResult, WatchFaceStoreTagListResultBean.class);
                result.success(jsonStr);
            }

            @Override
            public void onError(String error) {
                WatchFaceStoreTagListResultBean watchFaceStoreTagListResult = new WatchFaceStoreTagListResultBean(new ArrayList<>(), error);
                String jsonStr = GsonUtils.get().toJson(watchFaceStoreTagListResult, WatchFaceStoreTagListResultBean.class);
                result.success(jsonStr);
            }
        });
    }

    private void queryWatchFaceStoreList(MethodCall call, MethodChannel.Result result) {
        String jsonStr = call.argument("watchFaceStoreList");
        WatchFaceStoreListBean watchFaceStoreList = GsonUtils.get().fromJson(jsonStr, WatchFaceStoreListBean.class);
        bleConnection.queryWatchFaceStoreList(
                watchFaceStoreList.getWatchFaceStoreTagList(),
                watchFaceStoreList.getTagId(),
                new CRPWatchFaceStoreCallback() {
                    @Override
                    public void onWatchFaceStoreChange(CRPWatchFaceStoreInfo watchFaceStoreInfo) {
                        WatchFaceStoreResultBean watchFaceStoreResult = new WatchFaceStoreResultBean(watchFaceStoreInfo, "noError");
                        String jsonStr = GsonUtils.get().toJson(watchFaceStoreResult, WatchFaceStoreResultBean.class);
                        result.success(jsonStr);
                    }

                    @Override
                    public void onError(String error) {
                        CRPWatchFaceStoreInfo watchFaceStoreInfo = new CRPWatchFaceStoreInfo(-1, new LinkedList<>());
                        WatchFaceStoreResultBean watchFaceStoreResult = new WatchFaceStoreResultBean(watchFaceStoreInfo, error);
                        String jsonStr = GsonUtils.get().toJson(watchFaceStoreResult, WatchFaceStoreResultBean.class);
                        result.success(jsonStr);
                    }
                });
    }

    private void queryWatchFaceDetail(MethodCall call, MethodChannel.Result result) {
        String jsonStr = call.argument("watchFaceStoreTagList");
        WatchFaceDetailBean watchFaceDetail = GsonUtils.get().fromJson(jsonStr, WatchFaceDetailBean.class);
        CRPWatchFaceDetailsRequestInfo watchFaceStoreRequestInfo = new CRPWatchFaceDetailsRequestInfo(watchFaceDetail.getStoreType(), watchFaceDetail.getId());
        watchFaceStoreRequestInfo.setFirmwareVersion(watchFaceDetail.getFirmwareVersion());
        watchFaceStoreRequestInfo.setApiVersion(watchFaceDetail.getApiVersion());
        watchFaceStoreRequestInfo.setFeature(watchFaceDetail.getFeature());
        watchFaceStoreRequestInfo.setMaxSize(watchFaceDetail.getMaxSize());
        bleConnection.queryWatchFaceDetail(watchFaceStoreRequestInfo, new CRPWatchFaceDetailsCallback() {
            @Override
            public void onWatchFaceChange(CRPWatchFaceStoreInfo.WatchFaceBean watchFaceBean) {
                WatchFaceDetailResultBean watchFaceDetailResult = new WatchFaceDetailResultBean();
                watchFaceDetailResult.setWatchFaceBean(watchFaceBean);
                String jsonStr = GsonUtils.get().toJson(watchFaceDetailResult, WatchFaceDetailResultBean.class);
                result.success(jsonStr);
            }

            @Override
            public void onNewWatchFaceChange(CRPWatchFaceDetailsInfo watchFaceDetailsInfo) {
                WatchFaceDetailResultBean watchFaceDetailResult = new WatchFaceDetailResultBean();
                watchFaceDetailResult.setWatchFaceDetailsInfo(watchFaceDetailsInfo);
                String jsonStr = GsonUtils.get().toJson(watchFaceDetailResult, WatchFaceDetailResultBean.class);
                result.success(jsonStr);
            }

            @Override
            public void onError(String error) {
                WatchFaceDetailResultBean watchFaceDetailResult = new WatchFaceDetailResultBean();
                watchFaceDetailResult.setError(error);
                String jsonStr = GsonUtils.get().toJson(watchFaceDetailResult, WatchFaceDetailResultBean.class);
                result.success(jsonStr);
            }
        });
    }

    private void queryWatchFaceStore(MethodCall call, MethodChannel.Result result) {
        String jsonStr = call.argument("watchFaceStoreBean");
        WatchFaceStoreBean watchFaceLayoutInfo = GsonUtils.get().fromJson(jsonStr, WatchFaceStoreBean.class);

        bleConnection.queryWatchFaceStore(watchFaceLayoutInfo.getWatchFaceSupportList(), watchFaceLayoutInfo.getFirmwareVersion(),
                watchFaceLayoutInfo.getPageCount(), watchFaceLayoutInfo.getPageIndex(), new CRPWatchFaceStoreCallback() {
                    @Override
                    public void onWatchFaceStoreChange(CRPWatchFaceStoreInfo watchFaceStoreInfo) {
                        WatchFaceStoreResultBean watchFaceStoreResult = new WatchFaceStoreResultBean(watchFaceStoreInfo, "noError");
                        String jsonStr = GsonUtils.get().toJson(watchFaceStoreResult, WatchFaceStoreResultBean.class);
                        result.success(jsonStr);
                    }

                    @Override
                    public void onError(String error) {
                        CRPWatchFaceStoreInfo watchFaceStoreInfo = new CRPWatchFaceStoreInfo(-1, new LinkedList<>());
                        WatchFaceStoreResultBean watchFaceStoreResult = new WatchFaceStoreResultBean(watchFaceStoreInfo, error);
                        String jsonStr = GsonUtils.get().toJson(watchFaceStoreResult, WatchFaceStoreResultBean.class);
                        result.success(jsonStr);
                    }
                });
    }

    private void queryWatchFaceOfID(MethodCall call, MethodChannel.Result result) {
        Integer id = call.argument("id");
        id = id == null ? -1 : id;
        bleConnection.queryWatchFaceOfID(id, new CRPWatchFaceDetailsCallback() {
            @Override
            public void onWatchFaceChange(CRPWatchFaceStoreInfo.WatchFaceBean watchFaceBean) {
                int result_OK = 0;
                WatchFaceIDBean watchFaceID = new WatchFaceIDBean(result_OK);
                watchFaceID.setWatchFace(watchFaceBean);
                watchFaceID.setError("");
                String jsonStr = GsonUtils.get().toJson(watchFaceID, WatchFaceIDBean.class);
                result.success(jsonStr);
            }

            @Override
            public void onNewWatchFaceChange(CRPWatchFaceDetailsInfo watchFaceDetailsInfo) {

            }

            @Override
            public void onError(String error) {
                int errorCode = 101;
                WatchFaceIDBean watchFaceID = new WatchFaceIDBean(errorCode);
                watchFaceID.setError(error);
                watchFaceID.setWatchFace(new CRPWatchFaceStoreInfo.WatchFaceBean(-1, null, null));
                String jsonStr = GsonUtils.get().toJson(watchFaceID, WatchFaceIDBean.class);
                result.success(jsonStr);
            }
        });
    }

    private void sendWatchFace(MethodCall call) {
        MyLog.d("MOYOUNG-method", "sendWatchFace Listener");
        BaseConnectionEventChannelHandler lazyEveChlHandler
                = connEveChlRegister.getLazyEveChlHandler(EVENT_WF_FILE_TRANS);
        if (lazyEveChlHandler != null) {
            lazyEveChlHandler.setConnListener(bleConnection, call);
        }
    }

    private void sendWatchFaceId(MethodCall call) {
        Integer id = call.argument("id");
        id = id == null ? -1 : id;
        bleConnection.sendWatchFaceId(id);
    }

    private void abortWatchFace() {
        bleConnection.abortWatchFace();
    }

    private void deleteWatchFace(MethodCall call, MethodChannel.Result result) {
        Integer id = call.argument("id");
        id = id == null ? -1 : id;
        bleConnection.deleteWatchFace(id, new CRPWatchFaceDeleteCallback() {
            @Override
            public void onComplete() {
                result.success("Deleted successfully");
            }

            @Override
            public void onError() {
                result.success("Deletion failure");
            }
        });
    }

    private void queryAvailableStorage(MethodCall call, MethodChannel.Result result) {
        bleConnection.queryAvailableStorage(result::success);
    }

    private void sendNewAlarm(MethodCall call) {
        String jsonStr = call.argument("alarmClockInfo");
        CRPAlarmInfo alarmInfo = GsonUtils.get().fromJson(jsonStr, CRPAlarmInfo.class);
        bleConnection.sendAlarm(alarmInfo);
        bleConnection.sendNewAlarm(alarmInfo);
    }

    private void deleteNewAlarm(MethodCall call) {
        Integer id = call.argument("id");
        id = id == null ? -1 : id;
        bleConnection.deleteNewAlarm(id);
    }

    private void deleteAllNewAlarm() {
        bleConnection.deleteAllNewAlarm();
    }

    private void queryAllNewAlarm(MethodChannel.Result result) {
        AlarmCallback alarmCallback = new AlarmCallback(result);
        bleConnection.queryAllAlarm(alarmCallback);
        bleConnection.queryAllNewAlarm(alarmCallback);
    }

    private void queryLastDynamicRate(MethodCall call) {
        String type = call.argument("type");
        type = type == null ? CRPHistoryDynamicRateType.FIRST_HEART_RATE.toString() : type;
        bleConnection.queryLastDynamicRate(CRPHistoryDynamicRateType.valueOf(type));
    }

    private void enableTimingMeasureHeartRate(MethodCall call) {
        Integer interval = call.argument("interval");
        interval = interval == null ? 5 : interval;
        bleConnection.enableTimingMeasureHeartRate(interval);
    }

    private void disableTimingMeasureHeartRate() {
        bleConnection.disableTimingMeasureHeartRate();
    }

    private void queryTimingMeasureHeartRate(MethodChannel.Result result) {
        bleConnection.queryTimingMeasureHeartRate(result::success);
    }

    private void queryTodayHeartRate(MethodCall call) {
        Integer heartRateType = call.argument("heartRateType");
        heartRateType = heartRateType == null ? CRPHeartRateType.ALL_DAY_HEART_RATE : heartRateType;
        bleConnection.queryTodayHeartRate(heartRateType);
    }

    private void queryPastHeartRate(MethodCall call) {
        Integer historyDay = call.argument("historyDay");
        historyDay = historyDay == null ?
                1 : historyDay;
        bleConnection.queryHistoryTimingHeartRate(CRPHistoryDay.getInstance(historyDay.byteValue()));
    }

    private void queryTrainingHeartRate() {
        bleConnection.queryMovementHeartRate();
    }

    private void startMeasureOnceHeartRate() {
        bleConnection.startMeasureOnceHeartRate();
    }

    private void stopMeasureOnceHeartRate() {
        bleConnection.stopMeasureOnceHeartRate();
    }

    private void queryHistoryHeartRate() {
        bleConnection.queryHistoryHeartRate();
    }

    //血压
    private void startMeasureBloodPressure() {
        bleConnection.startMeasureBloodPressure();
    }

    private void stopMeasureBloodPressure() {
        bleConnection.stopMeasureBloodPressure();
    }

    private void enableContinueBloodPressure() {
        bleConnection.enableContinueBloodPressure();
    }

    private void disableContinueBloodPressure() {
        bleConnection.disableContinueBloodPressure();
    }

    private void queryContinueBloodPressureState() {
        bleConnection.queryContinueBloodPressureState();
    }

    private void queryLast24HourBloodPressure() {
        bleConnection.queryLast24HourBloodPressure();
    }

    private void queryHistoryBloodPressure() {
        bleConnection.queryHistoryBloodPressure();
    }

    private void startMeasureBloodOxygen() {
        bleConnection.startMeasureBloodOxygen();
    }

    private void stopMeasureBloodOxygen() {
        bleConnection.stopMeasureBloodOxygen();
    }

    private void enableTimingMeasureBloodOxygen(MethodCall call) {
        Integer interval = call.argument("interval");
        interval = interval == null ? 5 : interval;
        bleConnection.enableTimingMeasureBloodOxygen(interval);
    }

    private void disableTimingMeasureBloodOxygen() {
        bleConnection.disableTimingMeasureBloodOxygen();
    }

    private void queryTimingBloodOxygenMeasureState() {
        bleConnection.queryTimingBloodOxygenMeasureState();
    }

    private void queryTimingBloodOxygen(MethodCall call) {
        String bloodOxygenTimeType = call.argument("bloodOxygenTimeType");
        bloodOxygenTimeType = bloodOxygenTimeType == null ? CRPBloodOxygenTimeType.TODAY.toString() : bloodOxygenTimeType;
        bleConnection.queryTimingBloodOxygen(CRPBloodOxygenTimeType.valueOf(bloodOxygenTimeType));
    }

    private void enableContinueBloodOxygen() {
        bleConnection.enableContinueBloodOxygen();
    }

    private void disableContinueBloodOxygen() {
        bleConnection.disableContinueBloodOxygen();
    }

    private void queryContinueBloodOxygenState() {
        bleConnection.queryContinueBloodOxygenState();
    }


    private void queryLast24HourBloodOxygen() {
        bleConnection.queryLast24HourBloodOxygen();
    }

    private void queryHistoryBloodOxygen() {
        bleConnection.queryHistoryBloodOxygen();
    }

    private void enterCameraView() {
        bleConnection.enterCameraView();
    }

    private void exitCameraView() {
        bleConnection.exitCameraView();
    }

    private void readDeviceRssi() {
        bleConnection.readDeviceRssi();
    }

    private void setECGChangeListener(MethodCall call) {
        BaseConnectionEventChannelHandler lazyEveChlHandler
                = connEveChlRegister.getLazyEveChlHandler(EVENT_ECG);
        if (lazyEveChlHandler != null) {
            lazyEveChlHandler.setConnListener(bleConnection, call);
        }
    }

    private void startECGMeasure() {
        bleConnection.startECGMeasure();
    }

    private void stopECGMeasure() {
        bleConnection.stopECGMeasure();
    }

    private void isNewECGMeasurementVersion(MethodChannel.Result result) {
        boolean newMeasurementVersion = bleConnection.isNewECGMeasurementVersion();
        result.success(newMeasurementVersion);

    }

    private void queryLastMeasureECGData() {
        bleConnection.queryLastMeasureECGData();
    }

    private void sendECGHeartRate(MethodCall call) {
        Integer heartRate = call.argument("heartRate");
        heartRate = heartRate == null ? 0 : heartRate;
        bleConnection.sendECGHeartRate(heartRate);
    }

    private void sendDeviceLanguage(MethodCall call) {
        Integer language = call.argument("language");
        language = language == null ? CRPDeviceLanguageType.LANGUAGE_CHINESE : language;
        // Simplified Chinese is set to the Chinese version, non-simplified Chinese is set to the international version
        byte version = CRPDeviceVersionType.INTERNATIONAL_EDITION;
        if (language == CRPDeviceLanguageType.LANGUAGE_CHINESE) {
            version = CRPDeviceVersionType.CHINESE_EDITION;
        }
        bleConnection.sendDeviceVersion(version);
        bleConnection.sendDeviceLanguage(language.byteValue());
    }

    private void queryDeviceVersion(MethodChannel.Result result) {
        bleConnection.queryDeviceVersion(result::success);
    }

    private void queryDeviceLanguage(MethodChannel.Result result) {
        bleConnection.queryDeviceLanguage((int type, int[] languageType) -> {

            DeviceLanguageBean deviceLanguage = new DeviceLanguageBean(type, languageType);
            String jsonStr = GsonUtils.get().toJson(deviceLanguage, DeviceLanguageBean.class);
            result.success(jsonStr);
        });
    }

    private void sendOtherMessageState(MethodCall call) {
        Boolean state = call.argument("state");
        bleConnection.sendOtherMessageState(Boolean.TRUE.equals(state));
    }

    private void queryOtherMessageState(MethodChannel.Result result) {
        bleConnection.queryOtherMessageState(result::success);
    }

    private void sendMessage(MethodCall call) {
        String jsonStr = call.argument("messageInfo");
        NotificationBean notification = GsonUtils.get().fromJson(jsonStr, NotificationBean.class);
        CRPMessageInfo messageInfo = new CRPMessageInfo();
        messageInfo.setMessage(notification.getMessage());
        messageInfo.setType(notification.getType());
        messageInfo.setVersionCode(notification.getVersionCode());
        messageInfo.setHs(notification.isHs());
        messageInfo.setSmallScreen(notification.isSmallScreen());
        bleConnection.sendMessage(messageInfo);
    }

    private void endCall() {
        bleConnection.sendCall0ffHook();
    }

    private void sendCallContactName(MethodCall call) {
        String jsonStr = call.argument("name");
        bleConnection.sendCallContactName(jsonStr);
    }

    private void queryMessageList(MethodChannel.Result result) {
        bleConnection.queryMessageList(list -> {
            StringBuilder listStr = new StringBuilder();
            for (int i = 0; i < list.size(); i++) {
                listStr.append(list.get(i)).append(",");
            }
            listStr.delete(listStr.length() - 1, listStr.length());
            result.success(listStr);
        });
    }

    private void sendSedentaryReminder(MethodCall call) {
        Boolean sedentaryReminder = call.argument("sedentaryReminder");
        sedentaryReminder = sedentaryReminder != null && sedentaryReminder;
        bleConnection.sendSedentaryReminder(sedentaryReminder);
    }

    private void querySedentaryReminder(MethodChannel.Result result) {
        bleConnection.querySedentaryReminder(result::success);
    }

    private void sendSedentaryReminderPeriod(MethodCall call) {
        String jsonStr = call.argument("sedentaryReminderPeriodInfo");
        CRPSedentaryReminderPeriodInfo sedentaryReminderPeriodInfo =
                GsonUtils.get().fromJson(jsonStr, CRPSedentaryReminderPeriodInfo.class);
        bleConnection.sendSedentaryReminderPeriod(sedentaryReminderPeriodInfo);
    }

    private void querySedentaryReminderPeriod(MethodChannel.Result result) {
        bleConnection.querySedentaryReminderPeriod(sedentaryReminderPeriodInfo -> {
            String jsonStr = GsonUtils.get().toJson(sedentaryReminderPeriodInfo, CRPSedentaryReminderPeriodInfo.class);
            result.success(jsonStr);
        });
    }

    private void findDevice() {
        bleConnection.findDevice();
    }

    private void shutDown() {
        bleConnection.shutDown();
    }

    private void reset() {
        bleConnection.reset();
    }

    private void sendDoNotDisturbTime(MethodCall call) {
        String jsonStr = call.argument("periodTimeInfo");
        CRPPeriodTimeInfo periodTimeInfo =
                GsonUtils.get().fromJson(jsonStr, CRPPeriodTimeInfo.class);
        bleConnection.sendDoNotDistrubTime(periodTimeInfo);
    }

    private void queryDoNotDisturbTime(MethodChannel.Result result) {
        bleConnection.queryDoNotDistrubTime((periodTimeType, periodTimeInfo) -> {
            PeriodTimeBean doNotDisturbTime = new PeriodTimeBean(periodTimeType, periodTimeInfo);
            String jsonStr = GsonUtils.get().toJson(doNotDisturbTime, PeriodTimeBean.class);
            result.success(jsonStr);
        });
    }

    private void sendBreathingLight(MethodCall call) {
        Boolean breathingLight = call.argument("breathingLight");
        breathingLight = breathingLight != null && breathingLight;
        bleConnection.sendBreathingLight(breathingLight);
    }

    private void queryBreathingLight(MethodChannel.Result result) {
        bleConnection.queryBreathingLight(result::success);
    }

    public void sendIncomingNumber(String number) {
        if (enableTelephoneOperation()) {
            return;
        }
        CRPMessageInfo messageInfo = new CRPMessageInfo();
        messageInfo.setType(CRPBleMessageType.MESSAGE_PHONE);
        messageInfo.setMessage(number);
        messageInfo.setHs(false);
        messageInfo.setSmallScreen(false);
        messageInfo.setVersionCode(200);
        bleConnection.sendMessage(messageInfo);
    }

    public void sendCall0ffHook() {
        if (enableTelephoneOperation()) {
            return;
        }
        bleConnection.sendCall0ffHook();
    }

    private boolean enableTelephoneOperation() {
        if (bleDevice == null) getBleDevice();
        return bleConnection == null || bleDevice == null || !bleDevice.isConnected() || !enableIncomingNumber;
    }

    private void enableIncomingNumber(MethodCall call, MethodChannel.Result result) {
        enableIncomingNumber = Boolean.TRUE.equals(call.argument("enableIncoming"));
        result.success(enableIncomingNumber);
    }

    public static void supportDelayTime(boolean supportDelayTime) {
        ConnectionMethodHandler.supportDelayTime = supportDelayTime;
    }

    private void getBleDevice() {
        bleDevice = CRPBleClient.create(context.getApplicationContext()).getBleDevice(address);
    }

}
