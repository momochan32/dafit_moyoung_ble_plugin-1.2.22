//
//  MYScanPlugin.swift
//  moyoung_ble_plugin
//
//  Created by 魔样科技 on 2022/5/21.
//

import Foundation
import Flutter
import CRPSmartBand
import CoreBluetooth

enum ScreenCompressionType: Int {
    case LZO = 0
    case RGB_DEDUPLICATION = 1
    case RGB_LINE = 2
    case SIFLI = 3
    case ORIGINAL = 255
    
    var description: String {
        switch self {
        case .LZO:
            return "LZO"
        case .RGB_DEDUPLICATION:
            return "RGB_DEDUPLICATION"
        case .RGB_LINE:
            return "RGB_LINE"
        case .SIFLI:
            return "SIFLI"
        case .ORIGINAL:
            return "ORIGINAL"
        }
    }
}

public class MYScanPlugin: NSObject {
    
    var myDiscovery:CRPDiscovery!
    var deviceState: CRPState = .connecting
    var bluetoothState: CRPBluetoothState = .unknown
    lazy var discoverys: [CRPDiscovery] = [CRPDiscovery]()
    var deviceCurrentVersion: String = ""
    var deviceNewVersionInfo: CRPSmartBand.newVersionInfo = newVersionInfo(type: .normal, version: "", log: "", logEN: "", mcu: 0, md5: "", fileUrl: "", uiVersion: "")
    var hardWareType: CRPPlatform = .None
    
    var autoConnect: Bool = false
    
    /// 是否支持延迟拍照功能
    var isSupportDelayCamera = false
    
    /// 是否支持自定义版本号
    var isSupportCustomizeVersion = false
    
    /// flutter:   接收 扫描到的设备的监听
    var scannedDevicesEventStreamHandler = ScannedDeviceEventSinkStreamHandler()
    /// flutter:    接收设备连接状态的监听
    var connectionStateEventStreamHandler = ConnectionStateEventSinkStreamHandler()
//    /// flutter:    接收实时的计步数据的监听
    private var stepChangeEventStreamHandler = StepChangeEventSinkStreamHandler()
    /// flutter:    接收运动的监听
    var trainingStateEventStreamHandler = TrainingStateEventSinkStreamHandler()
    /// flutter:   体温的监听
    var temperatureChangeEventStreamHandler = TemperatureChangeEventSinkStreamHandler()
    /// flutter:    接收设备电量的监听
    var batteryEventStreamHandler = BatteryEventSinkStreamHandler()
    /// flutter:    天气的监听
    var weatherEventStreamHandler = WeatherEventSinkStreamHandler()
    /// flutter:    过去两天的步数分类统计的监听
    var stepsDetailEventStreamHandler = StepsDetailEventSinkStreamHandler()
    /// flutter:    睡眠的监听
    /// static const int sleepChange = 1;static const int historySleepChange = 2;
    var sleepChangeEventStreamHandler = SleepChangeEventSinkStreamHandler()
    /// flutter:    固件升级的监听
    var firmwareUpgradeEventStreamHandler = FirmwareUpgradeEventSinkStreamHandler()
    /// flutter:    接收⼼率测量结果(单次测量⼼率)的监听
    /// static const int measuring = 1;static const int onceMeasureComplete = 2;static const int heartRate = 3;static const int measureComplete = 4;static const int hourMeasureResult = 5;static const int measureResult = 6;
    var heartRateEventStreamHandler = HeartRateEventSinkStreamHandler()
    /// flutter:    接收⾎压测量结果
    var bloodPressureEventStreamHandler = BloodPressureEventSinkStreamHandler()
    /// flutter:    接收⾎氧测量结果的监听
    var bloodOxygenEventStreamHandler = BloodOxygenEventSinkStreamHandler()
    /// 相机的监听
    var cameraEventStreamHandler = CameraEventSinkStreamHandler()
    /// flutter:    手机的监听
    var phoneEventStreamHandler = PhoneEventSinkStreamHandler()
    /// flutter:    设备RSSI的监听
    var deviceRSSIEventStreamHandler = DeviceRSSIEventSinkStreamHandler()
    /// flutter:
    var fileTransEventStreamHandler = FileTransEventSinkStreamHandler()
    /// flutter:
    var wfFileTransEventStreamHandler = WFFileTransEventSinkStreamHandler()
    /// flutter:    心电图的监听
    var ecgEventStreamHandler = EcgEventSinkStreamHandler()
    /// flutter:    联系人头像的监听
    var contactAvatarEventStreamHandler = ContactAvatarEventSinkStreamHandler()
    /// flutter:    联系人的监听
    var contactEventStreamHandler = ContactEventSinkStreamHandler()
    /// flutter:    省电模式的监听
    var batterySavingEventStreamHandler = BatterySavingEventSinkStreamHandler()
    /// flutter:    锻炼的监听
    var trainingEventStreamHandler = TrainingEventSinkStreamHandler()
    
    var callNumberEventStreamHandler = CallNumberEventSinkStreamHandler()
    
    var findPhoneEventStreamHandler = FindPhoneEventSinkStreamHandler()
    
    var sosChangeEventStreamHandler = SOSChangeEventSinkStreamHandler()
    
    var newHrvEventStreamHandler = NewHrvEventSinkStreamHandler()
    
    var stressEventStreamHandler = StressEventSinkStreamHandler()
    
    var calendarEventStreamHandler = CalendarEventSinkStreamHandler()
    
    /// 吃药提醒数据闭包
    var receiveMedicineInfoClosure:((_ max: Int,_ model: CRPMedicineReminderModel?) -> Void)!
        
    private var notificationSupportTypeArray = [Int]()
    
    private var screenCompressionType: Int = 255
        
    //获取上次动态心率的时候，uni 发送过来的type： FIRST_HEART_RATE、SECOND_HEART_RATE、THIRD_HEART_RATE
    private var historyDynamicRateType: String = ""
    //获取上次动态心率的时候，因为如果有三次数据的话是回调三次，但是Android端是通过发送type，回调第几次的数据，所以这边需要处理一下
    private var currentHistoryDynamicRateIndex: Int = 0;
    
    private func isConnectedForConnectState(closure: @escaping () -> ()) {
        guard self.bluetoothState == .poweredOn else {
            return
        }
        guard self.deviceState == .connected else {
            return
        }
        closure()
    }
    
    private func isPoweredOnForBluetoothState(closure: @escaping () -> ()) {
        guard self.bluetoothState == .poweredOn else {
            return
        }
        closure()
    }
    
    class func setupEventChannel(name: String, registrar: FlutterPluginRegistrar, instance: (FlutterStreamHandler & NSObjectProtocol)?) {
        let channel = FlutterEventChannel(name: name, binaryMessenger: registrar.messenger())
        channel.setStreamHandler(instance)
    }
    
}

extension MYScanPlugin: FlutterPlugin, FlutterStreamHandler, CRPManagerDelegate {
    
    //MARK: - eventSink delegate
    public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        return nil
    }
    
    public func onCancel(withArguments arguments: Any?) -> FlutterError? {
        return nil
    }
    
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        //方法的通道
        let scanChannel = FlutterMethodChannel(name: METHOD_SCAN_DEVICE, binaryMessenger: registrar.messenger())
        let connectChannel = FlutterMethodChannel(name: METHOD_CONNECTION, binaryMessenger: registrar.messenger())
        //创建类对象
        let instance = MYScanPlugin()
        CRPSmartBandSDK.sharedInstance.delegate = instance
        //添加注册
        registrar.addMethodCallDelegate(instance, channel: scanChannel)
        registrar.addMethodCallDelegate(instance, channel: connectChannel)
        let eventChannelNames = [EVENT_SCAN_DEVICE,
                                 EVENT_CONNECTION_STATE,
                                 EVENT_STEP_CHANGE,
                                 EVENT_TRAINING_STATE,
                                 EVENT_TEMP_CHANGE,
                                 EVENT_DEVICE_BATTERY,
                                 EVENT_WEATHER_CHANGE,
                                 EVENT_STEPS_DETAIL,
                                 EVENT_SLEEP_CHANGE,
                                 EVENT_FIRMWARE_UPGRADE,
                                 EVENT_HEART_RATE,
                                 EVENT_BLOOD_PRESSURE,
                                 EVENT_BLOOD_OXYGEN,
                                 EVENT_BLOOD_CAMERA,
                                 EVENT_PHONE,
                                 EVENT_DEVICE_RSSI,
                                 EVENT_FILE_TRANS,
                                 EVENT_WF_FILE_TRANS,
                                 EVENT_EGC,
                                 EVENT_CONTACT_AVATAR,
                                 EVENT_CONTACT,
                                 EVENT_BATTERY_SAVING,
                                 EVENT_TRAIN,
                                 EVENT_CALL_NUMBER,
                                 EVENT_FIND_PHONE,
                                 EVENT_SOS_CHANGE,
                                 EVENT_NEW_HRV,
                                 EVENT_STRESS,
                                 EVENT_CALENDAE]
        let eventStramHandlers = [instance.scannedDevicesEventStreamHandler,
                                  instance.connectionStateEventStreamHandler,
                                  instance.stepChangeEventStreamHandler,
                                  instance.trainingStateEventStreamHandler,
                                  instance.temperatureChangeEventStreamHandler,
                                  instance.batteryEventStreamHandler,
                                  instance.weatherEventStreamHandler,
                                  instance.stepsDetailEventStreamHandler,
                                  instance.sleepChangeEventStreamHandler,
                                  instance.firmwareUpgradeEventStreamHandler,
                                  instance.heartRateEventStreamHandler,
                                  instance.bloodPressureEventStreamHandler,
                                  instance.bloodOxygenEventStreamHandler,
                                  instance.cameraEventStreamHandler,
                                  instance.phoneEventStreamHandler,
                                  instance.deviceRSSIEventStreamHandler,
                                  instance.fileTransEventStreamHandler,
                                  instance.wfFileTransEventStreamHandler,
                                  instance.ecgEventStreamHandler,
                                  instance.contactAvatarEventStreamHandler,
                                  instance.contactEventStreamHandler,
                                  instance.batterySavingEventStreamHandler,
                                  instance.trainingEventStreamHandler,
                                  instance.callNumberEventStreamHandler,
                                  instance.findPhoneEventStreamHandler,
                                  instance.sosChangeEventStreamHandler,
                                  instance.newHrvEventStreamHandler,
                                  instance.stressEventStreamHandler,
                                  instance.calendarEventStreamHandler]
        for (index, name) in eventChannelNames.enumerated() {
            setupEventChannel(name: name, registrar: registrar, instance: (eventStramHandlers[index] as! (FlutterStreamHandler & NSObjectProtocol)))
        }
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        var receivedDic: [String: Any] = [:]
        if call.arguments is [String: Any] {
            receivedDic = call.arguments as! [String : Any]
        }
//         print("flutter方法是：\(call.method)，flutter发送过来的数据是：\(receivedDic)")
        
        if (UserDefaults.standard.value(forKey: "hardWareType") != nil) {
            self.hardWareType = CRPPlatform.init(rawValue: UserDefaults.standard.value(forKey: "hardWareType") as! Int) ?? .None
        }
        
        
        //MARK: - 扫描连接 -
        switch call.method {
        case "startScan":
            self.isPoweredOnForBluetoothState {
                CRPSmartBandSDK.sharedInstance.scan(TimeInterval(receivedDic["scanPeriod"] as! Int)) {[weak self] datas in
                    guard let self = self else { return  }
                    for p in datas {
                        p.remotePeripheral.identifier.uuidString
                        if p.localName?.isEmpty == true {
                            return
                        }
                        self.discoverys.append(p)
                        var param: [String: Any] = [:]
                        param["isCompleted"] = false
                        param["address"] = p.mac
                        param["mRssi"] = p.RSSI
                        param["mScanRecord"] = [Int]()
                        param["name"] = p.localName
                        param["platform"] = p.platform.rawValue
                        let str = SystemAuth.getJsonStringFromBasicTypeData(data: param)
                        result(true)
                        self.scannedDevicesEventStreamHandler.scannedDevicesEventSink?(str)
                    }
                    
                } completionHandler: {[weak self] (datas, error) in
                    guard let self = self else { return  }
                    var param: [String: Any] = [:]
                    param["isCompleted"] = true
                    param["address"] = ""
                    param["mRssi"] = Int()
                    param["mScanRecord"] = [Int]()
                    param["name"] = ""
                    param["platform"] = -1
                    let str = SystemAuth.getJsonStringFromBasicTypeData(data: param)
//                    print("结束扫描\(param)")
                    result(true)
                    self.scannedDevicesEventStreamHandler.scannedDevicesEventSink?(str)
                    switch error {
                        
                    case .none: break
                        //-
                    case .disconnected: break
                        //-此处为断开连接后，是否进行重连
                    case .busy: break
                        //-此处为设备已经被连接，该进行怎样的逻辑
                    case .timeout: break
                        //-此处为扫描超时咯
                    case .interrupted: break
                        //-此处为扫描被中断
                    case .internalError: break
                        //-此处为SDK内部错误
                    case .noCentralManagerSet: break
                        //-此处为没有蓝牙设备中心
                    case .other: break
                        //-此处为其他错误
                    default: break
                        //-此处为默认
                    }
                }
            }
        case "cancelScan":
            self.isPoweredOnForBluetoothState {
                CRPSmartBandSDK.sharedInstance.interruptScan()
            }
            result(nil)
        case "isConnected":
            self.isPoweredOnForBluetoothState {
                if self.deviceState == .connected {
                    result(true)
                }
                else {
                    result(false)
                }
            }
        case "connect":
            //TODO: 调试
            self.isPoweredOnForBluetoothState { [weak self] in
                guard let self = self else {
                    result(nil)
                    return
                }
                let dic = SystemAuth.getDictionaryFromJSONString(jsonString: receivedDic["connectInfo"] as! String)
                self.autoConnect = Bool(truncating: dic["autoConnect"] as! NSNumber)
                
                guard let macString = dic["address"] as? String, macString.isEmpty == false else {
                    result(nil)
                    return
                }
                guard let uuidString = dic["uuid"] as? String else {
                    if macString.isEmpty == false {
                        for p in self.discoverys {
                            if p.mac == macString {
                                self.myDiscovery = p
                                self.hardWareType = p.platform
                                UserDefaults.standard.setValue(self.hardWareType.rawValue, forKey: "hardWareType")
                                CRPSmartBandSDK.sharedInstance.connet(p)
                                result(nil)
                                return
                            }
                        }
                    }
                    result(nil)
                    return
                }
                
                if uuidString.isEmpty {
                    for p in self.discoverys {
                        if p.mac == macString {
                            self.myDiscovery = p
                            self.hardWareType = p.platform
                            UserDefaults.standard.setValue(self.hardWareType.rawValue, forKey: "hardWareType")
                            CRPSmartBandSDK.sharedInstance.connet(p)
                            result(nil)
                            return
                        }
                    }
                } else {
                    if let uuid = UUID(uuidString: uuidString) {
                        let peripheralArray = CRPSmartBandSDK.sharedInstance.retrievePeripherals(identifier: uuid)
                        if peripheralArray.count > 0 {
                            if let peripheral = peripheralArray.first {
                                let discovery = CRPDiscovery(remotePeripheral: peripheral, mac: macString)
                                CRPSmartBandSDK.sharedInstance.connet(discovery)
                                result(nil)
                                return
                            }
                        }
                    }
                }
            }
            result(nil)
        //TODO: 2022年11月14日15:35:18 新增一个连接方法，参数为flutter端传过来的设备对象
        case "connectDevice":
            self.isPoweredOnForBluetoothState {
                let userInfoDic = SystemAuth.getDictionaryFromJSONString(jsonString: receivedDic["connectDevice"] as! String)
                self.autoConnect = Bool(truncating: userInfoDic["autoConnect"] as! NSNumber)
                guard let address = userInfoDic["address"] as? String else { return }
                guard let p = userInfoDic["peripheral"] as? CBPeripheral else { return }
                CRPSmartBandSDK.sharedInstance.connet(CRPDiscovery(remotePeripheral: p, mac: address))
            }
            result(nil)
        //TODO: 2022年11月14日15:35:18 新增一个重连方法，调用会连接上一次的设备
        case "reconnect":
            self.isPoweredOnForBluetoothState {
                CRPSmartBandSDK.sharedInstance.reConnet()
            }
            result(nil)
        case "disconnect":
            self.isPoweredOnForBluetoothState {
                self.autoConnect = false
                CRPSmartBandSDK.sharedInstance.disConnet()
                result(true)
            }
        case "createBond":
            self.isConnectedForConnectState {
                
            }
            result(nil)
        //MARK: - 同步时间 -
        case "queryTime":
            self.isConnectedForConnectState {
                CRPSmartBandSDK.sharedInstance.setTime()
            }
            result(nil)
        //MARK: - 设置时间制式 -
        case "sendTimeSystem":
            self.isConnectedForConnectState {
                CRPSmartBandSDK.sharedInstance.setTimeFormat(receivedDic["timeSystemType"] as! Int)
            }
            result(nil)
        case "queryTimeSystem":
            //查询时间制式
            self.isConnectedForConnectState {
                CRPSmartBandSDK.sharedInstance.getTimeformat { timeFormat, error in
                    result(timeFormat)
                }
            }
        //MARK: - 查询手环电量 -
        case "queryDeviceBattery":
            //查询手环电量
            self.isConnectedForConnectState {
                CRPSmartBandSDK.sharedInstance.getBattery { battery, error in
                    //TODO: flutter端是监听接收返回的
                    var param: [String: Any] = [:]
                    param["type"] = 2
                    param["subscribe"] = false
                    param["deviceBattery"] = battery
                    let str = SystemAuth.getJsonStringFromBasicTypeData(data: param)
                    self.batteryEventStreamHandler.batteryEventSink?(str)
                }
            }
            result(nil)
        case "subscribeDeviceBattery":
            //订阅手环电量
            //TODO: iOS端暂无
            result(nil)
            break
        //MARK: - 固件升级 -
        case "startOTA":
            self.isConnectedForConnectState {
                self.queryNewVersion {
                    let dic = SystemAuth.getDictionaryFromJSONString(jsonString: receivedDic["otaBean"] as! String)
                    guard let type = dic["type"] as? Int else {
                        switch self.hardWareType {
                        case .Huntersun:
                            CRPSmartBandSDK.sharedInstance.startHTXOTA(info: self.deviceNewVersionInfo, upgradeMac: dic["address"] as! String, isUser: true)
                        case .Goodix:
                            CRPSmartBandSDK.sharedInstance.startGoodixUpgradeFromFile(zipPath: self.deviceNewVersionInfo.fileUrl ?? "")
                        case .Nordic, .JieLi, .Sifli:
                            CRPSmartBandSDK.sharedInstance.startUpgrede(info: self.deviceNewVersionInfo)
                        default: break
                        }
                        
                        return }
                    var receivedHardWareType = 0
                    switch type {
                    case 1:
                        self.hardWareType = .Nordic
                    case 2:
                        self.hardWareType = .Huntersun
                    case 3:
                        self.hardWareType = .Realtek
                    case 4:
                        self.hardWareType = .Goodix
                    case 5:
                        self.hardWareType = .Sifli
                    case 6:
                        self.hardWareType = .JieLi
                    default:
                        return
                    }
                    switch self.hardWareType {
                    case .Huntersun:
                        CRPSmartBandSDK.sharedInstance.startHTXOTA(info: self.deviceNewVersionInfo, upgradeMac: dic["address"] as! String, isUser: true)
                    case .Goodix:
                        CRPSmartBandSDK.sharedInstance.startGoodixUpgradeFromFile(zipPath: self.deviceNewVersionInfo.fileUrl ?? "")
                    case .Nordic, .JieLi, .Sifli:
                        CRPSmartBandSDK.sharedInstance.startUpgrede(info: self.deviceNewVersionInfo)
                    default: break
                    }
                } failed: {
                    
                }
            }
            result(nil)
        case "abortOTA":
            switch self.hardWareType {
            case .Huntersun:
                CRPSmartBandSDK.sharedInstance.stopHTXOTA()
            case .Realtek:
                CRPSmartBandSDK.sharedInstance.stopUpgrade()
            case .Goodix:
                CRPSmartBandSDK.sharedInstance.stopUpgrade()
            case .Nordic, .JieLi:
                CRPSmartBandSDK.sharedInstance.stopUpgrade()
            default:
                CRPSmartBandSDK.sharedInstance.stopUpgrade()
            }
            result(nil)
        case "queryDeviceOtaStatus":
            self.isConnectedForConnectState {
                CRPSmartBandSDK.sharedInstance.checkDFUState { state, error in
                    //(DFU不为0时既⼿环处于升级状态
                    var status: Int = 0
                    if state != "0" {
                        status = 1
                    }
                    result(status)
                }
            }
        case "queryFirmwareVersion":
            //查询⼿环当前固件版本
            self.isConnectedForConnectState {
                CRPSmartBandSDK.sharedInstance.getSoftver {(softver, error) in
                    self.deviceCurrentVersion = softver
                    result(softver)
                }
            }
        case "queryCustomizeVersion":
            self.isConnectedForConnectState {
                CRPSmartBandSDK.sharedInstance.getSoftver {(softver, error) in
                    self.deviceCurrentVersion = softver
                    if self.deviceCurrentVersion.contains("QMQ") || self.deviceCurrentVersion.contains("V37") {
                        var customVersion = ""
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            if customVersion.isEmpty {
                                result(customVersion)
                            }
                        }
                        CRPSmartBandSDK.sharedInstance.getCustomVersion { value, error in
                            customVersion = value
                            result(customVersion)
                        }
                    } else {
                        result("")
                    }
                }
            }
        case "queryUUID":
            self.isConnectedForConnectState {
                result(CRPSmartBandSDK.sharedInstance.currentCRPDiscovery?.remotePeripheral.identifier.uuidString)
            }
        case "queryHsOtaAddress":
            self.isConnectedForConnectState {
                CRPSmartBandSDK.sharedInstance.getOTAMac { address, error in
                    result(address)
                }
            }
        case "sifliStartOTA":
//            upgradeFilePath
            self.queryNewVersion {
                CRPSmartBandSDK.sharedInstance.getUIVersion { value, error in
                    var upgradeUI = false
                    if self.deviceNewVersionInfo.uiVersion == value {
                        upgradeUI = false
                    } else {
                        upgradeUI = true
                    }
                    guard let path = receivedDic["upgradeFilePath"] as? String else {
                        result(nil)
                        return
                    }
                    CRPSmartBandSDK.sharedInstance.startSiFliOTAFromFile(zipPath: path, isUpgradeUI: upgradeUI)
                }
                result(nil)
            } failed: {
                
            }

        case "jieliStartOTA":
            self.isConnectedForConnectState {
//                self.queryNewVersion {
//                    CRPSmartBandSDK.sharedInstance.startUpgrede(info: self.deviceNewVersionInfo)
//                } failed: {
//
//                }
                guard let path = receivedDic["pathname"] as? String else {
                    return
                }
                CRPSmartBandSDK.sharedInstance.startUpgradeFromFile(path: path)
            }
            result(nil)
        case "jieliAbortOTA":
            self.isConnectedForConnectState {
                CRPSmartBandSDK.sharedInstance.stopUpgrade()
            }
            result(nil)
        //MARK: - iOS端暂无
        case "enableHsOta":
            result(nil)
            break
        //MARK: - iOS端暂无
        case "queryOtaType":
            result(nil)
            break
        case "checkFirmwareVersion":
            //查询新固件
            self.isConnectedForConnectState { [weak self] in
                guard let self = self else { return }
                let dic = SystemAuth.getDictionaryFromJSONString(jsonString: receivedDic["firmwareVersion"] as! String)
                self.deviceCurrentVersion = dic["version"] as! String
                CRPSmartBandSDK.sharedInstance.checkLatest(self.deviceCurrentVersion, self.myDiscovery.mac ?? "") { newVerInfo, newVerTpInfo, error in
                    var param: [String: Any] = [:]
                    if newVerInfo == nil {
                        param["isLatestVersion"] = true
                    } else {
                        self.deviceNewVersionInfo = newVerInfo!
                        if newVerInfo != nil {
                            var firmwareVersionInfo: [String: Any] = [:]
                            firmwareVersionInfo["changeNotes"] = newVerInfo?.log
                            firmwareVersionInfo["changeNotesEn"] = newVerInfo?.logEN
                            firmwareVersionInfo["mcu"] = newVerInfo?.mcu
                            firmwareVersionInfo["tpUpgrade"] = false
                            firmwareVersionInfo["type"] = newVerInfo?.type.rawValue
                            firmwareVersionInfo["version"] = newVerInfo?.version
                            param["firmwareVersionInfo"] = firmwareVersionInfo
                            
//                            if newVerInfo?.mcu == 4 || newVerInfo?.mcu == 8 {
//                                self.hardWareType = .Huntersun
//                            }
//                            else if newVerInfo?.mcu == 7 {
//                                self.hardWareType = .Realtek
//                            }
//                            else if newVerInfo?.mcu == 10 {
//                                self.hardWareType = .Goodix
//                            }
//                            else if newVerInfo?.mcu == 86 || newVerInfo?.mcu == 87 {
//                                self.hardWareType = .Sifli
//                            }
//                            else if newVerInfo?.mcu == 323 {
//                                self.hardWareType = .JieLi
//                            }
//                            else {
//                                self.hardWareType = .Nordic
//                            }
                        }
                        param["isLatestVersion"] = self.deviceCurrentVersion == newVerInfo?.version ? true : false
                    }
                    let str = SystemAuth.getJsonStringFromBasicTypeData(data: param)
                    result(str)
                }
            }
        case "reset":
            self.isConnectedForConnectState {
                CRPSmartBandSDK.sharedInstance.reset()
            }
            result(nil)
        case "sendUserInfo":
            //MARK: - 用户信息 -
            //设置⽤户信息
            self.isConnectedForConnectState {
                let userInfoDic: Dictionary = SystemAuth.getDictionaryFromJSONString(jsonString: receivedDic["userInfo"] as! String)
                let model: ProfileModel = ProfileModel(height: userInfoDic["height"] as! Int, weight: userInfoDic["weight"] as! Int, age: userInfoDic["age"] as! Int, gender: GenderOption(rawValue: GenderOption.RawValue(userInfoDic["gender"] as! Int)) ?? .male)
                CRPSmartBandSDK.sharedInstance.setProfile(model)
            }
            result(nil)
        case "sendStepLength":
            //设置步⻓
            self.isConnectedForConnectState {
                CRPSmartBandSDK.sharedInstance.setStepLength(length: receivedDic["stepLength"] as! Int)
            }
            result(nil)
        case "sendTodayWeather":
            //MARK: - 天气 -
            //设置今⽇天⽓
            self.isConnectedForConnectState {
                let weatherDic: Dictionary = SystemAuth.getDictionaryFromJSONString(jsonString: receivedDic["todayWeatherInfo"] as! String)
                let todayWeather:CRPSmartBand.weather = weather.init(type: weatherDic["weatherId"] as! Int, temp: weatherDic["temp"] as! Int , pm25: weatherDic["pm25"] as! Int, festival: weatherDic["festival"] as! String, city: weatherDic["city"] as! String)
                CRPSmartBandSDK.sharedInstance.setWeather(todayWeather)
            }
            result(nil)
        case "sendFutureWeather":
            //设置未来7⽇天⽓
            self.isConnectedForConnectState {
                let weatherDic: Dictionary = SystemAuth.getDictionaryFromJSONString(jsonString: receivedDic["futureWeatherInfo"] as! String)
                let weathers: [[String: Any]] = weatherDic["future"] as! [[String : Any]]
                var models: [forecastWeather] = []
                for weather in weathers {
                    let futureWeather:CRPSmartBand.forecastWeather = forecastWeather.init(type: weather["weatherId"] as! Int, maxTemp: weather["highTemperature"] as! Int, minTemp: weather["lowTemperature"] as! Int)
                    models.append(futureWeather)
                }
                CRPSmartBandSDK.sharedInstance.setForecastWeather(models)
            }
            result(nil)
        case "sendLocalCity":
            //设置本地城市
            self.isConnectedForConnectState {
                CRPSmartBandSDK.sharedInstance.sendCityName(receivedDic["city"] as! String)
            }
            result(nil)
        case "queryUnitSystem":
            //MARK: - 公英制单位 -
            //获取公英制单位
            self.isConnectedForConnectState {
                CRPSmartBandSDK.sharedInstance.getUnit { value, error in
                    result(value)
                }
            }
        case "sendUnitSystem":
            //设置公英制单位
            self.isConnectedForConnectState {
                CRPSmartBandSDK.sharedInstance.setUnit(receivedDic["metricSystemType"] as! Int)
            }
            result(nil)
        //MARK: - 翻腕亮屏 -
        case "sendQuickView":
            //设置翻腕亮屏状态
            self.isConnectedForConnectState {
                CRPSmartBandSDK.sharedInstance.setQuickView(receivedDic["quickViewState"] as! Bool)
            }
            result(nil)
        case "queryQuickView":
            //查询⼿环翻腕亮屏开启状态,0: 关闭 1： 开启
            self.isConnectedForConnectState {
                CRPSmartBandSDK.sharedInstance.getQuickView { state, error in
                    result(Bool(truncating: state as NSNumber))
                }
            }
        case "sendQuickViewTime":
            //设置翻腕亮屏时间
            self.isConnectedForConnectState {
                let periodTimeDic = SystemAuth.getDictionaryFromJSONString(jsonString: receivedDic["periodTimeInfo"] as! String)
                let model = periodTimeModel.init(startHour: periodTimeDic["startHour"] as! Int, startMin: periodTimeDic["startMinute"] as! Int, endHour: periodTimeDic["endHour"] as! Int, endMin: periodTimeDic["endMinute"] as! Int)
                CRPSmartBandSDK.sharedInstance.setQuickViewTime(model)
            }
            result(nil)
        case "queryQuickViewTime":
            //获取翻腕亮屏时间
            self.isConnectedForConnectState {
                CRPSmartBandSDK.sharedInstance.getQuickViewTime { model, error in
                    var param: [String: Any] = [:]
                    
                    var periodTimeInfo: [String: Any] = [:]
                    periodTimeInfo["startHour"] = model.startHour
                    periodTimeInfo["startMinute"] = model.startMin
                    periodTimeInfo["endHour"] = model.endHour
                    periodTimeInfo["endMinute"] = model.endMin
                    // int DO_NOT_DISTRUB_TYPE = 1;int QUICK_VIEW_TYPE = 2;
                    param["periodTimeType"] = 2
                    param["periodTimeInfo"] = periodTimeInfo
                    let str = SystemAuth.getJsonStringFromBasicTypeData(data: param)
                    result(str)
                    
                }
            }
        case "querySteps":
            //MARK: - 目标步数 -
            //今天的步数
            self.isConnectedForConnectState {
                CRPSmartBandSDK.sharedInstance.getSteps { model, error in
                   //TODO: flutter是通过监听接收的
                    var dic: [String: Any] = [:]
                    dic["calories"] = model.calory
                    dic["distance"] = model.distance
                    dic["steps"] = model.steps
                    dic["time"] = model.time
                    
                    var param: [String: Any] = [:]
                    param["type"] = 1
                    param["stepsInfo"] = dic
                    let str = SystemAuth.getJsonStringFromBasicTypeData(data: param)
//                    print("方法名： querySteps +++++  数据：  \(param)")
                    self.stepChangeEventStreamHandler.stepChangeEventSink?(str)
                }
            }
            result(nil)
        case "queryHistorySteps":
            //同步历史步数
            self.isConnectedForConnectState { [weak self] in
                guard let self = self else { return }
                let type: Int = receivedDic["historyTimeType"] as! Int
                CRPSmartBandSDK.sharedInstance.getAllData { stepModels, sleepModels, error in
                    //⼿环可保存前两天的计步数据和睡眠数据(allDataHandler中包含stepModels和sleepModels,数组的第⼀个为昨天数据，第⼆个为前天数据)
                    //TODO: flutter是通过监听接收的
                    if type == 1 {
                        //昨天的步数

                        let stepModel = stepModels[0]
                        var stepDic: [String: Any] = [:]
                        stepDic["calories"] = stepModel.calory
                        stepDic["distance"] = stepModel.distance
                        stepDic["steps"] = stepModel.steps
                        stepDic["time"] = stepModel.time
                        
                        var historyStepsInfo: [String: Any] = [:]
                        historyStepsInfo["historyDay"] = "YESTERDAY"
                        historyStepsInfo["stepsInfo"] = stepDic
                        
                        var stepParam: [String: Any] = [:]
                        stepParam["type"] = 2
                        stepParam["historyStepsInfo"] = historyStepsInfo
                        let stepStr = SystemAuth.getJsonStringFromBasicTypeData(data: stepParam)
                        self.stepChangeEventStreamHandler.stepChangeEventSink?(stepStr)
                    }
                    else if type == 2 {
                        //前天的步数
                        let stepModel = stepModels[1]
                        var stepDic: [String: Any] = [:]
                        stepDic["calories"] = stepModel.calory
                        stepDic["distance"] = stepModel.distance
                        stepDic["steps"] = stepModel.steps
                        stepDic["time"] = stepModel.time
                        
                        var historyStepsInfo: [String: Any] = [:]
                        historyStepsInfo["historyDay"] = "THEDAYBEFOREYESTERDAY"
                        historyStepsInfo["stepsInfo"] = stepDic
                        
                        var stepParam: [String: Any] = [:]
                        stepParam["type"] = 2
                        stepParam["historyStepsInfo"] = historyStepsInfo
                        let stepStr = SystemAuth.getJsonStringFromBasicTypeData(data: stepParam)
                        self.stepChangeEventStreamHandler.stepChangeEventSink?(stepStr)
                    }
                }
                
                //思澈用这个方法获取历史步数，(day:0-6; 0为今天，1为昨天 ，以此类推
                CRPSmartBandSDK.sharedInstance.getHistoryStepData(day: type) { day, stepModel, error in
                    var stepDic: [String: Any] = [:]
                    stepDic["calories"] = stepModel.calory
                    stepDic["distance"] = stepModel.distance
                    stepDic["steps"] = stepModel.steps
                    stepDic["time"] = stepModel.time
                    
                    var historyStepsInfo: [String: Any] = [:]
                    historyStepsInfo["historyDay"] = type == 1 ? "YESTERDAY" : "THEDAYBEFOREYESTERDAY"
                    historyStepsInfo["stepsInfo"] = stepDic
                    
                    var stepParam: [String: Any] = [:]
                    stepParam["type"] = 2
                    stepParam["historyStepsInfo"] = historyStepsInfo
                    let stepStr = SystemAuth.getJsonStringFromBasicTypeData(data: stepParam)
                    self.stepChangeEventStreamHandler.stepChangeEventSink?(stepStr)
                }
            }
            result(nil)
        case "queryStepsDetail":
            //查询步数详情
            //TODO: - flutter是监听接收
            self.isConnectedForConnectState {
                let dateType = receivedDic["stepsDetailDateType"] as! Int
                let dayArray = ["TODAY","YESTERDAY"]
                if dateType == 0 {
                    CRPSmartBandSDK.sharedInstance.get24HourSteps { datas, error in
                        
                        var param: [String: Any] = [:]
                        param["type"] = 1
                        
                        var model: [String: Any] = [:]
                        model["historyDay"] = dayArray[dateType]
                        model["stepsList"] = datas
                        
                        param["stepsCategoryInfo"] = model
                        let str = SystemAuth.getJsonStringFromBasicTypeData(data: param)
                        self.stepsDetailEventStreamHandler.stepsDetailEventSink?(str)
                    }
                }
                else {
                    CRPSmartBandSDK.sharedInstance.getAgo24HourSteps { datas, error in
                        var param: [String: Any] = [:]
                        param["type"] = 1
                        
                        var model: [String: Any] = [:]
                        model["historyDay"] = dayArray[dateType]
                        model["stepsList"] = datas
                        
                        param["stepsCategoryInfo"] = model
                        let str = SystemAuth.getJsonStringFromBasicTypeData(data: param)
                        self.stepsDetailEventStreamHandler.stepsDetailEventSink?(str)
                    }
                }
            }
            result(nil)
        case "sendGoalSteps":
            //设置目标步数
            self.isConnectedForConnectState {
                CRPSmartBandSDK.sharedInstance.setGoal(receivedDic["goalSteps"] as! Int)
            }
            result(nil)
        case "queryGoalSteps":
            //查询⽬标步数
            CRPSmartBandSDK.sharedInstance.getGoal { goal, error in
                result(goal)
            }
        case "sendDailyGoals":
            let goalDic: Dictionary = SystemAuth.getDictionaryFromJSONString(jsonString: receivedDic["dailyGoals"] as! String)
            CRPSmartBandSDK.sharedInstance.setNormalExerciseGoal(CRPExerciseGoalsModel(step: goalDic["steps"] as! Int, kcal: goalDic["calories"] as! Int, distance: goalDic["distance"] as! Int, exerciseTime: goalDic["trainingTime"] as! Int))
            result(nil)
        case "queryDailyGoals":
            CRPSmartBandSDK.sharedInstance.getNormalExerciseGoal { exerciseGoalsModel, error in
                var dic: [String: Any] = [:]
                dic["steps"] = exerciseGoalsModel.step
                dic["calories"] = exerciseGoalsModel.kcal
                dic["trainingTime"] = exerciseGoalsModel.exerciseTime
                dic["distance"] = exerciseGoalsModel.distance

                let str = SystemAuth.getJsonStringFromBasicTypeData(data: dic)
//                    print("方法名： querySteps +++++  数据：  \(param)")
                result(str)
            }
        case "sendTrainingDayGoals":
            let goalDic: Dictionary = SystemAuth.getDictionaryFromJSONString(jsonString: receivedDic["dailyGoals"] as! String)
            CRPSmartBandSDK.sharedInstance.setExerciseDayGoal(CRPExerciseGoalsModel(step: goalDic["steps"] as! Int, kcal: goalDic["calories"] as! Int, distance: goalDic["distance"] as! Int, exerciseTime: goalDic["trainingTime"] as! Int))
            result(nil)
        case "queryTrainingDayGoals":
            CRPSmartBandSDK.sharedInstance.getExerciseDayGoal { exerciseGoalsModel, error in
                var dic: [String: Any] = [:]
                dic["steps"] = exerciseGoalsModel.step
                dic["calories"] = exerciseGoalsModel.kcal
                dic["trainingTime"] = exerciseGoalsModel.exerciseTime
                dic["distance"] = exerciseGoalsModel.distance

                let str = SystemAuth.getJsonStringFromBasicTypeData(data: dic)
//                    print("方法名： querySteps +++++  数据：  \(param)")
                result(str)
            }
        case "sendTrainingDays":
            let goalDic: Dictionary = SystemAuth.getDictionaryFromJSONString(jsonString: receivedDic["trainingDay"] as! String)
            CRPSmartBandSDK.sharedInstance.setExerciseState(CRPExerciseGoalStateModel(state: goalDic["enable"] as! Int, weekday: goalDic["trainingDays"] as! [Int]))
            result(nil)
        case "queryTrainingDay":
            CRPSmartBandSDK.sharedInstance.getExerciseState { exerciseGoalsStateModel, error in
                var dic: [String: Any] = [:]
                dic["enable"] = Bool(truncating: exerciseGoalsStateModel.state as NSNumber)
                dic["trainingDays"] = exerciseGoalsStateModel.weekday

                let str = SystemAuth.getJsonStringFromBasicTypeData(data: dic)
//                    print("方法名： querySteps +++++  数据：  \(param)")
                result(str)
            }
        //MARK: - 活动步数 -
        case "get24HourCals":
            self.isConnectedForConnectState {
                CRPSmartBandSDK.sharedInstance.get24HourCals { value, error in
                    var dic: [String: Any] = [:]
                    dic["list"] = value

                    let str = SystemAuth.getJsonStringFromBasicTypeData(data: dic)
                    result(str)
                }
            }
        case "getAgo24HourCals":
            self.isConnectedForConnectState {
                CRPSmartBandSDK.sharedInstance.getAgo24HourCals { value, error in
                    var dic: [String: Any] = [:]
                    dic["list"] = value

                    let str = SystemAuth.getJsonStringFromBasicTypeData(data: dic)
                    result(str)
                }
            }
        case "get24HourDistances":
            self.isConnectedForConnectState {
                CRPSmartBandSDK.sharedInstance.get24HourDistances { value, error in
                    var dic: [String: Any] = [:]
                    dic["list"] = value

                    let str = SystemAuth.getJsonStringFromBasicTypeData(data: dic)
                    result(str)
                }
            }
        case "getAgo24HourDistances":
            self.isConnectedForConnectState {
                CRPSmartBandSDK.sharedInstance.getAgo24HourDistances { value, error in
                    var dic: [String: Any] = [:]
                    dic["list"] = value
                    let str = SystemAuth.getJsonStringFromBasicTypeData(data: dic)
                    result(str)
                }
            }
        case "queryActionDetails":
            self.isConnectedForConnectState {
                let dayType = receivedDic["actionDetailsType"] as! Int
                CRPSmartBandSDK.sharedInstance.getActionDetailInfo(day: dayType) { day, info, error in
                    let dayArray = ["TODAY","YESTERDAY"]
                    var param: [String: Any] = [:]
                    param["type"] = 2
                    var model: [String: Any] = [:]
                    model["historyDay"] = dayArray[day]
                    model["stepsList"] = info.steps
                    model["distanceList"] = info.distances.map{$0 / 100}
                    model["caloriesList"] = info.kcals.map{$0 / 1000}
                    
                    param["actionDetailsInfo"] = model
                    let str = SystemAuth.getJsonStringFromBasicTypeData(data: param)
                    self.stepsDetailEventStreamHandler.stepsDetailEventSink?(str)
                }
            }
            result(nil)
            
        //MARK: - 表盘 -
        case "sendDisplayWatchFace":
            //切换⼿环表盘
            self.isConnectedForConnectState {
                CRPSmartBandSDK.sharedInstance.setDial(receivedDic["watchFaceType"] as! Int)
            }
            result(nil)
        case "queryDisplayWatchFace":
            //查询⼿环正在使⽤的表盘序号
            self.isConnectedForConnectState {
                CRPSmartBandSDK.sharedInstance.getDial { number, error in
                    result(number)
                }
            }
        case "queryWatchFaceLayout":
            //获取指定表盘布局
            self.isConnectedForConnectState {
                CRPSmartBandSDK.sharedInstance.getScreenContent { content, imageSize, i, error in
                    var param: [String: Any] = [:]
                    self.screenCompressionType = i
                    param["backgroundPictureMd5"] = content.md5
                    param["compressionType"] = ScreenCompressionType(rawValue: i)?.description
                    param["height"] = imageSize.originalHeight
                    //hex转int
    //                let a = Scanner.init(string: content.contentColor.hexString!)
    //                var b: UInt32 = 0
    //                if withUnsafeMutablePointer(to: &b, { a.scanHexInt32($0)
    //                }){
//                       print(Int(b))
    //                }
    //                let colorString: String = content.contentColor.hexString ?? ""
    //                let colorNumber: Int = colorString.hexToDecamail()
                    param["textColor"] = content.contentColor.hexString?.hexToDecamail()
                    
                    param["thumHeight"] = imageSize.abbreviatedHeight
                    param["thumWidth"] = imageSize.abbreviatedWidth
                    param["timeBottomContent"] = content.underContent.rawValue
                    param["timePosition"] = content.position.rawValue
                    param["timeTopContent"] = content.upperContent.rawValue
                    param["width"] = imageSize.originalWidth
                    let str = SystemAuth.getJsonStringFromBasicTypeData(data: param)
                    result(str)
                }
            }
        case "sendWatchFaceLayout":
            //修改⾃定义表盘布局
            self.isConnectedForConnectState {
                let dic = SystemAuth.getDictionaryFromJSONString(jsonString: receivedDic["watchFaceLayoutInfo"] as! String)

                let hexColor = String(dic["textColor"] as! Int, radix: 16, uppercase: true)
                let textColor = UIColor.init(hexString: hexColor)
                
                let content = ScreenContent(position: ContentPosition(rawValue: dic["timePosition"] as! Int)!, upperContent: Content(rawValue: dic["timeTopContent"] as! Int)!, underContent: Content(rawValue: dic["timeBottomContent"] as! Int)!, contentColor: textColor, md5: dic["backgroundPictureMd5"] as! String)
                
                CRPSmartBandSDK.sharedInstance.setupScreenContent(content: content)
            }
            result(nil)
        case "querySupportWatchFace":
            //获取⽀持表盘类型
            self.isConnectedForConnectState {
                
                CRPSmartBandSDK.sharedInstance.getSiFliWatchFaceSupportModel { supportModel, error in
                    var list: [SifliWatchFaceModel] = []
                    for watchFace in supportModel.currentIDs {
                        let watchFaceModel = SifliWatchFaceModel(id: watchFace.id, state: "\(watchFace.state)")
                        list.append(watchFaceModel)
                    }
                    let supportWatchFaceBeanModel = SupportWatchFaceBeanModel(type: "SIFLI", sifliSupportWatchFaceInfo: SifliSupportWatchFaceInfoModel(typeList: supportModel.supportModel, list: list))
                    let param = supportWatchFaceBeanModel.toJSON()
                    let resultString = SystemAuth.getJsonStringFromBasicTypeData(data: param ?? "")
                    result(resultString)
                }
                
                CRPSmartBandSDK.sharedInstance.getNewWatchFaceSupportModel { supportModel, error in
                    let supportWatchFaceBeanModel = SupportWatchFaceBeanModel(type: "JIELI", jieliSupportWatchFaceInfo: JieliSupportWatchFaceInfoModel(displayWatchFace: supportModel.currentID, watchFaceMaxSize: supportModel.udtMaxSize, supportTypeList: supportModel.supportModel))
                    let param = supportWatchFaceBeanModel.toJSON()
                    let resultString = SystemAuth.getJsonStringFromBasicTypeData(data: param ?? "")
                    result(resultString)
                }
                
                CRPSmartBandSDK.sharedInstance.getWatchFaceSupportModel { model, error in
                    let supportWatchFaceBeanModel = SupportWatchFaceBeanModel(type: "DEFAULT", supportWatchFaceInfo: SupportWatchFaceInfoModel(displayWatchFace: model.currentID, supportWatchFaceList: model.supportModel))
                    let param = supportWatchFaceBeanModel.toJSON()
                    let resultString = SystemAuth.getJsonStringFromBasicTypeData(data: param ?? "")
                    result(resultString)
                }
                
            }
        case "queryWatchFaceStore":
            //获取表盘市场,根据表盘的⽀持类型获取能可以更换的表盘列表(分⻚获取)
            self.isConnectedForConnectState {
                let dic = SystemAuth.getDictionaryFromJSONString(jsonString: receivedDic["watchFaceStoreBean"] as! String)
//                print("表盘市场的参数：\(dic)")
                CRPSmartBandSDK.sharedInstance.getWatchFaceInfo(supportModel: dic["watchFaceSupportList"] as! [Int], currentPage: dic["pageIndex"] as! Int, perPage: dic["pageCount"] as! Int, isSiFli: false, max_size: 0) { watchFace, total, count, error in
                    var param: [String: Any] = [:]
                    
                    var watchFaceStore: [String: Any] = [:]
                    watchFaceStore["prePage"] = total
                    watchFaceStore["pageIndex"] = count
                    var list: [[String: Any]] = [[String: Any]]()
                    for data in watchFace {
                        var info: [String: Any] = [:]
                        info["id"] = data.id
                        info["preview"] = data.imageUrl
                        info["file"] = data.fileUrl
                        list.append(info)
                    }
                    watchFaceStore["list"] = list
                    watchFaceStore["total"] = list.count
                    
                    param["watchFaceStoreInfo"] = watchFaceStore
                    param["error"] = String(describing: error)
                    let str = SystemAuth.getJsonStringFromBasicTypeData(data: param)
//                    print("支持的表盘：\(str)")
                    result(str)
                }
            }
        case "queryWatchFaceOfID":
            //获取表盘ID的表盘信息
            self.isConnectedForConnectState {
                let currentId = receivedDic["id"] as! Int
                CRPSmartBandSDK.sharedInstance.getWatchFaceInfoByID(id: currentId, isSiFli: false) { watchFace, total, count, error in
                    var param: [String: Any] = [:]
                    var info: [String: Any] = [:]
                    for data in watchFace {
                        if data.id == currentId {
                            info["id"] = data.id
                            info["preview"] = data.imageUrl
                            info["file"] = data.fileUrl
                        }
                    }
                    if info.keys.count == 0 {
                        info["id"] = currentId
                        info["preview"] = ""
                        info["file"] = ""
                    }
                    
                    param["watchFace"] = info
                    param["error"] = String(describing: error)
                    param["code"] = 0
                    let str = SystemAuth.getJsonStringFromBasicTypeData(data: param)
                    result(str)
                }
            }
        case "sendWatchFaceBackground":
            //设置表盘背景
            self.isConnectedForConnectState {
                let dic = SystemAuth.getDictionaryFromJSONString(jsonString: receivedDic["watchFaceBackgroundInfo"] as! String)
                let imageSize = ScreenImageSize(originalWidth: dic["width"] as! Int, originalHeight: dic["height"] as! Int, abbreviatedWidth: dic["thumbWidth"] as! Int, abbreviatedHeight: dic["thumbHeight"] as! Int)
                // Uint8List bitmap;Uint8List thumbBitmap;
                let image = UIImage(data: Data(dic["bitmap"] as! Array))!
                CRPSmartBandSDK.sharedInstance.startChangeScreen(image, imageSize, false, self.screenCompressionType)
                
            }
            result(nil)
        case "sendWatchFace":
            //将新表盘的表盘文件发送给手表，在此过程中手表会重新启动。这个转移进程由CRPWatchFaceTransListener。
            self.isConnectedForConnectState {
                let dic = SystemAuth.getDictionaryFromJSONString(jsonString: receivedDic["sendWatchFaceBean"] as! String)
                let info: [String: Any] = dic["watchFaceFlutterBean"] as! [String : Any]
                CRPSmartBandSDK.sharedInstance.startChangeWatchFaceFromFile(path: info["file"] as! String, isSiFli: false, info["index"] as! Int)
            }
            result(nil)
        case "abortWatchFaceBackground":
            self.isConnectedForConnectState {
                
            }
            result(nil)
        case "abortWatchFace":
            self.isConnectedForConnectState {
                CRPSmartBandSDK.sharedInstance.stopChangeWatchFace(isSiFli: false)
            }
            result(nil)
        case "deleteWatchFace":
            self.isConnectedForConnectState {
                let watchFaceId = receivedDic["id"] as! Int
            }
            result(nil)
        case "queryWatchFaceStoreTagList":
            self.isConnectedForConnectState {
                let receivedDic = SystemAuth.getDictionaryFromJSONString(jsonString: receivedDic["watchFaceStoreTagList"] as! String)
                if let receivedModel = WatchFaceStoreTagListBeanModel.deserialize(from: receivedDic) {
                    CRPSmartBandSDK.sharedInstance.getNewWatchFaceTagList(supportModel: receivedModel.typeList, ver: receivedModel.firmwareVersion, currentPage: receivedModel.pageIndex, perPage: receivedModel.perPageCount, memorySize: receivedModel.maxSize, platform: self.hardWareType, model: CRPScreenMarketVersionModel(apiVersion: receivedModel.apiVersion, funcVersion: receivedModel.feature)) { tagList, error in
                        
                        var watchFaceStoreTagInfoList = [WatchFaceStoreTagInfoModel]()
                        for data in tagList {
                            var watchFaceStoreItemList = [WatchFaceStoreItemModel]()
                            for face in data.faces {
                                let watchFaceStoreItemModel = WatchFaceStoreItemModel(id: face?.id ?? 0, name: face?.name ?? "", size: face?.size ?? 0, download: face?.download ?? 0, preview: face?.preview ?? "")
                                watchFaceStoreItemList.append(watchFaceStoreItemModel)
                            }
                            
                            let watchFaceStoreTagInfoModel = WatchFaceStoreTagInfoModel(tagId: data.id, tagName: data.tag_name ?? "", list: watchFaceStoreItemList)
                            watchFaceStoreTagInfoList.append(watchFaceStoreTagInfoModel)
                        }
                        
                        let watchFaceStoreTagListResultModel = WatchFaceStoreTagListResultModel(list: watchFaceStoreTagInfoList, error: String(describing: error))
                        let param = watchFaceStoreTagListResultModel.toJSON()
                        let resultString = SystemAuth.getJsonStringFromBasicTypeData(data: param as Any)
                        result(resultString)
                    }
                }
                    
            }
        case "queryWatchFaceStoreList":
            self.isConnectedForConnectState {
                let receivedDic = SystemAuth.getDictionaryFromJSONString(jsonString: receivedDic["watchFaceStoreList"] as! String)
                if let receivedModel = WatchFaceStoreListBeanModel.deserialize(from: receivedDic), let watchfaceStoreTagListModel = receivedModel.watchFaceStoreTagList {
                    CRPSmartBandSDK.sharedInstance.getNewWatchFaceList(tag_id: receivedModel.tagId, ver: watchfaceStoreTagListModel.firmwareVersion, supportModel: watchfaceStoreTagListModel.typeList, currentPage: watchfaceStoreTagListModel.pageIndex, perPage: watchfaceStoreTagListModel.perPageCount, memorySize: watchfaceStoreTagListModel.maxSize, platform: self.hardWareType, model: CRPScreenMarketVersionModel(apiVersion: watchfaceStoreTagListModel.apiVersion, funcVersion: watchfaceStoreTagListModel.feature)) { list, error in
                        var watchFaceArray: [WatchFaceBeanModel] = []
                        for watchFace in list {
                            let watchFaceBeanModel = WatchFaceBeanModel(id: watchFace.id, preview: watchFace.preview ?? "", file: watchFace.file ?? "")
                            watchFaceArray.append(watchFaceBeanModel)
                        }
                        
                        let watchFaceStoreInfoBeanModel = watchFaceStoreInfoBeanModel(total: list.count, prePage: watchfaceStoreTagListModel.perPageCount, pageIndex: watchfaceStoreTagListModel.pageIndex, list: watchFaceArray)
                        let watchFaceStoreResultBeanModel = WatchFaceStoreResultBeanModel(watchFaceStoreInfo: watchFaceStoreInfoBeanModel, error: "")

                        let param = watchFaceStoreResultBeanModel.toJSON()
                        let resultString = SystemAuth.getJsonStringFromBasicTypeData(data: param as Any)
                        result(resultString)
                    }
                }
                
                
            }
        case "queryWatchFaceDetail":
            self.isConnectedForConnectState {
                let receivedDic = SystemAuth.getDictionaryFromJSONString(jsonString: receivedDic["watchFaceStoreTagList"] as! String)
                if let receivedModel = WatchFaceStoreTypeBeanModel.deserialize(from: receivedDic) {
                    CRPSmartBandSDK.sharedInstance.getNewWatchFaceInfo(screenId: receivedModel.id, ver: receivedModel.firmwareVersion, supportModel: [], memorySize: receivedModel.maxSize, platform: self.hardWareType, model: CRPScreenMarketVersionModel(apiVersion: receivedModel.apiVersion, funcVersion: receivedModel.feature)) { watchFaceInfo, error in
                        guard let watchFaceInfoModel = watchFaceInfo else {
                            return
                        }
                        
                        var recommendWatchFaceList = [RecommendWatchFaceBeanModel]()
                        if watchFaceInfoModel.face_list.count > 0 {
                            for face in watchFaceInfoModel.face_list {
                                let model = RecommendWatchFaceBeanModel(id: face.id, name: face.name ?? "", size: face.size, preview: face.preview ?? "")
                                recommendWatchFaceList.append(model)
                            }
                        }
                        
                        let watchFaceDetailsBeanModel = WatchFaceDetailsBeanModel(id: watchFaceInfoModel.id, name: watchFaceInfoModel.name ?? "", download: watchFaceInfoModel.download, size: watchFaceInfoModel.size, file: watchFaceInfo?.file ?? "", preview: watchFaceInfoModel.preview ?? "", remarkCn: watchFaceInfoModel.remark_cn ?? "", remarkEn: watchFaceInfoModel.remark_en ?? "", recommendWatchFaceList: recommendWatchFaceList)
                        let watchFaceBeanModel = WatchFaceBeanModel(id: watchFaceInfoModel.id, preview: watchFaceInfoModel.preview ?? "", file: watchFaceInfoModel.file ?? "")
                        let watchFaceDetailResultBeanModel = WatchFaceDetailResultBeanModel(error: "", watchFaceDetailsInfo: watchFaceDetailsBeanModel, watchFaceBean: watchFaceBeanModel)
                        let param = watchFaceDetailResultBeanModel.toJSON()
                        let resultString = SystemAuth.getJsonStringFromBasicTypeData(data: param ?? "")
                        result(resultString)
                    }
                }
            }
        case "queryJieliWatchFaceInfo":
            self.isConnectedForConnectState {
                CRPSmartBandSDK.sharedInstance.getJLScreenMarketVersionInfo { model, error in
                    let jlWatchFaceBeanModel = JieliWatchFaceBeanModel(apiVersion: model.apiVersion, feature: model.funcVersion)
                    let param = jlWatchFaceBeanModel.toJSON()
                    let resultString = SystemAuth.getJsonStringFromBasicTypeData(data: param ?? "")
                    result(resultString)
                }
                
            }
        case "sendWatchFaceId":
            self.isConnectedForConnectState {

            }
            result(nil)
        //MARK: - 可用存储空间
        case "queryAvailableStorage":
            self.isConnectedForConnectState {
                guard let type = receivedDic["type"] as? Int  else {
                    result(1024*1024)
                    return
                }
                
                switch type {
                case 5:
                    //思澈
                    CRPSmartBandSDK.sharedInstance.getSiFliUDTMaxSize { value, error in
                        result(value)
                    }
                case 6:
                    //杰里
                    CRPSmartBandSDK.sharedInstance.getUDTMaxSize { value, error in
                        result(value)
                    }
                default:
                    result(1024*1024)
                }
            }
            result(nil)
        //MARK: - 闹钟 -
        case "sendNewAlarm":
            self.isConnectedForConnectState {
                let dic = SystemAuth.getDictionaryFromJSONString(jsonString: receivedDic["alarmClockInfo"] as! String)
//                print("sendNewAlarm: \(dic)")
                let repeatMode: Int = dic["repeatMode"] as! Int
                var type: CRPSmartBand.AlarmType = .weekly
                var weekday: [Int] = []
                if repeatMode == 0 {
                    type = .once
                    weekday = []
                } else if repeatMode == 127 {
                    type = .everyday
                    weekday = self.returnAlarmWeeks(repeatMode: repeatMode)
                } else {
                    weekday = self.returnAlarmWeeks(repeatMode: repeatMode)
                }
//                print("sendNewAlarm-weekday: \(weekday)")
                let model = AlarmModel(id: dic["id"] as! Int, enable: dic["enable"] as! Int, type: type, hour: dic["hour"] as! Int, minute: dic["minute"] as! Int, year:SystemAuth.getDateComponent(type: .year, date: Date()), month: SystemAuth.getDateComponent(type: .month, date: Date()), day: SystemAuth.getDateComponent(type: .day, date: Date()), weekday: weekday)
                CRPSmartBandSDK.sharedInstance.setNewVerAddAlarm(model)
                CRPSmartBandSDK.sharedInstance.setAlarm(model)
                
            }
            result(nil)
        case "deleteNewAlarm":
            self.isConnectedForConnectState {
                let alarmId = receivedDic["id"] as! Int
                CRPSmartBandSDK.sharedInstance.setNewVerDeleteAlarm(alarmId)
            }
            result(nil)
        case "deleteAllNewAlarm":
            self.isConnectedForConnectState {
                CRPSmartBandSDK.sharedInstance.setNewVerDeleteAllAlarm()
            }
            result(nil)
        case "queryAllNewAlarm":
            self.isConnectedForConnectState {
                
                CRPSmartBandSDK.sharedInstance.getAlarms { alarms, error in
                    var arr: [AlarmInfoModel] = []
                    for alarm in alarms {
                        
                        var repeatMode: Int = 0
                        switch alarm.type {
                        case .once:
                            repeatMode = 0
                        case .everyday:
                            repeatMode = 127
                        case .weekly:
                            repeatMode = self.returnRepeatMode(withWeeks: alarm.weekday)
                        default:
                            repeatMode = 0
                        }
                        
                        let alarm = AlarmInfoModel(id: alarm.id, enable: Bool(truncating: alarm.enable as NSNumber), hour: alarm.hour, minute: alarm.minute, repeatMode: repeatMode)
                        arr.append(alarm)
                    }
                    
                    let alarmBeanModel = AlarmBeanModel(list: arr, isNew: false)
                    let param = alarmBeanModel.toJSON()
                    let resultString = SystemAuth.getJsonStringFromBasicTypeData(data: param as Any)
                    result(resultString)
                }
                
                CRPSmartBandSDK.sharedInstance.getNewVerAlarm { alarms, error in
                    var arr: [AlarmInfoModel] = []
                    for alarm in alarms {
                        
                        var repeatMode: Int = 0
                        switch alarm.type {
                        case .once:
                            repeatMode = 0
                        case .everyday:
                            repeatMode = 127
                        case .weekly:
                            repeatMode = self.returnRepeatMode(withWeeks: alarm.weekday)
                        default:
                            repeatMode = 0
                        }
                        
                        let alarm = AlarmInfoModel(id: alarm.id, enable: Bool(truncating: alarm.enable as NSNumber), hour: alarm.hour, minute: alarm.minute, repeatMode: repeatMode)
                        arr.append(alarm)
                    }
                    
                    let alarmBeanModel = AlarmBeanModel(list: arr, isNew: true)
                    let param = alarmBeanModel.toJSON()
                    let resultString = SystemAuth.getJsonStringFromBasicTypeData(data: param as Any)
                    result(resultString)
                }
            }
        //MARK: - 心率 -
        case "queryLastDynamicRate":
            //查询上次动态⼼率测量结果,receiveHeartRateAll回调
            //TODO: - 这里要去代理里面加监听，然后组合一下数据传给flutter
            self.isConnectedForConnectState {
                self.historyDynamicRateType = receivedDic["type"] as! String
                self.currentHistoryDynamicRateIndex = 0
                CRPSmartBandSDK.sharedInstance.getHeartData()
            }
            result(nil)
        case "enableTimingMeasureHeartRate":
            //开始定时测量心率，正数为开启
            self.isConnectedForConnectState {
                CRPSmartBandSDK.sharedInstance.set24HourHeartRate(receivedDic["interval"] as! Int)
            }
            result(nil)
        case "disableTimingMeasureHeartRate":
            self.isConnectedForConnectState {
                //关闭定时测量心率，0为关闭
                CRPSmartBandSDK.sharedInstance.set24HourHeartRate(0)
            }
            result(nil)
        case "queryTimingMeasureHeartRate":
            self.isConnectedForConnectState {
                //获取24⼩时定时测量间隔时间
                CRPSmartBandSDK.sharedInstance.get24HourHeartRateInterval { headtRateInterval, error in
                    result(headtRateInterval)
                }
            }
        case "queryTodayHeartRate":
            self.isConnectedForConnectState {
                //查询今天定时测量⼼率数据
                //TODO: - flutter监听接收
                /*
                 TodayHeartRateType：
                 | timingMeasureHeartRate       | **allDayHeartRate**            |
                 | ---------------------------- | ------------------------------ |
                 | Timed heart rate measurement | 24-hour continuous measurement |
                 */
                let type = receivedDic["heartRateType"] as! Int
                switch type {
                case 1:
                    CRPSmartBandSDK.sharedInstance.get24HourHeartRate { datas, error in
                        var interval = 0
                        var dic: [String: Any] = [:]
                        dic["heartRateList"] = datas
                        dic["startTime"] = self.getMorningDateStamp(intervalDay: 0)
                        if datas.count > 0 {
                            interval = 1440 / datas.count
                        }
                        dic["timeInterval"] = interval
                        var param: [String: Any] = [:]
                        param["type"] = 5
                        param["hour24MeasureResult"] = dic
                        
                        let str = SystemAuth.getJsonStringFromBasicTypeData(data: param)
                        self.heartRateEventStreamHandler.heartRateEventSink?(str)
                    }
                    //思澈用这个方法获取多天历史定时测量⼼率数据，(day:0-6; 0为今天，1为昨天 ，以此类推)
                    CRPSmartBandSDK.sharedInstance.getHistoryHrData(day: 0) { day, value, error in
                        var interval = 0
                        var dic: [String: Any] = [:]
                        dic["heartRateList"] = value
                        dic["startTime"] = self.getMorningDateStamp(intervalDay: 0)
                        if value.count > 0 {
                            interval = 1440 / value.count
                        }
                        dic["timeInterval"] = interval
                        var param: [String: Any] = [:]
                        param["type"] = 5
                        param["hour24MeasureResult"] = dic
                        
                        let str = SystemAuth.getJsonStringFromBasicTypeData(data: param)
                        self.heartRateEventStreamHandler.heartRateEventSink?(str)
                    }
                case 2:
                    CRPSmartBandSDK.sharedInstance.getFullDayHeartRate { today, yesterday, error in
                        var todayInterval = 0
                        var todayDic: [String: Any] = [:]
                        todayDic["heartRateList"] = today
                        todayDic["startTime"] = self.getMorningDateStamp()
                        if today.count > 0 {
                            todayInterval = 1440 / today.count
                        }
//                        todayDic["timeInterval"] = todayInterval
                        todayDic["timeInterval"] = 1
                        var todayParam: [String: Any] = [:]
                        todayParam["type"] = 5
                        todayParam["hour24MeasureResult"] = todayDic
                        let todayStr = SystemAuth.getJsonStringFromBasicTypeData(data: todayParam)
                        self.heartRateEventStreamHandler.heartRateEventSink?(todayStr)
                        
                        var yesterdayInterval = 0
                        var yesterdayDic: [String: Any] = [:]
                        yesterdayDic["heartRateList"] = yesterday
                        yesterdayDic["startTime"] = self.getMorningDateStamp(intervalDay: 1)
                        if yesterday.count > 0 {
                            yesterdayInterval = 1440 / yesterday.count
                        }
//                        yesterdayDic["timeInterval"] = yesterdayInterval
                        yesterdayDic["timeInterval"] = 1//说 24小时持续测量 的时间间隔都是1
                        var yesterdayParam: [String: Any] = [:]
                        yesterdayParam["type"] = 5
                        yesterdayParam["hour24MeasureResult"] = yesterdayDic
                        let yesterdayStr = SystemAuth.getJsonStringFromBasicTypeData(data: yesterdayParam)
                        self.heartRateEventStreamHandler.heartRateEventSink?(yesterdayStr)
                    }
                default:
                    break
                }
            }
            result(nil)
        case "queryPastHeartRate":
            self.isConnectedForConnectState {
                //查询过去的定时测量⼼率数据
                CRPSmartBandSDK.sharedInstance.getAgo24HourHeartRate { datas, error in
                    //TODO: - 这里会返回[int],flutter用监听接收
                    var interval = 0
                    var dic: [String: Any] = [:]
                    dic["heartRateList"] = datas
                    if datas.count > 0 {
                        interval = 1440 / datas.count
                    }
                    dic["startTime"] = self.getMorningDateStamp(intervalDay: 1)
                    dic["timeInterval"] = interval
                    var param: [String: Any] = [:]
                    param["type"] = 5
                    param["hour24MeasureResult"] = dic
                    let str = SystemAuth.getJsonStringFromBasicTypeData(data: param)
                    self.heartRateEventStreamHandler.heartRateEventSink?(str)
                }
                
                //思澈用这个方法，day传0是今天，1是昨天，2是前天,最多查7天
                CRPSmartBandSDK.sharedInstance.getHistoryHrData(day: 1) { day, value, error in
                    var interval = 0
                    var dic: [String: Any] = [:]
                    dic["heartRateList"] = value
                    if value.count > 0 {
                        interval = 1440 / value.count
                    }
                    dic["startTime"] = self.getMorningDateStamp(intervalDay: 1)
                    dic["timeInterval"] = interval
                    var param: [String: Any] = [:]
                    param["type"] = 5
                    param["hour24MeasureResult"] = dic
                    let str = SystemAuth.getJsonStringFromBasicTypeData(data: param)
                    self.heartRateEventStreamHandler.heartRateEventSink?(str)
                }
            }
            result(nil)
        case "queryTrainingHeartRate":
            self.isConnectedForConnectState {
                //获取运动数据,测量量结果包括⼼⼼率和卡路⾥等其它运动相关数据,保存最近三次
                //TODO: - flutter监听接收
//                CRPSmartBandSDK.sharedInstance.getHeartData()
                
                CRPSmartBandSDK.sharedInstance.getSportData({ models, error in

                    var list: [[String: Any]] = [[String: Any]]()
                    for model in models {
                        if model.startTime > 1000000000 {
                            var dic: [String: Any] = [:]
                            dic["type"] = model.type.rawValue
                            dic["startTime"] = model.startTime
                            dic["endTime"] = model.endTime
                            dic["validTime"] = model.vaildTime
                            dic["steps"] = model.step
                            dic["distance"] = model.distance
                            dic["calories"] = model.kcal
                            list.append(dic)
                        }
                        
                    }

                    var param: [String: Any] = [:]
                    param["type"] = 6
                    param["trainingList"] = list
                    let str = SystemAuth.getJsonStringFromBasicTypeData(data: param)
                    self.heartRateEventStreamHandler.heartRateEventSink?(str)
                })
            }
            result(nil)
        case "startMeasureOnceHeartRate":
            self.isConnectedForConnectState {
                //开启静态⼼率单次测量,测量结果通过receiveHeartRate(_ heartRate: Int)回调
                CRPSmartBandSDK.sharedInstance.setStartSingleHR()
            }
            result(nil)
        case "stopMeasureOnceHeartRate":
            //结束静态⼼率单次测量,测量结果通过receiveHeartRate(_ heartRate: Int)回调
            //TODO: - 这里方法走完会进入  receiveHeartRate代理，flutter监听接收
            self.isConnectedForConnectState {
                CRPSmartBandSDK.sharedInstance.setStopSingleHR()
            }
            result(nil)
        case "queryHistoryHeartRate":
            self.isConnectedForConnectState {
                //获取单次⼼率测量历史记录
                CRPSmartBandSDK.sharedInstance.getHeartRecordData { heartRecordDatas, error in
                    //TODO: - flutter监听接收
                    var param: [String: Any] = [:]
                    var list: [[String: Any]] = [[String: Any]]()
                    for data in heartRecordDatas {
                        var dic: [String: Any] = [:]
                        dic["hr"] = data.value
                        dic["date"] = String(data.time)
                        list.append(dic)
                    }
                    param["type"] = 3
                    param["historyHrList"] = list
                    let str = SystemAuth.getJsonStringFromBasicTypeData(data: param)
                    self.heartRateEventStreamHandler.heartRateEventSink?(str)
                }
            }
            result(nil)
        //MARK: - 血压 -
        case "startMeasureBloodPressure":
            //开始测量⾎压，点了以后，就会开始走代理receiveBloodPressure，
            //TODO: - 这里会调用回调receiveBloodPressure，flutter监听接收
            self.isConnectedForConnectState {
                CRPSmartBandSDK.sharedInstance.setStartBlood()
            }
            result(nil)
        case "stopMeasureBloodPressure":
            self.isConnectedForConnectState {
                //停⽌测量⾎压,测量结果通过receiveBloodPressure回调
                CRPSmartBandSDK.sharedInstance.setStopBlood()
            }
            result(nil)
        case "enableContinueBloodPressure":
            self.isConnectedForConnectState {
                //设置全天⾎压
                CRPSmartBandSDK.sharedInstance.setFullDayBPStatus(open: true)
            }
            result(nil)
        case "disableContinueBloodPressure":
            self.isConnectedForConnectState {
                //设置全天⾎压
                CRPSmartBandSDK.sharedInstance.setFullDayBPStatus(open: false)
            }
            result(nil)
        case "queryContinueBloodPressureState":
            self.isConnectedForConnectState {
                //获取全天⾎压状态
                CRPSmartBandSDK.sharedInstance.getFullDayBPStatus { status, error in
                   //TODO: - flutter监听接收
                    var param: [String: Any] = [:]
                    param["type"] = 1
                    param["continueState"] = Bool(truncating: status as NSNumber)
                    let str = SystemAuth.getJsonStringFromBasicTypeData(data: param)
                    self.bloodPressureEventStreamHandler.bloodPressureEventSink?(str)
                }
            }
            result(nil)
        case "queryLast24HourBloodPressure":
            //查询最近24小时血压
            //Android通过CRPBloodPressureChangeListener回调。onContinueBloodPressure (CRPBloodPressureInfo信息);
            self.isConnectedForConnectState {
                //获取全天⾎压数据
                CRPSmartBandSDK.sharedInstance.getFullDayBPData { datas, error in
                    //TODO: - flutter监听接收, 数据对不上
                    var dic: [String: Any] = [:]
                    dic["startTime"] = 0
                    dic["timeInterval"] = 0

                    var param: [String: Any] = [:]
                    param["type"] = 4
                    param["continueBp"] = dic
                    let str = SystemAuth.getJsonStringFromBasicTypeData(data: param)
                    self.bloodPressureEventStreamHandler.bloodPressureEventSink?(str)
                }
            }
            result(nil)
        case "queryHistoryBloodPressure":
            self.isConnectedForConnectState {
                //获取单次⾎压测量历史记录
                //Android通过CRPBloodPressureChangeListener回调。onHistoryBloodPressure列表(列表);
                CRPSmartBandSDK.sharedInstance.getBPRecordData { datas, error in
                    //TODO: - flutter监听接收
                    var param: [String: Any] = [:]
                    var list: [[String: Any]] = [[String: Any]]()
                    for data in datas {
                        var info: [String: Any] = [:]
                        info["SBP"] = data.SBP
                        info["DBP"] = data.DBP
                        info["date"] = String(data.time)
                        list.append(info)
                    }
                    param["type"] = 3
                    param["historyBpList"] = list
                    let str = SystemAuth.getJsonStringFromBasicTypeData(data: param)
                    self.bloodPressureEventStreamHandler.bloodPressureEventSink?(str)
                }
            }
            result(nil)
        case "startMeasureBloodOxygen":
            //MARK: - 血氧 -
            self.isConnectedForConnectState {
                //开始测量⾎氧
                //TODO: - 好像时间到了以后也会走代理receiveSpO2，flutter监听接收
                CRPSmartBandSDK.sharedInstance.setStartSpO2()
            }
            result(nil)
        case "stopMeasureBloodOxygen":
            self.isConnectedForConnectState {
                //停⽌测量⾎氧
                //TODO: - 返回值在receiveSpO2代理，flutter监听接收
                CRPSmartBandSDK.sharedInstance.setStopSpO2()
            }
            result(nil)
        case "enableTimingMeasureBloodOxygen":
            self.isConnectedForConnectState {
                //开启定时测量血氧
                CRPSmartBandSDK.sharedInstance.setAutoO2(receivedDic["interval"] as! Int)
            }
            result(nil)
        case "disableTimingMeasureBloodOxygen":
            self.isConnectedForConnectState {
                //禁用计时测量血氧
                CRPSmartBandSDK.sharedInstance.setAutoO2(0)
            }
            result(nil)
        case "queryTimingBloodOxygenMeasureState":
            self.isConnectedForConnectState {
                //查询定时测血氧状态
                //android 通过CRPBloodOxygenChangeListener回调。onTimingMeasure (int间隔);
                CRPSmartBandSDK.sharedInstance.getAutoO2Interval { data, error in
                    //TODO: - flutter监听接收
                    var param: [String: Any] = [:]
                    param["type"] = 2
                    param["timingMeasure"] = data
                    let str = SystemAuth.getJsonStringFromBasicTypeData(data: param)
                    self.bloodOxygenEventStreamHandler.bloodOxygenEventSink?(str)
                }
            }
            result(nil)
        case "queryTimingBloodOxygen":
            self.isConnectedForConnectState {
                //查询定时测血氧
                //android 通过CRPBloodOxygenChangeListener回调。onContinueBloodOxygen (CRPBloodOxygenInfo信息);
                //["bloodOxygenTimeType": TODAY]
                //["bloodOxygenTimeType": YESTERDAY]
                let type = receivedDic["bloodOxygenTimeType"] as! String
                CRPSmartBandSDK.sharedInstance.getAutoO2Data { todayData, error in
                    //TODO: - flutter监听接收
                    if type == "TODAY" {
                        var param: [String: Any] = [:]
                        param["type"] = 2
                        param["continueBO"] = todayData
                        let str = SystemAuth.getJsonStringFromBasicTypeData(data: param)
                        self.bloodOxygenEventStreamHandler.bloodOxygenEventSink?(str)
                    }
                } _: { yesterdayData, error in
                    //TODO: - flutter监听接收
                    if type == "YESTERDAY" {
                        var param: [String: Any] = [:]
                        param["type"] = 2
                        param["continueBO"] = yesterdayData
                        let str = SystemAuth.getJsonStringFromBasicTypeData(data: param)
                        self.bloodOxygenEventStreamHandler.bloodOxygenEventSink?(str)
                    }
                }
            }
            result(nil)
        case "enableContinueBloodOxygen":
            self.isConnectedForConnectState {
                //设置全天⾎氧
                CRPSmartBandSDK.sharedInstance.setFullDayO2Status(open: true)
            }
            result(nil)
        case "disableContinueBloodOxygen":
            self.isConnectedForConnectState {
                //设置全天⾎氧
                CRPSmartBandSDK.sharedInstance.setFullDayO2Status(open: false)
            }
            result(nil)
        case "queryContinueBloodOxygenState":
            self.isConnectedForConnectState {
                //查询持续的血氧状态
                //android 通过CRPBloodOxygenChangeListener回调。onContinueState(布尔状态);
                CRPSmartBandSDK.sharedInstance.getFullDayO2Status { data, error in
                    //TODO: - flutter监听接收
                    var param: [String: Any] = [:]
                    param["type"] = 1
                    param["continueState"] = Bool(truncating: data as NSNumber)
                    let str = SystemAuth.getJsonStringFromBasicTypeData(data: param)
                    self.bloodOxygenEventStreamHandler.bloodOxygenEventSink?(str)
                }
            }
            result(nil)
        case "queryLast24HourBloodOxygen":
            self.isConnectedForConnectState {
                //查询最近24小时血氧 Android
                CRPSmartBandSDK.sharedInstance.getFullDayO2Data { data, error in
                    //TODO: - flutter监听接收
                    var param: [String: Any] = [:]
                    param["type"] = 2
                    param["continueBO"] = data
                    let str = SystemAuth.getJsonStringFromBasicTypeData(data: param)
                    self.bloodOxygenEventStreamHandler.bloodOxygenEventSink?(str)
                }
            }
            result(nil)
        case "queryHistoryBloodOxygen":
            self.isConnectedForConnectState {
                //获取单次⾎氧测量历史记录
                //android 通过CRPBloodOxygenChangeListener回调。onHistoryBloodOxygen列表(列表);
                CRPSmartBandSDK.sharedInstance.getO2RecordData { datas, error in
                    //TODO: - flutter监听接收
                    var param: [String: Any] = [:]
                    var list: [[String: Any]] = [[String: Any]]()
                    for data in datas {
                        var dic: [String: Any] = [:]
                        dic["bo"] = data.value
                        dic["date"] = String(data.time)
                        list.append(dic)
                    }
                    param["type"] = 4
                    param["historyList"] = list
                    let str = SystemAuth.getJsonStringFromBasicTypeData(data: param)
                    self.bloodOxygenEventStreamHandler.bloodOxygenEventSink?(str)
                }
            }
            result(nil)
        case "enterCameraView":
            //MARK: - 拍照 -
            self.isConnectedForConnectState {
                //进入相机
                CRPSmartBandSDK.sharedInstance.switchCameraView()
            }
            result(nil)
        case "exitCameraView":
            self.isConnectedForConnectState {
                //退出相机
                CRPSmartBandSDK.sharedInstance.exitCameraView()
            }
            result(nil)
        case "sendDelayTaking":
            self.isConnectedForConnectState {
                let delayTime = receivedDic["delayTime"] as! Int
                CRPSmartBandSDK.sharedInstance.setDelayTaking(seconds: delayTime)
            }
            result(nil)
        case "queryDelayTaking":
            result(nil)
            break
        case "readDeviceRssi":
            //MARK: - RSSI - iOS端暂时没有
            //读取手表的实时RSSI   Android
            result(nil)
            break
        case "startECGMeasure":
            //MARK: - 心电图测量 -
            self.isConnectedForConnectState {
                //开始测量心电图
                CRPSmartBandSDK.sharedInstance.startECGMeasure()
            }
            result(nil)
        case "stopECGMeasure":
            self.isConnectedForConnectState {
                //停⽌⼼电测量
                CRPSmartBandSDK.sharedInstance.stopECGMeasure()
            }
            result(nil)
        case "isNewECGMeasurementVersion":
            self.isConnectedForConnectState {
                //检测是否是新的⼼电测量⽅式
                let isNew = CRPSmartBandSDK.sharedInstance.isNewECGMeasurementVersion()
                result(isNew)
            }
        case "queryLastMeasureECGData":
            self.isConnectedForConnectState {
                //查询上次⼼电数据 android
                //查询手表保存的心电数据，结果由CRPBleECGChangeListener.onECGChange()回调。android
                //TODO: - 通过代理receiveECGDate返回给监听,ECGEvnentSink,flutter监听接收
                CRPSmartBandSDK.sharedInstance.getLastMeasureECGData()
            }
            result(nil)
        case "sendECGHeartRate":
            self.isConnectedForConnectState {
                //设置⼼电测量期间⼼率,⽤测量所得到的数据，通过⼼电算法库计算出瞬时⼼率，发送⾄⼿环。
                CRPSmartBandSDK.sharedInstance.sendECGHeartRate(heartRate: receivedDic["heartRate"] as! Int)
            }
            result(nil)
        case "setECGChangeListener":
            //MARK: - iOS端暂无
            //所有心电相关数据将通过CRPBleECGChangeListener回收。
            result(nil)
            break
        case "sendDeviceVersion":
            //MARK: - 语言 -
            self.isConnectedForConnectState {
                //设置⼿环当前语⾔版本,⼿环语⾔版本分中⽂版和国际版，中⽂版只显示中⽂，国际版才能切换外语
                CRPSmartBandSDK.sharedInstance.setLanguageVersion(true)
            }
            result(nil)
        case "queryDeviceVersion":
            self.isConnectedForConnectState {
                
            }
            result(nil)
        case "sendDeviceLanguage":
            self.isConnectedForConnectState {
                //设置⼿环语⾔
                CRPSmartBandSDK.sharedInstance.setLanguage(receivedDic["language"] as! Int)
            }
            result(nil)
        case "queryDeviceLanguage":
            self.isConnectedForConnectState {
                //获取当前⼿环语⾔
                var param: [String: Any] = [:]
                CRPSmartBandSDK.sharedInstance.getLanguage { language, error in
                    param["type"] = language
                } _: { languages, error in
                    param["languageType"] = languages
                    let str = SystemAuth.getJsonStringFromBasicTypeData(data: param)
                    result(str)
                }
            }
        //MARK: - 通知 -
        case "setNotification":
            self.isConnectedForConnectState { [weak self] in
                guard let self = self else { return }
                //设置其它消息推送状态,开启或者关闭其它消息推送。
                var datas: [NotificationType] = []
                let notifications: [Int] = receivedDic["list"] as! [Int]
                if let yourArray = UserDefaults.standard.array(forKey: "notificationSupportTypeArray") as? [Int] {
                    if self.notificationSupportTypeArray.count == 0 {
                        self.notificationSupportTypeArray = yourArray
                    }
                }
                if self.notificationSupportTypeArray.count > 0 {
                    guard notifications.count == self.notificationSupportTypeArray.count else {
                        return
                    }
                    CRPSmartBandSDK.sharedInstance.setNotificationState(notifications)
                } else {
                    for notification in notifications {
                        let data: NotificationType = NotificationType.init(rawValue: notification) ?? .phone
                        datas.append(data)
                    }
                    CRPSmartBandSDK.sharedInstance.setNotification(datas)
                }
            }
            result(nil)
        case "getNotification":
            self.isConnectedForConnectState {
                if let yourArray = UserDefaults.standard.array(forKey: "notificationSupportTypeArray") as? [Int] {
                    if self.notificationSupportTypeArray.count == 0 {
                        self.notificationSupportTypeArray = yourArray
                    }
                }
                
                if self.notificationSupportTypeArray.count > 0 {
                    CRPSmartBandSDK.sharedInstance.getNotificationState { datas, error in
                        var param: [String: Any] = [:]
                        param["list"] = datas
                        param["isNew"] = true
                        let str = SystemAuth.getJsonStringFromBasicTypeData(data: param)
                        result(str)
                    }
                } else {
                    CRPSmartBandSDK.sharedInstance.getNotifications { datas, error in
                        var param: [String: Any] = [:]
                        param["list"] = datas
                        param["isNew"] = false
                        let str = SystemAuth.getJsonStringFromBasicTypeData(data: param)
                        result(str)
                    }
                }
            }
        case "sendOtherMessageState":
            self.isConnectedForConnectState {
                let state = receivedDic["state"] as! Int
            }
            result(nil)
        case "queryOtherMessageState":
            self.isConnectedForConnectState {
                
            }
            result(nil)
        case "sendMessage":
            self.isConnectedForConnectState {
                //向手表发送各类消息内容。
                
                let dic: [String: Any] = SystemAuth.getDictionaryFromJSONString(jsonString: receivedDic["messageInfo"] as! String)
                CRPSmartBandSDK.sharedInstance.setMessage(dic["message"] as! String)
            }
            result(nil)
        case "queryMessageList":
            self.isConnectedForConnectState {
                CRPSmartBandSDK.sharedInstance.getNotificationSupportType { value, error in
                    self.notificationSupportTypeArray = value
                    let str = value.map{String($0) }.joined(separator: ",")
                    result(str)
                }
            }
        case "endCall":
            //MARK: - iOS端暂无
            //当手表接收到手机类型的信息推送，手表将振动一个固定的时间。调用这个接口来停止手表手表接通或电话挂断时震动。
            result(nil)
            break
        case "sendCallContactName":
            self.isConnectedForConnectState {
                let name = receivedDic["name"] as! String
            }
            result(nil)
        case "queryContactNumberSymbol":
            self.isConnectedForConnectState {
                
            }
            result(nil)
        case "sendSedentaryReminder":
            //MARK: - 久坐提醒 -
            self.isConnectedForConnectState {
                //开启或者关闭久坐提醒。
                CRPSmartBandSDK.sharedInstance.setRemindersToMove(receivedDic["sedentaryReminder"] as! Bool)
            }
            result(nil)
        case "querySedentaryReminder":
            self.isConnectedForConnectState {
                //查询久坐提醒状态
                CRPSmartBandSDK.sharedInstance.getRemindersToMove { state, error in
                    result(Bool(truncating: state as NSNumber))
                }
            }
        case "sendSedentaryReminderPeriod":
            self.isConnectedForConnectState {
                //设置久坐提醒有效时间段
                let dic = SystemAuth.getDictionaryFromJSONString(jsonString: receivedDic["sedentaryReminderPeriodInfo"] as! String)
                let model = SitRemindModel(period: dic["period"] as! Int, steps: dic["steps"] as! Int, startHour: dic["startHour"] as! Int, endHour: dic["endHour"] as! Int)
                CRPSmartBandSDK.sharedInstance.setSitRemind(model)
            }
            result(nil)
        case "querySedentaryReminderPeriod":
            self.isConnectedForConnectState {
                //获取久坐提醒时间段
                CRPSmartBandSDK.sharedInstance.getSitRemindInfo { model, error in
                    var param: [String: Any] = [:]
                    param["startHour"] = model.startHour
                    param["period"] = model.period
                    param["endHour"] = model.endHour
                    param["steps"] = model.steps
                    let str = SystemAuth.getJsonStringFromBasicTypeData(data: param)
                    result(str)
                }
            }
        //MARK: - 找寻设备 -
        case "findDevice":
            self.isConnectedForConnectState {
                //查找⼿环，⼿环收到此指令以后会震动⼏秒。
                CRPSmartBandSDK.sharedInstance.setFindDevice()
            }
            result(nil)
        //MARK: - 关机 -
        case "shutDown":
            self.isConnectedForConnectState {
                //⼿环关机
                CRPSmartBandSDK.sharedInstance.shutDown()
            }
            result(nil)
        //MARK: - 勿扰时段 -
        case "sendDoNotDisturbTime":
            self.isConnectedForConnectState {
                //设置勿扰时段,⼿环⽀持勿扰时段，勿扰时段内不显示消息推送
                let dic = SystemAuth.getDictionaryFromJSONString(jsonString: receivedDic["periodTimeInfo"] as! String)
                let model = periodTimeModel(startHour: dic["startHour"] as! Int, startMin: dic["startMinute"] as! Int, endHour: dic["endHour"] as! Int, endMin: dic["endMinute"] as! Int)
                
                CRPSmartBandSDK.sharedInstance.setDisturbTime(model)
            }
            result(nil)
        case "queryDoNotDisturbTime":
            self.isConnectedForConnectState {
                //查询⼿环设置的勿扰时段
                CRPSmartBandSDK.sharedInstance.getDisturbTime { model, error in
                    var periodTimeInfo: [String: Any] = [:]
                    periodTimeInfo["startHour"] = model.startHour
                    periodTimeInfo["startMinute"] = model.startMin
                    periodTimeInfo["endHour"] = model.endHour
                    periodTimeInfo["endMinute"] = model.endMin
                    var param: [String: Any] = [:]
                    param["periodTimeInfo"] = periodTimeInfo
                    // int DO_NOT_DISTRUB_TYPE = 1;int QUICK_VIEW_TYPE = 2;
                    param["periodTimeType"] = 1
                    let str = SystemAuth.getJsonStringFromBasicTypeData(data: param)
                    result(str)
                }
            }
        //MARK: - 呼吸灯 -  iOS端暂时没有
        case "sendBreathingLight":
            
            //设置呼吸灯,一些手表支持呼吸灯，并打开或关闭呼吸灯。
            result(nil)
            break
        case "queryBreathingLight":
            result(nil)
            break
        //MARK: - 生理周期 -
        case "sendMenstrualCycle":
            self.isConnectedForConnectState {
                //设置⽣理周期提醒
                //TODO: -
                let dic = SystemAuth.getDictionaryFromJSONString(jsonString: receivedDic["menstrualCycleBean"] as! String)
                let startDate: Int = Int(dic["startDate"] as! String) ?? 0
                let date: Date = SystemAuth.timeToDate(timeStamp: startDate)
                
                
                let model = Physiological(reminderModels: [], cycleTime: dic["physiologcalPeriod"] as! Int, menstruationTime: dic["menstrualPeriod"] as! Int, lastTimeMonth: SystemAuth.getDateComponent(type: .month, date: date), lastTimeDay: SystemAuth.getDateComponent(type: .day, date: date), remindTimeHour: dic["reminderHour"] as! Int, remindTimeMinute: dic["reminderMinute"] as! Int)
                CRPSmartBandSDK.sharedInstance.setPhysiological(model)
            }
            result(nil)
        case "queryMenstrualCycle":
            self.isConnectedForConnectState {
                //查询⽣理周期提醒
                //TODO: - 这里参数对不上
                CRPSmartBandSDK.sharedInstance.getPhysiological { data, error in
                    
                    let year = SystemAuth.getDateComponent(type: .year, date: Date())
                    
                    let dateString: String = "\(year):\(data.lastTimeMonth):\(data.lastTimeDay)"
                    let date: Date = SystemAuth.timeToStamp(time: dateString)
                    let startDate: Int = SystemAuth.getTimeInterval(date: date)
                    var param: [String: Any] = [:]
                    param["reminderModels"] = data.reminderModels
                    param["physiologcalPeriod"] = data.cycleTime
                    param["menstrualPeriod"] = data.menstruationTime
                    param["startDate"] = String(startDate)
                    param["reminderHour"] = data.remindTimeHour
                    param["reminderMinute"] = data.remindTimeMinute
                    param["menstrualReminder"] = true
                    param["ovulationReminder"] = true
                    param["ovulationDayReminder"] = true
                    param["ovulationEndReminder"] = true
                    let str = SystemAuth.getJsonStringFromBasicTypeData(data: param)
                    result(str)
                }
            }
        //MARK: - 查找手机 -
        case "startFindPhone":
            self.isConnectedForConnectState {
                //开始找寻手机
                //收到回叫后，APP会震动并播放铃声提醒，您就可以按以下命令回复手环。一些手镯支持此命令。
                CRPSmartBandSDK.sharedInstance.sendFindingPhone()
            }
            result(nil)
        case "stopFindPhone":
            self.isConnectedForConnectState {
                //结束找寻手机
                CRPSmartBandSDK.sharedInstance.stopFindPhone()
            }
            result(nil)
        //MARK: - 播放器 - iOS端暂无此接口
        case "setPlayerState":
            //设置播放器状态
            result(nil)
            break
        case "sendSongTitle":
            //设置歌的标题
            result(nil)
            break
        case "sendLyrics":
            //设置歌词
            result(nil)
            break
        case "closePlayerControl":
            //关闭音乐控制
            result(nil)
            break
        case "sendMaxVolume":
            //设置最大音量
            result(nil)
            break
        case "sendCurrentVolume":
            //设置当前音量
            result(nil)
            break
        //MARK: - 喝水提醒 -
        case "enableDrinkWaterReminder":
            self.isConnectedForConnectState {
                //设置喝⽔提醒数据
                let dic = SystemAuth.getDictionaryFromJSONString(jsonString: receivedDic["drinkWaterPeriodInfo"] as! String)
                let model = drinkWaterRemind(isRemind: true, startHour: dic["startHour"] as! Int, startMinute: dic["startMinute"] as! Int, remindCount: dic["count"] as! Int, remindTimeInterval: dic["period"] as! Int, waterIntake: dic["currentCups"] as! Int)
                CRPSmartBandSDK.sharedInstance.sendDrinkWaterRemind(model)
            }
            result(nil)
        case "disableDrinkWaterReminder":
            self.isConnectedForConnectState {
                //设置喝⽔提醒数据
                let model = drinkWaterRemind(isRemind:false, startHour: 0, startMinute:0, remindCount: 0, remindTimeInterval: 0, waterIntake: 0)
                CRPSmartBandSDK.sharedInstance.sendDrinkWaterRemind(model)
            }
            result(nil)
        case "queryDrinkWaterReminderPeriod":
            self.isConnectedForConnectState {
                //获取喝⽔提醒数据
                CRPSmartBandSDK.sharedInstance.getDrinkWaterRemind { data, error in
                    var param: [String: Any] = [:]
                    param["enable"] = data.isRemind
                    param["startHour"] = data.startHour
                    param["startMinute"] = data.startMinute
                    param["count"] = data.remindCount
                    param["period"] = data.remindTimeInterval
                    param["currentCups"] = data.waterIntake
                    let str = SystemAuth.getJsonStringFromBasicTypeData(data: param)
                    result(str)
                }
            }
        //MARK: - 心率预警 -
        case "setMaxHeartRate":
            self.isConnectedForConnectState {
                //设置⼼率预警值
                let dic = SystemAuth.getDictionaryFromJSONString(jsonString: receivedDic["maxHeartRateBean"] as! String)
                let model = hrRemind(isRemind: dic["enable"] as! Bool, max: dic["heartRate"] as! Int)
                CRPSmartBandSDK.sharedInstance.sendHeartRateRemind(model)
            }
            result(nil)
        case "queryMaxHeartRate":
            self.isConnectedForConnectState {
                //获取⼼率预警值
                CRPSmartBandSDK.sharedInstance.getHeartRateRemind { data, error in
                    var param: [String: Any] = [:]
                    param["enable"] = data.isRemind
                    param["heartRate"] = data.max
                    let str = SystemAuth.getJsonStringFromBasicTypeData(data: param)
                    result(str)
                }
            }
        //MARK: - 锻炼 - iOS端暂无
        case "startTraining":
            self.isConnectedForConnectState {
                //开启锻炼
                CRPSmartBandSDK.sharedInstance.setSportState(state: SportType(rawValue: receivedDic["type"] as! Int) ?? SportType.walking)
            }
            result(nil)
        case "setTrainingState":
            self.isConnectedForConnectState {
                //设置锻炼状态
                CRPSmartBandSDK.sharedInstance.setSportState(state: SportType(rawValue: receivedDic["type"] as! Int) ?? SportType.walking)
            }
            result(nil)
        //MARK: - 协议版本 - iOS端暂无
        case "getProtocolVersion":
            //获取协议版本
            result(nil)
            break
        //MARK: - 温度 -
        case "startMeasureTemp":
            self.isConnectedForConnectState {
                //开始单次体温测量
                //Android：在开始测量之后，通过CRPTempChangeListener.onMeasureTemp()回调实时温度，并且测量状态通过CRPTempChangeListener.onMeasureTempState()回调
                //ios则是：receiveRealTimeTemperature回调⽅法返回测量值，receiveTemperature回调⽅法返回测量状态
                //TODO: - flutter监听接收
                CRPSmartBandSDK.sharedInstance.sendSingleTemperatureStart()
            }
            result(nil)
        case "stopMeasureTemp":
            self.isConnectedForConnectState {
                //结束单次体温测量
                //TODO: - flutter监听接收
                CRPSmartBandSDK.sharedInstance.sendSingleTemperatureEnd()
            }
            result(nil)
        case "enableTimingMeasureTemp":
            self.isConnectedForConnectState {
                //（iOS）开启定时温度测量，receiveRealTimeTemperature回调⽅法返回测量值，receiveTemperature回调⽅法返回测量状态
                //TODO: - flutter监听接收
                CRPSmartBandSDK.sharedInstance.sendAutoTemperature(true)
            }
            result(nil)
        case "disableTimingMeasureTemp":
            self.isConnectedForConnectState {
                //禁用定时温度测量
                CRPSmartBandSDK.sharedInstance.sendAutoTemperature(false)
            }
            result(nil)
        case "queryTimingMeasureTempState":
            self.isConnectedForConnectState {
                //获取⾃动体温测量开关
                CRPSmartBandSDK.sharedInstance.getAutoTemperatureState { data, error in
                    //1：开启；0：关闭 这个回调没走，不知道为什么
                    //TODO: - flutter监听接收
                    var param: [String: Any] = [:]
                    param["type"] = 3
                    param["state"] = Bool(truncating: data as NSNumber)
                    let str = SystemAuth.getJsonStringFromBasicTypeData(data: param)
                    self.temperatureChangeEventStreamHandler.temperatureChangeEventSink?(str)
                }
            }
            result(nil)
        case "queryTimingMeasureTemp":
            self.isConnectedForConnectState {
                //获取⾃动体温测量数据,每半⼩时⼀个数据
                //手环可以保存最后两天的计时测温数据，并通过回调结果CRPTempChangeListener.onTimingMeasureTemp (CRPTempInfo)。
                //TODO: - flutter监听接收
                let tempTimeType = receivedDic["tempTimeType"] as! String
                CRPSmartBandSDK.sharedInstance.getAutoTemperatureData { todayDatas, error in
                    //TODO: - 通过回调传给监听
                    if tempTimeType == "TODAY" {
                        
                        var dic: [String: Any] = [:]
                        dic["tempTimeType"] = tempTimeType
                        dic["tempList"] = todayDatas
                        
                        var param: [String: Any] = [:]
                        param["type"] = 4
                        param["tempInfo"] = dic
                        let str = SystemAuth.getJsonStringFromBasicTypeData(data: param)
                        self.temperatureChangeEventStreamHandler.temperatureChangeEventSink?(str)
                    }
                } _: { yesterdayDatas, error in
                    //TODO: - 通过回调传给监听
                    if tempTimeType == "YESTERDAY" {
                        
                        var dic: [String: Any] = [:]
                        dic["tempTimeType"] = tempTimeType
                        dic["tempList"] = yesterdayDatas
                        
                        var param: [String: Any] = [:]
                        param["type"] = 4
                        param["tempInfo"] = dic
                        let str = SystemAuth.getJsonStringFromBasicTypeData(data: param)
                        self.temperatureChangeEventStreamHandler.temperatureChangeEventSink?(str)
                    }
                }
            }
            result(nil)
        //MARK: - 亮屏时间
        case "sendDisplayTime":
            self.isConnectedForConnectState {
                //设置亮屏时间
                CRPSmartBandSDK.sharedInstance.sendAutoLockTime(receivedDic["time"] as! Int)
            }
            result(nil)
        case "queryDisplayTime":
            self.isConnectedForConnectState {
                //获取亮屏时间
                CRPSmartBandSDK.sharedInstance.getAutoLockTime { data, error in
                    result(data.AutoLockTime)
                }
            }
        case "sendGsensorCalibration":
            self.isConnectedForConnectState {
                CRPSmartBandSDK.sharedInstance.sendCalibration()
            }
            result(nil)
        //MARK: - 洗手提醒 -
        case "enableHandWashingReminder":
            self.isConnectedForConnectState {
                //开启洗⼿提醒
                let dic = SystemAuth.getDictionaryFromJSONString(jsonString: receivedDic["handWashingPeriodInfo"] as! String)
                let model = eventRemind(isRemind: dic["enable"] as! Bool, startHour: dic["startHour"] as! Int, startMinute: dic["startMinute"] as! Int, remindCount: dic["count"] as! Int, remindTimeInterval: dic["period"] as! Int)
                CRPSmartBandSDK.sharedInstance.sendHandWashRemind(model)
            }
            result(nil)
        case "disableHandWashingReminder":
            self.isConnectedForConnectState {
                //禁用洗手提醒
                let model = eventRemind(isRemind: false, startHour: 0, startMinute: 0, remindCount: 0, remindTimeInterval: 0)
                CRPSmartBandSDK.sharedInstance.sendHandWashRemind(model)
            }
            result(nil)
        case "queryHandWashingReminderPeriod":
            self.isConnectedForConnectState {
                //获取洗⼿提醒数据，结果从闭包返回
                CRPSmartBandSDK.sharedInstance.getHandWashRemind { data, error in
                    var param: [String: Any] = [:]
                    param["enable"] = data.isRemind
                    param["startHour"] = data.startHour
                    param["startMinute"] = data.startMinute
                    param["count"] = data.remindCount
                    param["period"] = data.remindTimeInterval
                    let str = SystemAuth.getJsonStringFromBasicTypeData(data: param)
                    result(str)
                }
            }
        //MARK: - 温度 -
        case "sendTempUnit":
            self.isConnectedForConnectState {
                //切换手环的温度系统。
                CRPSmartBandSDK.sharedInstance.setTemperatureUnit(receivedDic["temp"] as! Int)
            }
            result(nil)
        case "queryTempUnit":
            self.isConnectedForConnectState {
                //查询系统温度
                CRPSmartBandSDK.sharedInstance.getTemperatureUnit { data, error in
                    //TODO: - flutter监听接收
                    var param: [String: Any] = [:]
                    param["type"] = 2
                    param["tempUnit"] = data
                    let str = SystemAuth.getJsonStringFromBasicTypeData(data: param)
                    self.weatherEventStreamHandler.weatherEventSink?(str)
                }
            }
            result(nil)
        //MARK: - 亮度 -  iOS端暂无此接口
        case "sendBrightness":
            //设置亮度
            result(nil)
            break
        case "queryBrightness":
            //查询亮度
            result(nil)
            break
        //MARK: - 蓝牙地址 -
        case "queryBtAddress":
            self.isConnectedForConnectState {
                //获取经典的蓝牙地址
                CRPSmartBandSDK.sharedInstance.getMac { data, error in
                    result(data)
                }
            }
        //MARK: - 联系人 -
        case "checkSupportQuickContact":
            self.isConnectedForConnectState {
                //获取联系⼈配置项
                CRPSmartBandSDK.sharedInstance.getContactProfile { data, error in
                    var param: [String: Any] = [:]
                    param["supported"] = true
                    param["width"] = data.contactAvatarWidth
                    param["height"] = data.contactAvatarHeight
                    param["count"] = data.contactMax
                    let str = SystemAuth.getJsonStringFromBasicTypeData(data: param)
                    result(str)
                }
            }
        case "queryContactCount":
            self.isConnectedForConnectState {
                //获取当前联系⼈个数
                CRPSmartBandSDK.sharedInstance.getContactCount { data, error in
                    result(data)
                }
            }
        case "sendContact":
            self.isConnectedForConnectState {
                //设置联系⼈
                CRPSmartBandSDK.sharedInstance.getContactProfile { data, error in
                    let dic = SystemAuth.getDictionaryFromJSONString(jsonString: receivedDic["contactBean"] as! String)
//                    print("sendContact发送过来的联系人信息为：\(dic)")
                    var avatar = UIImage()
                    if let image = UIImage(data: Data(dic["avatar"] as? Array ?? [])) {
                        avatar = image
                    }
                    let contact: CRPContact = CRPContact(contactID: dic["id"] as! Int, fullName: dic["name"] as! String, image: avatar, phoneNumber: dic["number"] as! String)
                    CRPSmartBandSDK.sharedInstance.setContact(profile: data, contacts: [contact])
                }
            }
            result(nil)
        case "sendContactAvatar":
            self.isConnectedForConnectState {
                //设置联系⼈
                CRPSmartBandSDK.sharedInstance.getContactProfile { data, error in
                    let dic = SystemAuth.getDictionaryFromJSONString(jsonString: receivedDic["contactAvatarBean"] as! String)
//                    print("sendContactAvatar发送过来的联系人信息为：\(dic)")
                    var avatar = UIImage()
                    if let image = UIImage(data: Data(dic["avatar"] as? Array ?? [])) {
                        avatar = image
                    }
                    let contact: CRPContact = CRPContact(contactID: dic["id"] as! Int, fullName: dic["name"] as! String, image: avatar, phoneNumber: dic["number"] as! String)
                    CRPSmartBandSDK.sharedInstance.setContact(profile: data, contacts: [contact])
                }
            }
            result(nil)
        case "deleteContact":
            //删除联系人
            CRPSmartBandSDK.sharedInstance.deleteContact(contactID: receivedDic["index"] as! Int)
            result(nil)
        //MARK: - iOS端暂无
        case "deleteContactAvatar":
            //删除联系人
            result(nil)
            break
        case "clearContact":
            //删除联系人
            CRPSmartBandSDK.sharedInstance.cleanAllContact()
            result(nil)
        //MARK: - 省电模式 -
        case "sendBatterySaving":
            self.isConnectedForConnectState {
                //设置省电状态
                let enable = receivedDic["enable"] as! Bool
                CRPSmartBandSDK.sharedInstance.setPowerSaveState(open: enable)
            }
            result(nil)
        case "queryBatterySaving":
            self.isConnectedForConnectState {
                //获取省电状态
                //TODO: - flutter监听接收
                CRPSmartBandSDK.sharedInstance.getPowerSaveState { data, error in
                    self.batterySavingEventStreamHandler.batterySavingEventSink?(Bool(truncating: data as NSNumber))
                }
            }
            result(nil)
        //MARK: - 吃药提醒 -
        case "queryPillReminder":
            self.isConnectedForConnectState {
                //获取当前吃药提醒信息,通过receiveMedicineInfo⽅法返回数据
                //android 通过CRPPillReminderCallback进行回调。onpillremind (int supportCount, List List);
                CRPSmartBandSDK.sharedInstance.getMedicineInfo()
                self.returnReceiveMedicineInfoClosure { max, model in
                    
                    var list: [[String: Any]] = [[String: Any]]()
                    model?.reminderTimes.forEach({ timeModel in
                        var dic: [String: Any] = [:]
                        dic["remindTimeHour"] = timeModel.remindTimeHour
                        dic["remindTimeMinute"] = timeModel.remindTimeMinute
                        dic["pillCount"] = timeModel.pillCount
                        list.append(dic)
                    })
                
                    var info: [String: Any] = [:]
                    info["id"] = model?.medincineID
                    info["dateOffset"] = model?.pastDay
                    info["name"] = model?.medincineName
                    info["repeat"] = model?.cycleTime
                    info["reminderTimeList"] = list
                    
                    var param: [String: Any] = [:]
                    param["supportCount"] = max
                    param["list"] = [info]
                    let str = SystemAuth.getJsonStringFromBasicTypeData(data: param)
                    result(str)
                }
            }
        case "sendPillReminder":
            self.isConnectedForConnectState {
                //设置吃药提醒
                //TODO: - 这里有个reminderTimeList不知道
                let dic = SystemAuth.getDictionaryFromJSONString(jsonString: receivedDic["pillReminderInfo"] as! String)
                let model = CRPMedicineReminderModel(medincineID: dic["id"] as! Int, pastDay: dic["dateOffset"] as! Int, medincineName: dic["name"] as! String, cycleTime: dic["repeat"] as! Int, reminderTimes: [])//reminderTimeList
                CRPSmartBandSDK.sharedInstance.setMedicine(medicine: model)
            }
            result(nil)
        case "deletePillReminder":
            self.isConnectedForConnectState {
                //删除指定id的吃药提醒
                CRPSmartBandSDK.sharedInstance.deleteMedicine(id: receivedDic["id"] as! Int)
            }
            result(nil)
        case "clearPillReminder":
            self.isConnectedForConnectState {
                //删除所有吃药提醒设置
                CRPSmartBandSDK.sharedInstance.deleteAllMedicine()
            }
            result(nil)
        //MARK: - 唤醒 -
        case "sendWakeState":
            self.isConnectedForConnectState {
                //设置屏幕轻触唤醒
                CRPSmartBandSDK.sharedInstance.setTapToWake(open: receivedDic["enable"] as! Bool)
            }
            result(nil)
        case "queryWakeState":
            self.isConnectedForConnectState {
                //获取屏幕轻触唤醒设置(0: 关闭，1: 开启)
                CRPSmartBandSDK.sharedInstance.readTapToWake { data, error in
                    result(Bool(truncating: data as NSNumber))
                }
            }
        //MARK: - 锻炼 - ios端暂无
        case "queryHistoryTraining":
            //查询历史锻炼
            //android 查询手表中存储的培训记录。查询结果将通过CRPTrainingChangeListener。onHistoryTrainingChange列表(列表)。
            //TODO: - flutter监听接收
            CRPSmartBandSDK.sharedInstance.getSportRecordList()
            result(nil)
            break
        //MARK: - iOS端暂无
        case "queryTraining":
            if let id = receivedDic["id"] as? Int {
                self.getSportRecordData(id: id) { model in
                    let trainBeanModel = TrainBeanModel(trainingList: [model], type: 2)
                    let param = trainBeanModel.toJSON()
                    let resultString = SystemAuth.getJsonStringFromBasicTypeData(data: param as Any)
                    self.trainingEventStreamHandler.trainingEventSink?(resultString)
                }
            }
            
            result(nil)
            break
        case "querySleep":
            self.isConnectedForConnectState {
                //同步睡眠
                //获取今天的睡眠数据，结果被CRPSleepChangeListener.onSleepChange()回调。手表的睡眠时间是晚上八点，而且手表会记录从晚上8点到第二天早上10点的睡眠时间(android)
                //TODO: - flutter监听接收
                CRPSmartBandSDK.sharedInstance.getSleepData { data, error in
                    var soberTime = 0
                    var remTime = 0
                    var details: [[String: Any]] = []
                    for sleepDetail in data.detail {
                        if Int(sleepDetail["type"] ?? "0") == 0 {
                            soberTime += Int(sleepDetail["total"] ?? "0") ?? 0
                        }
                        if Int(sleepDetail["type"] ?? "0") == 3 {
                            remTime += Int(sleepDetail["total"] ?? "0") ?? 0
                        }
                        
                        var detail = [String: Any]()
                        if let type = Int(sleepDetail["type"] ?? "0") {
                            detail["type"] = type
                        }
                        
                        if let totalString = sleepDetail["total"], let totalTime = Int(totalString) {
                            detail["totalTime"] = totalTime
                        }
                        if let startString = sleepDetail["start"], let startTime = SystemAuth.totalMinutes(from: startString) {
                            detail["startTime"] = startTime
                        }
                        if let endString = sleepDetail["end"], let endTime = SystemAuth.totalMinutes(from: endString) {
                            detail["endTime"] = endTime
                        }
                        details.append(detail)
                    }
                    
                    
                    var dic: [String: Any] = [:]
                    dic["totalTime"] = data.deep + data.light + soberTime + remTime
                    dic["restfulTime"] = data.deep
                    dic["lightTime"] = data.light
                    dic["soberTime"] = soberTime
                    dic["remTime"] = remTime
                    dic["details"] = details

                    var param: [String: Any] = [:]
                    param["type"] = 1
                    param["sleepInfo"] = dic
                    let str = SystemAuth.getJsonStringFromBasicTypeData(data: param)
                    self.sleepChangeEventStreamHandler.sleepChangeEventSink?(str)
                }
            }
            result(nil)
        case "queryRemSleep":
            self.isConnectedForConnectState {
                //同步rem睡眠
                //增加rem睡眠状态
                //TODO: - flutter监听接收
                CRPSmartBandSDK.sharedInstance.getSleepDataWithREM { data, error in
                    
                    var soberTime = 0
                    var remTime = 0
                    var details: [[String: Any]] = []
                    for sleepDetail in data.detail {
                        if Int(sleepDetail["type"] ?? "0") == 0 {
                            soberTime += Int(sleepDetail["total"] ?? "0") ?? 0
                        }
                        if Int(sleepDetail["type"] ?? "0") == 3 {
                            remTime += Int(sleepDetail["total"] ?? "0") ?? 0
                        }
                        
                        var detail = [String: Any]()
                        if let type = Int(sleepDetail["type"] ?? "0") {
                            detail["type"] = type
                        }
                        if let totalString = sleepDetail["total"], let totalTime = Int(totalString) {
                            detail["totalTime"] = totalTime
                        }
                        if let startString = sleepDetail["start"], let startTime = SystemAuth.totalMinutes(from: startString) {
                            detail["startTime"] = startTime
                        }
                        if let endString = sleepDetail["end"], let endTime = SystemAuth.totalMinutes(from: endString) {
                            detail["endTime"] = endTime
                        }
                        details.append(detail)
                    }

                    var dic: [String: Any] = [:]
                    dic["totalTime"] = data.deep + data.light + soberTime + remTime
                    dic["restfulTime"] = data.deep
                    dic["lightTime"] = data.light
                    dic["soberTime"] = soberTime
                    dic["remTime"] = remTime
                    dic["details"] = details

                    var param: [String: Any] = [:]
                    param["type"] = 1
                    param["sleepInfo"] = dic
                    let str = SystemAuth.getJsonStringFromBasicTypeData(data: param)
                    self.sleepChangeEventStreamHandler.sleepChangeEventSink?(str)
                }
            }
            result(nil)
        case "queryHistorySleep":
            self.isConnectedForConnectState {
                //同步过去的睡眠
                //会传<String, int>{"pastTimeType": pastTimeType}过来
                //TODO: - flutter监听接收
                let type: Int = receivedDic["historyTimeType"] as! Int
                CRPSmartBandSDK.sharedInstance.getAllData { stepModels, sleepModels, error in
                    //⼿环可保存前两天的计步数据和睡眠数据(allDataHandler中包含stepModels和sleepModels,数组的第⼀个为昨天数据，第⼆个为前天数据)
                    //TODO: flutter是通过监听接收的
                    if type == 1 {
                        //昨天的睡眠
                        let sleepModel0 = sleepModels[0]
                        var soberTime = 0
                        var remTime = 0
                        var details: [[String: Any]] = []
                        for sleepDetail in sleepModel0.detail {
                            if Int(sleepDetail["type"] ?? "0") == 0 {
                                soberTime += Int(sleepDetail["total"] ?? "0") ?? 0
                            }
                            if Int(sleepDetail["type"] ?? "0") == 3 {
                                remTime += Int(sleepDetail["total"] ?? "0") ?? 0
                            }
                            
                            var detail = [String: Any]()
                            if let type = Int(sleepDetail["type"] ?? "0") {
                                detail["type"] = type
                            }
                            if let totalString = sleepDetail["total"], let totalTime = Int(totalString) {
                                detail["totalTime"] = totalTime
                            }
                            if let startString = sleepDetail["start"], let startTime = SystemAuth.totalMinutes(from: startString) {
                                detail["startTime"] = startTime
                            }
                            if let endString = sleepDetail["end"], let endTime = SystemAuth.totalMinutes(from: endString) {
                                detail["endTime"] = endTime
                            }
                            details.append(detail)
                        }
                        
                        var dic: [String: Any] = [:]
                        dic["totalTime"] = sleepModel0.deep + sleepModel0.light + soberTime + remTime
                        dic["restfulTime"] = sleepModel0.deep
                        dic["lightTime"] = sleepModel0.light
                        dic["soberTime"] = soberTime
                        dic["remTime"] = remTime
                        dic["details"] = details
                        
                        var historySleep: [String: Any] = [:]
                        historySleep["timeType"] = 3
                        historySleep["sleepInfo"] = dic
                        
                        var param: [String: Any] = [:]
                        param["type"] = 2
                        param["historySleep"] = historySleep
                        let str = SystemAuth.getJsonStringFromBasicTypeData(data: param)
                        self.sleepChangeEventStreamHandler.sleepChangeEventSink?(str)
                    }
                    else if type == 2 {
                        //前天的睡眠
                        let sleepModel0 = sleepModels[1]
                        var soberTime = 0
                        var remTime = 0
                        var details: [[String: Any]] = []
                        for sleepDetail in sleepModel0.detail {
                            if Int(sleepDetail["type"] ?? "0") == 0 {
                                soberTime += Int(sleepDetail["total"] ?? "0") ?? 0
                            }
                            if Int(sleepDetail["type"] ?? "0") == 3 {
                                remTime += Int(sleepDetail["total"] ?? "0") ?? 0
                            }
                            
                            var detail = [String: Any]()
                            if let type = Int(sleepDetail["type"] ?? "0") {
                                detail["type"] = type
                            }
                            if let totalString = sleepDetail["total"], let totalTime = Int(totalString) {
                                detail["totalTime"] = totalTime
                            }
                            if let startString = sleepDetail["start"], let startTime = SystemAuth.totalMinutes(from: startString) {
                                detail["startTime"] = startTime
                            }
                            if let endString = sleepDetail["end"], let endTime = SystemAuth.totalMinutes(from: endString) {
                                detail["endTime"] = endTime
                            }
                            details.append(detail)
                        }
                        
                        var dic: [String: Any] = [:]
                        dic["totalTime"] = sleepModel0.deep + sleepModel0.light + soberTime + remTime
                        dic["restfulTime"] = sleepModel0.deep
                        dic["lightTime"] = sleepModel0.light
                        dic["soberTime"] = soberTime
                        dic["remTime"] = remTime
                        dic["details"] = details
                        
                        var historySleep: [String: Any] = [:]
                        historySleep["timeType"] = 4
                        historySleep["sleepInfo"] = dic
                        
                        var param: [String: Any] = [:]
                        param["type"] = 2
                        param["historySleep"] = historySleep
                        let str = SystemAuth.getJsonStringFromBasicTypeData(data: param)
                        self.sleepChangeEventStreamHandler.sleepChangeEventSink?(str)
                    }
                }
                
                //思澈用这个方法获取多天历史活动步数(day:0-6; 0为今天，1为昨天 ，以此类推)
                CRPSmartBandSDK.sharedInstance.getHistorySleepData(day: type) { day, sleepModel, error in
                    var soberTime = 0
                    var remTime = 0
                    var details: [[String: Any]] = []
                    for sleepDetail in sleepModel.detail {
                        if Int(sleepDetail["type"] ?? "0") == 0 {
                            soberTime += Int(sleepDetail["total"] ?? "0") ?? 0
                        }
                        if Int(sleepDetail["type"] ?? "0") == 3 {
                            remTime += Int(sleepDetail["total"] ?? "0") ?? 0
                        }
                        
                        var detail = [String: Any]()
                        if let type = Int(sleepDetail["type"] ?? "0") {
                            detail["type"] = type
                        }
                        if let totalString = sleepDetail["total"], let totalTime = Int(totalString) {
                            detail["totalTime"] = totalTime
                        }
                        if let startString = sleepDetail["start"], let startTime = SystemAuth.totalMinutes(from: startString) {
                            detail["startTime"] = startTime
                        }
                        if let endString = sleepDetail["end"], let endTime = SystemAuth.totalMinutes(from: endString) {
                            detail["endTime"] = endTime
                        }
                        details.append(detail)
                    }
                    
                    var dic: [String: Any] = [:]
                    dic["totalTime"] = sleepModel.deep + sleepModel.light + soberTime + remTime
                    dic["restfulTime"] = sleepModel.deep
                    dic["lightTime"] = sleepModel.light
                    dic["soberTime"] = soberTime
                    dic["remTime"] = remTime
                    dic["details"] = details
                    
                    var historySleep: [String: Any] = [:]
                    historySleep["timeType"] = type == 1 ? 3 : 4
                    historySleep["sleepInfo"] = dic
                    
                    var param: [String: Any] = [:]
                    param["type"] = 2
                    param["historySleep"] = historySleep
                    let str = SystemAuth.getJsonStringFromBasicTypeData(data: param)
                    self.sleepChangeEventStreamHandler.sleepChangeEventSink?(str)
                }
            }
            result(nil)
        case "sendGoalSleepTime":
            self.isConnectedForConnectState {
                let duration = receivedDic["goalTime"] as! Int
                CRPSmartBandSDK.sharedInstance.setSleepGoalTime(minutes: duration / 10)
            }
            result(nil)
        case "queryGoalSleepTime":
            self.isConnectedForConnectState {
                CRPSmartBandSDK.sharedInstance.getSleepGoalTime { value, error in
                    var param: [String: Any] = [:]
                    param["type"] = 3
                    param["goalSleepTime"] = value * 10
                    let str = SystemAuth.getJsonStringFromBasicTypeData(data: param)
                    self.sleepChangeEventStreamHandler.sleepChangeEventSink?(str)
                }
            }
            result(nil)
            
        //MARK: - HRV
        case "querySupportNewHrv":
            self.isConnectedForConnectState {
                CRPSmartBandSDK.sharedInstance.getHRVIsSupport { value, error in
                    result(value)
                }
            }
        case "startMeasureNewHrv":
            self.isConnectedForConnectState {
                CRPSmartBandSDK.sharedInstance.startHRVMeasure()
            }
            result(nil)
        case "stopMeasureNewHrv":
            self.isConnectedForConnectState {
                CRPSmartBandSDK.sharedInstance.stopHRVMeasure()
            }
            result(nil)
        case "queryHistoryNewHrv":
            self.isConnectedForConnectState {
                
//                CRPSmartBandSDK.sharedInstance.getHRVRecord { hrvRecordModels, error in
//                    var arr: [[String: Any]] = [[String: Any]]()
//                    for record in hrvRecordModels {
//                        var dic: [String: Any] = [:]
//                        dic["value"] = record.value
//                        dic["time"] = record.time
//                        arr.append(dic)
//                    }
//                    var param: [String: Any] = [:]
//                    param["historyTrainList"] = arr
//                    let str = SystemAuth.getJsonStringFromBasicTypeData(data: param)
//                    self.trainEventSink?(str)
//                }
            }
            result(nil)
        //MARK: - Stress
        case "querySupportStress":
            self.isConnectedForConnectState {
                CRPSmartBandSDK.sharedInstance.getStressIsSupport { value, error in
                    result(value)
                }
            }
            result(nil)
        case "startMeasureStress":
            self.isConnectedForConnectState {
                CRPSmartBandSDK.sharedInstance.setStartStress()
            }
            result(nil)
        case "stopMeasureStress":
            self.isConnectedForConnectState {
                CRPSmartBandSDK.sharedInstance.setStopStress()
            }
            result(nil)
        case "queryHistoryStress":
            self.isConnectedForConnectState {
                CRPSmartBandSDK.sharedInstance.getStressRecord { stressRecordModels, error in
                    var arr: [[String: Any]] = [[String: Any]]()
                    for record in stressRecordModels {
                        var dic: [String: Any] = [:]
                        dic["stress"] = record.value
                        dic["date"] = record.time
                        arr.append(dic)
                    }
                    var param: [String: Any] = [:]
                    param["list"] = arr
                    let str = SystemAuth.getJsonStringFromBasicTypeData(data: param)
                    self.stressEventStreamHandler.stressEventSink?(str)
                }
            }
            result(nil)
        case "enableTimingStress":
            self.isConnectedForConnectState {
                CRPSmartBandSDK.sharedInstance.setAutoStress(1)
            }
            result(nil)
        case "disableTimingStress":
            self.isConnectedForConnectState {
                CRPSmartBandSDK.sharedInstance.setAutoStress(0)
            }
            result(nil)
        case "queryTimingStressState":
            self.isConnectedForConnectState {
                CRPSmartBandSDK.sharedInstance.getAutoStressInterval { value, error in
                    var param: [String: Any] = [:]
                    param["type"] = 4
                    param["state"] = value
                    let str = SystemAuth.getJsonStringFromBasicTypeData(data: param)
                    self.stressEventStreamHandler.stressEventSink?(str)
                }
            }
            result(nil)
        case "queryTimingStress":
            self.isConnectedForConnectState {
                if let type = receivedDic["stressDate"] as? String {
                    switch type {
                    case "TODAY":
                        CRPSmartBandSDK.sharedInstance.getTodayAutoStressData { value, error in
                            var param: [String: Any] = [:]
                            param["type"] = 5
                            var stressinfo: [String: Any] = [:]
                            stressinfo["date"] = type
                            stressinfo["list"] = value
                            param["timingStressInfo"] = stressinfo
                            let str = SystemAuth.getJsonStringFromBasicTypeData(data: param)
                            self.stressEventStreamHandler.stressEventSink?(str)
                        }
                    case "YESTERDAY":
                        CRPSmartBandSDK.sharedInstance.getYesterDayAutoStressData { value, error in
                            var param: [String: Any] = [:]
                            param["type"] = 5
                            var stressinfo: [String: Any] = [:]
                            stressinfo["date"] = type
                            stressinfo["list"] = value
                            param["timingStressInfo"] = stressinfo
                            let str = SystemAuth.getJsonStringFromBasicTypeData(data: param)
                            self.stressEventStreamHandler.stressEventSink?(str)
                        }
                    default:
                        break
                    }
                }
            }
            result(nil)
        //MARK: - ecard
        case "queryElectronicCardCount":
            self.isConnectedForConnectState {
                
            }
            result(nil)
        case "sendElectronicCard":
            self.isConnectedForConnectState {
                let dic = SystemAuth.getDictionaryFromJSONString(jsonString: receivedDic["electronicCardInfo"] as! String)
//                dic["id"]
//                dic["title"]
//                dic["url"]
            }
            result(nil)
        case "deleteElectronicCard":
            self.isConnectedForConnectState {
                guard let ecardId = receivedDic["id"] as? Int else { return }
            }
            result(nil)
            //查询电⼦名⽚详情
        case "queryElectronicCard":
            self.isConnectedForConnectState {
                guard let ecardId = receivedDic["id"] as? Int else { return }
            }
            result(nil)
            //通过 idList 对电⼦名⽚重新排序
        case "sendElectronicCardList":
            self.isConnectedForConnectState {
                guard let idList = receivedDic["idList"] as? [Int] else { return }
            }
            result(nil)
        //MARK: - calendar
        case "querySupportCalendarEvent":
            self.isConnectedForConnectState {
                
            }
            result(nil)
        case "sendCalendarEvent":
            self.isConnectedForConnectState {
                let dic = SystemAuth.getDictionaryFromJSONString(jsonString: receivedDic["calenderEventInfo"] as! String)
                //"id":1,"title":"生日","startHour":2,"startMinute":30,"endHour":4,"endMinute":30,"time":40
            }
            result(nil)
        case "deleteCalendarEvent":
            self.isConnectedForConnectState {
                guard let calendarId = receivedDic["id"] as? [Int] else { return }
            }
            result(nil)
        case "queryCalendarEvent":
            self.isConnectedForConnectState {
                guard let calendarId = receivedDic["id"] as? [Int] else { return }
            }
            result(nil)
        case "sendCalendarEventReminderTime":
            self.isConnectedForConnectState {
                let dic = SystemAuth.getDictionaryFromJSONString(jsonString: receivedDic["calendarEventReminderTime"] as! String)
                //"enable":true,"minutes":30
            }
            result(nil)
        case "queryCalendarEventReminderTime":
            self.isConnectedForConnectState {
                
            }
            result(nil)
        case "clearCalendarEvent":
            self.isConnectedForConnectState {
                
            }
            result(nil)
        default:
            result(nil)
            break
        }
    }
    
    //MARK: - CRPSmartBand Delegate
    
    /// 返回当前的⼿环的连接状态
    public func didState(_ state: CRPState) {
        self.deviceState = state
//        print("连接状态：\(state.rawValue)")
        if state == .connected {
            self.notificationSupportTypeArray.removeAll()
            UserDefaults.standard.removeObject(forKey: "notificationSupportTypeArray")
            CRPSmartBandSDK.sharedInstance.getNotificationSupportType { value, error in
                self.notificationSupportTypeArray = value
                UserDefaults.standard.set(self.notificationSupportTypeArray, forKey: "notificationSupportTypeArray")
            }
            CRPSmartBandSDK.sharedInstance.getSoftver {(softver, error) in
                self.deviceCurrentVersion = softver
            }
            
            self.isSupportDelayCamera = false
            CRPSmartBandSDK.sharedInstance.getDelayTaking { value, error in
                self.isSupportDelayCamera = true
            }
        }
        if state == .disconnected {
            self.notificationSupportTypeArray.removeAll()
            UserDefaults.standard.removeObject(forKey: "notificationSupportTypeArray")
            self.historyDynamicRateType = ""
            self.currentHistoryDynamicRateIndex = 0
            if self.autoConnect == true {
                CRPSmartBandSDK.sharedInstance.reConnet()
            }
        }
        
        var param: [String: Any] = [:]
        param["autoConnect"] = self.autoConnect
        param["connectState"] = state.rawValue
        let str = SystemAuth.getJsonStringFromBasicTypeData(data: param)
//        print("步数变化\(param)")
        self.connectionStateEventStreamHandler.connectionStateEventSink?(str)
    }
    
    /// 返回当前蓝⽛状态
    public func didBluetoothState(_ state: CRPBluetoothState) {
        self.bluetoothState = state
        if state == .poweredOn {
            if self.autoConnect == true {
                CRPSmartBandSDK.sharedInstance.reConnet()
            }
        }
    }
    
    /// 接收实时的运动计步数据
    public func receiveSteps(_ model: StepModel) {
        var dic: [String: Any] = [:]
        dic["calories"] = model.calory
        dic["distance"] = model.distance
        dic["steps"] = model.steps
        dic["time"] = model.time
        
        var param: [String: Any] = [:]
        param["type"] = 1
        param["stepsInfo"] = dic
        let str = SystemAuth.getJsonStringFromBasicTypeData(data: param)
//        print("步数变化\(param)")
        self.stepChangeEventStreamHandler.stepChangeEventSink?(str)
    }
    
    /// 接收⼼率测量结果(单次测量⼼率)
    public func receiveHeartRate(_ heartRate: Int) {
        var param: [String: Any] = [:]
        param["type"] = 2
        param["onceMeasureComplete"] = heartRate
        let str = SystemAuth.getJsonStringFromBasicTypeData(data: param)
        self.heartRateEventStreamHandler.heartRateEventSink?(str)
    }
    
    /// 接收实时⼼率数据(⼀般只⽤于显示不⽤于存储，部分⼿环⽀持返回实时RRI数据)
    public func receiveRealTimeHeartRate(_ heartRate: Int, _ rri: Int) {
        var param: [String: Any] = [:]
        param["type"] = 1
        param["measuring"] = heartRate
        let str = SystemAuth.getJsonStringFromBasicTypeData(data: param)
        self.heartRateEventStreamHandler.heartRateEventSink?(str)
    }
    
    /// 查询上次动态⼼率测量结果
    public func receiveHeartRateAll(_ model: HeartModel) {

        if model.detail.count != 1440 {
            //这里针对的是部分手表在手表运动结束的时候会自动返回一段运动心率，返回后手表就会移除这条数据
            let infoDict: [String: Any] = [
                "startTime": model.starttime,
                "heartRateList": model.detail,
                "timeInterval": 1,
                "isAllDay": 0,
                "heartRateType": ""
            ]

            let hrDict: [String: Any] = [
                "historyDynamicRateType": "FIRST_HEART_RATE",
                "heartRate": infoDict
            ]

            var param: [String: Any] = [:]
            param["type"] = 4
            param["measureComplete"] = hrDict
            
            let str = SystemAuth.getJsonStringFromBasicTypeData(data: param)
            self.heartRateEventStreamHandler.heartRateEventSink?(str)
        } else {
            self.currentHistoryDynamicRateIndex += 1
            
            // timeInterval 固定为1， isAllDay固定为0， historyDay Android端也没有收到，暂不处理
            if ((self.historyDynamicRateType == "FIRST_HEART_RATE" && self.currentHistoryDynamicRateIndex == 1) ||
                (self.historyDynamicRateType == "SECOND_HEART_RATE" && self.currentHistoryDynamicRateIndex == 2) ||
                (self.historyDynamicRateType == "THIRD_HEART_RATE" && self.currentHistoryDynamicRateIndex == 3)) {
                let infoDict: [String: Any] = [
                    "startTime": model.starttime,
                    "heartRateList": model.detail,
                    "timeInterval": 1,
                    "isAllDay": 0,
                    "heartRateType": ""
                ]

                let hrDict: [String: Any] = [
                    "historyDynamicRateType": self.historyDynamicRateType,
                    "heartRate": infoDict
                ]

                var param: [String: Any] = [:]
                param["type"] = 4
                param["measureComplete"] = hrDict
                
                let str = SystemAuth.getJsonStringFromBasicTypeData(data: param)
                self.heartRateEventStreamHandler.heartRateEventSink?(str)
            }
        }
        
        
        
        
//        CRPSmartBandSDK.sharedInstance.getSportData({ models, error in
//
//            var list: [[String: Any]] = [[String: Any]]()
//            for model in models {
//                var dic: [String: Any] = [:]
//                dic["type"] = model.type.rawValue
//                dic["startTime"] = model.startTime
//                dic["endTime"] = model.endTime
//                dic["validTime"] = model.vaildTime
//                dic["steps"] = model.step
//                dic["distance"] = model.distance
//                dic["calories"] = model.kcal
//                list.append(dic)
//            }
//
//            var param: [String: Any] = [:]
//            param["type"] = 6
//            param["trainingList"] = list
//            let str = SystemAuth.getJsonStringFromBasicTypeData(data: param)
//            self.heartRateEventStreamHandler.heartRateEventSink?(str)
//        })
        
        
    }
    
    /// 接收⾎压测量结果
    public func receiveBloodPressure(_ heartRate: Int, _ sbp: Int, _ dbp: Int) {
        
        var dic: [String: Any] = [:]
        dic["sbp"] = sbp
        dic["dbp"] = dbp
        
        var param: [String: Any] = [:]
        param["type"] = 2
        param["pressureChange"] = dic
        let str = SystemAuth.getJsonStringFromBasicTypeData(data: param)
        self.bloodPressureEventStreamHandler.bloodPressureEventSink?(str)
    }
    
    /// 接收⾎氧测量结果
    public func receiveSpO2(_ o2: Int) {
        var param: [String: Any] = [:]
        param["type"] = 3
        param["bloodOxygen"] = o2
        let str = SystemAuth.getJsonStringFromBasicTypeData(data: param)
        self.bloodOxygenEventStreamHandler.bloodOxygenEventSink?(str)
    }
    
    public func receiveUpgrede(_ state: CRPUpgradeState, _ progress: Int) {
        var resultModel = OTAResultModel()
        resultModel.upgradeProgress = progress
        switch state.rawValue {
        case 0:
            resultModel.type = 3
        case 1:
            resultModel.type = 4
        case 2:
            resultModel.type = 7
            resultModel.upgradeError.error = 21
            resultModel.upgradeError.errorContent = "Already the latest firmware version!"
        default:
            resultModel.type = -1
            break
        }
        let param = resultModel.toJSON()
        let resultString = SystemAuth.getJsonStringFromBasicTypeData(data: param as Any)
        self.firmwareUpgradeEventStreamHandler.firmwareUpgradeEventSink?(resultString)
    }
    
    
    
    /// 升级表盘文件/图片时的回调
    public func receiveUpgradeScreen(_ state: CRPUpgradeState, _ progress: Int) {
        var param: [String: Any] = [:]
        param["type"] = state.rawValue + 2
        param["progress"] = progress
        let str = SystemAuth.getJsonStringFromBasicTypeData(data: param)
//        print("ios端上传表盘的状态是：\(state.rawValue)--- 进度是：\(progress)")
        self.wfFileTransEventStreamHandler.wfFileTransEventSink?(str)
    }
    /// 收到拍照请求
    public func recevieTakePhoto() {
        self.isConnectedForConnectState {
            
            if self.isSupportDelayCamera {
                CRPSmartBandSDK.sharedInstance.getDelayTaking { value, error in
                    var param: [String: Any] = [:]
                    param["takePhoto"] = "takePhoto"
                    param["delayTime"] = value
                    let str = SystemAuth.getJsonStringFromBasicTypeData(data: param)
                    self.cameraEventStreamHandler.cameraEventSink?(str)
                }
            } else {
                var param: [String: Any] = [:]
                param["takePhoto"] = "takePhoto"
                param["delayTime"] = 0
                let str = SystemAuth.getJsonStringFromBasicTypeData(data: param) 
                self.cameraEventStreamHandler.cameraEventSink?(str)
            }
        }
    }
    
    /// 收到天⽓获取请求
    /// - Parameter closure:
    public func recevieWeather() {

    }

    /// 收到查找⼿机请求
    /// - Parameter closure: state
    public func recevieFindPhone(_ state: Int) {
        var param: [String: Any] = [:]
        param["type"] = state
        let str = SystemAuth.getJsonStringFromBasicTypeData(data: param)
        self.findPhoneEventStreamHandler.findPhoneEventSink?(str)
    }

    /// 收到实时的体温数值(
    /// - Parameter ⼿环收到实时体温数值后，保留最后⼀次收到的值，当收到测量结束状态时，最后的值就是测量结果
    public func receiveRealTimeTemperature(_ temp: Double) {
        var param: [String: Any] = [:]
        param["type"] = 2
        param["temp"] = temp
        let str = SystemAuth.getJsonStringFromBasicTypeData(data: param)
        self.temperatureChangeEventStreamHandler.temperatureChangeEventSink?(str)
    }

    /// 收到体温测量状态
    /// - Parameter closure: ⽤于判断单次体温测量的状态 收到state为1时为正在测量，收到state为0时为测量结束
    public func receiveTemperature(_ state: Int) {
        var param: [String: Any] = [:]
        param["type"] = 3
        param["state"] = (Bool(truncating: state as NSNumber))
        let str = SystemAuth.getJsonStringFromBasicTypeData(data: param)
        self.temperatureChangeEventStreamHandler.temperatureChangeEventSink?(str)
    }

    /// 收到⼀键呼叫请求
    public func receiveCalling() {
        
    }

    /// 收到HRV实时数据
    /// - Parameter model: CRPHRVDataModel
    public func receviceHRVRealTime(_ model: CRPHRVDataModel) {
        
    }
    
    public func receiveHRV(_ hrv: Int) {
        var param: [String: Any] = [:]
        param["type"] = 2
        param["value"] = hrv
        let str = SystemAuth.getJsonStringFromBasicTypeData(data: param)
        self.newHrvEventStreamHandler.newHrvEventSink?(str)
    }

    /// 收到当前来电号码
    /// - Parameter number: String
    public func receivePhoneNumber(number: String) {
        self.callNumberEventStreamHandler.callNumberEventSink?(number)
    }

    /// 收到吃药提醒数据
    /// - Parameter closure: _ max: Int,_ model: CRPMedicineReminderModel
    public func receiveMedicineInfo(_ max: Int, _ model: CRPMedicineReminderModel?) {
        if self.receiveMedicineInfoClosure != nil {
            self.receiveMedicineInfoClosure(max, model)
        }
    }

    /// 收到运动模式状态
    /// - Parameter state: SportType
    public func receiveSportState(_ state: SportType) {
        self.trainingStateEventStreamHandler.trainingStateEventSink?(state.rawValue)
    }



    public func receiveECGDate(_ state: ecgState, _ data: [UInt32], completeTime: Int) {
        var param: [String: Any] = [:]
        param["type"] = state.rawValue
        param["ints"] = data
        param["date"] = completeTime
        let str = SystemAuth.getJsonStringFromBasicTypeData(data: param)
        self.ecgEventStreamHandler.ecgEventSink?(str)
    }
    
    public func receiveSportList(_ list: [CRPSportRecord]) {
        var arr: [[String: Any]] = [[String: Any]]()
        for record in list {
            if record.startTime > 1000000000 {
                var dic: [String: Any] = [:]
                dic["type"] = record.type
                dic["startTime"] = record.startTime
                dic["id"] = record.id
                arr.append(dic)
            }
        }
        var param: [String: Any] = [:]
        param["type"] = 1 //1:historyTrainingChange, 2: trainingChange
        param["historyTrainList"] = arr
        let str = SystemAuth.getJsonStringFromBasicTypeData(data: param)
        self.trainingEventStreamHandler.trainingEventSink?(str)
        
        var recordModelArray: [TrainingInfoModel] = []
        var currentIndex = 0
        list.enumerated().forEach { index, record in
            if record.startTime != 0 {
                self.getSportRecordData(id: index) { model in
                    recordModelArray.append(model)
                    currentIndex = index
                    if currentIndex == list.count - 1 {
                        let trainBeanModel = TrainBeanModel(trainingList: recordModelArray, type: 2)
                        let trainBeanParam = trainBeanModel.toJSON()
                        let resultString = SystemAuth.getJsonStringFromBasicTypeData(data: trainBeanParam as Any)
                        self.trainingEventStreamHandler.trainingEventSink?(resultString)
                    }
                }
            }
        }
        

    }
    
    public func receiveStress(_ stress: Int) {
        var param: [String: Any] = [:]
        param["type"] = 2
        param["value"] = stress
        let str = SystemAuth.getJsonStringFromBasicTypeData(data: param)
        self.stressEventStreamHandler.stressEventSink?(str)
    }
    
    /// 收到吃药提醒数据
    /// - Parameter closure: _ max: Int,_ model: CRPMedicineReminderModel
    public func returnReceiveMedicineInfoClosure(closure : @escaping ((_ max: Int,_ model: CRPMedicineReminderModel?) -> Void)) {
        self.receiveMedicineInfoClosure = closure
    }
    
    
}

extension MYScanPlugin {
    func getMorningDateStamp(intervalDay: Int = 0) -> Int{
//        let currentDate = Date()
//        let morningDate = currentDate.beginning(of: .day)
//        print("\(Int(morningDate?.timeIntervalSince1970 ?? 0))")
//        return Int(morningDate?.timeIntervalSince1970 ?? 0)
        let calendar = Calendar.current
        let now = Date()
        let yesterday = calendar.date(byAdding: .day, value: -intervalDay, to: now)!
        let components = calendar.dateComponents([.year, .month, .day], from: yesterday)
        let yesterdayAtMidnight = calendar.date(from: components)!
        let yesterdayAtMidnightTimestamp = yesterdayAtMidnight.timeIntervalSince1970
        return Int(yesterdayAtMidnightTimestamp)
    }
    
    
    
    func decimalToReversedBinaryStringWithOnesIndexes(decimal: Int) -> (String, [Int]) {
        let binaryString = String(decimal, radix: 2)
        let reversedBinaryString = String(binaryString.reversed())
        let onesIndexes = reversedBinaryString.enumerated().compactMap { (index, character) -> Int? in
            if character == "1" {
                return index
            } else {
                return nil
            }
        }
        return (reversedBinaryString, onesIndexes)
    }
    
    func returnAlarmWeeks(repeatMode: Int) -> [Int] {
        let (_, onesIndexes) = self.decimalToReversedBinaryStringWithOnesIndexes(decimal: repeatMode)
        var weeks = [Int]()
        if onesIndexes.contains(0) {
            weeks.append(7)
        }
        if onesIndexes.contains(1) {
            weeks.append(1)
        }
        if onesIndexes.contains(2) {
            weeks.append(2)
        }
        if onesIndexes.contains(3) {
            weeks.append(3)
        }
        if onesIndexes.contains(4) {
            weeks.append(4)
        }
        if onesIndexes.contains(5) {
            weeks.append(5)
        }
        if onesIndexes.contains(6) {
            weeks.append(6)
        }
        return weeks
    }
    
    func returnRepeatMode(withWeeks weeks: [Int]) -> Int {
        let onesIndexes = self.returnBinaryIndexs(withWeeks: weeks)
        let repeatMode = self.binaryArrayToDecimal(onesIndexes)
        return repeatMode
    }
    
    func returnBinaryIndexs (withWeeks weeks: [Int]) -> [Int] {
        var onesIndexes = [Int]()
        if weeks.contains(7) {
            onesIndexes.append(0)
        }
        if weeks.contains(1) {
            onesIndexes.append(1)
        }
        if weeks.contains(2) {
            onesIndexes.append(2)
        }
        if weeks.contains(3) {
            onesIndexes.append(3)
        }
        if weeks.contains(4) {
            onesIndexes.append(4)
        }
        if weeks.contains(5) {
            onesIndexes.append(5)
        }
        if weeks.contains(6) {
            onesIndexes.append(6)
        }
        return onesIndexes
    }
    
    func binaryArrayToDecimal(_ array: [Int]) -> Int {
        let decimalArray = array.map { (bitPosition) -> Int in
            return 1 << bitPosition
        }
        let decimalValue = decimalArray.reduce(0, +)
        return decimalValue
    }
    
    
}

extension MYScanPlugin {
    
    func cropImage(image: UIImage, targetSize: CGSize, cornerRadius: CGFloat) -> UIImage? {
        // 调整图片尺寸
        let imageSize = image.size
        let widthRatio = targetSize.width / imageSize.width
        let heightRatio = targetSize.height / imageSize.height
        let scaleFactor = max(widthRatio, heightRatio)
        let scaledSize = CGSize(width: imageSize.width * scaleFactor, height: imageSize.height * scaleFactor)
        let scaledImage = resizeImage(image: image, newSize: scaledSize)
        
        // 裁剪图片
        let croppedRect = CGRect(x: (scaledImage.size.width - targetSize.width) / 2,
                                 y: (scaledImage.size.height - targetSize.height) / 2,
                                 width: targetSize.width,
                                 height: targetSize.height)
        let croppedImage = cropToBounds(image: scaledImage, bounds: croppedRect)
        
        // 添加圆角
        let roundedImage = addRoundedCorners(image: croppedImage, cornerRadius: cornerRadius)
        
        return roundedImage
    }

    // 调整图片尺寸
    func resizeImage(image: UIImage, newSize: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }

    // 裁剪图片
    func cropToBounds(image: UIImage, bounds: CGRect) -> UIImage {
        guard let cgImage = image.cgImage?.cropping(to: bounds) else {
            return image
        }
        return UIImage(cgImage: cgImage)
    }

    // 添加圆角
    func addRoundedCorners(image: UIImage, cornerRadius: CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(image.size, false, 0.0)
        let bounds = CGRect(origin: .zero, size: image.size)
        UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).addClip()
        image.draw(in: bounds)
        let roundedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return roundedImage!
    }
}

extension MYScanPlugin {
    
    private func queryNewVersion(success: @escaping () -> (), failed: @escaping () -> ()) {
        self.isConnectedForConnectState {
            CRPSmartBandSDK.sharedInstance.getSoftver {(softver, error) in
                self.deviceCurrentVersion = softver
                
                CRPSmartBandSDK.sharedInstance.checkLatest(self.deviceCurrentVersion, self.myDiscovery.mac ?? "") { newVerInfo, newVerTpInfo, error in
                    
                    if newVerInfo == nil {
                        self.returnOTAlatest()
                        failed()
                        return
                    }
                    
//                    self.deviceNewVersionInfo = newVerInfo!
//                    if newVerInfo?.mcu == 4 || newVerInfo?.mcu == 8 {
//                        self.hardWareType = .Huntersun
//                    }
//                    else if newVerInfo?.mcu == 7 {
//                        self.hardWareType = .Realtek
//                    }
//                    else if newVerInfo?.mcu == 10 {
//                        self.hardWareType = .Goodix
//                    }
//                    else if newVerInfo?.mcu == 86 || newVerInfo?.mcu == 87 {
//                        self.hardWareType = .Sifli
//                    }
//                    else if newVerInfo?.mcu == 323 {
//                        self.hardWareType = .JieLi
//                    }
//                    else {
//                        self.hardWareType = .Nordic
//                    }
                    
                    if self.deviceNewVersionInfo.version?.isEmpty == true || self.deviceCurrentVersion == self.deviceNewVersionInfo.version {
                        self.returnOTAlatest()
                        failed()
                        return
                    } else {
                        success()
                        return
                    }
                }
            }
        }
    }
    
    private func returnOTAlatest() {
        var resultModel = OTAResultModel()
        resultModel.type = 7
        resultModel.upgradeError.error = 21
        resultModel.upgradeError.errorContent = "Already the latest firmware version!"
        
        let param = resultModel.toJSON()
        let resultString = SystemAuth.getJsonStringFromBasicTypeData(data: param as Any)
        self.firmwareUpgradeEventStreamHandler.firmwareUpgradeEventSink?(resultString)
    }
    
    private func getSportRecordData(id: Int, success: @escaping (TrainingInfoModel) -> ()) {
        CRPSmartBandSDK.sharedInstance.getSportRecordData(id: id) { sportModel, error in
            if sportModel.startTime > 1000000000 {
                var model = TrainingInfoModel()
                model.type = sportModel.type.rawValue
                model.startTime = sportModel.startTime
                model.endTime = sportModel.endTime
                model.validTime = sportModel.vaildTime
                model.steps = sportModel.step
                model.calories = sportModel.kcal
                model.distance = sportModel.distance
                model.hrList = sportModel.heartRate
                
                success(model)
            }
        }
    }

}
