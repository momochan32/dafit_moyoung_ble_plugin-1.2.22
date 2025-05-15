import 'dart:async';

import 'package:moyoung_ble_plugin/impl/moyoung_beans.dart';
import 'package:moyoung_ble_plugin/impl/moyoung_ble_impl.dart';

// Export [moyoung_beans], [moyoung_contants] from the moyoung_ble
// so plugin users can use them directly.
export 'package:moyoung_ble_plugin/impl/moyoung_beans.dart';
export 'package:moyoung_ble_plugin/impl/moyoung_contants.dart';

class MoYoungBle {
  /// Constructs a singleton instance of [MoYoungBle].
  ///
  /// [MoYoungBle] is designed to work as a singleton.
  factory MoYoungBle() {
    // print("MoYoungBle");
    _singleton ??= MoYoungBle._();
    return _singleton!;
  }

  MoYoungBle._();

  static MoYoungBle? _singleton;

  static MoyoungBleImpl get _platform {
    return MoyoungBleImpl.instance;
  }

  Future<bool> get checkBluetoothEnable {
    return _platform.checkBluetoothEnable;
  }

  /// Clicking the scan button will trigger the scan event listener stream
  /// bleScanEveStm, and the scan result will be returned through the
  /// bleScanEveStm listener stream and stored in the event as a BleScanEvent
  /// object.
  Stream<BleScanBean> get bleScanEveStm {
    return _platform.bleScanEveStm;
  }

  /// When scanning Bluetooth devices, it will first obtain the open status of
  /// Bluetooth, and only when the  permission is allowed and the Bluetooth is
  /// turned on can start normal scanning.
  Future<bool> startScan(int scanPeriod) {
    return _platform.startScan(scanPeriod);
  }

  /// Turn off the bluetooth scan, and the result listens to the callback
  /// through the bleScanEveStm data stream.
  Future<void> get cancelScan {
    return _platform.cancelScan;
  }

  /// Gets the watch's Mac address by scanning the received CRPScanDevice. Click
  /// the Bluetooth connection to connect the device, and the Bluetooth
  /// connection monitoring will be triggered at the same time. Monitor
  /// connection and callback status via the connStateEveStm data stream. The
  /// result is saved in "event". It is recommended to add an appropriate delay
  /// when disconnecting and reconnecting, so that the system can recover
  /// resources and ensure the connection success rate.
  Stream<ConnectStateBean> get connStateEveStm {
    return _platform.connStateEveStm;
  }

  /// Gets the current status of the watch's successful connection according to
  /// the watch's mac address.
  Future<bool> isConnected(String address) {
    return _platform.isConnected(address);
  }

  /// Gets the watch's Mac address by scanning the received CRPScanDevice.
  /// Click the Bluetooth connection to connect the device, and the Bluetooth
  /// connection monitoring will be triggered at the same time. Monitor
  /// connection and callback status via the connStateEveStm data stream.
  /// The result is saved in "event". It is recommended to add an appropriate
  /// delay when disconnecting and reconnecting, so that the system can recover
  /// resources and ensure the connection success rate.
  Future<void> connect(ConnectBean connectBean) {
    return _platform.connect(connectBean);
  }

  /// Disconnected watch,disconnect returns true.
  Future<bool> get disconnect {
    return _platform.disconnect();
  }

  Future<bool> get closeGatt {
    return _platform.closeGatt();
  }

  Future<void> get reconnect {
    return _platform.reconnect();
  }

  Future<void> connectDevice(ConnectDeviceBean connectDeviceBean) {
    return _platform.connectDevice(connectDeviceBean);
  }

  /// Synchronize the time of your phone and watch.
  Future<void> get queryTime {
    return _platform.queryTime;
  }

  /// Sets the system time of the watch.
  Future<void> sendTimeSystem(int timeSystemType) {
    return _platform.sendTimeSystem(timeSystemType);
  }

  /// Gets the time system of the watch.
  Future<int> get queryTimeSystem {
    return _platform.queryTimeSystem;
  }

  /// Gets the current firmware version of the watch.
  Future<String> get queryFirmwareVersion {
    return _platform.queryFirmwareVersion;
  }

  /// Gets the latest version information.
  Future<CheckFirmwareVersionBean> checkFirmwareVersion(FirmwareVersion info) {
    return _platform.checkFirmwareVersion(info);
  }

  /// Monitoring of firmware version updates。
  Stream<OTABean> get oTAEveStm {
    return _platform.oTAEveStm;
  }

  /// The way to upgrade
  Future<void> startOTA(OtaBean otaBean) {
    return _platform.startOTA(otaBean);
  }

  ///Abort method
  Future<void> abortOTA(int oTAType) {
    return _platform.abortOTA(oTAType);
  }

  /// Watch OTA status.
  Future<int> get queryDeviceOtaStatus {
    return _platform.queryDeviceOtaStatus;
  }

  Future<String> get queryHsOtaAddress {
    return _platform.queryHsOtaAddress;
  }

  Future<void> get enableHsOta {
    return _platform.enableHsOta;
  }

  Future<int> get queryOtaType {
    return _platform.queryOtaType;
  }

  Future<String> get queryUUID {
    return _platform.queryUUID;
  }

  /// Sets the watch battery monitoring stream connDeviceBatteryEveStm to return
  /// data about the watch battery.
  Stream<DeviceBatteryBean> get deviceBatteryEveStm {
    return _platform.deviceBatteryEveStm;
  }

  /// Gets the current battery of the watch. When the battery level of the watch
  /// exceeds 100, it means the watch is charging.
  Future<void> get queryDeviceBattery {
    return _platform.queryDeviceBattery;
  }

  /// When the battery of the watch changes, the result is returned through the
  /// data stream deviceBatteryEveStmand saved in the subscribe field in "event".
  Future<void> get subscribeDeviceBattery {
    return _platform.subscribeDeviceBattery;
  }

  /// Sets the user's personal information to the watch.
  Future<void> sendUserInfo(UserBean userInfo) {
    return _platform.sendUserInfo(userInfo);
  }

  /// In the watch firmware 1.6.6 and above, you can set the step length to the
  /// watch to calculate the activity data more accurately.
  Future<void> sendStepLength(int stepLength) {
    return _platform.sendStepLength(stepLength);
  }

  /// Sets up a weather listener weatherChangeEveStm, and the update result of
  /// the weather state is returned through the data stream and saved in the "event".
  Stream<WeatherChangeBean> get weatherChangeEveStm {
    return _platform.weatherChangeEveStm;
  }

  /// Set the watch's weather for today.
  Future<void> sendTodayWeather(TodayWeatherBean todayWeatherInfo) {
    return _platform.sendTodayWeather(todayWeatherInfo);
  }

  /// Sets the weather for the next 7 days to the watch.
  Future<void> sendFutureWeather(FutureWeatherListBean futureWeathersBean) {
    return _platform.sendFutureWeather(futureWeathersBean);
  }

  /// Sets a step change listener stepChangeEveStm, the result is returned
  /// through the data stream, and saved in "event" as the StepChangeBean object.
  Stream<StepsChangeBean> get stepsChangeEveStm {
    return _platform.stepsChangeEveStm;
  }

  /// Gets today's step count data. The query result will be obtained through
  /// the stepsChangeEveStm listening stream and saved in the
  /// StepChangeBean.stepInfo field.
  Future<void> get querySteps {
    return _platform.querySteps;
  }

  /// 1.The watch can save the number of activity steps in the past three days,
  /// and can query the number of activity steps in a certain day.
  /// 2.Query the activity steps data in a certain day. The query result will be
  /// obtained through the trainingEveStm listening stream and saved in the
  /// trainingInfo.past field and trainingInfo.pastStepInfo field.
  Future<void> queryHistorySteps(int historyTimeType) {
    return _platform.queryHistorySteps(historyTimeType);
  }

  /// Some watches support categorical statistics for the past two days.
  /// Query classification statistics for the past two days. The query result
  /// will be obtained through the stepsDetailEveStm listening stream and saved
  /// in "event" as the StepsDetailBean object.
  Future<void> queryStepsDetail(int stepsDetailDateType) {
    return _platform.queryStepsDetail(stepsDetailDateType);
  }

  // Future<The24HourListBean> get get24HourCals {
  //   return _platform.get24HourCals;
  // }
  //
  // Future<The24HourListBean> get getAgo24HourCals {
  //   return _platform.getAgo24HourCals;
  // }
  //
  // Future<The24HourListBean> get get24HourDistances {
  //   return _platform.get24HourDistances;
  // }
  //
  // Future<The24HourListBean> get getAgo24HourDistances {
  //   return _platform.getAgo24HourDistances;
  // }

  /// Set a step category listener stepsDetailEveStm, and the result is returned
  /// through the data stream and saved in the "event" as the StepsDetailBean object.
  Stream<StepsDetailBean> get stepsDetailEveStm {
    return _platform.stepsDetailEveStm;
  }

  /// Set up a sleep monitor sleepChangeEveStm, and save the returned value
  /// in "event" with the value of the SleepBean object.
  Stream<SleepBean> get sleepChangeEveStm {
    return _platform.sleepChangeEveStm;
  }

  /// Query detailed data for a training. The query result will be obtained
  /// through the sleepChangeEveStm listening stream and saved in the
  /// SleepBean.sleepInfo field
  Future<void> get querySleep {
    return _platform.querySleep;
  }

  ///  added rem sleep state
  Future<void> get queryRemSleep {
    return _platform.queryRemSleep;
  }

  Future<void> sendGoalSleepTime(int minutes) {
    return _platform.sendGoalSleepTime(minutes);
  }

  Future<void> get queryGoalSleepTime {
    return _platform.queryGoalSleepTime;
  }

  /// Gets the sleep data of a certain day. The query result will be obtained
  /// through the sleepChangeEveStm listening stream and saved in the
  /// SleepBean.past field and the SleepBean.pastSleepInfo field.
  Future<void> queryHistorySleep(int historyTimeType) {
    return _platform.queryHistorySleep(historyTimeType);
  }

  /// Gets the unit system.
  Future<int> get queryUnitSystem {
    return _platform.queryUnitSystem;
  }

  /// The watch supports setting the time system to metric and imperial
  Future<void> sendUnitSystem(int unitSystemType) {
    return _platform.sendUnitSystem(unitSystemType);
  }

  /// Turns the quick view on or off.
  Future<void> sendQuickView(bool quickViewState) {
    return _platform.sendQuickView(quickViewState);
  }

  /// Gets the quick view state of the device.
  Future<bool> get queryQuickView {
    return _platform.queryQuickView;
  }

  /// The watch supports setting the effective time period for turning the wrist
  /// and turning on the screen, and it is only valid when turning the wrist and
  /// turning on the screen within the set time period.
  Future<void> sendQuickViewTime(PeriodTimeBean periodTimeInfo) {
    return _platform.sendQuickViewTime(periodTimeInfo);
  }

  /// Gets the effective time for quick view
  Future<PeriodTimeResultBean> get queryQuickViewTime {
    return _platform.queryQuickViewTime;
  }

  /// Push the user's target step number to the watch. When the number of
  /// activity steps on the day reaches the target number of steps, the watch
  /// will remind you to reach the target.
  Future<void> sendGoalSteps(int goalSteps) {
    return _platform.sendGoalSteps(goalSteps);
  }

  /// Gets the target number of steps set in the watch.
  Future<int> get queryGoalSteps {
    return _platform.queryGoalSteps;
  }

  /// Daily goals are to set daily target values.
  Future<void> sendDailyGoals(DailyGoalsInfoBean dailyGoals) {
    return _platform.sendDailyGoals(dailyGoals);
  }

  /// Querying Daily Goals.
  Future<DailyGoalsInfoBean> get queryDailyGoals {
    return _platform.queryDailyGoals;
  }

  /// Set workout day goals.
  Future<void> sendTrainingDayGoals(DailyGoalsInfoBean dailyGoals) {
    return _platform.sendTrainingDayGoals(dailyGoals);
  }

  /// Look up workout day goals.
  Future<DailyGoalsInfoBean> get queryTrainingDayGoals {
    return _platform.queryTrainingDayGoals;
  }

  /// Set up a workout Day.
  Future<void> sendTrainingDays(TrainingDayInfoBean trainingDay) {
    return _platform.sendTrainingDays(trainingDay);
  }

  /// Check Exercise Day.
  Future<TrainingDayInfoBean> get queryTrainingDay {
    return _platform.queryTrainingDay;
  }

  /// The watch supports a variety of different watchfaces, which can be switched freely.
  /// Send watchface type,Parameters provided by WatchFaceType.
  Future<void> sendDisplayWatchFace(int watchFaceType) {
    return _platform.sendDisplayWatchFace(watchFaceType);
  }

  /// Gets the type that the watch face is currently using.
  Future<int> get queryDisplayWatchFace {
    return _platform.queryDisplayWatchFace;
  }

  /// Gets the watchface layout.
  Future<WatchFaceLayoutBean> get queryWatchFaceLayout {
    return _platform.queryWatchFaceLayout;
  }

  /// Sets the watchface layout
  Future<void> sendWatchFaceLayout(WatchFaceLayoutBean watchFaceLayoutInfo) {
    return _platform.sendWatchFaceLayout(watchFaceLayoutInfo);
  }

  /// The dial of the 1.3-inch color screen supports the replacement of the
  /// background image with a picture size of 240 * 240 px. Compressed indicates
  /// whether the picture needs to be compressed (the watch with the master
  /// control of 52840 does not support compression and is fixed to false);
  /// timeout indicates the timeout period, in seconds. The progress is called
  /// back by _blePlugin.lazyFileTransEveStm.listen.
  Future<void> sendWatchFaceBackground(WatchFaceBackgroundBean watchFaceBackgroundInfo) {
    return _platform.sendWatchFaceBackground(watchFaceBackgroundInfo);
  }

  Future<void> get abortWatchFaceBackground {
    return _platform.abortWatchFaceBackground;
  }

  /// Monitor the process of sending the dial background.
  Stream<FileTransBean> get fileTransEveStm {
    return _platform.fileTransEveStm;
  }

  /// When the watch switches dials, it needs to query the type supported by the
  /// dial.
  Future<SupportWatchFaceBean> get querySupportWatchFace {
    return _platform.querySupportWatchFace;
  }

  /// Gets the list of available watch faces by way of paging query.
  Future<List<WatchFaceBean>> queryWatchFaceStore(WatchFaceStoreBean watchFaceStoreBean) {
    return _platform.queryWatchFaceStore(watchFaceStoreBean);
  }

  Future<JieliWatchFaceBean> get queryJieliWatchFaceInfo {
    return _platform.queryJieliWatchFaceInfo;
  }

  Future<WatchFaceStoreTagListResult> queryWatchFaceStoreTagList(WatchFaceStoreTagListBean watchFaceStoreTagList) {
    return _platform.queryWatchFaceStoreTagList(watchFaceStoreTagList);
  }

  Future<List<WatchFaceBean>> queryWatchFaceStoreList(WatchFaceStoreListBean watchFaceStoreList) {
    return _platform.queryWatchFaceStoreList(watchFaceStoreList);
  }

  Future<WatchFaceDetailResultBean> queryWatchFaceDetail(WatchFaceStoreTypeBean watchFaceStoreType) {
    return _platform.queryWatchFaceDetail(watchFaceStoreType);
  }

  /// Gets the watchface information of the watchface ID.
  Future<WatchFaceIdBean> queryWatchFaceOfID(int id) {
    return _platform.queryWatchFaceOfID(id);
  }

  Stream<FileTransBean> get wfFileTransEveStm {
    return _platform.wfFileTransEveStm;
  }

  /// Send the watchface file of the new watchface to the watch, during which
  /// the watch will restart.
  Future<void> sendWatchFace(SendWatchFaceBean sendWatchFaceBean) {
    return _platform.sendWatchFace(sendWatchFaceBean);
  }

  Future<void> sendWatchFaceId(int id) {
    return _platform.sendWatchFaceId(id);
  }

  Future<void> get abortWatchFace {
    return _platform.abortWatchFace;
  }

  Future<void> deleteWatchFace(int id) {
    return _platform.deleteWatchFace(id);
  }

  Future<int> queryAvailableStorage(int type) {
    return _platform.queryAvailableStorage(type);
  }

  /// The watch supports three alarm clocks, and the alarm clock information can
  /// be set according to the alarm clock serial number. Single alarm clock
  /// supports setting date.
  // Future<void> sendAlarm(AlarmClockBean alarmClockInfo) {
  //   return _platform.sendAlarm(alarmClockInfo);
  // }

  /// Gets all alarm clock information saved by the watch.
  // Future<List<AlarmClockBean>> get queryAllAlarm {
  //   return _platform.queryAllAlarm;
  // }

  Future<void> sendNewAlarm(AlarmClockBean alarmClockInfo) {
    return _platform.sendNewAlarm(alarmClockInfo);
  }

  Future<void> deleteNewAlarm(int id) {
    return _platform.deleteNewAlarm(id);
  }

  Future<void> deleteAllNewAlarm() {
    return _platform.deleteAllNewAlarm();
  }

  Future<AlarmBean> get queryAllNewAlarm {
    return _platform.queryAllNewAlarm;
  }

  /// Sets blood pressure listener
  Stream<HeartRateBean> get heartRateEveStm {
    return _platform.heartRateEveStm;
  }

  /// Gets the last measured heart rate record saved by the watch. The query
  /// result will be obtained through the heartRateEveStm listening stream and
  /// saved in the HeartRateBean.measuring field.
  Future<void> queryLastDynamicRate(String type) {
    return _platform.queryLastDynamicRate(type);
  }

  /// The watch supports 24-hour timed measurement of heart rate, starting from
  /// 00:00, you can set the measurement interval, the time interval is a
  /// multiple of 5 minutes.
  Future<void> enableTimingMeasureHeartRate(int interval) {
    return _platform.enableTimingMeasureHeartRate(interval);
  }

  /// The query timing measures the heart rate on state.
  Future<void> get disableTimingMeasureHeartRate {
    return _platform.disableTimingMeasureHeartRate;
  }

  /// The query timing measures the heart rate on state.
  Future<int> get queryTimingMeasureHeartRate {
    return _platform.queryTimingMeasureHeartRate;
  }

  /// Query today's measured heart rate value. The query result will be obtained
  /// through the heartRateEveStm listening stream and saved in the
  /// HeartRateBean.hour24MeasureResult field.
  Future<void> queryTodayHeartRate(int heartRateType) {
    return _platform.queryTodayHeartRate(heartRateType);
  }

  /// Gets the heart rate data of the previous day. The query result will be
  /// obtained through the heartRateEveStm listening stream and saved in the
  /// HeartRateBean.hour24MeasureResult field.
  Future<void> queryPastHeartRate(int historyDay) {
    return _platform.queryPastHeartRate(historyDay);
  }

  /// Some watchs support heart rate measurement in a variety of motion modes.
  /// The measurements include other motion-related data such as heart rate and
  /// calories. This interface is used to obtain data such as calories.
  /// The watch can save the last three sports data. Supporting 24-hour
  /// continuous measurement of the watch, the exercise heart rate can be
  /// obtained from the 24-hour heart rate data according to the movement up time;
  /// other watch exercise heart rate and dynamic heart rate acquisition
  /// methods are consistent.
  Future<void> get queryTrainingHeartRate {
    return _platform.queryTrainingHeartRate;
  }

  /// Start measuring a single heart rate, the query result will be obtained
  /// through the heartRateEveStm listening stream and saved in the
  /// HeartRateBean.onceMeasureComplete field.
  Future<void> get startMeasureOnceHeartRate {
    return _platform.startMeasureOnceHeartRate;
  }

  /// End a once measurement. A measurement time that is too short will result
  /// in no measurement data.
  Future<void> get stopMeasureOnceHeartRate {
    return _platform.stopMeasureOnceHeartRate;
  }

  /// To query the historical heart rate, the query result will be obtained
  /// through the heartRateEveStm monitoring stream and saved in the
  /// HeartRateBean.historyHRList field.
  Future<void> get queryHistoryHeartRate {
    return _platform.queryHistoryHeartRate;
  }

  Future<int> queryAverageHeartRate(int startTime, int endTime, List list) {
    return _platform.queryAverageHeartRate(startTime, endTime, list);
  }

  /// Sets blood pressure listener
  Stream<BloodPressureBean> get bloodPressureEveStm {
    return _platform.bloodPressureEveStm;
  }

  /// Measuring blood pressure
  Future<void> get startMeasureBloodPressure {
    return _platform.startMeasureBloodPressure;
  }

  /// Stop measuring blood pressure, too short a measurement time will result in
  /// no measurement results. The measurement results are monitored through the
  /// bloodPressureEveStm data stream, and the returned high and low pressure
  /// values are stored in BloodPressureBean.bloodPressureChange and
  /// BloodOxygenBean.bloodPressureChange1, respectively.
  Future<void> get stopMeasureBloodPressure {
    return _platform.stopMeasureBloodPressure;
  }

  /// Enable continue blood pressure
  Future<void> get enableContinueBloodPressure {
    return _platform.enableContinueBloodPressure;
  }

  /// Disable continue blood pressure
  Future<void> get disableContinueBloodPressure {
    return _platform.disableContinueBloodPressure;
  }

  /// The measurement results are monitored through the bloodPressureEveStmdata
  /// stream, and the value is stored in BloodPressureBean.continueState.
  Future<void> get queryContinueBloodPressureState {
    return _platform.queryContinueBloodPressureState;
  }

  /// The measurement results are monitored through the bloodPressureEveStmdata
  /// stream, and the value is stored in BloodPressureBean.historyBPList.
  Future<void> get queryLast24HourBloodPressure {
    return _platform.queryLast24HourBloodPressure;
  }

  /// The measurement results are monitored through the bloodPressureEveStmdata
  /// stream, and the value is stored in BloodPressureBean.historyBPList.
  Future<void> get queryHistoryBloodPressure {
    return _platform.queryHistoryBloodPressure;
  }

  /// Sets blood oxygen listener.
  Stream<BloodOxygenBean> get bloodOxygenEveStm {
    return _platform.bloodOxygenEveStm;
  }

  /// Measuring blood oxygen.
  Future<void> get startMeasureBloodOxygen {
    return _platform.startMeasureBloodOxygen;
  }

  /// When the blood oxygen measurement is stopped, if the measurement time is
  /// too short, there will be no measurement results. The measurement results
  /// are monitored through the bloodOxygenEveStm data stream, and the value is
  /// stored in BloodOxygenBean.bloodOxygen.
  Future<void> get stopMeasureBloodOxygen {
    return _platform.stopMeasureBloodOxygen;
  }

  /// measure period = interval * 5 (mins).
  Future<void> enableTimingMeasureBloodOxygen(int interval) {
    return _platform.enableTimingMeasureBloodOxygen(interval);
  }

  /// Disable timing measure blood oxygen.
  Future<void> get disableTimingMeasureBloodOxygen {
    return _platform.disableTimingMeasureBloodOxygen;
  }

  /// The measurement results are monitored through the bloodOxygenEveStm data
  /// stream, and the value is stored in BloodOxygenBean.timingMeasure.
  Future<void> get queryTimingBloodOxygenMeasureState {
    return _platform.queryTimingBloodOxygenMeasureState;
  }

  /// The measurement results are monitored through the bloodOxygenEveStm data
  /// stream, and the value is stored in BloodOxygenBean.continueBO.
  Future<void> queryTimingBloodOxygen(String bloodOxygenTimeType) {
    return _platform.queryTimingBloodOxygen(bloodOxygenTimeType);
  }

  /// Enable continue blood oxygen.
  Future<void> get enableContinueBloodOxygen {
    return _platform.enableContinueBloodOxygen;
  }

  /// Disable continue blood oxygen.
  Future<void> get disableContinueBloodOxygen {
    return _platform.disableContinueBloodOxygen;
  }

  ///  The measurement results are monitored through the bloodOxygenEveStm data
  ///  stream, and the value is stored in BloodOxygenBean.continueState.
  Future<void> get queryContinueBloodOxygenState {
    return _platform.queryContinueBloodOxygenState;
  }

  ///  The measurement results are monitored through the bloodOxygenEveStm data
  ///  stream, and the value is stored in BloodOxygenBean.continueBO.
  Future<void> get queryLast24HourBloodOxygen {
    return _platform.queryLast24HourBloodOxygen;
  }

  /// The measurement results are monitored through the bloodOxygenEveStm data
  /// stream, and the value is stored in BloodOxygenBean.historyList.
  Future<void> get queryHistoryBloodOxygen {
    return _platform.queryHistoryBloodOxygen;
  }

  /// Enable camera view.
  Future<void> get enterCameraView {
    return _platform.enterCameraView;
  }

  /// Exit camera view.
  Future<void> get exitCameraView {
    return _platform.exitCameraView;
  }

  /// Long press the watch photo interface to trigger the camera's camera command.
  Stream<CameraBean> get cameraEveStm {
    return _platform.cameraEveStm;
  }

  /// Sets phone listener
  Stream<int> get phoneEveStm {
    return _platform.phoneEveStm;
  }

  /// Sets RSSI listening
  Stream<int> get deviceRssiEveStm {
    return _platform.deviceRssiEveStm;
  }

  /// Read the real-time RSSI value of the watch. The query result will be
  /// obtained through the deviceRssiEveStm listening stream and saved in
  /// the "event" field.
  Future<void> get readDeviceRssi {
    return _platform.readDeviceRssi;
  }

  /// Add ECG listening event.
  Future<void> setECGChangeListener(String ecgMeasureType) {
    return _platform.setECGChangeListener(ecgMeasureType);
  }

  /// Sets the ECG monitor and get the return value through connLazyEgcEveStm.
  Stream<EcgBean> get ecgEveStm {
    return _platform.ecgEveStm;
  }

  /// Start to measure the ECG, the ECG measurement time is 30 seconds, and the
  /// user needs to touch the left and right electrodes of the watch with both
  /// hands. The value is obtained by listening to the lazyEcgEveStm data stream,
  /// and the value is saved in EgcBean.ints
  Future<void> get startECGMeasure {
    return _platform.startECGMeasure;
  }

  /// Stop measuring ECG.
  Future<void> get stopECGMeasure {
    return _platform.stopECGMeasure;
  }

  /// In the new measurement mode, the watch can save the last unsent measurement
  /// result; the old version does not.
  Future<bool> get isNewECGMeasurementVersion {
    return _platform.isNewECGMeasurementVersion;
  }

  /// Gets the ECG data saved by the watch, monitor the data stream through
  /// lazyEcgEveStm, and save the value in EgcBean.ints
  Future<void> get queryLastMeasureECGData {
    return _platform.queryLastMeasureECGData;
  }

  /// Using the measured data, the instantaneous heart rate is calculated
  /// through the ECG algorithm library and sent to the watch.
  Future<void> sendECGHeartRate(int heartRate) {
    return _platform.sendECGHeartRate(heartRate);
  }

  /// Sets the language of the watch. When setting the language, the language
  /// version will be set. Simplified Chinese is set to the Chinese version,
  /// and non-simplified Chinese is set to the international version.
  Future<void> sendDeviceLanguage(int language) {
    return _platform.sendDeviceLanguage(language);
  }

  Future<int> get queryDeviceVersion {
    return _platform.queryDeviceVersion;
  }

  /// Gets the language that the watch is using and the list of languages
  /// supported by the watch.
  Future<DeviceLanguageBean> get queryDeviceLanguage {
    return _platform.queryDeviceLanguage;
  }

  Future<void> sendOtherMessageState(bool state) {
    return _platform.sendOtherMessageState(state);
  }

  Future<bool> get queryOtherMessageState {
    return _platform.queryOtherMessageState;
  }

  /// Send various types of message content to the watch.
  Future<void> sendMessage(MessageBean messageInfo) {
    return _platform.sendMessage(messageInfo);
  }

  /// When the watch receives a push of a phone type message, the watch will
  /// vibrate for a fixed time. Call this interface to stop the watch from
  /// vibrating when the watch answers the call or hangs up the call.
  Future<void> get endCall {
    return _platform.endCall;
  }

  Future<void> sendCallContactName(String name) {
    return _platform.sendCallContactName(name);
  }

  Future<List<int>> get queryMessageList {
    return _platform.queryMessageList;
  }

  Stream<String> get callNumberEveStm {
    return _platform.callNumberEveStm;
  }

  ///Sets up other push notifications<Only ios support>
  Future<void> setNotification(List<int> list) {
    return _platform.setNotification(list);
  }

  ///Gets other push notifications<Only ios support>
  Future<NotificationBean> get getNotification {
    return _platform.getNotification;
  }

  /// Turn sedentary reminders on or off.
  Future<void> sendSedentaryReminder(bool sedentaryReminder) {
    return _platform.sendSedentaryReminder(sedentaryReminder);
  }

  /// Gets sedentary reminder status
  Future<bool> get querySedentaryReminder {
    return _platform.querySedentaryReminder;
  }

  /// Sets the effective period of sedentary reminder.
  Future<void> sendSedentaryReminderPeriod(SedentaryReminderPeriodBean sedentaryReminderPeriodInfo) {
    return _platform.sendSedentaryReminderPeriod(sedentaryReminderPeriodInfo);
  }

  /// Gets the watch for sedentary reminder valid period.
  Future<SedentaryReminderPeriodBean> get querySedentaryReminderPeriod {
    return _platform.querySedentaryReminderPeriod;
  }

  /// Find the watch, the watch will vibrate for a few seconds after
  /// receiving this command.
  Future<void> get findDevice {
    return _platform.findDevice;
  }

  /// The watch is turned off.
  Future<void> get shutDown {
    return _platform.shutDown;
  }

  Future<void> get reset {
    return _platform.reset;
  }

  /// Check if do not disturb the time set by the watch.
  Future<PeriodTimeResultBean> get queryDoNotDisturbTime {
    return _platform.queryDoNotDisturbTime;
  }

  /// The watch supports the Do Not Disturb period. Do not display message push
  /// and sedentary reminders during the time.
  Future<void> sendDoNotDisturbTime(PeriodTimeBean periodTimeInfo) {
    return _platform.sendDoNotDisturbTime(periodTimeInfo);
  }

  /// Sets the breathing light.
  Future<void> sendBreathingLight(bool breathingLight) {
    return _platform.sendBreathingLight(breathingLight);
  }

  /// Gets the status of the breathing light.
  Future<bool> get queryBreathingLight {
    return _platform.queryBreathingLight;
  }

  /// Sets the menstrual cycle reminder
  Future<void> sendMenstrualCycle(MenstrualCycleBean info) {
    return _platform.sendMenstrualCycle(info);
  }

  /// Gets physiological cycle reminder
  Future<MenstrualCycleBean> get queryMenstrualCycle {
    return _platform.queryMenstrualCycle;
  }

  /// When receiving a callback to find the bracelet phone, the app vibrates
  /// and plays a ringtone reminder.
  Future<void> get startFindPhone {
    return _platform.startFindPhone;
  }

  /// When the user retrieves the phone, the vibrate and ringtone reminder ends,
  /// returning to the watch with this command
  Future<void> get stopFindPhone {
    return _platform.stopFindPhone;
  }

  Stream<FindPhoneBean> get findPhoneEveStm {
    return _platform.findPhoneEveStm;
  }

  /// Sets player state
  Future<void> setPlayerState(int musicPlayer) {
    return _platform.setPlayerState(musicPlayer);
  }

  /// Sets song name
  Future<void> sendSongTitle(String title) {
    return _platform.sendSongTitle(title);
  }

  /// Sets lyrics
  Future<void> sendLyrics(String lyrics) {
    return _platform.sendLyrics(lyrics);
  }

  /// Close Music Control
  Future<void> get closePlayerControl {
    return _platform.closePlayerControl;
  }

  /// Sets max volume
  Future<void> sendCurrentVolume(int volume) {
    return _platform.sendCurrentVolume(volume);
  }

  /// Sets Current volumed
  Future<void> sendMaxVolume(int volume) {
    return _platform.sendMaxVolume(volume);
  }

  /// Enable drinking reminder.
  Future<void> enableDrinkWaterReminder(DrinkWaterPeriodBean drinkWaterPeriodInfo) {
    return _platform.enableDrinkWaterReminder(drinkWaterPeriodInfo);
  }

  /// Disable water reminder.
  Future<void> get disableDrinkWaterReminder {
    return _platform.disableDrinkWaterReminder;
  }

  /// Gets drinking reminder
  Future<DrinkWaterPeriodBean> get queryDrinkWaterReminderPeriod {
    return _platform.queryDrinkWaterReminderPeriod;
  }

  ///  Sets the heart rate alarm value
  Future<void> setMaxHeartRate(MaxHeartRateBean maxHeartRateBean) {
    return _platform.setMaxHeartRate(maxHeartRateBean);
  }

  /// Gets the status of the wristband heart rate alarm and the value of
  /// the heart rate alarm.
  Future<MaxHeartRateBean> get queryMaxHeartRate {
    return _platform.queryMaxHeartRate;
  }

  /// Start training
  Future<void> startTraining(int type) {
    return _platform.startTraining(type);
  }

  /// Sets training state
  Future<void> setTrainingState(int training) {
    return _platform.setTrainingState(training);
  }

  /// Modify the training state on the bracelet, and obtain the current
  /// measurement state by monitoring the data stream movementStateEveStm.
  Stream<int> get trainingStateEveStm {
    return _platform.trainingStateEveStm;
  }

  /// Gets the protocol version.
  Future<String> get getProtocolVersion {
    return _platform.getProtocolVersion;
  }

  /// Start measuring once temperature.
  Future<void> get startMeasureTemp {
    return _platform.startMeasureTemp;
  }

  /// Stop measuring once temperature.
  Future<void> get stopMeasureTemp {
    return _platform.stopMeasureTemp;
  }

  /// When the chronograph measurement is turned on, the watch automatically
  /// measures the temperature every half an hour.
  Future<void> get enableTimingMeasureTemp {
    return _platform.enableTimingMeasureTemp;
  }

  /// Disable timing temperature measurement.
  Future<void> get disableTimingMeasureTemp {
    return _platform.disableTimingMeasureTemp;
  }

  /// Gets the timing of temperature measurement status.
  Future<String> get queryTimingMeasureTempState {
    return _platform.queryTimingMeasureTempState;
  }

  /// Gets timed temperature measurement results
  Future<void> queryTimingMeasureTemp(String tempTimeType) {
    return _platform.queryTimingMeasureTemp(tempTimeType);
  }

  Future<void> get enableContinueTemp {
    return _platform.enableContinueTemp;
  }

  Future<void> get disableContinueTemp {
    return _platform.disableContinueTemp;
  }

  Future<void> get queryContinueTempState {
    return _platform.queryContinueTempState;
  }

  Future<void> get queryLast24HourTemp {
    return _platform.queryLast24HourTemp;
  }

  Future<void> get sendGsensorCalibration {
    return _platform.sendGsensorCalibration;
  }

  /// Sets the monitoring of body temperature measurement results to return the
  /// corresponding data of body temperature.
  Stream<TempChangeBean> get tempChangeEveStm {
    return _platform.tempChangeEveStm;
  }

  /// Sets display time.
  Future<void> sendDisplayTime(int time) {
    return _platform.sendDisplayTime(time);
  }

  /// Gets display time.
  Future<int> get queryDisplayTime {
    return _platform.queryDisplayTime;
  }

  /// Enable hand washing reminder
  Future<void> enableHandWashingReminder(HandWashingPeriodBean info) {
    return _platform.enableHandWashingReminder(info);
  }

  /// Disable hand washing reminder.
  Future<void> get disableHandWashingReminder {
    return _platform.disableHandWashingReminder;
  }

  /// Gets hand washing reminder.
  Future<HandWashingPeriodBean> get queryHandWashingReminderPeriod {
    return _platform.queryHandWashingReminderPeriod;
  }

  /// sets local city.
  Future<void> sendLocalCity(String city) {
    return _platform.sendLocalCity(city);
  }

  /// Sets temperature system.
  Future<void> sendTempUnit(int temp) {
    return _platform.sendTempUnit(temp);
  }

  /// Gets temperature system.
  Future<void> get queryTempUnit {
    return _platform.queryTempUnit;
  }

  /// Sets brightness.
  Future<void> sendBrightness(int brightness) {
    return _platform.sendBrightness(brightness);
  }

  /// Gets brightness.
  Future<BrightnessBean> get queryBrightness {
    return _platform.queryBrightness;
  }

  /// Classic Bluetooth address.
  Future<String> get queryBtAddress {
    return _platform.queryBtAddress;
  }

  /// Check support contacts.
  Future<ContactConfigBean> get checkSupportQuickContact {
    return _platform.checkSupportQuickContact;
  }

  /// Gets current contacts count.
  Future<int> get queryContactCount {
    return _platform.queryContactCount;
  }

  /// Sets up a contact listener, and the result is returned via the data stream
  /// contactEveStm and stored in "event".
  Stream<ContactListenBean> get contactEveStm {
    return _platform.contactEveStm;
  }

  Future<bool> get queryContactNumberSymbol {
    return _platform.queryContactNumberSymbol;
  }

  /// Sets monitoring of contacts with avatars
  Stream<FileTransBean> get contactAvatarEveStm {
    return _platform.contactAvatarEveStm;
  }

  /// Sets the contact, the result is obtained through contactEveStm.
  Future<void> sendContact(ContactBean info) {
    return _platform.sendContact(info);
  }

  /// Sets the contact avatar, the result is obtained through contactAvatarEveStm.
  Future<void> sendContactAvatar(ContactBean info) {
    return _platform.sendContactAvatar(info);
  }

  /// Delete contact information based on contact index.
  Future<void> deleteContact(int index) {
    return _platform.deleteContact(index);
  }

  /// Delete contact avatar information based on contact index.
  Future<void> deleteContactAvatar(int index) {
    return _platform.deleteContactAvatar(index);
  }

  /// Clearing all contacts
  Future<void> clearContact() {
    return _platform.clearContact();
  }

  /// Sets the battery storage listener, the result is returned through the data
  /// stream, and saved in "event".
  Stream<bool> get batterySavingEveStm {
    return _platform.batterySavingEveStm;
  }

  /// Sets battery saving state.
  Future<void> sendBatterySaving(bool enable) {
    return _platform.sendBatterySaving(enable);
  }

  /// The query result will be obtained through the batterySavingEveStm
  /// monitoring stream and saved in the event field.
  Future<void> get queryBatterySaving {
    return _platform.queryBatterySaving;
  }

  /// Gets support pill reminder.
  Future<PillReminderCallback> get queryPillReminder {
    return _platform.queryPillReminder;
  }

  /// Sets pill reminder.
  Future<void> sendPillReminder(PillReminderBean info) {
    return _platform.sendPillReminder(info);
  }

  /// Delete pill reminder.
  Future<void> deletePillReminder(int id) {
    return _platform.deletePillReminder(id);
  }

  /// Clear pill reminder.
  Future<void> get clearPillReminder {
    return _platform.clearPillReminder;
  }

  /// Gets whether it is in the wake-up state. If the result is true, it means
  /// that it is in the awake state, otherwise, it is not awake.
  Future<bool> get queryWakeState {
    return _platform.queryWakeState;
  }

  /// Sets tap to wake state.
  Future<void> sendWakeState(bool enable) {
    return _platform.sendWakeState(enable);
  }

  /// Set up a training listener, the results are returned through the data
  /// stream, and saved in "event".
  Stream<TrainBean> get trainingEveStm {
    return _platform.trainingEveStm;
  }

  /// Gets the training records stored in the watch. The query result will be
  /// obtained through trainingEveStm listening stream and saved in the
  /// historyTrainList field.
  Future<void> get queryHistoryTraining {
    return _platform.queryHistoryTraining;
  }

  /// Gets detailed data for a training. The query result will be obtained
  /// through the trainingEveStm listening stream and saved in the
  /// trainingInfo field.
  Future<void> queryTraining(int id) {
    return _platform.queryTraining(id);
  }

  Stream<dynamic> get sosChangeEveStm {
    return _platform.sosChangeEveStm;
  }

  Future<int> createBond(List<int> keys) {
    return _platform.createBond(keys);
  }

  Stream<HrvHandlerBean> get newHrvEveStm {
    return _platform.newHrvEveStm;
  }

  Future<void> get querySupportNewHrv {
    return _platform.querySupportNewHrv;
  }

  Future<void> get startMeasureNewHrv {
    return _platform.startMeasureNewHrv;
  }

  Future<void> get stopMeasureNewHrv {
    return _platform.stopMeasureNewHrv;
  }

  Future<void> get queryHistoryNewHrv {
    return _platform.queryHistoryNewHrv;
  }

  Stream<StressHandlerBean> get stressEveStm {
    return _platform.stressEveStm;
  }

  Future<void> get querySupportStress {
    return _platform.querySupportStress;
  }

  Future<void> get startMeasureStress {
    return _platform.startMeasureStress;
  }

  Future<void> get stopMeasureStress {
    return _platform.stopMeasureStress;
  }

  Future<void> get queryHistoryStress {
    return _platform.queryHistoryStress;
  }

  Future<void> get enableTimingStress {
    return _platform.enableTimingStress;
  }

  Future<void> get disableTimingStress {
    return _platform.disableTimingStress;
  }

  Future<void> get queryTimingStressState {
    return _platform.queryTimingStressState;
  }

  Future<void> queryTimingStress(String stressDate) {
    return _platform.queryTimingStress(stressDate);
  }

  Future<ElectronicCardCountInfoBean> get queryElectronicCardCount {
    return _platform.queryElectronicCardCount;
  }

  Future<void> sendElectronicCard(ElectronicCardInfoBean electronicCardInfo) {
    return _platform.sendElectronicCard(electronicCardInfo);
  }

  Future<void> deleteElectronicCard(int id) {
    return _platform.deleteElectronicCard(id);
  }

  Future<ElectronicCardInfoBean> queryElectronicCard(int id) {
    return _platform.queryElectronicCard(id);
  }

  Future<void> sendElectronicCardList(List idList) {
    return _platform.sendElectronicCardList(idList);
  }

  Stream<CalendarEventBean> get calendarEventEveStem {
    return _platform.calendarEventEveStem;
  }

  Future<void> get querySupportCalendarEvent {
    return _platform.querySupportCalendarEvent;
  }

  Future<void> sendCalendarEvent(CalendarEventInfoBean calenderEventInfo) {
    return _platform.sendCalendarEvent(calenderEventInfo);
  }

  Future<void> deleteCalendarEvent(int id) {
    return _platform.deleteCalendarEvent(id);
  }

  Future<void> queryCalendarEvent(int id) {
    return _platform.queryCalendarEvent(id);
  }

  Future<void> sendCalendarEventReminderTime(CalendarEventReminderTimeBean calendarEventReminderTime) {
    return _platform.sendCalendarEventReminderTime(calendarEventReminderTime);
  }

  Future<void> get queryCalendarEventReminderTime {
    return _platform.queryCalendarEventReminderTime;
  }

  Future<void> get clearCalendarEvent {
    return _platform.clearCalendarEvent;
  }

  // ignore: non_constant_identifier_names
  Stream<int> get gpsChangeEveStm {
    return _platform.gpsChangeEveStm;
  }

  Future<void> get queryHistoryGps {
    return _platform.queryHistoryGps;
  }

  Future<void> queryGpsDetail(int seconds) {
    return _platform.queryGpsDetail(seconds);
  }

  Future<void> sendVibrationStrength(int value) {
    return _platform.sendVibrationStrength(value);
  }

  Future<VibrationStrength> get queryVibrationStrength {
    return _platform.queryVibrationStrength;
  }

  Future<bool> uploadLocalFile(String filePath) {
    return _platform.uploadLocalFile(filePath);
  }

  Future<bool> enableIncomingNumber(bool enableIncoming) {
    return _platform.enableIncomingNumber(enableIncoming);
  }
}
