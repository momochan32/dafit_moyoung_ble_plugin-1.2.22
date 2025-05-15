import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:moyoung_ble_plugin/impl/channel_names.dart';
import 'package:moyoung_ble_plugin/impl/moyoung_beans.dart';

import 'event_streams.dart';

class MoyoungBleImpl {
  static final MoyoungBleImpl _instance = MoyoungBleImpl();

  /// The default instance of [MoyoungBleImpl] to use.
  ///
  /// Defaults to [MoyoungBleImpl].
  static MoyoungBleImpl get instance => _instance;

  MethodChannel mBleScanconst = const MethodChannel(ChannelNames.methodScanDevice);
  MethodChannel mConnconst = const MethodChannel(ChannelNames.methodConnection);

  final _bleEveChannels = MYEventStreams();

  Future<bool> get checkBluetoothEnable async {
    return await mConnconst.invokeMethod('checkBluetoothEnable');
  }

  Future<bool> startScan(int scanPeriod) async {
    return await mBleScanconst.invokeMethod('startScan', <String, int>{"scanPeriod": scanPeriod});
  }

  Future<void> get cancelScan {
    return mBleScanconst.invokeMethod('cancelScan');
  }

  Future<bool> isConnected(String address) async {
    bool isConnected = await mConnconst.invokeMethod('isConnected', <String, String>{"address": address});
    return isConnected;
  }

  Future<void> connect(ConnectBean connectBean) {
    String jsonStr = connectBeanToJson(connectBean);
    return mConnconst.invokeMethod('connect', <String, String>{"connectInfo": jsonStr});
  }

  Future<bool> disconnect() async {
    bool isSuccess = await mConnconst.invokeMethod('disconnect');
    return isSuccess;
  }

  Future<bool> closeGatt() async {
    bool isSuccess = await mConnconst.invokeMethod('closeGatt');
    return isSuccess;
  }

  Future<void> reconnect() {
    return mConnconst.invokeMethod('reconnect');
  }

  Future<void> connectDevice(ConnectDeviceBean connectDevice) {
    String jsonStr = connectDeviceBeanToJson(connectDevice);
    return mConnconst.invokeMethod('connectDevice', <String, String>{"connectDevice": jsonStr});
  }

  Future<void> get queryTime {
    return mConnconst.invokeMethod('queryTime');
  }

  Future<void> sendTimeSystem(int timeSystemType) {
    return mConnconst.invokeMethod('sendTimeSystem', <String, int>{"timeSystemType": timeSystemType});
  }

  Future<int> get queryTimeSystem async {
    int time = await mConnconst.invokeMethod('queryTimeSystem');
    return time;
  }

  Future<String> get queryFirmwareVersion async {
    return await mConnconst.invokeMethod('queryFirmwareVersion');
  }

  Future<void> get queryDeviceBattery {
    return mConnconst.invokeMethod('queryDeviceBattery');
  }

  Future<void> get subscribeDeviceBattery {
    return mConnconst.invokeMethod('subscribeDeviceBattery');
  }

  Future<CheckFirmwareVersionBean> checkFirmwareVersion(FirmwareVersion info) async {
    String json = firmwareVersionToJson(info);
    String jsonStr = await mConnconst.invokeMethod('checkFirmwareVersion', <String, String>{"firmwareVersion": json});
    return checkFirmwareVersionBeanFromJson(jsonStr);
  }

  Future<void> sendUserInfo(UserBean userInfo) {
    String jsonStr = userBeanToJson(userInfo);
    return mConnconst.invokeMethod('sendUserInfo', <String, String>{"userInfo": jsonStr});
  }

  Future<void> sendStepLength(int stepLength) {
    return mConnconst.invokeMethod('sendStepLength', <String, int>{"stepLength": stepLength});
  }

  Future<void> sendTodayWeather(TodayWeatherBean todayWeatherInfo) {
    String jsonStr = todayWeatherBeanToJson(todayWeatherInfo);
    return mConnconst.invokeMethod('sendTodayWeather', <String, String>{"todayWeatherInfo": jsonStr});
  }

  Future<void> sendFutureWeather(FutureWeatherListBean futureWeathersBean) {
    String jsonStr = futureWeatherListBeanToJson(futureWeathersBean);
    return mConnconst.invokeMethod('sendFutureWeather', <String, String>{"futureWeatherInfo": jsonStr});
  }

  Stream<BleScanBean> get bleScanEveStm {
    return _bleEveChannels.bleScanEveStm;
  }

  Stream<ConnectStateBean> get connStateEveStm {
    return _bleEveChannels.stateEveStm;
  }

  Stream<StepsChangeBean> get stepsChangeEveStm {
    return _bleEveChannels.stepsChangeEveStm;
  }

  Stream<DeviceBatteryBean> get deviceBatteryEveStm {
    return _bleEveChannels.deviceBatteryEveStm;
  }

  Stream<WeatherChangeBean> get weatherChangeEveStm {
    return _bleEveChannels.weatherChangeEveStm;
  }

  Future<void> get querySteps {
    return mConnconst.invokeMethod('querySteps');
  }

  Future<void> queryHistorySteps(int historyTimeType) {
    return mConnconst.invokeMethod('queryHistorySteps', <String, int>{"historyTimeType": historyTimeType});
  }

  Future<void> queryStepsDetail(int stepsDetailDateType) {
    return mConnconst.invokeMethod('queryStepsDetail', <String, int>{"stepsDetailDateType": stepsDetailDateType});
  }

  // Future<The24HourListBean> get get24HourCals async {
  //   String jsonStr = await mConnconst.invokeMethod('get24HourCals');
  //   return the24HourListBeanFromJson(jsonStr);
  // }
  //
  // Future<The24HourListBean> get getAgo24HourCals async {
  //   String jsonStr = await mConnconst.invokeMethod('getAgo24HourCals');
  //   return the24HourListBeanFromJson(jsonStr);
  // }
  //
  // Future<The24HourListBean> get get24HourDistances async {
  //   String jsonStr = await mConnconst.invokeMethod('get24HourDistances');
  //   return the24HourListBeanFromJson(jsonStr);
  // }
  //
  // Future<The24HourListBean> get getAgo24HourDistances async {
  //   String jsonStr = await mConnconst.invokeMethod('getAgo24HourDistances');
  //   return the24HourListBeanFromJson(jsonStr);
  // }

  Stream<StepsDetailBean> get stepsDetailEveStm {
    return _bleEveChannels.stepsDetailEveStm;
  }

  Stream<SleepBean> get sleepChangeEveStm {
    return _bleEveChannels.sleepChangeEveStm;
  }

  Future<void> get querySleep {
    return mConnconst.invokeMethod('querySleep');
  }

  Future<void> get queryRemSleep {
    return mConnconst.invokeMethod('queryRemSleep');
  }

  Future<void> sendGoalSleepTime(int minutes) {
    return mConnconst.invokeMethod('sendGoalSleepTime', <String, int>{"goalTime": minutes});
  }

  Future<void> get queryGoalSleepTime {
    return mConnconst.invokeMethod('queryGoalSleepTime');
  }

  Future<void> queryHistorySleep(int historyTimeType) {
    return mConnconst.invokeMethod('queryHistorySleep', <String, int>{"historyTimeType": historyTimeType});
  }

  Stream<OTABean> get oTAEveStm {
    return _bleEveChannels.oTAEveStm;
  }

  Future<void> startOTA(OtaBean otaBean) {
    String jsonStr = otaBeanToJson(otaBean);
    return mConnconst.invokeMethod('startOTA', <String, String>{"otaBean": jsonStr});
  }

  Future<void> abortOTA(int type) {
    return mConnconst.invokeMethod('abortOTA', <String, int>{"type": type});
  }

  Future<int> get queryDeviceOtaStatus async {
    int deviceOtaStatus = await mConnconst.invokeMethod('queryDeviceOtaStatus');
    return deviceOtaStatus;
  }

  Future<String> get queryHsOtaAddress async {
    String address = await mConnconst.invokeMethod('queryHsOtaAddress');
    return address;
  }

  Future<void> get enableHsOta {
    return mConnconst.invokeMethod('enableHsOta');
  }

  Future<int> get queryOtaType async {
    int type = await mConnconst.invokeMethod('queryOtaType');
    return type;
  }

  Future<String> get queryUUID async {
    return await mConnconst.invokeMethod('queryUUID');
  }

  Future<int> get queryUnitSystem async {
    int metricSystem = await mConnconst.invokeMethod('queryUnitSystem');
    return metricSystem;
  }

  Future<void> sendUnitSystem(int metricSystemType) {
    return mConnconst.invokeMethod('sendUnitSystem', <String, int>{"metricSystemType": metricSystemType});
  }

  Future<void> sendQuickView(bool quickViewState) {
    return mConnconst.invokeMethod('sendQuickView', <String, bool>{"quickViewState": quickViewState});
  }

  Future<bool> get queryQuickView async {
    bool quickViewState = await mConnconst.invokeMethod('queryQuickView');
    return quickViewState;
  }

  Future<void> sendQuickViewTime(PeriodTimeBean periodTimeInfo) {
    String jsonStr = periodTimeBeanToJson(periodTimeInfo);
    return mConnconst.invokeMethod('sendQuickViewTime', <String, String>{"periodTimeInfo": jsonStr});
  }

  Future<PeriodTimeResultBean> get queryQuickViewTime async {
    String jsonStr = await mConnconst.invokeMethod('queryQuickViewTime');
    PeriodTimeResultBean quickViewTime = periodTimeResultBeanFromJson(jsonStr);
    return quickViewTime;
  }

  Future<void> sendGoalSteps(int goalSteps) {
    return mConnconst.invokeMethod('sendGoalSteps', <String, int>{"goalSteps": goalSteps});
  }

  Future<int> get queryGoalSteps async {
    int goalSteps = await mConnconst.invokeMethod('queryGoalSteps');
    return goalSteps;
  }

  Future<void> sendDailyGoals(DailyGoalsInfoBean dailyGoals) {
    String josnStr = dailyGoalsInfoBeanToJson(dailyGoals);
    return mConnconst.invokeMethod('sendDailyGoals', <String, dynamic>{"dailyGoals": josnStr});
  }

  Future<DailyGoalsInfoBean> get queryDailyGoals async {
    String jsonStr = await mConnconst.invokeMethod('queryDailyGoals');
    DailyGoalsInfoBean goalsInfoBean = dailyGoalsInfoBeanFromJson(jsonStr);
    return goalsInfoBean;
  }

  Future<void> sendTrainingDayGoals(DailyGoalsInfoBean dailyGoals) {
    String josnStr = dailyGoalsInfoBeanToJson(dailyGoals);
    return mConnconst.invokeMethod('sendTrainingDayGoals', <String, dynamic>{"dailyGoals": josnStr});
  }

  Future<DailyGoalsInfoBean> get queryTrainingDayGoals async {
    String jsonStr = await mConnconst.invokeMethod('queryTrainingDayGoals');
    DailyGoalsInfoBean goalsInfoBean = dailyGoalsInfoBeanFromJson(jsonStr);
    return goalsInfoBean;
  }

  Future<void> sendTrainingDays(TrainingDayInfoBean trainingDay) {
    String jsonStr = trainingDayInfoBeanToJson(trainingDay);
    return mConnconst.invokeMethod('sendTrainingDays', <String, dynamic>{"trainingDay": jsonStr});
  }

  Future<TrainingDayInfoBean> get queryTrainingDay async {
    String jsonStr = await mConnconst.invokeMethod('queryTrainingDay');
    TrainingDayInfoBean trainingDay = trainingDayInfoBeanFromJson(jsonStr);
    return trainingDay;
  }

  Future<void> sendDisplayWatchFace(int watchFaceType) {
    return mConnconst.invokeMethod('sendDisplayWatchFace', <String, int>{"watchFaceType": watchFaceType});
  }

  Future<int> get queryDisplayWatchFace async {
    int watchFaceType = await mConnconst.invokeMethod('queryDisplayWatchFace');
    return watchFaceType;
  }

  Future<WatchFaceLayoutBean> get queryWatchFaceLayout async {
    String jsonStr = await mConnconst.invokeMethod('queryWatchFaceLayout');
    WatchFaceLayoutBean watchFaceLayoutInfo = watchFaceLayoutBeanFromJson(jsonStr);
    return watchFaceLayoutInfo;
  }

  Future<void> sendWatchFaceLayout(WatchFaceLayoutBean watchFaceLayoutInfo) {
    String jsonStr = watchFaceLayoutBeanToJson(watchFaceLayoutInfo);
    return mConnconst.invokeMethod('sendWatchFaceLayout', <String, String>{"watchFaceLayoutInfo": jsonStr});
  }

  Future<void> sendWatchFaceBackground(WatchFaceBackgroundBean watchFaceBackgroundInfo) {
    String jsonStr = watchFaceBackgroundBeanToJson(watchFaceBackgroundInfo);
    return mConnconst.invokeMethod('sendWatchFaceBackground', <String, String>{"watchFaceBackgroundInfo": jsonStr});
  }

  Future<void> get abortWatchFaceBackground {
    return mConnconst.invokeMethod('abortWatchFaceBackground');
  }

  Stream<FileTransBean> get fileTransEveStm {
    return _bleEveChannels.fileTransEveStm;
  }

  Future<SupportWatchFaceBean> get querySupportWatchFace async {
    String jsonStr = await mConnconst.invokeMethod('querySupportWatchFace');
    SupportWatchFaceBean supportWatchFaceInfo = supportWatchFaceBeanFromJson(jsonStr);
    return supportWatchFaceInfo;
  }

  Future<List<WatchFaceBean>> queryWatchFaceStore(WatchFaceStoreBean watchFaceStoreBean) async {
    String jsonStr = watchFaceStoreBeanToJson(watchFaceStoreBean);
    String str = await mConnconst.invokeMethod('queryWatchFaceStore', <String, String>{"watchFaceStoreBean": jsonStr});
    WatchFaceStoreResultBean watchFaceStore = watchFaceStoreListResultBeanFromJson(str);
    WatchFaceStore watchFaceInfo = watchFaceStore.watchFaceStoreInfo!;
    return watchFaceInfo.list!;
  }

  Future<JieliWatchFaceBean> get queryJieliWatchFaceInfo async {
    String str = await mConnconst.invokeMethod("queryJieliWatchFaceInfo");
    return jieliWatchFaceBeanFromJson(str);
  }

  Future<WatchFaceStoreTagListResult> queryWatchFaceStoreTagList(WatchFaceStoreTagListBean watchFaceStoreTagList) async {
    String jsonStr = watchFaceStoreTagListBeanToJson(watchFaceStoreTagList);
    String str = await mConnconst.invokeMethod("queryWatchFaceStoreTagList", <String, String>{"watchFaceStoreTagList": jsonStr});
    WatchFaceStoreTagListResult watchFaceStoreTagListResult = watchFaceStoreTagListResultFromJson(str);
    return watchFaceStoreTagListResult;
  }

  Future<List<WatchFaceBean>> queryWatchFaceStoreList(WatchFaceStoreListBean watchFaceStoreList) async {
    String jsonStr = watchFaceStoreListBeanToJson(watchFaceStoreList);
    String str = await mConnconst.invokeMethod("queryWatchFaceStoreList", <String, String>{"watchFaceStoreList": jsonStr});
    WatchFaceStoreResultBean watchFaceStore = watchFaceStoreListResultBeanFromJson(str);
    WatchFaceStore watchFaceInfo = watchFaceStore.watchFaceStoreInfo!;
    return watchFaceInfo.list!;
  }

  Future<WatchFaceDetailResultBean> queryWatchFaceDetail(WatchFaceStoreTypeBean watchFaceStoreType) async {
    String jsonStr = watchFaceStoreTypeBeanToJson(watchFaceStoreType);
    String str = await mConnconst.invokeMethod("queryWatchFaceDetail", <String, String>{"watchFaceStoreTagList": jsonStr});
    return watchFaceDetailResultBeanFromJson(str);
  }

  Future<WatchFaceIdBean> queryWatchFaceOfID(int id) async {
    String jsonStr = await mConnconst.invokeMethod('queryWatchFaceOfID', <String, int>{"id": id});
    WatchFaceIdBean? watchFaceId = watchFaceIdBeanFromJson(jsonStr);
    return watchFaceId;
  }

  Future<void> sendWatchFace(SendWatchFaceBean sendWatchFaceBean) {
    String jsonStr = sendWatchFaceBeanToJson(sendWatchFaceBean);
    return mConnconst.invokeMethod('sendWatchFace', <String, String>{"sendWatchFaceBean": jsonStr});
  }

  Future<void> sendWatchFaceId(int id) {
    return mConnconst.invokeMethod("sendWatchFaceId", <String, int>{"id": id});
  }

  Future<void> get abortWatchFace {
    return mConnconst.invokeMethod('abortWatchFace');
  }

  Future<void> deleteWatchFace(int id) {
    return mConnconst.invokeMethod('deleteWatchFace', <String, int>{"id": id});
  }

  Future<int>  queryAvailableStorage(int type) async {
    return await mConnconst.invokeMethod("queryAvailableStorage", <String, int>{"id": type});
  }

  Stream<FileTransBean> get wfFileTransEveStm {
    return _bleEveChannels.wfFileTransEveStm;
  }

  // Future<void> sendAlarm(AlarmClockBean alarmInfo) {
  //   String jsonStr = alarmClockBeanToJson(alarmInfo);
  //   return mConnconst.invokeMethod('sendAlarm', <String, String>{"alarmClockInfo": jsonStr});
  // }
  //
  // Future<List<AlarmClockBean>> get queryAllAlarm async {
  //   String jsonStr = await mConnconst.invokeMethod('queryAllAlarm');
  //   var listDynamic = jsonDecode(jsonStr);
  //   List<AlarmClockBean> listStr = (listDynamic as List<dynamic>).map((e) => AlarmClockBean.fromJson((e as Map<String, dynamic>))).toList();
  //
  //   return listStr;
  // }

  Future<void> sendNewAlarm(AlarmClockBean alarmInfo) {
    String jsonStr = alarmClockBeanToJson(alarmInfo);
    return mConnconst.invokeMethod("sendNewAlarm", <String, String>{"alarmClockInfo": jsonStr});
  }

  Future<void> deleteNewAlarm(int id) {
    return mConnconst.invokeMethod("deleteNewAlarm", <String, int>{"id": id});
  }

  Future<void> deleteAllNewAlarm() {
    return mConnconst.invokeMethod("deleteAllNewAlarm");
  }

  Future<AlarmBean> get queryAllNewAlarm async {
    String jsonStr = await mConnconst.invokeMethod("queryAllNewAlarm");
    return alarmBeanFromJson(jsonStr);
  }

  Stream<HeartRateBean> get heartRateEveStm {
    return _bleEveChannels.heartRateEveStm;
  }

  Future<void> queryLastDynamicRate(String type) {
    return mConnconst.invokeMethod('queryLastDynamicRate', <String, String>{"type": type});
  }

  Future<void> enableTimingMeasureHeartRate(int interval) {
    return mConnconst.invokeMethod('enableTimingMeasureHeartRate', <String, int>{"interval": interval});
  }

  Future<void> get disableTimingMeasureHeartRate {
    return mConnconst.invokeMethod('disableTimingMeasureHeartRate');
  }

  Future<int> get queryTimingMeasureHeartRate async {
    int timeHR = await mConnconst.invokeMethod('queryTimingMeasureHeartRate');
    return timeHR;
  }

  Future<void> queryTodayHeartRate(int heartRateType) {
    return mConnconst.invokeMethod('queryTodayHeartRate', <String, int>{"heartRateType": heartRateType});
  }

  Future<void> queryPastHeartRate(int historyDay) {
    return mConnconst.invokeMethod('queryPastHeartRate', <String, int>{"historyDay": historyDay});
  }

  Future<void> get queryTrainingHeartRate {
    return mConnconst.invokeMethod('queryTrainingHeartRate');
  }

  Future<void> get startMeasureOnceHeartRate {
    return mConnconst.invokeMethod('startMeasureOnceHeartRate');
  }

  Future<void> get stopMeasureOnceHeartRate {
    return mConnconst.invokeMethod('stopMeasureOnceHeartRate');
  }

  Future<void> get queryHistoryHeartRate {
    return mConnconst.invokeMethod('queryHistoryHeartRate');
  }

  Future<int> queryAverageHeartRate(int newStartTime, int newEndTime, List list) async {
    var start = newStartTime * 1000;
    var end = newEndTime * 1000;

    DateTime startTime = DateTime.fromMillisecondsSinceEpoch(start);
    DateTime endTime = DateTime.fromMillisecondsSinceEpoch(end);

    var initTime = getInitTime(startTime);
    var startIndex = getIndex(initTime, startTime);
    var endIndex = getIndex(initTime, endTime);
    int? sum = 0;
    for (int i = startIndex; i <= endIndex; i++) {
      sum = (sum! + list[i]) as int?;
    }
    var mean = sum! ~/ (endIndex - startIndex + 1);
    return mean;
  }

  DateTime getInitTime(DateTime dateTime) {
    var year = dateTime.year;
    var month = dateTime.month;
    var day = dateTime.day;
    return DateTime(year, month, day);
  }

  int getIndex(DateTime initTime, DateTime currentTime) {
    return currentTime.difference(initTime).inMinutes;
  }

  Stream<BloodPressureBean> get bloodPressureEveStm {
    return _bleEveChannels.bloodPressureEveStm;
  }

  Future<void> get startMeasureBloodPressure {
    return mConnconst.invokeMethod('startMeasureBloodPressure');
  }

  Future<void> get stopMeasureBloodPressure {
    return mConnconst.invokeMethod('stopMeasureBloodPressure');
  }

  Future<void> get enableContinueBloodPressure {
    return mConnconst.invokeMethod('enableContinueBloodPressure');
  }

  Future<void> get disableContinueBloodPressure {
    return mConnconst.invokeMethod('disableContinueBloodPressure');
  }

  Future<void> get queryContinueBloodPressureState {
    return mConnconst.invokeMethod('queryContinueBloodPressureState');
  }

  Future<void> get queryLast24HourBloodPressure {
    return mConnconst.invokeMethod('queryLast24HourBloodPressure');
  }

  Future<void> get queryHistoryBloodPressure {
    return mConnconst.invokeMethod('queryHistoryBloodPressure');
  }

  Stream<BloodOxygenBean> get bloodOxygenEveStm {
    return _bleEveChannels.bloodOxygenEveStm;
  }

  Future<void> get startMeasureBloodOxygen {
    return mConnconst.invokeMethod('startMeasureBloodOxygen');
  }

  Future<void> get stopMeasureBloodOxygen {
    return mConnconst.invokeMethod('stopMeasureBloodOxygen');
  }

  Future<void> enableTimingMeasureBloodOxygen(int interval) {
    return mConnconst.invokeMethod('enableTimingMeasureBloodOxygen', <String, int>{"interval": interval});
  }

  Future<void> get disableTimingMeasureBloodOxygen {
    return mConnconst.invokeMethod('disableTimingMeasureBloodOxygen');
  }

  Future<void> get queryTimingBloodOxygenMeasureState {
    return mConnconst.invokeMethod('queryTimingBloodOxygenMeasureState');
  }

  Future<void> queryTimingBloodOxygen(String bloodOxygenTimeType) {
    return mConnconst.invokeMethod('queryTimingBloodOxygen', <String, String>{"bloodOxygenTimeType": bloodOxygenTimeType});
  }

  Future<void> get enableContinueBloodOxygen {
    return mConnconst.invokeMethod('enableContinueBloodOxygen');
  }

  Future<void> get disableContinueBloodOxygen {
    return mConnconst.invokeMethod('disableContinueBloodOxygen');
  }

  Future<void> get queryContinueBloodOxygenState {
    return mConnconst.invokeMethod('queryContinueBloodOxygenState');
  }

  Future<void> get queryLast24HourBloodOxygen {
    return mConnconst.invokeMethod('queryLast24HourBloodOxygen');
  }

  Future<void> get queryHistoryBloodOxygen {
    return mConnconst.invokeMethod('queryHistoryBloodOxygen');
  }

  Future<void> get enterCameraView {
    return mConnconst.invokeMethod('enterCameraView');
  }

  Future<void> get exitCameraView {
    return mConnconst.invokeMethod('exitCameraView');
  }

  Stream<CameraBean> get cameraEveStm {
    return _bleEveChannels.cameraEveStm;
  }

  Stream<int> get phoneEveStm {
    return _bleEveChannels.phoneEveStm;
  }

  Stream<int> get deviceRssiEveStm {
    return _bleEveChannels.deviceRssiEveStm;
  }

  Future<void> get readDeviceRssi {
    return mConnconst.invokeMethod('readDeviceRssi');
  }

  Future<void> setECGChangeListener(String ecgMeasureType) {
    return mConnconst.invokeMethod('setECGChangeListener', <String, String>{"ecgMeasureType": ecgMeasureType});
  }

  Stream<EcgBean> get ecgEveStm {
    return _bleEveChannels.ecgEveStm;
  }

  Future<void> get startECGMeasure {
    return mConnconst.invokeMethod('startECGMeasure');
  }

  Future<void> get stopECGMeasure {
    return mConnconst.invokeMethod('stopECGMeasure');
  }

  Future<bool> get isNewECGMeasurementVersion async {
    bool newMeasurementVersion = await mConnconst.invokeMethod('isNewECGMeasurementVersion');
    return newMeasurementVersion;
  }

  Future<void> get queryLastMeasureECGData {
    return mConnconst.invokeMethod('queryLastMeasureECGData');
  }

  Future<void> sendECGHeartRate(int heartRate) {
    return mConnconst.invokeMethod('sendECGHeartRate', <String, int>{"heartRate": heartRate});
  }

  Stream<FileTransBean> get contactAvatarEveStm {
    return _bleEveChannels.tactAvatarEveStm;
  }

  Future<void> sendDeviceLanguage(int language) {
    return mConnconst.invokeMethod('sendDeviceLanguage', <String, int>{"language": language});
  }

  Future<int> get queryDeviceVersion async {
    return await mConnconst.invokeMethod("queryDeviceVersion");
  }

  Future<DeviceLanguageBean> get queryDeviceLanguage async {
    String jsonStr = await mConnconst.invokeMethod('queryDeviceLanguage');
    DeviceLanguageBean deviceLanguage = deviceLanguageBeanFromJson(jsonStr);
    return deviceLanguage;
  }

  Future<void> sendOtherMessageState(bool state) {
    return mConnconst.invokeMethod("sendOtherMessageState", <String, bool>{"state": state});
  }

  Future<bool> get queryOtherMessageState async {
    return await mConnconst.invokeMethod("queryOtherMessageState");
  }

  Future<void> sendMessage(MessageBean messageInfo) {
    String jsonStr = messageBeanToJson(messageInfo);
    return mConnconst.invokeMethod('sendMessage', <String, String>{"messageInfo": jsonStr});
  }

  Future<void> get endCall {
    return mConnconst.invokeMethod('endCall');
  }

  Future<void> sendCallContactName(String name) {
    return mConnconst.invokeMethod("sendCallContactName", <String, String>{"name": name});
  }

  Future<List<int>> get queryMessageList async {
    String jsonStr = await mConnconst.invokeMethod("queryMessageList");
    List<int> list = jsonStr.split(",").map((e) => int.parse(e)).toList();
    return list;
  }

  Stream<String> get callNumberEveStm {
    return _bleEveChannels.callNumberEveStm;
  }

  Future<void> setNotification(List<int> list) {
    return mConnconst.invokeMethod('setNotification', <String, List<int>>{"list": list});
  }

  Future<NotificationBean> get getNotification async {
    String str = await mConnconst.invokeMethod('getNotification');
    return notificationBeanFromJson(str);
  }

  Future<void> sendSedentaryReminder(bool sedentaryReminder) {
    return mConnconst.invokeMethod('sendSedentaryReminder', <String, bool>{"sedentaryReminder": sedentaryReminder});
  }

  Future<bool> get querySedentaryReminder async {
    bool sedentaryReminder = await mConnconst.invokeMethod('querySedentaryReminder');
    return sedentaryReminder;
  }

  Future<void> sendSedentaryReminderPeriod(SedentaryReminderPeriodBean sedentaryReminderPeriodInfo) {
    String jsonStr = sedentaryReminderPeriodBeanToJson(sedentaryReminderPeriodInfo);
    return mConnconst.invokeMethod('sendSedentaryReminderPeriod', <String, String>{"sedentaryReminderPeriodInfo": jsonStr});
  }

  Future<SedentaryReminderPeriodBean> get querySedentaryReminderPeriod async {
    String jsonStr = await mConnconst.invokeMethod('querySedentaryReminderPeriod');
    SedentaryReminderPeriodBean sedentaryReminderPeriodInfo = sedentaryReminderPeriodBeanFromJson(jsonStr);
    return sedentaryReminderPeriodInfo;
  }

  Future<void> get findDevice {
    return mConnconst.invokeMethod('findDevice');
  }

  Future<void> get shutDown {
    return mConnconst.invokeMethod('shutDown');
  }

  Future<void> get reset {
    return mConnconst.invokeMethod("reset");
  }

  Future<PeriodTimeResultBean> get queryDoNotDisturbTime async {
    String jsonStr = await mConnconst.invokeMethod('queryDoNotDisturbTime');
    PeriodTimeResultBean doNotDisturbTime = periodTimeResultBeanFromJson(jsonStr);
    return doNotDisturbTime;
  }

  Future<void> sendDoNotDisturbTime(PeriodTimeBean periodTimeInfo) {
    String jsonStr = periodTimeBeanToJson(periodTimeInfo);
    return mConnconst.invokeMethod('sendDoNotDisturbTime', <String, String>{"periodTimeInfo": jsonStr});
  }

  Future<void> sendBreathingLight(bool breathingLight) {
    return mConnconst.invokeMethod('sendBreathingLight', <String, bool>{"breathingLight": breathingLight});
  }

  Future<bool> get queryBreathingLight async {
    bool breathingLight = await mConnconst.invokeMethod('queryBreathingLight');
    return breathingLight;
  }

  Future<void> sendMenstrualCycle(MenstrualCycleBean info) {
    String jsonStr = menstrualCycleBeanToJson(info);
    return mConnconst.invokeMethod("sendMenstrualCycle", <String, String>{"menstrualCycleBean": jsonStr});
  }

  Future<MenstrualCycleBean> get queryMenstrualCycle async {
    String resultJson = await mConnconst.invokeMethod("queryMenstrualCycle");
    MenstrualCycleBean physiologcalPeriodBean = menstrualCycleBeanFromJson(resultJson);
    return physiologcalPeriodBean;
  }

  Future<void> get startFindPhone {
    return mConnconst.invokeMethod("startFindPhone");
  }

  Future<void> get stopFindPhone {
    return mConnconst.invokeMethod("stopFindPhone");
  }

  Stream<FindPhoneBean> get findPhoneEveStm {
    return _bleEveChannels.findPhoneEveStm;
  }

  Future<void> setPlayerState(int musicPlayer) {
    return mConnconst.invokeMethod("setPlayerState", <String, int>{"musicPlayerStateType": musicPlayer});
  }

  Future<void> sendSongTitle(String title) {
    return mConnconst.invokeMethod("sendSongTitle", <String, String>{"title": title});
  }

  Future<void> sendLyrics(String lyrics) {
    return mConnconst.invokeMethod("sendLyrics", <String, String>{"lyrics": lyrics});
  }

  Future<void> get closePlayerControl {
    return mConnconst.invokeMethod("closePlayerControl");
  }

  Future<void> sendCurrentVolume(int volume) {
    return mConnconst.invokeMethod("sendCurrentVolume", <String, int>{"volume": volume});
  }

  Future<void> sendMaxVolume(int volume) {
    return mConnconst.invokeMethod("sendMaxVolume", <String, int>{"volume": volume});
  }

  Future<void> enableDrinkWaterReminder(DrinkWaterPeriodBean drinkWaterPeriodInfo) {
    String jsonStr = drinkWaterPeriodBeanToJson(drinkWaterPeriodInfo);
    return mConnconst.invokeMethod('enableDrinkWaterReminder', <String, String>{"drinkWaterPeriodInfo": jsonStr});
  }

  Future<void> get disableDrinkWaterReminder {
    return mConnconst.invokeMethod("disableDrinkWaterReminder");
  }

  Future<DrinkWaterPeriodBean> get queryDrinkWaterReminderPeriod async {
    String jsonStr = await mConnconst.invokeMethod("queryDrinkWaterReminderPeriod");
    return drinkWaterPeriodBeanFromJson(jsonStr);
  }

  Future<void> setMaxHeartRate(MaxHeartRateBean maxHeartRateBean) {
    String jsonStr = maxHeartRateBeanToJson(maxHeartRateBean);
    return mConnconst.invokeMethod("setMaxHeartRate", <String, String>{"maxHeartRateBean": jsonStr});
  }

  Future<MaxHeartRateBean> get queryMaxHeartRate async {
    String jsonStr = await mConnconst.invokeMethod("queryMaxHeartRate");
    MaxHeartRateBean maxHeartRate = maxHeartRateBeanFromJson(jsonStr);
    return maxHeartRate;
  }

  Future<void> startTraining(int type) {
    return mConnconst.invokeMethod("startTraining", <String, int>{"type": type});
  }

  Future<void> setTrainingState(int training) {
    return mConnconst.invokeMethod("setTrainingState", <String, int>{"training": training});
  }

  Stream<int> get trainingStateEveStm {
    return _bleEveChannels.trainingStateEveStm;
  }

  Future<String> get getProtocolVersion async {
    String protocolVersion = await mConnconst.invokeMethod("getProtocolVersion");
    return protocolVersion;
  }

  Future<void> get startMeasureTemp {
    return mConnconst.invokeMethod("startMeasureTemp");
  }

  Future<void> get stopMeasureTemp {
    return mConnconst.invokeMethod("stopMeasureTemp");
  }

  Future<void> get enableTimingMeasureTemp {
    return mConnconst.invokeMethod("enableTimingMeasureTemp");
  }

  Future<void> get disableTimingMeasureTemp {
    return mConnconst.invokeMethod("disableTimingMeasureTemp");
  }

  Future<String> get queryTimingMeasureTempState async {
    String tempState = await mConnconst.invokeMethod("queryTimingMeasureTempState");
    return tempState;
  }

  Future<void> queryTimingMeasureTemp(String tempTimeType) {
    return mConnconst.invokeMethod("queryTimingMeasureTemp", <String, String>{"tempTimeType": tempTimeType});
  }

  Future<void> get sendGsensorCalibration {
    return mConnconst.invokeMethod("sendGsensorCalibration");
  }

  Future<void> get enableContinueTemp {
    return mConnconst.invokeMethod("enableContinueTemp");
  }

  Future<void> get disableContinueTemp {
    return mConnconst.invokeMethod("disableContinueTemp");
  }

  Future<void> get queryContinueTempState {
    return mConnconst.invokeMethod("queryContinueTempState");
  }

  Future<void> get queryLast24HourTemp {
    return mConnconst.invokeMethod("queryLast24HourTemp");
  }

  Stream<TempChangeBean> get tempChangeEveStm {
    return _bleEveChannels.tempChangeEveStm;
  }

  Future<void> sendDisplayTime(int time) {
    return mConnconst.invokeMethod("sendDisplayTime", <String, int>{"time": time});
  }

  Future<int> get queryDisplayTime async {
    int time = await mConnconst.invokeMethod("queryDisplayTime");
    return time;
  }

  Future<void> enableHandWashingReminder(HandWashingPeriodBean handWashingPeriodInfo) {
    String jsonStr = handWashingPeriodBeanToJson(handWashingPeriodInfo);
    return mConnconst.invokeMethod("enableHandWashingReminder", <String, String>{"handWashingPeriodInfo": jsonStr});
  }

  Future<void> get disableHandWashingReminder {
    return mConnconst.invokeMethod("disableHandWashingReminder");
  }

  Future<HandWashingPeriodBean> get queryHandWashingReminderPeriod async {
    String period = await mConnconst.invokeMethod("queryHandWashingReminderPeriod");
    return handWashingPeriodBeanFromJson(period);
  }

  Future<void> sendLocalCity(String city) {
    return mConnconst.invokeMethod("sendLocalCity", <String, String>{"city": city});
  }

  Future<void> sendTempUnit(int temp) {
    return mConnconst.invokeMethod("sendTempUnit", <String, int>{"temp": temp});
  }

  Future<void> get queryTempUnit {
    return mConnconst.invokeMethod("queryTempUnit");
  }

  Future<void> sendBrightness(int brightness) {
    return mConnconst.invokeMethod("sendBrightness", <String, int>{"brightness": brightness});
  }

  Future<BrightnessBean> get queryBrightness async {
    String jsonStr = await mConnconst.invokeMethod("queryBrightness");
    BrightnessBean brightness = brightnessBeanFromJson(jsonStr);
    return brightness;
  }

  Future<String> get queryBtAddress async {
    String address = await mConnconst.invokeMethod("queryBtAddress");
    return address;
  }

  Future<ContactConfigBean> get checkSupportQuickContact async {
    String jsonStr = await mConnconst.invokeMethod("checkSupportQuickContact");
    ContactConfigBean contactConfigBean = contactConfigBeanFromJson(jsonStr);
    return contactConfigBean;
  }

  Future<int> get queryContactCount async {
    int count = await mConnconst.invokeMethod("queryContactCount");
    return count;
  }

  Stream<ContactListenBean> get contactEveStm {
    return _bleEveChannels.tactEveStm;
  }

  Future<bool> get queryContactNumberSymbol async {
    return await mConnconst.invokeMethod("queryContactNumberSymbol");
  }

  Future<void> sendContact(ContactBean info) {
    String jsonStr = contactBeanToJson(info);
    return mConnconst.invokeMethod("sendContact", <String, String>{"contactBean": jsonStr});
  }

  Future<void> sendContactAvatar(ContactBean info) {
    String jsonStr = contactBeanToJson(info);
    return mConnconst.invokeMethod("sendContactAvatar", <String, String>{"contactAvatarBean": jsonStr});
  }

  Future<void> deleteContact(int index) {
    return mConnconst.invokeMethod("deleteContact", <String, int>{"index": index});
  }

  Future<void> deleteContactAvatar(int index) {
    return mConnconst.invokeMethod("deleteContactAvatar", <String, int>{"index": index});
  }

  Future<void> clearContact() {
    return mConnconst.invokeMethod("clearContact");
  }

  Stream<bool> get batterySavingEveStm {
    return _bleEveChannels.batterySavingEveStm;
  }

  Future<void> sendBatterySaving(bool enable) {
    return mConnconst.invokeMethod("sendBatterySaving", <String, bool>{"enable": enable});
  }

  Future<void> get queryBatterySaving {
    return mConnconst.invokeMethod("queryBatterySaving");
  }

  Future<PillReminderCallback> get queryPillReminder async {
    String jsonStr = await mConnconst.invokeMethod("queryPillReminder");
    PillReminderCallback pillReminderCallback = pillReminderCallbackFromJson(jsonStr);
    return pillReminderCallback;
  }

  Future<void> sendPillReminder(PillReminderBean info) {
    String jsonStr = pillReminderBeanToJson(info);
    return mConnconst.invokeMethod("sendPillReminder", <String, String>{"pillReminderInfo": jsonStr});
  }

  Future<void> deletePillReminder(int id) {
    return mConnconst.invokeMethod("deletePillReminder", <String, int>{"id": id});
  }

  Future<void> get clearPillReminder {
    return mConnconst.invokeMethod("clearPillReminder");
  }

  Future<bool> get queryWakeState async {
    bool state = await mConnconst.invokeMethod("queryWakeState");
    return state;
  }

  Future<void> sendWakeState(bool enable) {
    return mConnconst.invokeMethod("sendWakeState", <String, bool>{"enable": enable});
  }

  Stream<TrainBean> get trainingEveStm {
    return _bleEveChannels.trainingEveStm;
  }

  Future<void> get queryHistoryTraining {
    return mConnconst.invokeMethod("queryHistoryTraining");
  }

  Future<void> queryTraining(int id) {
    return mConnconst.invokeMethod("queryTraining", <String, int>{"id": id});
  }

  Stream<dynamic> get sosChangeEveStm {
    return _bleEveChannels.sosChangeEveStm;
  }

  Future<int> createBond(List<int> keys) async {
    String keysStr = keys.join();
    return await mConnconst.invokeMethod("createBond", <String, String>{'keys': keysStr});
  }

  Stream<HrvHandlerBean> get newHrvEveStm {
    return _bleEveChannels.newHrvEveStm;
  }

  Future<void> get querySupportNewHrv {
    return mConnconst.invokeMethod("querySupportNewHrv");
  }

  Future<void> get startMeasureNewHrv {
    return mConnconst.invokeMethod("startMeasureNewHrv");
  }

  Future<void> get stopMeasureNewHrv {
    return mConnconst.invokeMethod("stopMeasureNewHrv");
  }

  Future<void> get queryHistoryNewHrv {
    return mConnconst.invokeMethod("queryHistoryNewHrv");
  }

  Stream<StressHandlerBean> get stressEveStm {
    return _bleEveChannels.stressEveStm;
  }

  Future<void> get querySupportStress {
    return mConnconst.invokeMethod("querySupportStress");
  }

  Future<void> get startMeasureStress {
    return mConnconst.invokeMethod("startMeasureStress");
  }

  Future<void> get stopMeasureStress {
    return mConnconst.invokeMethod("stopMeasureStress");
  }

  Future<void> get queryHistoryStress {
    return mConnconst.invokeMethod("queryHistoryStress");
  }

  Future<void> get enableTimingStress {
    return mConnconst.invokeMethod("enableTimingStress");
  }

  Future<void> get disableTimingStress {
    return mConnconst.invokeMethod("disableTimingStress");
  }

  Future<void> get queryTimingStressState {
    return mConnconst.invokeMethod("queryTimingStressState");
  }

  Future<void> queryTimingStress(String stressDate) {
    return mConnconst.invokeMethod("queryTimingStress", <String, String>{"stressDate": stressDate});
  }

  Future<ElectronicCardCountInfoBean> get queryElectronicCardCount async {
    String jsonStr = await mConnconst.invokeMethod("queryElectronicCardCount");
    ElectronicCardCountInfoBean electronicCardCountInfo = electronicCardCountInfoBeanFromJson(jsonStr);
    return electronicCardCountInfo;
  }

  Future<void> sendElectronicCard(ElectronicCardInfoBean electronicCardInfo) {
    String jsonStr = electronicCardInfoBeanToJson(electronicCardInfo);
    return mConnconst.invokeMethod("sendElectronicCard", <String, String>{"electronicCardInfo": jsonStr});
  }

  Future<void> deleteElectronicCard(int id) {
    return mConnconst.invokeMethod("deleteElectronicCard", <String, int>{"id": id});
  }

  Future<ElectronicCardInfoBean> queryElectronicCard(int id) async {
    String jsonStr = await mConnconst.invokeMethod("queryElectronicCard", <String, int>{"id": id});
    ElectronicCardInfoBean electronicCardInfo = electronicCardInfoBeanFromJson(jsonStr);
    return electronicCardInfo;
  }

  Future<void> sendElectronicCardList(List idList) {
    String idListStr = jsonEncode(idList);
    return mConnconst.invokeMethod("sendElectronicCardList", <String, String>{"idList": idListStr});
  }

  Stream<CalendarEventBean> get calendarEventEveStem {
    return _bleEveChannels.calendarEventEveStem;
  }

  Future<void> get querySupportCalendarEvent {
    return mConnconst.invokeMethod("querySupportCalendarEvent");
  }

  Future<void> sendCalendarEvent(CalendarEventInfoBean calenderEventInfo) {
    String jsonStr = calendarEventInfoBeanToJson(calenderEventInfo);
    return mConnconst.invokeMethod("sendCalendarEvent", <String, String>{"calenderEventInfo": jsonStr});
  }

  Future<void> deleteCalendarEvent(int id) {
    return mConnconst.invokeMethod("deleteCalendarEvent", <String, int>{"id": id});
  }

  Future<void> queryCalendarEvent(int id) {
    return mConnconst.invokeMethod("queryCalendarEvent", <String, int>{"id": id});
  }

  Future<void> sendCalendarEventReminderTime(CalendarEventReminderTimeBean calendarEventReminderTime) {
    String jsonStr = calendarEventReminderTimeBeanToJson(calendarEventReminderTime);
    return mConnconst.invokeMethod("sendCalendarEventReminderTime", <String, String>{"calendarEventReminderTime": jsonStr});
  }

  Future<void> get queryCalendarEventReminderTime {
    return mConnconst.invokeMethod("queryCalendarEventReminderTime");
  }

  Future<void> get clearCalendarEvent {
    return mConnconst.invokeMethod("clearCalendarEvent");
  }

  Stream<int> get gpsChangeEveStm {
    return _bleEveChannels.gpsChangeEveStm;
  }

  Future<void> get queryHistoryGps {
    return mConnconst.invokeMethod("queryHistoryGps");
  }

  Future<void> queryGpsDetail(int seconds) {
    return mConnconst.invokeMethod("queryHistoryGps", <String, int>{"seconds": seconds});
  }

  Future<void> sendVibrationStrength(int value) {
    return mConnconst.invokeMethod("sendVibrationStrength", <String, int>{"value": value});
  }

  Future<VibrationStrength> get queryVibrationStrength async {
    String jsonStr = await mConnconst.invokeMethod("queryVibrationStrength");
    return vibrationStrengthFromJson(jsonStr);
  }

  Future<bool> uploadLocalFile(String filePath) async {
    File file = File(filePath);
    if (await file.exists()) {
      CustomizeWatchFaceBean bean = CustomizeWatchFaceBean(file: filePath, index: 5);

      /// 调用表盘上传接口
      try {
        // print("开始上传");
        await sendWatchFace(SendWatchFaceBean(watchFaceFlutterBean: bean, timeout: 30));
        return true;
      } catch (e) {
        // print(e);
        // print("上传超时");
        return false;
      }
    } else {
      // print("没有这个文件");
      return false;
    }
  }

  Future<bool> enableIncomingNumber(bool enable) async {
    return await mConnconst.invokeMethod("enableIncomingNumber", <String, bool>{"enableIncoming": enable});
  }
}
