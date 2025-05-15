class McuPlatform {
  static const int platformNone = 0;
  static const int platformNordic = 1;
  static const int platformHuntersun = 2;
  static const int platformRealtek = 3;
  static const int platformGoodix = 4;
  static const int platformSifli = 5;
  static const int platformJieli = 6;
}

class TimeSystemType {
  static const int timeSystem12 = 0;
  static const int timeSystem24 = 1;
}

class WeatherId {
  static const int cloudy = 0;
  static const int foggy = 1;
  static const int overcast = 2;
  static const int rainy = 3;
  static const int snowy = 4;
  static const int sunny = 5;
  static const int sandstorm = 6;
  static const int haze = 7;
}

class SleepHistoryTimeType {
  static const int today = 0;
  static const int yesterday = 1;
  static const int theDayBeforeYesterday = 2;
}

class StepsDetailDateType {
  static const int today = 0;
  static const int yesterday = 1;
  static const int theDayBeforeYesterday = 2;
  static const int threeDaysAgo = 3;
  static const int fourDaysAgo = 4;
  static const int fiveDaysAgo = 5;
  static const int sixDaysAgo = 6;
}

class TempTimeType {
  static const String today = "TODAY";
  static const String yesterday = "YESTERDAY";
}

class UnitSystemType {
  static const int metricSystem = 0;
  static const int imperialSystem = 1;
}

class WatchFaceType {
  static const int firstWatchFace = 1;
  static const int secondWatchFace = 2;
  static const int thirdWatchFace = 3;
  static const int newCustomizeWatchFace = 4;
}

class WatchFaceLayoutType {
  static const String defaultWatchFaceBgMd5 = "00000000000000000000000000000000";
  static const int watchFaceTimeTop = 0;
  static const int watchFaceTimeBottom = 1;
  static const int watchFaceContentclose = 0;
  static const int watchFaceContentDate = 1;
  static const int watchFaceContentSleep = 2;
  static const int watchFaceContentHeartRate = 3;
  static const int watchFaceContentStep = 4;
}

class TodayHeartRateType {
  static const int timingMeasureHeartRate = 1;
  static const int allDayHeartRate = 2;
}

class HistoryHeartRateDay {
  static const int historyDay = 0;
}

class BloodOxygenTimeType {
  static const String today = 'TODAY';
  static const String yesterday = 'YESTERDAY';
}

class PhoneOperationType {
  static const int musicPlayOrPause = 0;
  static const int musicPrevious = 1;
  static const int musicNext = 2;
  static const int rejectIncoming = 3;
  static const int volumeUp = 4;
  static const int volumeDown = 5;
  static const int musicPlay = 6;
  static const int musicPause = 7;
}

class OTAType {
  static const int normalUpgradeType = 0;
  static const int betaUpgradeType = 1;
  static const int forcedUpdateType = 2;
}

enum CompressionType {
  lzo,
  rgbDeduplication,
  rgbLine,
  original,
}

class EcgMeasureType {
  static const String tyhx = "TYHX";
  static const String ti = "TI";
}

class HistoryDynamicRateType {
  static const String firstHeartRate = "FIRST_HEART_RATE";
  static const String secondHeartRate = "SECOND_HEART_RATE";
  static const String thirdHeartRate = "THIRD_HEART_RATE";
}

class ActionHeartRateType {
  static const String partHeartRate = "PART_HEART_RATE";
  static const String todayHeartRate = "TODAY_HEART_RATE";
  static const String yesterdayHeartRate = "YESTERDAY_HEART_RATE";
}

class DeviceVersionType {
  static const int chineseEdition = 0;
  static const int internationalEdition = 1;
}

class DeviceLanguageType {
  static const int languageEnglish = 0;
  static const int languageChinese = 1;
  static const int languageJapanese = 2;
  static const int languageKorean = 3;
  static const int languageGerman = 4;
  static const int languageFrensh = 5;
  static const int languageSpanish = 6;
  static const int languageArabic = 7;
  static const int languageRussian = 8;
  static const int languageTraditional = 9;
  static const int languageUkrainian = 10;
  static const int languageItalian = 11;
  static const int languagePortuguese = 12;
  static const int languageDutch = 13;
  static const int languagePolish = 14;
  static const int languageSwedish = 15;
  static const int languageFinnish = 16;
  static const int languageDanish = 17;
  static const int languageNorwegian = 18;
  static const int languageHungarian = 19;
  static const int languageCzech = 20;
  static const int languageBulgarian = 21;
  static const int languageRomanian = 22;
  static const int languageSlovakLanguage = 23;
  static const int languageLatvian = 24;
}

class BleMessageType {
  static const int call = 0;
  static const int sms = 1;
  static const int wechat = 2;
  static const int qq = 3;
  static const int facebook = 130;
  static const int twitter = 131;
  static const int whatsApp = 4;
  static const int wechatIn = 5;
  static const int instagram = 6;
  static const int skype = 7;
  static const int kaKao = 8;
  static const int line = 9;
  static const int email = 11;
  static const int messenger = 12;
  static const int zalo = 13;
  static const int telegram = 14;
  static const int viber = 15;
  static const int nateOn = 16;
  static const int gmail = 17;
  static const int calendar = 18;
  static const int dailyHunt = 19;
  static const int outlook = 20;
  static const int yahoo = 21;
  static const int inshorts = 22;
  static const int phonepe = 23;
  static const int gpay = 24;
  static const int paytm = 25;
  static const int swiggy = 26;
  static const int zomato = 27;
  static const int uber = 28;
  static const int ola = 29;
  static const int reflexApp = 30;
  static const int snapchat = 31;
  static const int ytMusic = 32;
  static const int youTube = 33;
  static const int linkEdin = 34;
  static const int amazon = 35;
  static const int flipkart = 36;
  static const int netFlix = 37;
  static const int hotstar = 38;
  static const int amazonPrime = 39;
  static const int googleChat = 40;
  static const int wynk = 41;
  static const int googleDrive = 42;
  static const int dunzo = 43;
  static const int gaana = 44;
  static const int missCall = 45;
  static const int whatsAppBusiness = 46;
  static const int dingtalk = 47;
  static const int tiktok = 48;
  static const int lyft = 49;
  static const int mail = 50;
  static const int googleMaps = 51;
  static const int slack = 52;
  static const int microsoftTeams = 53;
  static const int mormaiiSmartwatches = 54;
  static const int other = 128;
}

class PlayerStateType {
  static const int musicPlayerPause = 0;
  static const int musicPlayerPlay = 1;
}

class TrainingHeartRateStateType {
  static const int trainingPause = -2;
  static const int trainingContinue = -3;
  static const int trainingComplete = -1;
}

class TempUnit {
  static const int celsius = 0;
  static const int fahrenheit = 1;
}

class PeriodTimeType {
  static const int doNotDistributeType = 1;
  static const int quickViewType = 2;
}

class ConnectionState {
  static const int stateDisconnected = 0;
  static const int stateConnecting = 1;
  static const int stateConnected = 2;
  static const int stateDisconnecting = 3;
}

class BloodOxygenType {
  static const int continueState = 1;
  static const int timingMeasure = 2;
  static const int bloodOxygen = 3;
  static const int historyList = 4;
  static const int continueBO = 5;
}

class BloodPressureType {
  static const int continueState = 1;
  static const int pressureChange = 2;
  static const int historyList = 3;
  static const int continueBP = 4;
}

class ContactListenType {
  static const int savedSuccess = 1;
  static const int savedFail = 2;
}

class DeviceBatteryType {
  static const int subscribe = 1;
  static const int deviceBattery = 2;
}

class ECGType {
  static const int ecgChangeInts = 1;
  static const int measureComplete = 2;
  static const int date = 3;
  static const int cancel = 4;
  static const int fail = 5;
}

class FileTransType {
  static const int startTrans = 1;
  static const int transProgress = 2;
  static const int transCompleted = 3;
  static const int error = 4;
}

class OTAProgressType {
  static const int downloadStart = 1;
  static const int downloadComplete = 2;
  static const int progressStart = 3;
  static const int progressChanged = 4;
  static const int upgradeCompleted = 5;
  static const int upgradeAborted = 6;
  static const int error = 7;
}

class HeartRateType {
  static const int measuring = 1;
  static const int onceMeasureComplete = 2;
  static const int heartRate = 3;
  static const int measureComplete = 4;
  static const int hourMeasureResult = 5;
  static const int measureResult = 6;
}

class SleepType {
  static const int sleepChange = 1;
  static const int historySleepChange = 2;
  static const int goalSleepTimeChange = 3;
}

class TransType {
  static const int transStart = 1;
  static const int transChanged = 2;
  static const int transCompleted = 3;
  static const int error = 4;
}

class DisplayTimeType {
  static const int displayFive = 5;
  static const int displayTen = 10;
  static const int displayFifteen = 15;
  static const int displayTwenty = 20;
  static const int displayTwentyFive = 25;
  static const int displayThirty = 30;
}

class OTAMcuType {
  static const int startOta = 0;
  static const int startNordicOta = 1;
  static const int startHsOta = 2;
  static const int startRtkOta = 3;
  static const int startGoodixOta = 4;
  static const int startSifliOta = 5;
  static const int startJieliOta = 6;
}

class SendWatchFaceType {
  static const int transProgressStart = 1;
  static const int transProgressChanged = 2;
  static const int transCompleted = 3;
  static const int transError = 4;
}

class WeatherChangeType {
  static const int updateWeather = 1;
  static const int tempUnitChange = 2;
}

class TrainType {
  static const int historyTrainingChange = 1;
  static const int trainingChange = 2;
}

class TempChangeType {
  static const int continueState = 1;
  static const int measureTemp = 2;
  static const int measureState = 3;
  static const int continueTemp = 4;
}

class AlarmId {
  static const int firstClock = 0;
  static const int secondClock = 1;
  static const int thirdClock = 2;
}

class RepeatMode {
  static const int single = 0;
  static const int sunday = 1;
  static const int monday = 2;
  static const int tuesday = 4;
  static const int wednesday = 8;
  static const int thursday = 16;
  static const int friday = 32;
  static const int saturday = 64;
  static const int everyday = 127;
}

///Only ios use
class NotificationType {
  static const int call = 0;
  static const int sms = 1;
  static const int wechat = 2;
  static const int qq = 3;
  static const int facebook = 4;
  static const int twitter = 5;
  static const int instagram = 6;
  static const int skype = 7;
  static const int whatsApp = 8;
  static const int line = 9;
  static const int kakao = 10;
  static const int email = 11;
  static const int messenger = 12;
  static const int zalo = 13;
  static const int telegram = 14;
  static const int viber = 15;
  static const int nateOn = 16;
  static const int gmail = 17;
  static const int calenda = 18;
  static const int dailyHunt = 19;
  static const int outlook = 20;
  static const int yahoo = 21;
  static const int inshorts = 22;
  static const int phonepe = 23;
  static const int gpay = 24;
  static const int paytm = 25;
  static const int swiggy = 26;
  static const int zomato = 27;
  static const int uber = 28;
  static const int ola = 29;
  static const int reflexApp = 30;
  static const int snapchat = 31;
  static const int ytMusic = 32;
  static const int youTube = 33;
  static const int linkEdin = 34;
  static const int amazon = 35;
  static const int flipkart = 36;
  static const int netFlix = 37;
  static const int hotstar = 38;
  static const int amazonPrime = 39;
  static const int googleChat = 40;
  static const int wynk = 41;
  static const int googleDrive = 42;
  static const int dunzo = 43;
  static const int gaana = 44;
  static const int missCall = 45;
  static const int whatsAppBusiness = 46;
  static const int dingtalk = 47;
  static const int tikTok = 48;
  static const int lyft = 49;
  static const int mail = 50;
  static const int googleMaps = 51;
  static const int slack = 52;
  static const int microsoftTeams = 53;
  static const int mormaiiSmartwatches = 54;
  static const int other = 128;
}

class StressDate {
  static const String today = "TODAY";
  static const String yesterday = "YESTERDAY";
}

class CalendarEventType {
  static const int support = 1;
  static const int details = 2;
  static const int stateAndTime = 3;
}

class FindPhoneType {
  static const int find = 1;
  static const int complete = 2;
}

class HRVType {
  static const int support = 1;
  static const int hrv = 2;
  static const int history = 3;
}

class StressHandlerType {
  static const int support = 1;
  static const int change = 2;
  static const int historyChange = 3;
  static const int timingStateChange = 4;
  static const int timingChange = 5;
}

class CameraType {
  static const int takePhotoState = 1;
  static const int delayTakingState = 2;
}

// class ActionDetailsType {
//   static const int today = 0;
//   static const int yesterday = 1;
//   static const int theDayBeforeYesterday = 2;
//   static const int threeDaysAgo = 3;
//   static const int fourDaysAgo = 4;
//   static const int fiveDaysAgo = 5;
//   static const int sixDaysAgo = 6;
// }

class StepsChangeType {
  static const int stepChange = 1;
  static const int historyStepChange = 2;
}

class StepsDetailType {
  static const int stepsCategoryChange = 1;
  static const int actionDetailsChange = 2;
}

class VibrationStrengthType {
  static const int low = 1;
  static const int medium = 2;
  static const int strong = 3;
}

class SupportWatchFaceType {
  static const String ordinary = "DEFAULT";
  static const String sifli = "SIFLI";
  static const String jieli = "JIELI";
}
