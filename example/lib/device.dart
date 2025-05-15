import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:moyoung_ble_plugin/moyoung_ble.dart';
import 'package:moyoung_ble_plugin_example/modules/GSensor.dart';
import 'package:moyoung_ble_plugin_example/modules/protoclVersion.dart';
import 'package:moyoung_ble_plugin_example/modules/quickView.dart';
import 'package:moyoung_ble_plugin_example/modules/sedentaryReminder.dart';
import 'package:moyoung_ble_plugin_example/modules/setsLocalCity.dart';
import 'package:moyoung_ble_plugin_example/modules/shutDown.dart';
import 'package:moyoung_ble_plugin_example/modules/sleep.dart';
import 'package:moyoung_ble_plugin_example/modules/sos.dart';
import 'package:moyoung_ble_plugin_example/modules/steps.dart';
import 'package:moyoung_ble_plugin_example/modules/stress.dart';
import 'package:moyoung_ble_plugin_example/modules/takePhoto.dart';
import 'package:moyoung_ble_plugin_example/modules/temperatureSystem.dart';
import 'package:moyoung_ble_plugin_example/modules/time.dart';
import 'package:moyoung_ble_plugin_example/modules/unitsystem.dart';
import 'package:moyoung_ble_plugin_example/modules/userInfo.dart';
import 'package:moyoung_ble_plugin_example/modules/vibrationStrength.dart';
import 'package:moyoung_ble_plugin_example/modules/watchFace.dart';
import 'package:moyoung_ble_plugin_example/modules/weather.dart';
import 'package:moyoung_ble_plugin_example/modules/BloodOxygen.dart';
import 'package:moyoung_ble_plugin_example/modules/ClassicBluetoothAddress.dart';
import 'package:moyoung_ble_plugin_example/modules/ECG.dart';
import 'package:moyoung_ble_plugin_example/modules/FindWatch.dart';
import 'package:moyoung_ble_plugin_example/modules/Language.dart';
import 'package:moyoung_ble_plugin_example/modules/MusicPlayer.dart';
import 'package:moyoung_ble_plugin_example/modules/PillReminder.dart';
import 'package:moyoung_ble_plugin_example/modules/RSSI.dart';
import 'package:moyoung_ble_plugin_example/modules/TapWake.dart';
import 'package:moyoung_ble_plugin_example/modules/Training.dart';
import 'package:moyoung_ble_plugin_example/modules/alarm.dart';
import 'package:moyoung_ble_plugin_example/modules/battery.dart';
import 'package:moyoung_ble_plugin_example/modules/batterySaving.dart';
import 'package:moyoung_ble_plugin_example/modules/bloodPressure.dart';
import 'package:moyoung_ble_plugin_example/modules/bodyTemperature.dart';
import 'package:moyoung_ble_plugin_example/modules/breathingLight.dart';
import 'package:moyoung_ble_plugin_example/modules/brightness.dart';
import 'package:moyoung_ble_plugin_example/modules/contacts.dart';
import 'package:moyoung_ble_plugin_example/modules/displayTime.dart';
import 'package:moyoung_ble_plugin_example/modules/drinkWaterReminder.dart';
import 'package:moyoung_ble_plugin_example/modules/findPhone.dart';
import 'package:moyoung_ble_plugin_example/modules/firmware.dart';
import 'package:moyoung_ble_plugin_example/modules/goalSteps.dart';
import 'package:moyoung_ble_plugin_example/modules/handWashingReminder.dart';
import 'package:moyoung_ble_plugin_example/modules/heartRate.dart';
import 'package:moyoung_ble_plugin_example/modules/heartRateAlarm.dart';
import 'package:moyoung_ble_plugin_example/modules/menstrualCycle.dart';
import 'package:moyoung_ble_plugin_example/modules/notDisturb.dart';
import 'package:moyoung_ble_plugin_example/modules/notification.dart';

import 'Global.dart';
import 'components/base/CustomGestureDetector.dart';
import 'modules/GPS.dart';
import 'modules/HRV.dart';
import 'modules/calendarEvent.dart';

import 'modules/demo.dart';
import 'modules/electronicCard.dart';
import 'modules/pairing.dart';

class DevicePage extends StatefulWidget {
  final BleScanBean device;

  const DevicePage({
    Key? key,
    required this.device,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _DevicePage();
  }
}

class _DevicePage extends State<DevicePage> {
  late BleScanBean device = widget.device;

  final _streamSubscriptions = <StreamSubscription<dynamic>>[];
  final MoYoungBle _blePlugin = Global.blePlugin;

  int _connetionState = -1;
  bool _autoConnect = false;
  bool _isConn = false;
  bool _reconnect = true;

  String oTAType = "";
  List<BluetoothDevice> list = [];
  String btAddress = "";

  CrossFadeState displayState1 = CrossFadeState.showSecond;
  CrossFadeState displayState2 = CrossFadeState.showSecond;
  CrossFadeState displayState3 = CrossFadeState.showSecond;

  @override
  void initState() {
    super.initState();
    subscriptStream();
  }

  void subscriptStream() {
    _streamSubscriptions.add(
      _blePlugin.connStateEveStm.listen(
        (ConnectStateBean event) {
          setState(() {
            setState(() {
              _connetionState = event.connectState;
              _autoConnect = event.autoConnect;
              if (_connetionState == 2) {
                _isConn = true;
              } else {
                _isConn = false;
              }

              if (event.connectState == 2) {
                addStepsListen();
              } else if (event.connectState == 0) {
                // delayConnect();
              }
            });
          });
        },
      ),
    );
  }

  void delayConnect() {
    if (_reconnect) {
      Timer(const Duration(seconds: 3), () => _blePlugin.connect(ConnectBean(autoConnect: false, address: device.address)));
    }
  }

  void addStepsListen() {
    _streamSubscriptions.add(
      _blePlugin.stepsChangeEveStm.listen(
        (StepsChangeBean event) {
          setState(() {
            // print("stepEvent: $event");
            // _stepsChange = event.stepsInfo.steps;
          });
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    for (final subscription in _streamSubscriptions) {
      subscription.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    List<BluetoothDevice> _list;
    return WillPopScope(
        onWillPop: () async {
          if (_connetionState == 2) await _blePlugin.disconnect;
          return true;
        },
        child: MaterialApp(
          home: Scaffold(
            appBar: AppBar(
              title: Text(device.address),
              automaticallyImplyLeading: false, // 禁用默认的返回按钮
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () async {
                  await _blePlugin.disconnect;
                  Navigator.pop(context); // 手动处理返回逻辑
                },
              ),
            ),
            body: Center(
                child: ListView(children: <Widget>[
              Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('device: ${device.name}', style: const TextStyle(height: 1.5, fontSize: 14, color: Colors.deepOrange)),
                      Text('address: ${device.address}', style: const TextStyle(height: 1.5, fontSize: 14, color: Colors.grey)),
                      Text('platform: ${device.platform}', style: const TextStyle(height: 1.5, fontSize: 14, color: Colors.grey)),
                      Text('isConn: $_isConn', style: const TextStyle(height: 1.5, fontSize: 14, color: Colors.grey)),
                      Text('connectionState: $_connetionState', style: const TextStyle(height: 1.5, fontSize: 14, color: Colors.deepOrange)),
                      Text('autoConnect: $_autoConnect', style: const TextStyle(height: 1.5, fontSize: 14, color: Colors.grey)),
                      Text('Pairing list: ${list.map((e) => e.name)}', style: const TextStyle(height: 1.5, fontSize: 14, color: Colors.grey)),
                    ],
                  )),
              CustomGestureDetector(
                  title: 'Connect',
                  childrenBCallBack: (CrossFadeState newDisplayState) {
                    setState(() {
                      displayState1 = newDisplayState;
                    });
                  },
                  displayState: displayState1,
                  children: <Widget>[
                    ElevatedButton(
                        child: const Text('isConnected()', style: TextStyle(fontSize: 14)),
                        onPressed: () async {
                          bool isConn = await _blePlugin.isConnected(device.address);
                          // bool isConn = await _blePlugin.isConnected("D3:C3:1D:46:73:7A");
                          setState(() {
                            _isConn = isConn;
                          });
                        }),
                    ElevatedButton(
                        child: const Text("connect(false)", style: TextStyle(fontSize: 14, color: Colors.deepOrangeAccent)),
                        onPressed: () {
                          _blePlugin.connect(ConnectBean(autoConnect: false, address: device.address));
                          _reconnect = true;
                          // print(device.address);
                          // _blePlugin.connect("EC:28:65:94:61:1D");
                          // _blePlugin.connect("D3:C3:1D:46:73:7A");
                        }),
                    ElevatedButton(
                        child: const Text("connect(true)", style: TextStyle(fontSize: 14)),
                        onPressed: () {
                          _blePlugin.connect(ConnectBean(autoConnect: true, address: device.address));
                          _reconnect = true;
                          // print(device.address);
                          // _blePlugin.connect("EC:28:65:94:61:1D");
                          // _blePlugin.connect("D3:C3:1D:46:73:7A");
                        }),
                    ElevatedButton(
                        child: const Text('disconnect()', style: TextStyle(fontSize: 14)),
                        onPressed: () async {
                          _reconnect = false;
                          bool connetionState = await _blePlugin.disconnect;
                          setState(() {
                            if (connetionState) {
                              _connetionState = 0;
                            }
                          });
                        }),
                    // ElevatedButton(
                    //     child: const Text('closeGatt()', style: TextStyle(fontSize: 14)),
                    //     onPressed: () async {
                    //       bool connetionState = await _blePlugin.closeGatt;
                    //       setState(() {
                    //         if (connetionState) {
                    //           _connetionState = 0;
                    //         }
                    //       });
                    //     }),
                    ElevatedButton(
                        child: const Text('reconnect()', style: TextStyle(fontSize: 14)),
                        onPressed: () {
                          _blePlugin.reconnect;
                        }),
                    ElevatedButton(
                        child: const Text('connectDevice(false)', style: TextStyle(fontSize: 14)),
                        onPressed: () {
                          _blePlugin.connectDevice(ConnectDeviceBean(address: device.address, peripheral: "edsd", autoConnect: false));
                        }),
                  ]),
              CustomGestureDetector(
                  title: 'Pair',
                  childrenBCallBack: (CrossFadeState newDisplayState) {
                    setState(() {
                      displayState2 = newDisplayState;
                    });
                  },
                  displayState: displayState2,
                  children: <Widget>[
                    Text('btAddress: $btAddress', style: const TextStyle(height: 1.5, fontSize: 14, color: Colors.grey)),
                    ElevatedButton(
                        child: const Text('queryBtAddress', style: TextStyle(fontSize: 14)),
                        onPressed: () async => {
                              btAddress = await _blePlugin.queryBtAddress,
                              setState(() {
                                btAddress = btAddress;
                              })
                            }),
                    ElevatedButton(
                        child: const Text('Bluetooth pairing', style: TextStyle(fontSize: 14)),
                        onPressed: () async => {
                              await FlutterBluetoothSerial.instance.bondDeviceAtAddress(btAddress),
                            }),
                    ElevatedButton(
                        child: const Text('Get the Bluetooth pairing list', style: TextStyle(fontSize: 14)),
                        onPressed: () async => {
                              _list = await FlutterBluetoothSerial.instance.getBondedDevices(),
                              setState(() {
                                list = _list;
                              })
                            }),
                    ElevatedButton(
                        child: const Text('Unpairing Bluetooth', style: TextStyle(fontSize: 14)),
                        onPressed: () async => {await FlutterBluetoothSerial.instance.removeDeviceBondWithAddress(device.address)}),
                  ]),
              CustomGestureDetector(
                title: 'Functions Module',
                childrenBCallBack: (CrossFadeState newDisplayState) {
                  setState(() {
                    displayState3 = newDisplayState;
                  });
                },
                displayState: displayState3,
                children: <Widget>[
                  const Text("Note: First please click the button of connect, or don't click functions module",
                      style: TextStyle(height: 1.5, fontSize: 14, color: Colors.deepOrange)),
                  ElevatedButton(
                      onPressed: () {
                        if (_isConn) {
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return TimePage(
                              blePlugin: _blePlugin,
                            );
                          }));
                        }
                      },
                      child: const Text("4-Time")),
                  ElevatedButton(
                      onPressed: () {
                        if (_isConn) {
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return FirmwarePage(
                              blePlugin: _blePlugin,
                              device: device,
                            );
                          }));
                        }
                      },
                      child: const Text("5-Firmware")),
                  ElevatedButton(
                      onPressed: () {
                        if (_isConn) {
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return BatteryPage(
                              blePlugin: _blePlugin,
                            );
                          }));
                        }
                      },
                      child: const Text("6-Battery")),
                  ElevatedButton(
                      onPressed: () {
                        if (_isConn) {
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return UserInfoPage(
                              blePlugin: _blePlugin,
                            );
                          }));
                        }
                      },
                      child: const Text("7-UserInfo")),
                  ElevatedButton(
                      onPressed: () {
                        if (_isConn) {
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return WeatherPage(
                              blePlugin: _blePlugin,
                            );
                          }));
                        }
                      },
                      child: const Text("8-Weather")),
                  ElevatedButton(
                      onPressed: () {
                        if (_isConn) {
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return StepsPage(
                              blePlugin: _blePlugin,
                            );
                          }));
                        }
                      },
                      child: const Text("9-Steps")),
                  ElevatedButton(
                      onPressed: () {
                        if (_isConn) {
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return SleepPage(
                              blePlugin: _blePlugin,
                            );
                          }));
                        }
                      },
                      child: const Text("10-Sleep")),
                  ElevatedButton(
                      onPressed: () {
                        if (_isConn) {
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return UnitSystemPage(
                              blePlugin: _blePlugin,
                            );
                          }));
                        }
                      },
                      child: const Text("11-UnitSystem")),
                  ElevatedButton(
                      onPressed: () {
                        if (_isConn) {
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return QuickViewPage(
                              blePlugin: _blePlugin,
                            );
                          }));
                        }
                      },
                      child: const Text("12-QuickView")),
                  ElevatedButton(
                      onPressed: () {
                        if (_isConn) {
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return GoalStepsPage(
                              blePlugin: _blePlugin,
                            );
                          }));
                        }
                      },
                      child: const Text("13-GoalSteps")),
                  ElevatedButton(
                      onPressed: () {
                        if (_isConn) {
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return WatchFacePage(
                              blePlugin: _blePlugin,
                              device: device,
                            );
                          }));
                        }
                      },
                      child: const Text("14-WatchFace")),
                  ElevatedButton(
                      onPressed: () {
                        if (_isConn) {
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return AlarmPage(
                              blePlugin: _blePlugin,
                            );
                          }));
                        }
                      },
                      child: const Text("15-Alarm")),
                  ElevatedButton(
                      onPressed: () {
                        if (_isConn) {
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return LanguagePage(
                              blePlugin: _blePlugin,
                            );
                          }));
                        }
                      },
                      child: const Text("16-Language")),
                  ElevatedButton(
                      onPressed: () {
                        if (_isConn) {
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return NotificationPage(
                              blePlugin: _blePlugin,
                            );
                          }));
                        }
                      },
                      child: const Text("17-Notification")),
                  ElevatedButton(
                      onPressed: () {
                        if (_isConn) {
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return SedentaryReminderPage(
                              blePlugin: _blePlugin,
                            );
                          }));
                        }
                      },
                      child: const Text("18-SedentaryReminder")),
                  ElevatedButton(
                      onPressed: () {
                        if (_isConn) {
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return FindWatchPage(
                              blePlugin: _blePlugin,
                            );
                          }));
                        }
                      },
                      child: const Text("19-FindWatch")),
                  ElevatedButton(
                      onPressed: () {
                        if (_isConn) {
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return HeartRatePage(
                              blePlugin: _blePlugin,
                            );
                          }));
                        }
                      },
                      child: const Text("20-HeartRate")),
                  ElevatedButton(
                      onPressed: () {
                        if (_isConn) {
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return BloodPressurePage(
                              blePlugin: _blePlugin,
                            );
                          }));
                        }
                      },
                      child: const Text("21-BloodPressure")),
                  ElevatedButton(
                      onPressed: () {
                        if (_isConn) {
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return BloodOxygenPage(
                              blePlugin: _blePlugin,
                            );
                          }));
                        }
                      },
                      child: const Text("22-BloodOxygen")),
                  ElevatedButton(
                      onPressed: () {
                        if (_isConn) {
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return TakePhotoPage(
                              blePlugin: _blePlugin,
                            );
                          }));
                        }
                      },
                      child: const Text("23 & 24-TakePhoto")),
                  ElevatedButton(
                      onPressed: () {
                        if (_isConn) {
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return RSSIPage(
                              blePlugin: _blePlugin,
                            );
                          }));
                        }
                      },
                      child: const Text("25-RSSI")),
                  ElevatedButton(
                      onPressed: () {
                        if (_isConn) {
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return ShutDownPage(
                              blePlugin: _blePlugin,
                            );
                          }));
                        }
                      },
                      child: const Text("26-ShutDown")),
                  ElevatedButton(
                      onPressed: () {
                        if (_isConn) {
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return NotDisturbPage(
                              blePlugin: _blePlugin,
                            );
                          }));
                        }
                      },
                      child: const Text("27-NotDisturb")),
                  ElevatedButton(
                      onPressed: () {
                        if (_isConn) {
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return BreathingLightPage(
                              blePlugin: _blePlugin,
                            );
                          }));
                        }
                      },
                      child: const Text("28-BreathingLight")),
                  ElevatedButton(
                      onPressed: () {
                        if (_isConn) {
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return ECGPage(
                              blePlugin: _blePlugin,
                            );
                          }));
                        }
                      },
                      child: const Text("29-ECG")),
                  ElevatedButton(
                      onPressed: () {
                        if (_isConn) {
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return MenstrualCyclePage(
                              blePlugin: _blePlugin,
                            );
                          }));
                        }
                      },
                      child: const Text("30-MenstrualCycle")),
                  ElevatedButton(
                      onPressed: () {
                        if (_isConn) {
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return FindPhonePage(
                              blePlugin: _blePlugin,
                            );
                          }));
                        }
                      },
                      child: const Text("31-FindPhone")),
                  ElevatedButton(
                      onPressed: () {
                        if (_isConn) {
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return MusicPlayerPage(
                              blePlugin: _blePlugin,
                            );
                          }));
                        }
                      },
                      child: const Text("32-MusicPlayer")),
                  ElevatedButton(
                      onPressed: () {
                        if (_isConn) {
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return DrinkWaterReminderPage(
                              blePlugin: _blePlugin,
                            );
                          }));
                        }
                      },
                      child: const Text("33-DrinkWaterReminder")),
                  ElevatedButton(
                      onPressed: () {
                        if (_isConn) {
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return HeartRateAlarmPage(
                              blePlugin: _blePlugin,
                            );
                          }));
                        }
                      },
                      child: const Text("34-HeartRateAlarm")),
                  ElevatedButton(
                      onPressed: () {
                        if (_isConn) {
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return ProtocolVersionPage(
                              blePlugin: _blePlugin,
                            );
                          }));
                        }
                      },
                      child: const Text("36-ProtocolVersion")),
                  ElevatedButton(
                      onPressed: () {
                        if (_isConn) {
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return BodyTemperaturePage(
                              blePlugin: _blePlugin,
                            );
                          }));
                        }
                      },
                      child: const Text("37-BodyTemperature")),
                  ElevatedButton(
                      onPressed: () {
                        if (_isConn) {
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return DisplayTimePage(
                              blePlugin: _blePlugin,
                            );
                          }));
                        }
                      },
                      child: const Text("38-DisplayTime")),
                  ElevatedButton(
                      onPressed: () {
                        if (_isConn) {
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return HandWashingReminderPage(
                              blePlugin: _blePlugin,
                            );
                          }));
                        }
                      },
                      child: const Text("39-HandWashingReminder")),
                  ElevatedButton(
                      onPressed: () {
                        if (_isConn) {
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return SetsLocalCityPage(
                              blePlugin: _blePlugin,
                            );
                          }));
                        }
                      },
                      child: const Text("40-SetsLocalCity")),
                  ElevatedButton(
                      onPressed: () {
                        if (_isConn) {
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return TemperatureSystemPage(
                              blePlugin: _blePlugin,
                            );
                          }));
                        }
                      },
                      child: const Text("41-TemperatureSystem")),
                  ElevatedButton(
                      onPressed: () {
                        if (_isConn) {
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return BrightnessPage(
                              blePlugin: _blePlugin,
                            );
                          }));
                        }
                      },
                      child: const Text("42-Brightness")),

                  /// 配对移至同级显示
                  // ElevatedButton(
                  //     onPressed: () {
                  //       if (_isConn) {
                  //         Navigator.push(context, MaterialPageRoute(builder: (context) {
                  //           return ClassicBluetoothAddressPage(
                  //             blePlugin: _blePlugin,
                  //           );
                  //         }));
                  //       }
                  //     },
                  //     child: const Text("43-ClassicBluetoothAddress")),
                  const Text("Note: First please BT pair, because Contacts need BT pair",
                      style: TextStyle(height: 1.5, fontSize: 14, color: Colors.deepOrange)),
                  ElevatedButton(
                      onPressed: () {
                        if (_isConn) {
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return ContactsPage(
                              blePlugin: _blePlugin,
                            );
                          }));
                        }
                      },
                      child: const Text("44-Contacts")),
                  ElevatedButton(
                      onPressed: () {
                        if (_isConn) {
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return BatterySavingPage(
                              blePlugin: _blePlugin,
                            );
                          }));
                        }
                      },
                      child: const Text("45-BatterySaving")),
                  ElevatedButton(
                      onPressed: () {
                        if (_isConn) {
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return PillReminderPage(
                              blePlugin: _blePlugin,
                            );
                          }));
                        }
                      },
                      child: const Text("46-PillReminder")),
                  ElevatedButton(
                      onPressed: () {
                        if (_isConn) {
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return TapWakePage(
                              blePlugin: _blePlugin,
                            );
                          }));
                        }
                      },
                      child: const Text("47-TapWake")),
                  ElevatedButton(
                      onPressed: () {
                        if (_isConn) {
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return TrainingPage(
                              blePlugin: _blePlugin,
                            );
                          }));
                        }
                      },
                      child: const Text("35 & 48-Training")),
                  ElevatedButton(
                      onPressed: () {
                        if (_isConn) {
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return GSensorPage(
                              blePlugin: _blePlugin,
                            );
                          }));
                        }
                      },
                      child: const Text("49-GSensor")),
                  ElevatedButton(
                      onPressed: () {
                        if (_isConn) {
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return SOSPage(
                              blePlugin: _blePlugin,
                            );
                          }));
                        }
                      },
                      child: const Text("50-SOS")),
                  // ElevatedButton(
                  //     onPressed: () {
                  //       if (_isConn) {
                  //         Navigator.push(context, MaterialPageRoute(builder: (context) {
                  //           return PaddingPage(
                  //             blePlugin: _blePlugin,
                  //           );
                  //         }));
                  //       }
                  //     },
                  //     child: const Text("51-Padding")),
                  ElevatedButton(
                      onPressed: () {
                        if (_isConn) {
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return HRVPage(
                              blePlugin: _blePlugin,
                            );
                          }));
                        }
                      },
                      child: const Text("52-HRV")),
                  ElevatedButton(
                      onPressed: () {
                        if (_isConn) {
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return StressPage(
                              blePlugin: _blePlugin,
                            );
                          }));
                        }
                      },
                      child: const Text("53-Stress")),
                  ElevatedButton(
                      onPressed: () {
                        if (_isConn) {
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return ElectronicCardPage(
                              blePlugin: _blePlugin,
                            );
                          }));
                        }
                      },
                      child: const Text("54-ElectronicCard")),
                  ElevatedButton(
                      onPressed: () {
                        if (_isConn) {
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return CalendarEventPage(
                              blePlugin: _blePlugin,
                            );
                          }));
                        }
                      },
                      child: const Text("54-CalendarEvent")),

                  /// gps demo 待完成
                  // ElevatedButton(
                  //     onPressed: () {
                  //       if (_isConn) {
                  //         Navigator.push(context, MaterialPageRoute(builder: (context) {
                  //           return GPSPage(
                  //             blePlugin: _blePlugin,
                  //           );
                  //         }));
                  //       }
                  //     },
                  //     child: const Text("55-GPSPage")),
                  ElevatedButton(
                      onPressed: () {
                        if (_isConn) {
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return VibrationStrengthPage(
                              blePlugin: _blePlugin,
                            );
                          }));
                        }
                      },
                      child: const Text("56-VibrationStrengthPage")),
                ],
              ),
            ])),
          ),
        ));
  }
}
