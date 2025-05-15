import 'dart:convert';

import 'dart:typed_data';
import 'dart:ui';

ConnectBean connectBeanFromJson(String str) => ConnectBean.fromJson(json.decode(str));

String connectBeanToJson(ConnectBean data) => json.encode(data.toJson());

class ConnectBean {
  bool autoConnect;
  String address;
  String? uuid;

  ConnectBean({
    required this.autoConnect,
    required this.address,
    this.uuid,
  });

  factory ConnectBean.fromJson(Map<String, dynamic> json) => ConnectBean(
        autoConnect: json["autoConnect"],
        address: json["address"],
        uuid: json["uuid"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "autoConnect": autoConnect,
        "address": address,
        "uuid": uuid,
      };
}

ConnectStateBean connectStateBeanFromJson(String str) => ConnectStateBean.fromJson(json.decode(str));

String connectStateBeanToJson(ConnectStateBean data) => json.encode(data.toJson());

class ConnectStateBean {
  bool autoConnect;
  int connectState;

  ConnectStateBean({
    required this.autoConnect,
    required this.connectState,
  });

  factory ConnectStateBean.fromJson(Map<String, dynamic> json) => ConnectStateBean(
        autoConnect: json["autoConnect"] ?? false,
        connectState: json["connectState"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "autoConnect": autoConnect,
        "connectState": connectState,
      };
}

ConnectDeviceBean connectDeviceBeanFromJson(String str) => ConnectDeviceBean.fromJson(json.decode(str));

String connectDeviceBeanToJson(ConnectDeviceBean data) => json.encode(data.toJson());

class ConnectDeviceBean {
  ConnectDeviceBean({
    required this.address,
    required this.peripheral,
    required this.autoConnect,
  });

  String address;
  dynamic peripheral;
  bool autoConnect;

  factory ConnectDeviceBean.fromJson(Map<String, dynamic> json) => ConnectDeviceBean(
        address: json["address"],
        peripheral: json["peripheral"] ?? " ",
        autoConnect: json["autoConnect"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "address": address,
        "peripheral": peripheral,
        "autoConnect": autoConnect,
      };
}

BleScanBean bleScanBeanFromJson(String str) => BleScanBean.fromJson(json.decode(str));

String bleScanEventToJson(BleScanBean data) => json.encode(data.toJson());

class BleScanBean {
  BleScanBean({
    required this.isCompleted,
    required this.address,
    required this.mRssi,
    required this.mScanRecord,
    required this.name,
    required this.platform,
  });

  bool isCompleted;
  String address;
  int mRssi;
  List<int> mScanRecord;
  String name;
  int platform;

  factory BleScanBean.fromJson(Map<String, dynamic> json) => BleScanBean(
        isCompleted: json["isCompleted"],
        address: json["address"],
        mRssi: json["mRssi"],
        mScanRecord: List<int>.from(json["mScanRecord"].map((x) => x)),
        name: json["name"],
        platform: json["platform"],
      );

  Map<String, dynamic> toJson() => {
        "isCompleted": isCompleted,
        "address": address,
        "mRssi": mRssi,
        "mScanRecord": List<dynamic>.from(mScanRecord.map((x) => x)),
        "name": name,
        "platform": platform,
      };
}

CheckFirmwareVersionBean checkFirmwareVersionBeanFromJson(String str) => CheckFirmwareVersionBean.fromJson(json.decode(str));

String checkFirmwareVersionBeanToJson(CheckFirmwareVersionBean data) => json.encode(data.toJson());

class CheckFirmwareVersionBean {
  CheckFirmwareVersionBean({
    required this.firmwareVersionInfo,
    required this.isLatestVersion,
  });

  FirmwareVersionBean? firmwareVersionInfo;
  bool? isLatestVersion;

  factory CheckFirmwareVersionBean.fromJson(Map<String, dynamic> json) => CheckFirmwareVersionBean(
        firmwareVersionInfo: FirmwareVersionBean.fromJson(json["firmwareVersionInfo"] ?? {}),
        isLatestVersion: json["isLatestVersion"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "firmwareVersionInfo": firmwareVersionInfo!.toJson(),
        "isLatestVersion": isLatestVersion!,
      };
}

FirmwareVersionBean firmwareVersionInfoFromJson(String str) => FirmwareVersionBean.fromJson(json.decode(str));

String firmwareVersionInfoToJson(FirmwareVersionBean data) => json.encode(data.toJson());

class FirmwareVersionBean {
  FirmwareVersionBean({
    required this.changeNotes,
    required this.changeNotesEn,
    required this.mcu,
    required this.tpUpgrade,
    required this.type,
    required this.version,
  });

  String? changeNotes;
  String? changeNotesEn;
  int? mcu;
  bool? tpUpgrade;
  int? type;
  String? version;

  factory FirmwareVersionBean.fromJson(Map<String, dynamic> json) => FirmwareVersionBean(
        changeNotes: json["changeNotes"],
        changeNotesEn: json["changeNotesEn"],
        mcu: json["mcu"],
        tpUpgrade: json["tpUpgrade"],
        type: json["type"],
        version: json["version"],
      );

  Map<String, dynamic> toJson() => {
        "changeNotes": changeNotes,
        "changeNotesEn": changeNotesEn,
        "mcu": mcu,
        "tpUpgrade": tpUpgrade,
        "type": type,
        "version": version,
      };
}

UserBean userBeanFromJson(String str) => UserBean.fromJson(json.decode(str));

String userBeanToJson(UserBean data) => json.encode(data.toJson());

class UserBean {
  static const int male = 0;
  static const int female = 1;

  UserBean({
    required this.weight,
    required this.height,
    required this.gender,
    required this.age,
  });

  int? weight;
  int? height;
  int? gender;
  int? age;

  factory UserBean.fromJson(Map<String, dynamic> json) => UserBean(
        weight: json["weight"] ?? -1,
        height: json["height"] ?? -1,
        gender: json["gender"] ?? -1,
        age: json["age"] ?? -1,
      );

  Map<String, dynamic> toJson() => {
        "weight": weight,
        "height": height,
        "gender": gender,
        "age": age,
      };
}

TodayWeatherBean todayWeatherBeanFromJson(String str) => TodayWeatherBean.fromJson(json.decode(str));

String todayWeatherBeanToJson(TodayWeatherBean data) => json.encode(data.toJson());

class TodayWeatherBean {
  TodayWeatherBean({
    required this.city,
    required this.lunar,
    required this.festival,
    required this.pm25,
    required this.temp,
    required this.weatherId,
  });

  String? city;
  String? lunar;
  String? festival;
  int? pm25;
  int? temp;
  int? weatherId;

  factory TodayWeatherBean.fromJson(Map<String, dynamic> json) => TodayWeatherBean(
        city: json["city"] ?? "",
        lunar: json["lunar"] ?? "",
        festival: json["festival"] ?? "",
        pm25: json["pm25"] ?? -1,
        temp: json["temp"] ?? -1,
        weatherId: json["weatherId"] ?? -1,
      );

  Map<String, dynamic> toJson() => {
        "city": city,
        "lunar": lunar,
        "festival": festival,
        "pm25": pm25,
        "temp": temp,
        "weatherId": weatherId,
      };
}

FutureWeatherListBean futureWeatherListBeanFromJson(String str) => FutureWeatherListBean.fromJson(json.decode(str));

String futureWeatherListBeanToJson(FutureWeatherListBean data) => json.encode(data.toJson());

class FutureWeatherListBean {
  FutureWeatherListBean({
    required this.future,
  });

  List<FutureWeatherBean> future;

  factory FutureWeatherListBean.fromJson(Map<String, dynamic> json) => FutureWeatherListBean(
        future: List<FutureWeatherBean>.from(json["future"].map((x) => FutureWeatherBean.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "future": List<dynamic>.from(future.map((x) => x.toJson())),
      };
}

class FutureWeatherBean {
  FutureWeatherBean({
    required this.weatherId,
    required this.lowTemperature,
    required this.highTemperature,
  });

  int weatherId;
  int lowTemperature;
  int highTemperature;

  factory FutureWeatherBean.fromJson(Map<String, dynamic> json) => FutureWeatherBean(
        weatherId: json["weatherId"],
        lowTemperature: json["lowTemperature"],
        highTemperature: json["highTemperature"],
      );

  Map<String, dynamic> toJson() => {
        "weatherId": weatherId,
        "lowTemperature": lowTemperature,
        "highTemperature": highTemperature,
      };
}

StepsDetailBean stepsDetailBeanFromJson(String str) => StepsDetailBean.fromJson(json.decode(str));

String stepsDetailBeanToJson(StepsDetailBean data) => json.encode(data.toJson());

class StepsDetailBean {
  StepsDetailBean({required this.type, required this.stepsCategoryInfo, required this.actionDetailsInfo});

  int type;
  StepsCategoryBean? stepsCategoryInfo;
  ActionDetailsBean? actionDetailsInfo;

  factory StepsDetailBean.fromJson(Map<String, dynamic> json) => StepsDetailBean(
      type: json["type"],
      stepsCategoryInfo: StepsCategoryBean.fromJson(json["stepsCategoryInfo"] ?? {}),
      actionDetailsInfo: ActionDetailsBean.fromJson(json["actionDetailsInfo"] ?? {}));

  Map<String, dynamic> toJson() => {"type": type, "stepsCategoryInfo": stepsCategoryInfo!.toJson(), "actionDetailsInfo": actionDetailsInfo!.toJson()};
}

StepsCategoryBean stepsCategoryBeanFromJson(String str) => StepsCategoryBean.fromJson(json.decode(str));

String stepsCategoryBeanToJson(StepsCategoryBean data) => json.encode(data.toJson());

class StepsCategoryBean {
  StepsCategoryBean({
    required this.historyDay,
    required this.timeInterval,
    required this.stepsList,
  });

  String? historyDay;
  int? timeInterval;
  List<int>? stepsList;

  factory StepsCategoryBean.fromJson(Map<String, dynamic> json) => StepsCategoryBean(
        historyDay: json["historyDay"] ?? "",
        timeInterval: json["timeInterval"] ?? -1,
        stepsList: List<int>.from((json["stepsList"] ?? []).map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "historyDay": historyDay,
        "timeInterval": timeInterval,
        "stepsList": List<dynamic>.from(stepsList!.map((x) => x)),
      };
}

ActionDetailsBean actionDetailsBeanFromJson(String str) => ActionDetailsBean.fromJson(json.decode(str));

String actionDetailsBeanToJson(ActionDetailsBean data) => json.encode(data.toJson());

class ActionDetailsBean {
  ActionDetailsBean({
    required this.historyDay,
    required this.stepsList,
    required this.distanceList,
    required this.caloriesList,
  });

  String? historyDay;
  List<int>? stepsList;
  List<int>? distanceList;
  List<int>? caloriesList;

  factory ActionDetailsBean.fromJson(Map<String, dynamic> json) => ActionDetailsBean(
        historyDay: json["historyDay"] ?? "",
        stepsList: List<int>.from((json["stepsList"] ?? []).map((x) => x)),
        distanceList: List<int>.from((json["distanceList"] ?? []).map((x) => x)),
        caloriesList: List<int>.from((json["caloriesList"] ?? []).map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "historyDay": historyDay,
        "stepsList": List<dynamic>.from(stepsList!.map((x) => x)),
        "distanceList": List<dynamic>.from(distanceList!.map((x) => x)),
        "caloriesList": List<dynamic>.from(caloriesList!.map((x) => x)),
      };
}

HistorySleepBean historySleepBeanFromJson(String str) => HistorySleepBean.fromJson(json.decode(str));

String historySleepBeanToJson(HistorySleepBean data) => json.encode(data.toJson());

class HistorySleepBean {
  HistorySleepBean({
    required this.timeType,
    required this.sleepInfo,
  });

  int? timeType;
  SleepInfo? sleepInfo;

  factory HistorySleepBean.fromJson(Map<String, dynamic> json) => HistorySleepBean(
        timeType: json["timeType"] ?? -1,
        sleepInfo: SleepInfo.fromJson(json["sleepInfo"] ?? {}),
      );

  Map<String, dynamic> toJson() => {
        "timeType": timeType,
        "sleepInfo": sleepInfo!.toJson(),
      };
}

SleepBean sleepBeanFromJson(String str) => SleepBean.fromJson(json.decode(str));

String sleepBeanToJson(SleepBean data) => json.encode(data.toJson());

class SleepBean {
  SleepBean({required this.type, required this.sleepInfo, required this.historySleep, required this.goalSleepTime});

  int type;
  SleepInfo? sleepInfo;
  HistorySleepBean? historySleep;
  int? goalSleepTime;

  factory SleepBean.fromJson(Map<String, dynamic> json) => SleepBean(
        type: json["type"],
        sleepInfo: SleepInfo.fromJson(json["sleepInfo"] ?? {}),
        historySleep: HistorySleepBean.fromJson(json["historySleep"] ?? {}),
        goalSleepTime: json["goalSleepTime"] ?? -1,
      );

  Map<String, dynamic> toJson() =>
      {"type": type, "sleepInfo": sleepInfo!.toJson(), "historySleep": historySleep!.toJson(), "goalSleepTime": goalSleepTime!};
}

SleepInfo sleepInfoFromJson(String str) => SleepInfo.fromJson(json.decode(str));

String sleepInfoToJson(SleepInfo data) => json.encode(data.toJson());

class SleepInfo {
  SleepInfo({
    required this.totalTime,
    required this.restfulTime,
    required this.lightTime,
    required this.soberTime,
    required this.remTime,
    required this.details,
  });

  int? totalTime;
  int? restfulTime;
  int? lightTime;
  int? soberTime;
  int? remTime;
  List<DetailBean> details;

  static const int sleepStateRem = 3;
  static const int sleepStateRestful = 2;
  static const int sleepStateLight = 1;
  static const int sleepStateSober = 0;

  factory SleepInfo.fromJson(Map<String, dynamic> json) => SleepInfo(
        totalTime: json["totalTime"],
        restfulTime: json["restfulTime"],
        lightTime: json["lightTime"],
        soberTime: json["soberTime"],
        remTime: json["remTime"],
        details: List<DetailBean>.from((json["details"] ?? []).map((e) => DetailBean.fromJson(e))),
      );

  Map<String, dynamic> toJson() => {
        "totalTime": totalTime,
        "restfulTime": restfulTime,
        "lightTime": lightTime,
        "soberTime": soberTime,
        "remTime": remTime,
        "details": details,
      };
}

DetailBean detailBeanFromJson(String str) => DetailBean.fromJson(json.decode(str));

String detailBeanToJson(DetailBean data) => json.encode(data.toJson());

class DetailBean {
  DetailBean({
    required this.startTime,
    required this.endTime,
    required this.totalTime,
    required this.type,
  });

  int startTime;
  int endTime;
  int totalTime;
  int type;

  factory DetailBean.fromJson(Map<String, dynamic> json) => DetailBean(
        startTime: json["startTime"],
        endTime: json["endTime"],
        totalTime: json["totalTime"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "startTime": startTime,
        "endTime": endTime,
        "totalTime": totalTime,
        "type": type,
      };
}

PeriodTimeBean periodTimeBeanFromJson(String str) => PeriodTimeBean.fromJson(json.decode(str));

String periodTimeBeanToJson(PeriodTimeBean data) => json.encode(data.toJson());

class PeriodTimeBean {
  PeriodTimeBean({
    required this.endHour,
    required this.endMinute,
    required this.startHour,
    required this.startMinute,
  });

  int endHour;
  int endMinute;
  int startHour;
  int startMinute;

  factory PeriodTimeBean.fromJson(Map<String, dynamic> json) => PeriodTimeBean(
        endHour: json["endHour"],
        endMinute: json["endMinute"],
        startHour: json["startHour"],
        startMinute: json["startMinute"],
      );

  Map<String, dynamic> toJson() => {
        "endHour": endHour,
        "endMinute": endMinute,
        "startHour": startHour,
        "startMinute": startMinute,
      };
}

WatchFaceLayoutBean watchFaceLayoutBeanFromJson(String str) => WatchFaceLayoutBean.fromJson(json.decode(str));

String watchFaceLayoutBeanToJson(WatchFaceLayoutBean data) => json.encode(data.toJson());

class WatchFaceLayoutBean {
  WatchFaceLayoutBean({
    required this.backgroundPictureMd5,
    required this.compressionType,
    required this.height,
    required this.textColor,
    required this.thumHeight,
    required this.thumWidth,
    required this.timeBottomContent,
    required this.timePosition,
    required this.timeTopContent,
    required this.width,
  });

  String backgroundPictureMd5;
  String compressionType;
  int height;
  Color textColor;
  int thumHeight;
  int thumWidth;
  int timeBottomContent;
  int timePosition;
  int timeTopContent;
  int width;

  factory WatchFaceLayoutBean.fromJson(Map<String, dynamic> json) {
    Color newTextColor = ColorUtils().decimalToColor(json["textColor"]);
    return WatchFaceLayoutBean(
      backgroundPictureMd5: json["backgroundPictureMd5"],
      compressionType: json["compressionType"],
      height: json["height"],
      textColor: newTextColor,
      thumHeight: json["thumHeight"],
      thumWidth: json["thumWidth"],
      timeBottomContent: json["timeBottomContent"],
      timePosition: json["timePosition"],
      timeTopContent: json["timeTopContent"],
      width: json["width"],
    );
  }

  Map<String, dynamic> toJson() {
    int newTextColor = ColorUtils().colorToDecimal(textColor);
    return {
      "backgroundPictureMd5": backgroundPictureMd5,
      "compressionType": compressionType,
      "height": height,
      "textColor": newTextColor,
      "thumHeight": thumHeight,
      "thumWidth": thumWidth,
      "timeBottomContent": timeBottomContent,
      "timePosition": timePosition,
      "timeTopContent": timeTopContent,
      "width": width,
    };
  }
}

class ColorUtils {
  Color decimalToColor(int decimalValue) {
    int red = (decimalValue >> 16) & 0xFF;
    int green = (decimalValue >> 8) & 0xFF;
    int blue = decimalValue & 0xFF;

    return Color.fromARGB(255, red, green, blue);
  }

  int colorToDecimal(Color color) {
    return Color.fromARGB(0, color.red, color.green, color.blue).value;
  }
}

AlarmBean alarmBeanFromJson(String str) => AlarmBean.fromJson(json.decode(str));

String alarmBeanToJson(AlarmBean data) => json.encode(data.toJson());

class AlarmBean {
  AlarmBean({
    required this.list,
    required this.isNew,
  });

  List<AlarmClockBean> list;
  bool isNew;

  factory AlarmBean.fromJson(Map<String, dynamic> json) => AlarmBean(
    list: List<AlarmClockBean>.from((json["list"] ?? []).map((e) => AlarmClockBean.fromJson(e))),
    isNew: json["isNew"],
  );

  Map<String, dynamic> toJson() => {
    "list": list,
    "isNew": isNew,
  };
}

AlarmClockBean alarmClockBeanFromJson(String str) => AlarmClockBean.fromJson(json.decode(str));

String alarmClockBeanToJson(AlarmClockBean data) => json.encode(data.toJson());

class AlarmClockBean {
  AlarmClockBean({
    required this.enable,
    required this.hour,
    required this.id,
    required this.minute,
    required this.repeatMode,
  });

  bool enable;
  int hour;
  int id;
  int minute;
  int repeatMode;

  static const int firstClock = 0;
  static const int secondClock = 1;
  static const int thirdClock = 2;

  static const int single = 0;
  static const int sunday = 1;
  static const int monday = 2;
  static const int tuesday = 4;
  static const int wednesday = 8;
  static const int thursday = 16;
  static const int friday = 32;
  static const int saturday = 64;
  static const int everyday = 127;

  factory AlarmClockBean.fromJson(Map<String, dynamic> json) => AlarmClockBean(
        enable: json["enable"],
        hour: json["hour"],
        id: json["id"],
        minute: json["minute"],
        repeatMode: json["repeatMode"],
      );

  Map<String, dynamic> toJson() => {
        "enable": enable,
        "hour": hour,
        "id": id,
        "minute": minute,
        "repeatMode": repeatMode,
      };
}

SupportWatchFaceBean supportWatchFaceBeanFromJson(String str) => SupportWatchFaceBean.fromJson(json.decode(str));

String supportWatchFaceBeanToJson(SupportWatchFaceBean data) => json.encode(data.toJson());

class SupportWatchFaceBean {
  SupportWatchFaceBean({
    required this.type,
    required this.supportWatchFaceInfo,
    required this.sifliSupportWatchFaceInfo,
    required this.jieliSupportWatchFaceInfo,
  });

  String type;
  SupportWatchFaceInfo? supportWatchFaceInfo;
  SifliSupportWatchFaceInfo? sifliSupportWatchFaceInfo;
  JieliSupportWatchFaceInfo? jieliSupportWatchFaceInfo;

  factory SupportWatchFaceBean.fromJson(Map<String, dynamic> json) => SupportWatchFaceBean(
        type: json["type"],
        supportWatchFaceInfo: SupportWatchFaceInfo.fromJson(json["supportWatchFaceInfo"] ?? {}),
        sifliSupportWatchFaceInfo: SifliSupportWatchFaceInfo.fromJson(json["sifliSupportWatchFaceInfo"] ?? {}),
        jieliSupportWatchFaceInfo: JieliSupportWatchFaceInfo.fromJson(json["jieliSupportWatchFaceInfo"] ?? {}),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "supportWatchFaceInfo": supportWatchFaceInfo!.toJson(),
        "sifliSupportWatchFaceInfo": sifliSupportWatchFaceInfo!.toJson(),
        "jieliSupportWatchFaceInfo": jieliSupportWatchFaceInfo!.toJson(),
      };
}

SupportWatchFaceInfo supportWatchFaceInfoFromJson(String str) => SupportWatchFaceInfo.fromJson(json.decode(str));

String supportWatchFaceInfoToJson(SupportWatchFaceInfo data) => json.encode(data.toJson());

class SupportWatchFaceInfo {
  SupportWatchFaceInfo({
    required this.displayWatchFace,
    required this.supportWatchFaceList,
  });

  int? displayWatchFace;
  List<int>? supportWatchFaceList;

  factory SupportWatchFaceInfo.fromJson(Map<String, dynamic> json) => SupportWatchFaceInfo(
        displayWatchFace: json["displayWatchFace"] ?? -1,
        supportWatchFaceList: List<int>.from((json["supportWatchFaceList"] ?? []).map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "displayWatchFace": displayWatchFace,
        "supportWatchFaceList": List<dynamic>.from(supportWatchFaceList!.map((x) => x)),
      };
}

SifliSupportWatchFaceInfo sifliSupportWatchFaceInfoFromJson(String str) => SifliSupportWatchFaceInfo.fromJson(json.decode(str));

String sifliSupportWatchFaceInfoToJson(SifliSupportWatchFaceInfo data) => json.encode(data.toJson());

class SifliSupportWatchFaceInfo {
  SifliSupportWatchFaceInfo({
    required this.typeList,
    required this.list,
  });

  List<int>? typeList;
  List<SifliWatchFace>? list;

  factory SifliSupportWatchFaceInfo.fromJson(Map<String, dynamic> json) => SifliSupportWatchFaceInfo(
        typeList: List<int>.from((json["typeList"] ?? []).map((x) => x)),
        list: List<SifliWatchFace>.from((json["list"] ?? []).map((x) => SifliWatchFace.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "typeList": List<int>.from(typeList!.map((x) => x)),
        "list": List<SifliWatchFace>.from(list!.map((x) => x)),
      };
}

class SifliWatchFace {
  SifliWatchFace({
    required this.id,
    required this.state,
  });

  int id;
  String state;

  factory SifliWatchFace.fromJson(Map<String, dynamic> json) => SifliWatchFace(
        id: json["id"],
        state: json["state"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "state": state,
      };
}

JieliSupportWatchFaceInfo jieliSupportWatchFaceInfoFromJson(String str) => JieliSupportWatchFaceInfo.fromJson(json.decode(str));

String jieliSupportWatchFaceInfoToJson(JieliSupportWatchFaceInfo data) => json.encode(data.toJson());

class JieliSupportWatchFaceInfo {
  JieliSupportWatchFaceInfo({
    required this.displayWatchFace,
    required this.watchFaceMaxSize,
    required this.supportTypeList,
  });

  int? displayWatchFace;
  int? watchFaceMaxSize;
  List<int>? supportTypeList;

  factory JieliSupportWatchFaceInfo.fromJson(Map<String, dynamic> json) => JieliSupportWatchFaceInfo(
        displayWatchFace: json["displayWatchFace"] ?? -1,
        watchFaceMaxSize: json["watchFaceMaxSize"] ?? -1,
        supportTypeList: List<int>.from((json["supportTypeList"] ?? []).map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "displayWatchFace": displayWatchFace,
        "watchFaceMaxSize": watchFaceMaxSize,
        "supportTypeList": List<dynamic>.from(supportTypeList!.map((x) => x)),
      };
}

WatchFaceStoreBean watchFaceStoreBeanFromJson(String str) => WatchFaceStoreBean.fromJson(json.decode(str));

String watchFaceStoreBeanToJson(WatchFaceStoreBean data) => json.encode(data.toJson());

class WatchFaceStoreBean {
  WatchFaceStoreBean({
    required this.watchFaceSupportList,
    required this.firmwareVersion,
    required this.pageCount,
    required this.pageIndex,
  });

  List<int> watchFaceSupportList;
  String firmwareVersion;
  int pageCount;
  int pageIndex;

  factory WatchFaceStoreBean.fromJson(Map<String, dynamic> json) => WatchFaceStoreBean(
        watchFaceSupportList: List<int>.from(json["list"].map((x) => x)),
        firmwareVersion: json["firmwareVersion"],
        pageCount: json["pageCount"],
        pageIndex: json["pageIndex"],
      );

  Map<String, dynamic> toJson() => {
        "watchFaceSupportList": List<dynamic>.from(watchFaceSupportList.map((x) => x)),
        "firmwareVersion": firmwareVersion,
        "pageCount": pageCount,
        "pageIndex": pageIndex,
      };
}

JieliWatchFaceBean jieliWatchFaceBeanFromJson(String str) => JieliWatchFaceBean.fromJson(json.decode(str));

String jieliWatchFaceBeanToJson(JieliWatchFaceBean data) => json.encode(data.toJson());

class JieliWatchFaceBean {
  int? apiVersion;
  int? feature;

  JieliWatchFaceBean({
    required this.apiVersion,
    required this.feature,
  });

  factory JieliWatchFaceBean.fromJson(Map<String, dynamic> json) => JieliWatchFaceBean(
        apiVersion: json["apiVersion"] ?? -1,
        feature: json["feature"] ?? -1,
      );

  Map<String, dynamic> toJson() => {
        "apiVersion": apiVersion,
        "feature": feature,
      };
}

WatchFaceStoreTagListBean watchFaceStoreTagListBeanFromJson(String str) => WatchFaceStoreTagListBean.fromJson(json.decode(str));

String watchFaceStoreTagListBeanToJson(WatchFaceStoreTagListBean data) => json.encode(data.toJson());

class WatchFaceStoreTagListBean {
  String storeType;
  List<int> typeList;
  String firmwareVersion;
  int perPageCount;
  int pageIndex;
  int maxSize;
  int apiVersion;
  int feature;

  WatchFaceStoreTagListBean({
    required this.storeType,
    required this.typeList,
    required this.firmwareVersion,
    required this.perPageCount,
    required this.pageIndex,
    required this.maxSize,
    required this.apiVersion,
    required this.feature,
  });

  factory WatchFaceStoreTagListBean.fromJson(Map<String, dynamic> json) => WatchFaceStoreTagListBean(
        storeType: json["storeType"],
        typeList: List<int>.from(json["typeList"].map((x) => x)),
        firmwareVersion: json["firmwareVersion"],
        perPageCount: json["perPageCount"],
        pageIndex: json["pageIndex"],
        maxSize: json["maxSize"],
        apiVersion: json["apiVersion"],
        feature: json["feature"],
      );

  Map<String, dynamic> toJson() => {
        "storeType": storeType,
        "typeList": List<dynamic>.from(typeList.map((x) => x)),
        "firmwareVersion": firmwareVersion,
        "perPageCount": perPageCount,
        "pageIndex": pageIndex,
        "maxSize": maxSize,
        "apiVersion": apiVersion,
        "feature": feature,
      };
}

WatchFaceStoreTagListResult watchFaceStoreTagListResultFromJson(String str) => WatchFaceStoreTagListResult.fromJson(json.decode(str));

String watchFaceStoreTagListResultToJson(WatchFaceStoreTagListResult data) => json.encode(data.toJson());

class WatchFaceStoreTagListResult {
  List<WatchFaceStoreTagInfo>? list;
  String? error;

  WatchFaceStoreTagListResult({
    required this.list,
    required this.error,
  });

  factory WatchFaceStoreTagListResult.fromJson(Map<String, dynamic> json) => WatchFaceStoreTagListResult(
        list: List<WatchFaceStoreTagInfo>.from((json["list"] ?? []).map((x) => WatchFaceStoreTagInfo.fromJson(x))),
        error: json["error"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "list": List<WatchFaceStoreTagInfo>.from(list!.map((x) => x)),
        "error": error,
      };
}

WatchFaceStoreTagInfo watchFaceStoreTagInfoFromJson(String str) => WatchFaceStoreTagInfo.fromJson(json.decode(str));

String watchFaceStoreTagInfoToJson(WatchFaceStoreTagInfo data) => json.encode(data.toJson());

class WatchFaceStoreTagInfo {
  int? tagId;
  String? tagName;
  List<WatchFaceStoreItem>? list;

  WatchFaceStoreTagInfo({required this.tagId, required this.tagName, required this.list});

  factory WatchFaceStoreTagInfo.fromJson(Map<String, dynamic> json) => WatchFaceStoreTagInfo(
        tagId: json["tagId"] ?? -1,
        tagName: json["tagName"] ?? "",
        list: List<WatchFaceStoreItem>.from((json["list"] ?? []).map((x) => WatchFaceStoreItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {"tagId": tagId, "tagName": tagName, "list": List<WatchFaceStoreItem>.from(list!.map((x) => x))};
}

WatchFaceStoreItem watchFaceStoreItemFromJson(String str) => WatchFaceStoreItem.fromJson(json.decode(str));

String watchFaceStoreItemToJson(WatchFaceStoreItem data) => json.encode(data.toJson());

class WatchFaceStoreItem {
  int? id;
  String? name;
  int? size;
  int? download;
  String? preview;

  WatchFaceStoreItem({
    required this.id,
    required this.name,
    required this.size,
    required this.download,
    required this.preview,
  });

  factory WatchFaceStoreItem.fromJson(Map<String, dynamic> json) => WatchFaceStoreItem(
        id: json["id"] ?? -1,
        name: json["name"] ?? "",
        size: json["size"] ?? -1,
        download: json["download"] ?? -1,
        preview: json["preview"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "size": size,
        "download": download,
        "preview": preview,
      };
}

WatchFaceStoreListBean watchFaceStoreListBeanFromJson(String str) => WatchFaceStoreListBean.fromJson(json.decode(str));

String watchFaceStoreListBeanToJson(WatchFaceStoreListBean data) => json.encode(data.toJson());

class WatchFaceStoreListBean {
  WatchFaceStoreTagListBean watchFaceStoreTagList;
  int tagId;

  WatchFaceStoreListBean({required this.watchFaceStoreTagList, required this.tagId});

  factory WatchFaceStoreListBean.fromJson(Map<String, dynamic> json) => WatchFaceStoreListBean(
        watchFaceStoreTagList: json["watchFaceStoreTagList"],
        tagId: json["tagId"],
      );

  Map<String, dynamic> toJson() => {
        "watchFaceStoreTagList": watchFaceStoreTagList,
        "tagId": tagId,
      };
}

WatchFaceStoreTypeBean watchFaceStoreTypeBeanFromJson(String str) => WatchFaceStoreTypeBean.fromJson(json.decode(str));

String watchFaceStoreTypeBeanToJson(WatchFaceStoreTypeBean data) => json.encode(data.toJson());

class WatchFaceStoreTypeBean {
  String storeType;
  int id;
  List<int> typeList;
  String firmwareVersion;
  int apiVersion;
  int feature;
  int maxSize;

  WatchFaceStoreTypeBean(
      {required this.storeType,
      required this.id,
      required this.typeList,
      required this.firmwareVersion,
      required this.apiVersion,
      required this.feature,
      required this.maxSize});

  factory WatchFaceStoreTypeBean.fromJson(Map<String, dynamic> json) => WatchFaceStoreTypeBean(
        storeType: json["storeType"],
        id: json["id"],
        typeList: json["typeList"],
        firmwareVersion: json["firmwareVersion"],
        apiVersion: json["apiVersion"],
        feature: json["feature"],
        maxSize: json["maxSize"],
      );

  Map<String, dynamic> toJson() => {
        "storeType": storeType,
        "id": id,
        "typeList": typeList,
        "firmwareVersion": firmwareVersion,
        "apiVersion": apiVersion,
        "feature": feature,
        "maxSize": maxSize,
      };
}

WatchFaceDetailResultBean watchFaceDetailResultBeanFromJson(String str) => WatchFaceDetailResultBean.fromJson(json.decode(str));

String watchFaceDetailResultBeanToJson(WatchFaceDetailResultBean data) => json.encode(data.toJson());

class WatchFaceDetailResultBean {
  WatchFaceBean? watchFaceBean;
  WatchFaceDetailsBean? watchFaceDetailsInfo;
  String? error;

  WatchFaceDetailResultBean({
    required this.watchFaceBean,
    required this.watchFaceDetailsInfo,
    required this.error,
  });

  factory WatchFaceDetailResultBean.fromJson(Map<String, dynamic> json) => WatchFaceDetailResultBean(
        watchFaceBean: WatchFaceBean.fromJson(json["watchFaceBean"] ?? {}),
        watchFaceDetailsInfo: WatchFaceDetailsBean.fromJson(json["watchFaceDetailsInfo"] ?? {}),
        error: json["error"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "watchFaceBean": watchFaceBean,
        "watchFaceDetailsInfo": watchFaceDetailsInfo,
        "error": error,
      };
}

WatchFaceBean watchFaceBeanFromJson(String str) => WatchFaceBean.fromJson(json.decode(str));

String watchFaceBeanToJson(WatchFaceBean data) => json.encode(data.toJson());

class WatchFaceBean {
  WatchFaceBean({
    required this.id,
    required this.preview,
    required this.file,
  });

  int? id;
  String? preview;
  String? file;

  factory WatchFaceBean.fromJson(Map<String, dynamic> json) => WatchFaceBean(
        id: json["id"] ?? -1,
        preview: json["preview"] ?? "",
        file: json["file"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "preview": preview,
        "file": file,
      };
}

WatchFaceDetailsBean watchFaceDetailsBeanFromJson(String str) => WatchFaceDetailsBean.fromJson(json.decode(str));

String watchFaceDetailsBeanToJson(WatchFaceDetailsBean data) => json.encode(data.toJson());

class WatchFaceDetailsBean {
  int id;
  String name;
  int download;
  int size;
  String file;
  String preview;
  String remarkCn;
  String remarkEn;
  List<RecommendWatchFaceBean> recommendWatchFaceList;

  WatchFaceDetailsBean({
    required this.id,
    required this.name,
    required this.download,
    required this.size,
    required this.file,
    required this.preview,
    required this.remarkCn,
    required this.remarkEn,
    required this.recommendWatchFaceList,
  });

  factory WatchFaceDetailsBean.fromJson(Map<String, dynamic> json) => WatchFaceDetailsBean(
        id: json["id"] ?? -1,
        name: json["name"] ?? "",
        download: json["download"] ?? -1,
        size: json["size"] ?? -1,
        file: json["file"] ?? "",
        preview: json["preview"] ?? "",
        remarkCn: json["remarkCn"] ?? "",
        remarkEn: json["remarkEn"] ?? "",
        recommendWatchFaceList:
            List<RecommendWatchFaceBean>.from((json["recommendWatchFaceList"] ?? []).map((x) => RecommendWatchFaceBean.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "download": download,
        "size": size,
        "file": file,
        "preview": preview,
        "remarkCn": remarkCn,
        "remarkEn": remarkEn,
        "recommendWatchFaceList": List<dynamic>.from(recommendWatchFaceList.map((x) => x)),
      };
}

class RecommendWatchFaceBean {
  int id;
  String name;
  int size;
  String preview;

  RecommendWatchFaceBean({
    required this.id,
    required this.name,
    required this.size,
    required this.preview,
  });

  factory RecommendWatchFaceBean.fromJson(Map<String, dynamic> json) => RecommendWatchFaceBean(
        id: json["id"] ?? -1,
        name: json["name"] ?? "",
        size: json["size"] ?? -1,
        preview: json["preview"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "size": size,
        "preview": preview,
      };
}

WatchFaceBackgroundBean watchFaceBackgroundBeanFromJson(String str) => WatchFaceBackgroundBean.fromJson(json.decode(str));

String watchFaceBackgroundBeanToJson(WatchFaceBackgroundBean data) => json.encode(data.toJson());

class WatchFaceBackgroundBean {
  WatchFaceBackgroundBean({
    required this.bitmap,
    required this.thumbBitmap,
    required this.type,
    required this.thumbWidth,
    required this.thumbHeight,
    required this.width,
    required this.height,
  });

  Uint8List bitmap;
  Uint8List thumbBitmap;
  String type;
  int thumbWidth;
  int thumbHeight;
  int width;
  int height;
  static const int defaultTimeout = 30;
  static const int timeout = 30;

  factory WatchFaceBackgroundBean.fromJson(Map<String, dynamic> json) => WatchFaceBackgroundBean(
        bitmap: json["bitmap"],
        thumbBitmap: json["thumbBitmap"],
        type: json["type"],
        thumbWidth: json["thumbWidth"],
        thumbHeight: json["thumbHeight"],
        width: json["width"],
        height: json["height"],
      );

  Map<String, dynamic> toJson() => {
        "bitmap": bitmap,
        "thumbBitmap": thumbBitmap,
        "type": type,
        "thumbWidth": thumbWidth,
        "thumbHeight": thumbHeight,
        "width": width,
        "height": height,
      };
}

CustomizeWatchFaceBean customizeWatchFaceBeanFromJson(String str) => CustomizeWatchFaceBean.fromJson(json.decode(str));

String customizeWatchFaceBeanToJson(CustomizeWatchFaceBean data) => json.encode(data.toJson());

class CustomizeWatchFaceBean {
  CustomizeWatchFaceBean({
    required this.index,
    required this.file,
  });

  int index;
  String file;

  factory CustomizeWatchFaceBean.fromJson(Map<String, dynamic> json) => CustomizeWatchFaceBean(
        index: json["index"],
        file: json["file"],
      );

  Map<String, dynamic> toJson() => {
        "index": index,
        "file": file,
      };
}

WatchFaceInfo watchFaceInfoFromJson(String str) => WatchFaceInfo.fromJson(json.decode(str));

String watchFaceInfoToJson(WatchFaceInfo data) => json.encode(data.toJson());

class WatchFaceInfo {
  WatchFaceInfo({
    required this.total,
    required this.prePage,
    required this.pageIndex,
    required this.list,
  });

  int total;
  int prePage;
  int pageIndex;
  List<WatchFaceBean> list;

  factory WatchFaceInfo.fromJson(Map<String, dynamic> json) => WatchFaceInfo(
        total: json["total"],
        prePage: json["prePage"],
        pageIndex: json["pageIndex"],
        list: List<WatchFaceBean>.from(json["list"].map((x) => WatchFaceBean.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "prePage": prePage,
        "pageIndex": pageIndex,
        "list": List<dynamic>.from(list.map((x) => x.toJson())),
      };
}

StepsChangeBean stepsChangeBeanFromJson(String str) => StepsChangeBean.fromJson(json.decode(str));

String stepsChangeBeanToJson(StepsChangeBean data) => json.encode(data.toJson());

class StepsChangeBean {
  StepsChangeBean({
    required this.type,
    required this.stepsInfo,
    required this.historyStepsInfo,
  });

  int type;
  StepInfoBean? stepsInfo;
  HistoryStepInfoBean? historyStepsInfo;

  factory StepsChangeBean.fromJson(Map<String, dynamic> json) => StepsChangeBean(
        type: json["type"],
        stepsInfo: StepInfoBean.fromJson(json["stepsInfo"] ?? {}),
        historyStepsInfo: HistoryStepInfoBean.fromJson(json["historyStepsInfo"] ?? {}),
      );

  Map<String, dynamic> toJson() => {"type": type, "stepsInfo": stepsInfo!.toJson(), "historyStepsInfo": historyStepsInfo!.toJson()};
}

StepInfoBean stepInfoBeanFromJson(String str) => StepInfoBean.fromJson(json.decode(str));

String stepInfoBeanToJson(StepInfoBean data) => json.encode(data.toJson());

class StepInfoBean {
  StepInfoBean({
    required this.steps,
    required this.distance,
    required this.calories,
    required this.time,
  });

  int? steps;
  int? distance;
  int? calories;
  int? time;

  factory StepInfoBean.fromJson(Map<String, dynamic> json) => StepInfoBean(
        steps: json["steps"] ?? -1,
        distance: json["distance"] ?? -1,
        calories: json["calories"] ?? -1,
        time: json["time"] ?? -1,
      );

  Map<String, dynamic> toJson() => {
        "steps": steps,
        "distance": distance,
        "calories": calories,
        "time": time,
      };
}

HistoryStepInfoBean historyStepInfoBeanFromJson(String str) => HistoryStepInfoBean.fromJson(json.decode(str));

String historyStepInfoBeanToJson(HistoryStepInfoBean data) => json.encode(data.toJson());

class HistoryStepInfoBean {
  HistoryStepInfoBean({
    required this.historyDay,
    required this.stepsInfo,
  });

  String? historyDay;
  StepInfoBean? stepsInfo;

  factory HistoryStepInfoBean.fromJson(Map<String, dynamic> json) => HistoryStepInfoBean(
        historyDay: json["historyDay"] ?? "",
        stepsInfo: StepInfoBean.fromJson(json["stepsInfo"] ?? {}),
      );

  Map<String, dynamic> toJson() => {
        "historyDay": historyDay!,
        "stepsInfo": stepsInfo!.toJson(),
      };
}

HistoryHeartRateBean historyHeartRateBeanFromJson(String str) => HistoryHeartRateBean.fromJson(json.decode(str));

String historyHeartRateBeanToJson(HistoryHeartRateBean data) => json.encode(data.toJson());

class HistoryHeartRateBean {
  HistoryHeartRateBean({
    required this.date,
    required this.hr,
  });

  String date;
  int hr;

  factory HistoryHeartRateBean.fromJson(Map<String, dynamic> json) => HistoryHeartRateBean(
        date: json["date"],
        hr: json["hr"],
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "hr": hr,
      };
}

HeartRateInfo heartRateInfoFromJson(String str) => HeartRateInfo.fromJson(json.decode(str));

String heartRateInfoToJson(HeartRateInfo data) => json.encode(data.toJson());

class HeartRateInfo {
  HeartRateInfo({
    required this.startTime,
    required this.heartRateList,
    required this.timeInterval,
    required this.heartRateType,
    required this.isAllDay
  });

  int startTime;
  List<int> heartRateList;
  int timeInterval;
  String heartRateType;
  int isAllDay;

  factory HeartRateInfo.fromJson(Map<String, dynamic> json) => HeartRateInfo(
        startTime: json["startTime"] ?? 0,
        heartRateList: List<int>.from((json["heartRateList"] ?? []).map((x) => x)),
        timeInterval: json["timeInterval"] ?? 0,
        heartRateType: json["heartRateType"] ?? "",
        isAllDay: json["isAllDay"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "startTime": startTime,
        "heartRateList": List<dynamic>.from(heartRateList.map((x) => x)),
        "timeInterval": timeInterval,
        "heartRateType": heartRateType,
        "isAllDay": isAllDay,
      };
}

TrainingHeartRateBean trainingHeartRateBeanFromJson(String str) => TrainingHeartRateBean.fromJson(json.decode(str));

String trainingHeartRateBeanToJson(TrainingHeartRateBean data) => json.encode(data.toJson());

class TrainingHeartRateBean {
  TrainingHeartRateBean({
    required this.type,
    required this.startTime,
    required this.endTime,
    required this.validTime,
    required this.steps,
    required this.distance,
    required this.calories,
  });

  int type;
  int startTime;
  int endTime;
  int validTime;
  int steps;
  int distance;
  int calories;

  factory TrainingHeartRateBean.fromJson(Map<String, dynamic> json) => TrainingHeartRateBean(
        type: json["type"],
        startTime: json["startTime"],
        endTime: json["endTime"],
        validTime: json["validTime"],
        steps: json["steps"],
        distance: json["distance"],
        calories: json["calories"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "startTime": startTime,
        "endTime": endTime,
        "validTime": validTime,
        "steps": steps,
        "distance": distance,
        "calories": calories,
      };
}

MeasureCompleteBean measureCompleteBeanFromJson(String str) => MeasureCompleteBean.fromJson(json.decode(str));

String measureCompleteBeanToJson(MeasureCompleteBean data) => json.encode(data.toJson());

class MeasureCompleteBean {
  MeasureCompleteBean({
    required this.historyDynamicRateType,
    required this.heartRate,
  });

  String? historyDynamicRateType;
  HeartRateInfo? heartRate;

  factory MeasureCompleteBean.fromJson(Map<String, dynamic> json) => MeasureCompleteBean(
        historyDynamicRateType: json["historyDynamicRateType"] ?? "",
        heartRate: HeartRateInfo.fromJson(json["heartRate"] ?? {}),
      );

  Map<String, dynamic> toJson() => {
        "historyDynamicRateType": historyDynamicRateType,
        "heartRate": heartRate!.toJson(),
      };
}

HeartRateBean heartRateBeanFromJson(String str) => HeartRateBean.fromJson(json.decode(str));

String heartRateBeanToJson(HeartRateBean data) => json.encode(data.toJson());

class HeartRateBean {
  HeartRateBean({
    required this.type,
    required this.measuring,
    required this.onceMeasureComplete,
    required this.historyHrList,
    required this.measureComplete,
    required this.hour24MeasureResult,
    required this.trainingList,
  });

  int type;
  int? measuring;
  int? onceMeasureComplete;
  List<HistoryHeartRateBean>? historyHrList;
  MeasureCompleteBean? measureComplete;
  HeartRateInfo? hour24MeasureResult;
  List<TrainingHeartRateBean>? trainingList;

  factory HeartRateBean.fromJson(Map<String, dynamic> json) => HeartRateBean(
        type: json["type"],
        measuring: json["measuring"] ?? -1,
        onceMeasureComplete: json["onceMeasureComplete"] ?? -1,
        historyHrList: List<HistoryHeartRateBean>.from((json["historyHrList"] ?? []).map((x) => HistoryHeartRateBean.fromJson(x))),
        measureComplete: MeasureCompleteBean.fromJson(json["measureComplete"] ?? {}),
        hour24MeasureResult: HeartRateInfo.fromJson(json["hour24MeasureResult"] ?? {}),
        trainingList: List<TrainingHeartRateBean>.from((json["trainingList"] ?? []).map((x) => TrainingHeartRateBean.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "measuring": measuring,
        "onceMeasureComplete": onceMeasureComplete,
        "historyHrList": List<dynamic>.from(historyHrList!.map((x) => x.toJson())),
        "measureComplete": measureComplete!.toJson(),
        "hour24MeasureResult": hour24MeasureResult!.toJson(),
        "trainingList": List<dynamic>.from(trainingList!.map((x) => x.toJson())),
      };
}

BloodPressureChangeBean bloodPressureChangeBeanFromJson(String str) => BloodPressureChangeBean.fromJson(json.decode(str));

String bloodPressureChangeBeanToJson(BloodPressureChangeBean data) => json.encode(data.toJson());

class BloodPressureChangeBean {
  BloodPressureChangeBean({
    required this.sbp,
    required this.dbp,
  });

  int? sbp;
  int? dbp;

  factory BloodPressureChangeBean.fromJson(Map<String, dynamic> json) => BloodPressureChangeBean(
        sbp: json["sbp"] ?? -1,
        dbp: json["dbp"] ?? -1,
      );

  Map<String, dynamic> toJson() => {
        "sbp": sbp,
        "dbp": dbp,
      };
}

BloodPressureBean bloodPressureBeanFromJson(String str) => BloodPressureBean.fromJson(json.decode(str));

String bloodPressureBeanToJson(BloodPressureBean data) => json.encode(data.toJson());

class BloodPressureBean {
  BloodPressureBean({
    required this.type,
    required this.continueState,
    required this.pressureChange,
    required this.historyBpList,
    required this.continueBp,
  });

  int type;
  bool? continueState;
  BloodPressureChangeBean? pressureChange;
  List<HistoryBloodPressureBean>? historyBpList;
  BloodPressureInfo? continueBp;

  factory BloodPressureBean.fromJson(Map<String, dynamic> json) => BloodPressureBean(
        type: json["type"],
        continueState: json["continueState"] ?? false,
        pressureChange: BloodPressureChangeBean.fromJson(json["pressureChange"] ?? {}),
        historyBpList: List<HistoryBloodPressureBean>.from((json["historyBpList"] ?? []).map((x) => HistoryBloodPressureBean.fromJson(x))),
        continueBp: BloodPressureInfo.fromJson(json["continueBp"] ?? {}),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "continueState": continueState,
        "pressureChange": pressureChange!.toJson(),
        "historyBpList": List<dynamic>.from(historyBpList!.map((x) => x.toJson())),
        "continueBp": continueBp!.toJson(),
      };
}

HistoryBloodPressureBean historyBloodPressureBeanFromJson(String str) => HistoryBloodPressureBean.fromJson(json.decode(str));

String historyBloodPressureBeanToJson(HistoryBloodPressureBean data) => json.encode(data.toJson());

class HistoryBloodPressureBean {
  HistoryBloodPressureBean({
    required this.date,
    required this.sbp,
    required this.dbp,
  });

  String? date;
  int? sbp;
  int? dbp;

  factory HistoryBloodPressureBean.fromJson(Map<String, dynamic> json) => HistoryBloodPressureBean(
        date: json["date"] ?? "",
        sbp: json["sbp"] ?? -1,
        dbp: json["dbp"] ?? -1,
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "sbp": sbp,
        "dbp": dbp,
      };
}

BloodPressureInfo bloodPressureInfoFromJson(String str) => BloodPressureInfo.fromJson(json.decode(str));

String bloodPressureInfoToJson(BloodPressureInfo data) => json.encode(data.toJson());

class BloodPressureInfo {
  BloodPressureInfo({
    required this.startTime,
    required this.timeInterval,
  });

  int? startTime;
  int? timeInterval;

  factory BloodPressureInfo.fromJson(Map<String, dynamic> json) => BloodPressureInfo(
        startTime: json["startTime"],
        timeInterval: json["timeInterval"],
      );

  Map<String, dynamic> toJson() => {
        "startTime": startTime,
        "timeInterval": timeInterval,
      };
}

BloodOxygenBean bloodOxygenBeanFromJson(String str) => BloodOxygenBean.fromJson(json.decode(str));

String bloodOxygenBeanToJson(BloodOxygenBean data) => json.encode(data.toJson());

class BloodOxygenBean {
  BloodOxygenBean({
    required this.continueState,
    required this.timingMeasure,
    required this.bloodOxygen,
    required this.historyList,
    required this.continueBo,
    required this.type,
  });

  int type;
  bool? continueState;
  int? timingMeasure;
  int? bloodOxygen;
  List<HistoryBloodOxygenBean>? historyList;
  BloodOxygenInfo? continueBo;

  factory BloodOxygenBean.fromJson(Map<String, dynamic> json) => BloodOxygenBean(
        type: json["type"] ?? -1,
        continueState: json["continueState"] ?? false,
        timingMeasure: json["timingMeasure"] ?? -1,
        bloodOxygen: json["bloodOxygen"] ?? -1,
        historyList: List<HistoryBloodOxygenBean>.from((json["historyList"] ?? []).map((x) => HistoryBloodOxygenBean.fromJson(x))),
        continueBo: BloodOxygenInfo.fromJson(json["continueBO"] ?? {}),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "continueState": continueState,
        "timingMeasure": timingMeasure,
        "bloodOxygen": bloodOxygen,
        "historyList": List<dynamic>.from(historyList!.map((x) => x.toJson())),
        "continueBO": continueBo!.toJson(),
      };
}

HistoryBloodOxygenBean historyBloodOxygenBeanFromJson(String str) => HistoryBloodOxygenBean.fromJson(json.decode(str));

String historyBloodOxygenBeanToJson(HistoryBloodOxygenBean data) => json.encode(data.toJson());

class HistoryBloodOxygenBean {
  HistoryBloodOxygenBean({
    required this.date,
    required this.bo,
  });

  String? date;
  int? bo;

  factory HistoryBloodOxygenBean.fromJson(Map<String, dynamic> json) => HistoryBloodOxygenBean(
        date: json["date"] ?? "",
        bo: json["bo"] ?? -1,
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "bo": bo,
      };
}

BloodOxygenInfo bloodOxygenInfoFromJson(String str) => BloodOxygenInfo.fromJson(json.decode(str));

String bloodOxygenInfoToJson(BloodOxygenInfo data) => json.encode(data.toJson());

class BloodOxygenInfo {
  BloodOxygenInfo({
    required this.startTime,
    required this.timeInterval,
  });

  int? startTime;
  int? timeInterval;

  factory BloodOxygenInfo.fromJson(Map<String, dynamic> json) => BloodOxygenInfo(
        startTime: json["startTime"],
        timeInterval: json["timeInterval"],
      );

  Map<String, dynamic> toJson() => {
        "startTime": startTime,
        "timeInterval": timeInterval,
      };
}

EcgBean ecgBeanFromJson(String str) => EcgBean.fromJson(json.decode(str));

String ecgBeanToJson(EcgBean data) => json.encode(data.toJson());

class EcgBean {
  EcgBean({
    required this.type,
    required this.ints,
    required this.date,
  });

  int type;
  List<int>? ints;
  String? date;

  factory EcgBean.fromJson(Map<String, dynamic> json) => EcgBean(
        type: json["type"],
        ints: List<int>.from((json["ints"] ?? []).map((x) => x)),
        date: json["date"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "ints": List<dynamic>.from(ints!.map((x) => x)),
        "date": date,
      };
}

MessageBean messageBeanFromJson(String str) => MessageBean.fromJson(json.decode(str));

String messageBeanToJson(MessageBean data) => json.encode(data.toJson());

class MessageBean {
  MessageBean({
    required this.title,
    required this.message,
    required this.type,
    required this.versionCode,
    required this.isHs,
    required this.isSmallScreen,
  });

  String title;
  String message;
  int type;
  int versionCode;
  bool isHs;
  bool isSmallScreen;

  factory MessageBean.fromJson(Map<String, dynamic> json) => MessageBean(
        title: json["title"],
        message: json["message"],
        type: json["type"],
        versionCode: json["versionCode"],
        isHs: json["isHs"],
        isSmallScreen: json["isSmallScreen"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "message": message,
        "type": type,
        "versionCode": versionCode,
        "isHs": isHs,
        "isSmallScreen": isSmallScreen,
      };
}

SedentaryReminderPeriodBean sedentaryReminderPeriodBeanFromJson(String str) => SedentaryReminderPeriodBean.fromJson(json.decode(str));

String sedentaryReminderPeriodBeanToJson(SedentaryReminderPeriodBean data) => json.encode(data.toJson());

class SedentaryReminderPeriodBean {
  SedentaryReminderPeriodBean({
    required this.endHour,
    required this.period,
    required this.startHour,
    required this.steps,
  });

  int endHour;
  int period;
  int startHour;
  int steps;

  factory SedentaryReminderPeriodBean.fromJson(Map<String, dynamic> json) => SedentaryReminderPeriodBean(
        endHour: json["endHour"],
        period: json["period"],
        startHour: json["startHour"],
        steps: json["steps"],
      );

  Map<String, dynamic> toJson() => {
        "endHour": endHour,
        "period": period,
        "startHour": startHour,
        "steps": steps,
      };
}

MenstrualCycleBean menstrualCycleBeanFromJson(String str) => MenstrualCycleBean.fromJson(json.decode(str));

String menstrualCycleBeanToJson(MenstrualCycleBean data) => json.encode(data.toJson());

class MenstrualCycleBean {
  MenstrualCycleBean({
    required this.physiologcalPeriod,
    required this.menstrualPeriod,
    required this.startDate,
    required this.menstrualReminder,
    required this.ovulationReminder,
    required this.ovulationDayReminder,
    required this.ovulationEndReminder,
    required this.reminderHour,
    required this.reminderMinute,
  });

  int physiologcalPeriod;
  int menstrualPeriod;
  String startDate;
  bool menstrualReminder;
  bool ovulationReminder;
  bool ovulationDayReminder;
  bool ovulationEndReminder;
  int reminderHour;
  int reminderMinute;

  factory MenstrualCycleBean.fromJson(Map<String, dynamic> json) => MenstrualCycleBean(
        physiologcalPeriod: json["physiologcalPeriod"],
        menstrualPeriod: json["menstrualPeriod"],
        startDate: json["startDate"],
        menstrualReminder: json["menstrualReminder"],
        ovulationReminder: json["ovulationReminder"],
        ovulationDayReminder: json["ovulationDayReminder"],
        ovulationEndReminder: json["ovulationEndReminder"],
        reminderHour: json["reminderHour"],
        reminderMinute: json["reminderMinute"],
      );

  Map<String, dynamic> toJson() => {
        "physiologcalPeriod": physiologcalPeriod,
        "menstrualPeriod": menstrualPeriod,
        "startDate": startDate,
        "menstrualReminder": menstrualReminder,
        "ovulationReminder": ovulationReminder,
        "ovulationDayReminder": ovulationDayReminder,
        "ovulationEndReminder": ovulationEndReminder,
        "reminderHour": reminderHour,
        "reminderMinute": reminderMinute,
      };
}

DrinkWaterPeriodBean drinkWaterPeriodBeanFromJson(String str) => DrinkWaterPeriodBean.fromJson(json.decode(str));

String drinkWaterPeriodBeanToJson(DrinkWaterPeriodBean data) => json.encode(data.toJson());

class DrinkWaterPeriodBean {
  DrinkWaterPeriodBean({
    required this.enable,
    required this.startHour,
    required this.startMinute,
    required this.count,
    required this.period,
    required this.currentCups,
  });

  bool enable;
  int startHour;
  int startMinute;
  int count;
  int period;
  int currentCups;

  factory DrinkWaterPeriodBean.fromJson(Map<String, dynamic> json) => DrinkWaterPeriodBean(
        enable: json["enable"],
        startHour: json["startHour"],
        startMinute: json["startMinute"],
        count: json["count"],
        period: json["period"],
        currentCups: json["currentCups"],
      );

  Map<String, dynamic> toJson() => {
        "enable": enable,
        "startHour": startHour,
        "startMinute": startMinute,
        "count": count,
        "period": period,
        "currentCups": currentCups,
      };
}

HandWashingPeriodBean handWashingPeriodBeanFromJson(String str) => HandWashingPeriodBean.fromJson(json.decode(str));

String handWashingPeriodBeanToJson(HandWashingPeriodBean data) => json.encode(data.toJson());

class HandWashingPeriodBean {
  HandWashingPeriodBean({
    required this.enable,
    required this.startHour,
    required this.startMinute,
    required this.count,
    required this.period,
  });

  bool enable;
  int startHour;
  int startMinute;
  int count;
  int period;

  factory HandWashingPeriodBean.fromJson(Map<String, dynamic> json) => HandWashingPeriodBean(
        enable: json["enable"],
        startHour: json["startHour"],
        startMinute: json["startMinute"],
        count: json["count"],
        period: json["period"],
      );

  Map<String, dynamic> toJson() => {
        "enable": enable,
        "startHour": startHour,
        "startMinute": startMinute,
        "count": count,
        "period": period,
      };
}

PillReminderBean pillReminderBeanFromJson(String str) => PillReminderBean.fromJson(json.decode(str));

String pillReminderBeanToJson(PillReminderBean data) => json.encode(data.toJson());

class PillReminderBean {
  PillReminderBean({
    required this.id,
    required this.dateOffset,
    required this.name,
    required this.repeat,
    required this.reminderTimeList,
  });

  int id;
  int dateOffset;
  String name;
  int repeat;
  List<dynamic> reminderTimeList;

  factory PillReminderBean.fromJson(Map<String, dynamic> json) => PillReminderBean(
        id: json["id"],
        dateOffset: json["dateOffset"],
        name: json["name"],
        repeat: json["repeat"],
        reminderTimeList: List<dynamic>.from(json["reminderTimeList"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "dateOffset": dateOffset,
        "name": name,
        "repeat": repeat,
        "reminderTimeList": List<dynamic>.from(reminderTimeList.map((x) => x)),
      };
}

ContactBean contactBeanFromJson(String str) => ContactBean.fromJson(json.decode(str));

String contactBeanToJson(ContactBean data) => json.encode(data.toJson());

class ContactBean {
  ContactBean({
    required this.id,
    required this.width,
    required this.height,
    required this.address,
    required this.name,
    required this.number,
    required this.avatar,
    required this.timeout,
  });

  int id;
  int width;
  int height;
  int address;
  String name;
  String number;
  Uint8List? avatar;
  int timeout;

  factory ContactBean.fromJson(Map<String, dynamic> json) => ContactBean(
        id: json["id"],
        width: json["width"],
        height: json["height"],
        address: json["address"],
        name: json["name"],
        number: json["number"],
        avatar: json["avatar"],
        timeout: json["timeout"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "width": width,
        "height": height,
        "address": address,
        "name": name,
        "number": number,
        "avatar": avatar,
        "timeout": timeout,
      };
}

TrainBean trainBeanFromJson(String str) => TrainBean.fromJson(json.decode(str));

String trainBeanToJson(TrainBean data) => json.encode(data.toJson());

class TrainBean {
  TrainBean({
    required this.historyTrainList,
    required this.trainingList,
    required this.type,
  });

  List<HistoryTrainList>? historyTrainList;
  List<TrainingInfo>? trainingList;
  int type;

  factory TrainBean.fromJson(Map<String, dynamic> json) => TrainBean(
        historyTrainList: List<HistoryTrainList>.from((json["historyTrainList"] ?? []).map((x) => HistoryTrainList.fromJson(x))),
        trainingList: List<TrainingInfo>.from((json["trainingList"] ?? []).map((x) => TrainingInfo.fromJson(x))),
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "historyTrainList": List<HistoryTrainList>.from(historyTrainList!.map((x) => x)),
        "trainingList": List<TrainingInfo>.from(trainingList!.map((x) => x)),
        "type": type,
      };
}

class HistoryTrainList {
  HistoryTrainList({
    required this.startTime,
    required this.type,
    required this.id,
  });

  int? startTime;
  int? type;
  int? id;

  factory HistoryTrainList.fromJson(Map<String, dynamic> json) => HistoryTrainList(
        startTime: json["startTime"] ?? -1,
        type: json["type"] ?? -1,
        id: json["id"] ?? -1,
      );

  Map<String, dynamic> toJson() => {
        "startTime": startTime,
        "type": type,
        "id": id,
      };
}

class TrainingInfo {
  TrainingInfo({
    required this.type,
    required this.startTime,
    required this.endTime,
    required this.validTime,
    required this.steps,
    required this.distance,
    required this.calories,
    required this.hrList,
  });

  int? type;
  int? startTime;
  int? endTime;
  int? validTime;
  int? steps;
  int? distance;
  int? calories;
  List<int>? hrList;

  factory TrainingInfo.fromJson(Map<String, dynamic> json) => TrainingInfo(
        type: json["type"] ?? -1,
        startTime: json["startTime"] ?? -1,
        endTime: json["endTime"] ?? -1,
        validTime: json["validTime"] ?? -1,
        steps: json["steps"] ?? -1,
        distance: json["distance"] ?? -1,
        calories: json["calories"] ?? -1,
        hrList: List<int>.from((json["hrList"] ?? []).map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "startTime": startTime,
        "endTime": endTime,
        "validTime": validTime,
        "steps": steps,
        "distance": distance,
        "calories": calories,
        "hrList": List<dynamic>.from(hrList!.map((x) => x)),
      };
}

DeviceLanguageBean deviceLanguageBeanFromJson(String str) => DeviceLanguageBean.fromJson(json.decode(str));

String deviceLanguageBeanToJson(DeviceLanguageBean data) => json.encode(data.toJson());

class DeviceLanguageBean {
  DeviceLanguageBean({
    required this.languageType,
    required this.type,
  });

  List<int> languageType;
  int type;

  factory DeviceLanguageBean.fromJson(Map<String, dynamic> json) => DeviceLanguageBean(
        languageType: List<int>.from(json["languageType"].map((x) => x)),
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "languageType": List<dynamic>.from(languageType.map((x) => x)),
        "type": type,
      };
}

PeriodTimeResultBean periodTimeResultBeanFromJson(String str) => PeriodTimeResultBean.fromJson(json.decode(str));

String periodTimeResultBeanToJson(PeriodTimeResultBean data) => json.encode(data.toJson());

class PeriodTimeResultBean {
  PeriodTimeResultBean({
    required this.periodTimeType,
    required this.periodTimeInfo,
  });

  int periodTimeType;
  PeriodTimeBean periodTimeInfo;

  factory PeriodTimeResultBean.fromJson(Map<String, dynamic> json) => PeriodTimeResultBean(
        periodTimeType: json["periodTimeType"],
        periodTimeInfo: PeriodTimeBean.fromJson(json["periodTimeInfo"]),
      );

  Map<String, dynamic> toJson() => {
        "periodTimeType": periodTimeType,
        "periodTimeInfo": periodTimeInfo.toJson(),
      };
}

BrightnessBean brightnessBeanFromJson(String str) => BrightnessBean.fromJson(json.decode(str));

String brightnessBeanToJson(BrightnessBean data) => json.encode(data.toJson());

class BrightnessBean {
  BrightnessBean({
    required this.current,
    required this.max,
  });

  int current;
  int max;

  factory BrightnessBean.fromJson(Map<String, dynamic> json) => BrightnessBean(
        current: json["current"],
        max: json["max"],
      );

  Map<String, dynamic> toJson() => {
        "current": current,
        "max": max,
      };
}

MaxHeartRateBean maxHeartRateBeanFromJson(String str) => MaxHeartRateBean.fromJson(json.decode(str));

String maxHeartRateBeanToJson(MaxHeartRateBean data) => json.encode(data.toJson());

class MaxHeartRateBean {
  MaxHeartRateBean({
    required this.heartRate,
    required this.enable,
  });

  int heartRate;
  bool enable;

  factory MaxHeartRateBean.fromJson(Map<String, dynamic> json) => MaxHeartRateBean(
        heartRate: json["heartRate"],
        enable: json["enable"],
      );

  Map<String, dynamic> toJson() => {
        "heartRate": heartRate,
        "enable": enable,
      };
}

WatchFaceIdBean watchFaceIdBeanFromJson(String str) => WatchFaceIdBean.fromJson(json.decode(str));

String watchFaceIdBeanToJson(WatchFaceIdBean data) => json.encode(data.toJson());

class WatchFaceIdBean {
  WatchFaceIdBean({
    required this.watchFace,
    required this.error,
    required this.code,
  });

  WatchFace watchFace;
  String? error;
  int code;

  factory WatchFaceIdBean.fromJson(Map<String, dynamic> json) => WatchFaceIdBean(
        watchFace: WatchFace.fromJson(json["watchFace"]),
        error: json["error"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "watchFace": watchFace.toJson(),
        "error": error,
        "code": code,
      };
}

class WatchFace {
  WatchFace({
    required this.id,
    required this.preview,
    required this.file,
  });

  int? id;
  String? preview;
  String? file;

  factory WatchFace.fromJson(Map<String, dynamic> json) => WatchFace(
        id: json["id"] ?? -1,
        preview: json["preview"] ?? "",
        file: json["file"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "preview": preview,
        "file": file,
      };
}

WatchFaceStoreResultBean watchFaceStoreListResultBeanFromJson(String str) => WatchFaceStoreResultBean.fromJson(json.decode(str));

String watchFaceStoreListResultBeanToJson(WatchFaceStoreResultBean data) => json.encode(data.toJson());

class WatchFaceStoreResultBean {
  WatchFaceStoreResultBean({
    required this.watchFaceStoreInfo,
    required this.error,
  });

  WatchFaceStore? watchFaceStoreInfo;
  String? error;

  factory WatchFaceStoreResultBean.fromJson(Map<String, dynamic> json) => WatchFaceStoreResultBean(
        watchFaceStoreInfo: WatchFaceStore.fromJson(json["watchFaceStoreInfo"] ?? {}),
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "watchFaceStoreInfo": watchFaceStoreInfo!.toJson(),
        "error": error,
      };
}

class WatchFaceStore {
  WatchFaceStore({
    required this.total,
    required this.prePage,
    required this.pageIndex,
    required this.list,
  });

  int? total;
  int? prePage;
  int? pageIndex;
  List<WatchFaceBean>? list;

  factory WatchFaceStore.fromJson(Map<String, dynamic> json) => WatchFaceStore(
        total: json["total"] ?? -1,
        prePage: json["prePage"] ?? -1,
        pageIndex: json["pageIndex"] ?? -1,
        list: List<WatchFaceBean>.from((json["list"] ?? []).map((x) => WatchFaceBean.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "prePage": prePage,
        "pageIndex": pageIndex,
        "list": List<dynamic>.from(list!.map((x) => x.toJson())),
      };
}

class ListClass {
  ListClass({
    required this.id,
    required this.preview,
    required this.file,
  });

  int id;
  String preview;
  String file;

  factory ListClass.fromJson(Map<String, dynamic> json) => ListClass(
        id: json["id"],
        preview: json["preview"],
        file: json["file"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "preview": preview,
        "file": file,
      };
}

FileTransBean fileTransBeanFromJson(String str) => FileTransBean.fromJson(json.decode(str));

String wfFileTransBeanToJson(FileTransBean data) => json.encode(data.toJson());

class FileTransBean {
  FileTransBean({
    required this.type,
    required this.progress,
    required this.error,
  });

  int type;
  int? progress;
  int? error;

  factory FileTransBean.fromJson(Map<String, dynamic> json) => FileTransBean(
        progress: json["progress"] ?? -1,
        error: json["error"] ?? -1,
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "progress": progress,
        "error": error,
      };
}

ContactListenBean contactListenBeanFromJson(String str) => ContactListenBean.fromJson(json.decode(str));

String contactListenBeanToJson(ContactListenBean data) => json.encode(data.toJson());

class ContactListenBean {
  ContactListenBean({
    required this.type,
    required this.savedSuccess,
    required this.savedFail,
  });

  int type;
  int? savedSuccess;
  int? savedFail;

  factory ContactListenBean.fromJson(Map<String, dynamic> json) => ContactListenBean(
        type: json["type"],
        savedSuccess: json["savedSuccess"] ?? -1,
        savedFail: json["savedFail"] ?? -1,
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "savedSuccess": savedSuccess!,
        "savedFail": savedFail!,
      };
}

DeviceBatteryBean deviceBatteryBeanFromJson(String str) => DeviceBatteryBean.fromJson(json.decode(str));

String deviceBatteryBeanToJson(DeviceBatteryBean data) => json.encode(data.toJson());

class DeviceBatteryBean {
  DeviceBatteryBean({
    required this.type,
    required this.subscribe,
    required this.deviceBattery,
  });

  int type;
  bool? subscribe;
  int? deviceBattery;

  factory DeviceBatteryBean.fromJson(Map<String, dynamic> json) => DeviceBatteryBean(
        type: json["type"],
        subscribe: json["subscribe"] ?? false,
        deviceBattery: json["deviceBattery"] ?? -1,
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "subscribe": subscribe,
        "deviceBattery": deviceBattery,
      };
}

UpgradeErrorBean upgradeErrorBeanFromJson(String str) => UpgradeErrorBean.fromJson(json.decode(str));

String upgradeErrorBeanToJson(UpgradeErrorBean data) => json.encode(data.toJson());

class UpgradeErrorBean {
  UpgradeErrorBean({
    required this.error,
    required this.errorContent,
  });

  int? error;
  String? errorContent;

  factory UpgradeErrorBean.fromJson(Map<String, dynamic> json) => UpgradeErrorBean(
        error: json["error"],
        errorContent: json["errorContent"],
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "errorContent": errorContent,
      };
}

OTABean oTABeanFromJson(String str) => OTABean.fromJson(json.decode(str));

String oTABeanToJson(OTABean data) => json.encode(data.toJson());

class OTABean {
  OTABean({
    required this.type,
    required this.upgradeError,
    required this.upgradeProgress,
    required this.start,
  });

  int type;
  int? upgradeProgress;
  bool? start;
  UpgradeErrorBean? upgradeError;

  factory OTABean.fromJson(Map<String, dynamic> json) => OTABean(
        type: json["type"],
        start: json["start"] ?? false,
        upgradeError: UpgradeErrorBean.fromJson(json["upgradeError"] ?? {}),
        upgradeProgress: json["upgradeProgress"] ?? -1,
      );

  Map<String, dynamic> toJson() => {"type": type, "start": start, "upgradeError": upgradeError!.toJson(), "upgradeProgress": upgradeProgress};
}

ContactConfigBean contactConfigBeanFromJson(String str) => ContactConfigBean.fromJson(json.decode(str));

String contactConfigBeanToJson(ContactConfigBean data) => json.encode(data.toJson());

class ContactConfigBean {
  ContactConfigBean({
    required this.supported,
    required this.count,
    required this.width,
    required this.height,
  });

  bool supported;
  int count;
  int width;
  int height;

  factory ContactConfigBean.fromJson(Map<String, dynamic> json) => ContactConfigBean(
        supported: json["supported"],
        count: json["count"],
        width: json["width"],
        height: json["height"],
      );

  Map<String, dynamic> toJson() => {
        "supported": supported,
        "count": count,
        "width": width,
        "height": height,
      };
}

TempChangeBean tempChangeBeanFromJson(String str) => TempChangeBean.fromJson(json.decode(str));

String tempChangeBeanToJson(TempChangeBean data) => json.encode(data.toJson());

class TempChangeBean {
  TempChangeBean({
    required this.enable,
    required this.temp,
    required this.state,
    required this.tempInfo,
    required this.type,
  });

  bool? enable;
  double? temp;
  bool? state;
  TempInfo? tempInfo;
  int type;

  factory TempChangeBean.fromJson(Map<String, dynamic> json) => TempChangeBean(
        enable: json["enable"] ?? false,
        temp: (json["temp"] ?? 0.0).toDouble(),
        state: json["state"] ?? false,
        tempInfo: TempInfo.fromJson(json["tempInfo"] ?? {}),
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "enable": enable!,
        "temp": temp!,
        "state": state!,
        "tempInfo": tempInfo!.toJson(),
        "type": type,
      };
}

class TempInfo {
  TempInfo({
    required this.tempTimeType,
    required this.startTime,
    required this.tempList,
  });

  String? tempTimeType;
  int? startTime;
  List<double>? tempList;

  factory TempInfo.fromJson(Map<String, dynamic> json) => TempInfo(
        tempTimeType: json["tempTimeType"] ?? "",
        startTime: json["startTime"] ?? -1,
        tempList: List<double>.from((json["tempList"] ?? []).map((x) => x.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "tempTimeType": tempTimeType,
        "startTime": startTime,
        "tempList": List<dynamic>.from(tempList!.map((x) => x)),
      };
}

PillReminderCallback pillReminderCallbackFromJson(String str) => PillReminderCallback.fromJson(json.decode(str));

String pillReminderCallbackToJson(PillReminderCallback data) => json.encode(data.toJson());

class PillReminderCallback {
  PillReminderCallback({
    required this.supportCount,
    required this.list,
  });

  int supportCount;
  List<PillReminderBean> list;

  factory PillReminderCallback.fromJson(Map<String, dynamic> json) => PillReminderCallback(
        supportCount: json["supportCount"],
        list: List<PillReminderBean>.from(json["list"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "supportCount": supportCount,
        "list": List<PillReminderBean>.from(list.map((x) => x)),
      };
}

OtaBean otaBeanFromJson(String str) => OtaBean.fromJson(json.decode(str));

String otaBeanToJson(OtaBean data) => json.encode(data.toJson());

class OtaBean {
  OtaBean({
    required this.address,
    required this.type,
  });

  String address;
  int type;

  factory OtaBean.fromJson(Map<String, dynamic> json) => OtaBean(
        address: json["address"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "address": address,
        "type": type,
      };
}

SendWatchFaceBean sendWatchFaceBeanFromJson(String str) => SendWatchFaceBean.fromJson(json.decode(str));

String sendWatchFaceBeanToJson(SendWatchFaceBean data) => json.encode(data.toJson());

class SendWatchFaceBean {
  SendWatchFaceBean({
    required this.watchFaceFlutterBean,
    required this.timeout,
  });

  CustomizeWatchFaceBean watchFaceFlutterBean;
  int timeout;

  factory SendWatchFaceBean.fromJson(Map<String, dynamic> json) => SendWatchFaceBean(
        watchFaceFlutterBean: CustomizeWatchFaceBean.fromJson(json["watchFaceFlutterBean"]),
        timeout: json["timeout"],
      );

  Map<String, dynamic> toJson() => {
        "watchFaceFlutterBean": watchFaceFlutterBean.toJson(),
        "timeout": timeout,
      };
}

WeatherChangeBean weatherChangeBeanFromJson(String str) => WeatherChangeBean.fromJson(json.decode(str));

String weatherChangeBeanToJson(WeatherChangeBean data) => json.encode(data.toJson());

class WeatherChangeBean {
  WeatherChangeBean({
    required this.type,
    required this.tempUnit,
  });

  int type;
  int? tempUnit;

  factory WeatherChangeBean.fromJson(Map<String, dynamic> json) => WeatherChangeBean(
        type: json["type"],
        tempUnit: json["tempUnit"] ?? -1,
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "tempUnit": tempUnit!,
      };
}

FirmwareVersion firmwareVersionFromJson(String str) => FirmwareVersion.fromJson(json.decode(str));

String firmwareVersionToJson(FirmwareVersion data) => json.encode(data.toJson());

class FirmwareVersion {
  FirmwareVersion({
    required this.version,
    required this.otaType,
  });

  String version;
  int otaType;

  factory FirmwareVersion.fromJson(Map<String, dynamic> json) => FirmwareVersion(
        version: json["version"],
        otaType: json["OTAType"],
      );

  Map<String, dynamic> toJson() => {
        "version": version,
        "OTAType": otaType,
      };
}

DailyGoalsInfoBean dailyGoalsInfoBeanFromJson(String str) => DailyGoalsInfoBean.fromJson(json.decode(str));

String dailyGoalsInfoBeanToJson(DailyGoalsInfoBean data) => json.encode(data.toJson());

class DailyGoalsInfoBean {
  DailyGoalsInfoBean({
    required this.steps,
    required this.calories,
    required this.trainingTime,
    required this.distance,
  });

  int steps;
  int calories;
  int trainingTime;
  int distance;

  factory DailyGoalsInfoBean.fromJson(Map<String, dynamic> json) =>
      DailyGoalsInfoBean(steps: json["steps"], calories: json["calories"], trainingTime: json["trainingTime"], distance: json["distance"]);

  Map<String, dynamic> toJson() => {"steps": steps, "calories": calories, "trainingTime": trainingTime, "distance": distance};
}

TrainingDayInfoBean trainingDayInfoBeanFromJson(String str) => TrainingDayInfoBean.fromJson(json.decode(str));

String trainingDayInfoBeanToJson(TrainingDayInfoBean data) => json.encode(data.toJson());

class TrainingDayInfoBean {
  TrainingDayInfoBean({
    required this.enable,
    required this.trainingDays,
  });

  bool enable;
  List<int> trainingDays;

  factory TrainingDayInfoBean.fromJson(Map<String, dynamic> json) => TrainingDayInfoBean(
        enable: json["enable"],
        trainingDays: List<int>.from(json["trainingDays"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "enable": enable,
        "trainingDays": List<dynamic>.from(trainingDays.map((x) => x)),
      };
}

ElectronicCardInfoBean electronicCardInfoBeanFromJson(String str) => ElectronicCardInfoBean.fromJson(json.decode(str));

String electronicCardInfoBeanToJson(ElectronicCardInfoBean data) => json.encode(data.toJson());

class ElectronicCardInfoBean {
  ElectronicCardInfoBean({
    required this.id,
    required this.title,
    required this.url,
  });

  int id;
  String title;
  String url;

  factory ElectronicCardInfoBean.fromJson(Map<String, dynamic> json) => ElectronicCardInfoBean(
        id: json["id"],
        title: json["title"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "url": url,
      };
}

CalendarEventInfoBean calendarEventInfoBeanFromJson(String str) => CalendarEventInfoBean.fromJson(json.decode(str));

String calendarEventInfoBeanToJson(CalendarEventInfoBean data) => json.encode(data.toJson());

class CalendarEventInfoBean {
  CalendarEventInfoBean({
    required this.id,
    required this.title,
    required this.startHour,
    required this.startMinute,
    required this.endHour,
    required this.endMinute,
    required this.time,
  });

  int id;
  String title;
  int startHour;
  int startMinute;
  int endHour;
  int endMinute;
  int time;

  factory CalendarEventInfoBean.fromJson(Map<String, dynamic> json) => CalendarEventInfoBean(
        id: json["id"],
        title: json["title"],
        startHour: json["startHour"],
        startMinute: json["startMinute"],
        endHour: json["endHour"],
        endMinute: json["endMinute"],
        time: json["time"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "startHour": startHour,
        "startMinute": startMinute,
        "endHour": endHour,
        "endMinute": endMinute,
        "time": time,
      };
}

CalendarEventReminderTimeBean calendarEventReminderTimeBeanFromJson(String str) => CalendarEventReminderTimeBean.fromJson(json.decode(str));

String calendarEventReminderTimeBeanToJson(CalendarEventReminderTimeBean data) => json.encode(data.toJson());

class CalendarEventReminderTimeBean {
  CalendarEventReminderTimeBean({
    required this.enable,
    required this.minutes,
  });

  bool enable;
  int minutes;

  factory CalendarEventReminderTimeBean.fromJson(Map<String, dynamic> json) => CalendarEventReminderTimeBean(
        enable: json["enable"],
        minutes: json["minutes"],
      );

  Map<String, dynamic> toJson() => {
        "enable": enable,
        "minutes": minutes,
      };
}

ElectronicCardCountInfoBean electronicCardCountInfoBeanFromJson(String str) => ElectronicCardCountInfoBean.fromJson(json.decode(str));

String electronicCardCountInfoBeanToJson(ElectronicCardCountInfoBean data) => json.encode(data.toJson());

class ElectronicCardCountInfoBean {
  ElectronicCardCountInfoBean({
    required this.count,
    required this.urlBytesLimit,
    required this.savedIdList,
  });

  int count;
  int urlBytesLimit;
  List<int> savedIdList;

  factory ElectronicCardCountInfoBean.fromJson(Map<String, dynamic> json) => ElectronicCardCountInfoBean(
        count: json["count"],
        urlBytesLimit: json["urlBytesLimit"],
        savedIdList: List<int>.from(json["savedIdList"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "urlBytesLimit": urlBytesLimit,
        "savedIdList": List<dynamic>.from(savedIdList.map((x) => x)),
      };
}

CalendarEventBean calendarEventBeanFromJson(String str) => CalendarEventBean.fromJson(json.decode(str));

String calendarEventBeanToJson(CalendarEventBean data) => json.encode(data.toJson());

class CalendarEventBean {
  CalendarEventBean({
    required this.type,
    required this.maxNumber,
    required this.list,
    required this.state,
    required this.time,
    required this.calendarEventInfo,
  });

  int type;
  int maxNumber;
  List<SavedCalendarEventInfoBean> list;
  bool state;
  int time;
  CalendarEventInfoBean calendarEventInfo;

  factory CalendarEventBean.fromJson(Map<String, dynamic> json) => CalendarEventBean(
        type: json["type"],
        maxNumber: json["maxNumber"] ?? -1,
        list: List<SavedCalendarEventInfoBean>.from((json["list"] ?? []).map((x) => (SavedCalendarEventInfoBean.fromJson(x)))),
        state: json["statet"] ?? false,
        time: json["time"] ?? -1,
        calendarEventInfo: CalendarEventInfoBean.fromJson(json["calendarEventInfo"] ?? {}),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "maxNumber": maxNumber,
        "list": List<dynamic>.from(list.map((x) => x)),
        "statet": state,
        "time": time,
        "calendarEventInfo": calendarEventInfo,
      };
}

class SavedCalendarEventInfoBean {
  SavedCalendarEventInfoBean({
    required this.id,
    required this.time,
  });

  int id;
  List<int> time;

  factory SavedCalendarEventInfoBean.fromJson(Map<String, dynamic> json) => SavedCalendarEventInfoBean(
        id: json["id"],
        time: List<int>.from(json["time"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "time": List<dynamic>.from(time.map((x) => x)),
      };
}

FindPhoneBean findPhoneBeanFromJson(String str) => FindPhoneBean.fromJson(json.decode(str));

String findPhoneBeanToJson(FindPhoneBean data) => json.encode(data.toJson());

class FindPhoneBean {
  FindPhoneBean({
    required this.type,
  });

  int type;

  factory FindPhoneBean.fromJson(Map<String, dynamic> json) => FindPhoneBean(
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
      };
}

HrvHandlerBean hrvHandlerBeanFromJson(String str) => HrvHandlerBean.fromJson(json.decode(str));

String hrvHandlerBeanToJson(HrvHandlerBean data) => json.encode(data.toJson());

class HrvHandlerBean {
  HrvHandlerBean({
    required this.type,
    required this.isSupport,
    required this.value,
    required this.list,
  });

  int type;
  bool isSupport;
  int value;
  List<HistoryHrvInfoBean> list;

  factory HrvHandlerBean.fromJson(Map<String, dynamic> json) => HrvHandlerBean(
        type: json["type"],
        isSupport: json["isSupport"] ?? false,
        value: json["value"] ?? -1,
        list: List<HistoryHrvInfoBean>.from((json["list"] ?? []).map((x) => (HistoryHrvInfoBean.fromJson(x)))),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "isSupport": isSupport,
        "value": value,
        "list": List<dynamic>.from(list.map((x) => x)),
      };
}

class HistoryHrvInfoBean {
  HistoryHrvInfoBean({
    required this.date,
    required this.hrv,
  });

  String date;
  int hrv;

  factory HistoryHrvInfoBean.fromJson(Map<String, dynamic> json) => HistoryHrvInfoBean(
        date: json["date"],
        hrv: json["hrv"],
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "hrv": hrv,
      };
}

StressHandlerBean stressHandlerBeanFromJson(String str) => StressHandlerBean.fromJson(json.decode(str));

String stressHandlerBeanToJson(StressHandlerBean data) => json.encode(data.toJson());

class StressHandlerBean {
  StressHandlerBean({
    required this.type,
    required this.isSupport,
    required this.value,
    required this.list,
    required this.state,
    required this.timingStressInfo,
  });

  int type;
  bool isSupport;
  int value;
  List<HistoryStressInfoBean> list;
  bool state;
  TimingStressInfoBean timingStressInfo;

  factory StressHandlerBean.fromJson(Map<String, dynamic> json) => StressHandlerBean(
        type: json["type"],
        isSupport: json["isSupport"] ?? false,
        value: json["value"] ?? -1,
        list: List<HistoryStressInfoBean>.from((json["list"] ?? []).map((x) => (HistoryStressInfoBean.fromJson(x)))),
        state: json["state"] ?? false,
        timingStressInfo: TimingStressInfoBean.fromJson(json["timingStressInfo"] ?? {}),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "isSupport": isSupport,
        "value": value,
        "list": List<dynamic>.from(list.map((x) => x)),
        "state": state,
        "timingStressInfo": timingStressInfo,
      };
}

HistoryStressInfoBean historyStressInfoBeanFromJson(String str) => HistoryStressInfoBean.fromJson(json.decode(str));

String historyStressInfoBeanToJson(HistoryStressInfoBean data) => json.encode(data.toJson());

class HistoryStressInfoBean {
  HistoryStressInfoBean({
    required this.date,
    required this.stress,
  });

  int? date;
  int? stress;

  factory HistoryStressInfoBean.fromJson(Map<String, dynamic> json) => HistoryStressInfoBean(
        date: json["date"] ?? -1,
        stress: json["stress"] ?? -1,
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "stress": stress,
      };
}

TimingStressInfoBean timingStressInfoBeanFromJson(String str) => TimingStressInfoBean.fromJson(json.decode(str));

String timingStressInfoBeanToJson(TimingStressInfoBean data) => json.encode(data.toJson());

class TimingStressInfoBean {
  TimingStressInfoBean({
    required this.date,
    required this.list,
  });

  String? date;
  List<int>? list;

  factory TimingStressInfoBean.fromJson(Map<String, dynamic> json) => TimingStressInfoBean(
    date: json["date"] ?? "",
        list: List<int>.from((json["list"] ?? []).map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "list": List<dynamic>.from(list!.map((x) => x)),
      };
}

class StressDateBean {
  StressDateBean({
    required this.value,
  });

  int? value;

  factory StressDateBean.fromJson(Map<String, dynamic> json) => StressDateBean(
        value: json["value"] ?? -1,
      );

  Map<String, dynamic> toJson() => {
        "value": value,
      };
}

GpsChangeEventBean gpsChangeEventBeanFromJson(String str) => GpsChangeEventBean.fromJson(json.decode(str));

String gpsChangeEventBeanToJson(GpsChangeEventBean data) => json.encode(data.toJson());

class GpsChangeEventBean {
  GpsChangeEventBean({
    required this.time,
  });

  int? time;

  factory GpsChangeEventBean.fromJson(Map<String, dynamic> json) => GpsChangeEventBean(
        time: json["time"] ?? -1,
      );

  Map<String, dynamic> toJson() => {
        "time": time,
      };
}

GpsPathInfo gpsPathInfoFromJson(String str) => GpsPathInfo.fromJson(json.decode(str));

String gpsPathInfoToJson(GpsPathInfo data) => json.encode(data.toJson());

class GpsPathInfo {
  GpsPathInfo({
    required this.time,
    required this.locationList,
  });

  int? time;
  List<Location>? locationList;

  factory GpsPathInfo.fromJson(Map<String, dynamic> json) => GpsPathInfo(
        time: json["time"] ?? -1,
        locationList: List<Location>.from((json["locationList"] ?? []).map((x) => (Location.fromJson(x)))),
      );

  Map<String, dynamic> toJson() => {
        "time": time,
      };
}

Location locationFromJson(String str) => Location.fromJson(json.decode(str));

String locationToJson(Location data) => json.encode(data.toJson());

class Location {
  Location({
    required this.latitude,
    required this.longitude,
  });

  double latitude;
  double longitude;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
      };
}

VibrationStrength vibrationStrengthFromJson(String str) => VibrationStrength.fromJson(json.decode(str));

String vibrationStrengthToJson(VibrationStrength data) => json.encode(data.toJson());

class VibrationStrength {
  VibrationStrength({
    required this.value,
  });

  int? value;

  factory VibrationStrength.fromJson(Map<String, dynamic> json) => VibrationStrength(
        value: json["value"] ?? -1,
      );

  Map<String, dynamic> toJson() => {
        "value": value,
      };
}

The24HourListBean the24HourListBeanFromJson(String str) => The24HourListBean.fromJson(json.decode(str));

String the24HourListBeanToJson(The24HourListBean data) => json.encode(data.toJson());

class The24HourListBean {
  The24HourListBean({
    required this.list,
  });

  List<ListBean>? list;

  factory The24HourListBean.fromJson(Map<String, dynamic> json) => The24HourListBean(
        list: List<ListBean>.from(
          (json["list"] ?? []).map(
            (x) => (ListBean.fromJson(x)),
          ),
        ),
      );

  Map<String, dynamic> toJson() => {
        "value": list,
      };
}

ListBean listBeanFromJson(String str) => ListBean.fromJson(json.decode(str));

String listBeanToJson(ListBean data) => json.encode(data.toJson());

class ListBean {
  ListBean({
    required this.value,
  });

  int? value;

  factory ListBean.fromJson(Map<String, dynamic> json) => ListBean(
        value: json["value"] ?? -1,
      );

  Map<String, dynamic> toJson() => {
        "value": value,
      };
}

CameraBean cameraBeanFromJson(String str) => CameraBean.fromJson(json.decode(str));

String cameraBeanToJson(CameraBean data) => json.encode(data.toJson());

class CameraBean {
  CameraBean({
    required this.takePhoto,
    required this.delayTime,
  });

  String? takePhoto;
  int? delayTime;

  factory CameraBean.fromJson(Map<String, dynamic> json) => CameraBean(
        takePhoto: json["takePhoto"] ?? "",
        delayTime: json["delayTime"] ?? -1,
      );

  Map<String, dynamic> toJson() => {
        "takePhoto": takePhoto,
        "delayTime": delayTime,
      };
}

NotificationBean notificationBeanFromJson(String str) => NotificationBean.fromJson(json.decode(str));

String notificationBeanToJson(NotificationBean data) => json.encode(data.toJson());

class NotificationBean {
  NotificationBean({
    required this.isNew,
    required this.list,
  });

  bool? isNew;
  List<int>? list;

  factory NotificationBean.fromJson(Map<String, dynamic> json) => NotificationBean(
        isNew: json["isNew"] ?? false,
        list: List<int>.from((json["list"] ?? []).map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "isNew": isNew,
        "list": List<dynamic>.from(list!.map((x) => x)),
      };
}
