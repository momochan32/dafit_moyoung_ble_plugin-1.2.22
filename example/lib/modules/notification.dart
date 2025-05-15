import 'dart:async';
import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:moyoung_ble_plugin/moyoung_ble.dart';

import '../components/base/CustomGestureDetector.dart';

class NotificationPage extends StatefulWidget {
  final MoYoungBle blePlugin;

  const NotificationPage({Key? key, required this.blePlugin}) : super(key: key);

  @override
  State<NotificationPage> createState() {
    return _NotificationPage();
  }
}

class _NotificationPage extends State<NotificationPage> {
  final _streamSubscriptions = <StreamSubscription<dynamic>>[];
  List _list = [];
  bool _state = false;
  String _number = "";
  int _firmwareVersion = -1;
  List<int> _messageType = [];
  final List<int> _newMessageType = [];
  bool started = true;
  bool _enableIncomingNumber = false;

  ReceivePort port = ReceivePort();
  bool hasPort = false;

  CrossFadeState displayState1 = CrossFadeState.showSecond;
  CrossFadeState displayState2 = CrossFadeState.showSecond;
  CrossFadeState displayState3 = CrossFadeState.showSecond;
  CrossFadeState displayState4 = CrossFadeState.showSecond;

  @override
  void initState() {
    super.initState();
    subscriptStream();
  }

  void subscriptStream() {
    _streamSubscriptions.add(
      widget.blePlugin.callNumberEveStm.listen((String event) {
        if (!mounted) return;
        setState(() {
          _number = event;
        });
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: const Text("Notification"),
              automaticallyImplyLeading: false, // 禁用默认的返回按钮
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context); // 手动处理返回逻辑
                },
              ),
            ),
            body: Center(
                child: ListView(children: [
              CustomGestureDetector(
                  title: 'Android',
                  childrenBCallBack: (CrossFadeState newDisplayState) {
                    setState(() {
                      displayState1 = newDisplayState;
                    });
                  },
                  displayState: displayState1,
                  children: <Widget>[
                    Text("enableIncomingNumber: $_enableIncomingNumber", style: const TextStyle(height: 1.5, fontSize: 14, color: Colors.grey)),
                    ElevatedButton(
                      child: const Text('1.android:enableIncomingNumber(true)'),
                      onPressed: () async {
                        MoYoungBle _blePlugin = MoYoungBle();
                        bool enableIncomingNumber = await _blePlugin.enableIncomingNumber(true);
                        setState(() {
                          _enableIncomingNumber = enableIncomingNumber;
                        });
                      },
                    ),
                    ElevatedButton(
                      child: const Text('android:enableIncomingNumber(false)'),
                      onPressed: () async {
                        bool enableIncomingNumber = await widget.blePlugin.enableIncomingNumber(false);
                        setState(() {
                          _enableIncomingNumber = enableIncomingNumber;
                        });
                      },
                    ),
                    Text("state: $_state", style: const TextStyle(height: 1.5, fontSize: 14, color: Colors.grey)),
                    ElevatedButton(
                      child: const Text('2.android:sendOtherMessageState'),
                      onPressed: () => widget.blePlugin.sendOtherMessageState(!_state),
                    ),
                    ElevatedButton(
                        child: const Text("android:queryOtherMessageState"),
                        onPressed: () async {
                          bool state = await widget.blePlugin.queryOtherMessageState;
                          setState(() {
                            _state = state;
                          });
                        }),
                    Text("messageType: $_messageType", style: const TextStyle(height: 1.5, fontSize: 14, color: Colors.grey)),
                    ElevatedButton(
                        child: const Text('3.queryMessageList'),
                        onPressed: () async {
                          List<int> messageType = await widget.blePlugin.queryMessageList;
                          setState(() {
                            _messageType = messageType;
                          });
                        }),
                    Text("firmwareVersion: $_firmwareVersion", style: const TextStyle(height: 1.5, fontSize: 14, color: Colors.grey)),
                    ElevatedButton(
                        child: const Text("4.queryFirmwareVersion"),
                        onPressed: () async {
                          String firmwareVersion = await widget.blePlugin.queryFirmwareVersion;
                          int index = firmwareVersion.lastIndexOf('-');
                          String subString = firmwareVersion.substring(index);
                          String version = '';
                          subString.replaceAllMapped(RegExp(r'\d'), (Match m) {
                            version += m[0]!;
                            return m[0]!;
                          });
                          setState(() {
                            _firmwareVersion = int.parse(version);
                          });
                        }),
                    const Text("Send the following message push example",
                        style: TextStyle(height: 1.5, fontSize: 14, color: Colors.deepOrangeAccent)),
                    ElevatedButton(
                        child: const Text('sendMessage(facebook)'),
                        onPressed: () {
                          Timer(const Duration(seconds: 10), () {
                            if (_firmwareVersion != -1) {
                              widget.blePlugin.sendMessage(
                                MessageBean(
                                  title: 'facebook',
                                  message: 'message',
                                  type: BleMessageType.facebook,
                                  versionCode: _firmwareVersion,
                                  isHs: true,
                                  isSmallScreen: true,
                                ),
                              );
                            }
                          });
                        }),
                    ElevatedButton(
                        child: const Text('sendMessage(twitter)'),
                        onPressed: () {
                          Timer(const Duration(seconds: 10), () {
                            if (_firmwareVersion != -1) {
                              widget.blePlugin.sendMessage(
                                MessageBean(
                                  title: 'twitter',
                                  message: 'message',
                                  type: BleMessageType.twitter,
                                  versionCode: _firmwareVersion,
                                  isHs: true,
                                  isSmallScreen: true,
                                ),
                              );
                            }
                          });
                        }),
                    ElevatedButton(
                        child: const Text('sendMessage(whatsApp)'),
                        onPressed: () {
                          Timer(const Duration(seconds: 10), () {
                            if (_firmwareVersion != -1) {
                              widget.blePlugin.sendMessage(
                                MessageBean(
                                  title: 'whatsApp',
                                  message: 'message',
                                  type: BleMessageType.whatsApp,
                                  versionCode: _firmwareVersion,
                                  isHs: true,
                                  isSmallScreen: true,
                                ),
                              );
                            }
                          });
                        }),
                    ElevatedButton(
                        child: const Text('sendMessage(kaKao)'),
                        onPressed: () {
                          Timer(const Duration(seconds: 10), () {
                            if (_firmwareVersion != -1) {
                              widget.blePlugin.sendMessage(
                                MessageBean(
                                  title: 'kaKao',
                                  message: 'message',
                                  type: BleMessageType.kaKao,
                                  versionCode: _firmwareVersion,
                                  isHs: true,
                                  isSmallScreen: true,
                                ),
                              );
                            }
                          });
                        }),
                    ElevatedButton(
                        child: const Text('sendMessage(messenger)'),
                        onPressed: () {
                          Timer(const Duration(seconds: 10), () {
                            if (_firmwareVersion != -1) {
                              widget.blePlugin.sendMessage(
                                MessageBean(
                                  title: 'messenger',
                                  message: 'message',
                                  type: BleMessageType.messenger,
                                  versionCode: _firmwareVersion,
                                  isHs: true,
                                  isSmallScreen: true,
                                ),
                              );
                            }
                          });
                        }),
                    ElevatedButton(
                        child: const Text('sendMessage(telegram)'),
                        onPressed: () {
                          Timer(const Duration(seconds: 10), () {
                            if (_firmwareVersion != -1) {
                              widget.blePlugin.sendMessage(
                                MessageBean(
                                  title: 'telegram',
                                  message: 'message',
                                  type: BleMessageType.telegram,
                                  versionCode: _firmwareVersion,
                                  isHs: true,
                                  isSmallScreen: true,
                                ),
                              );
                            }
                          });
                        }),
                    ElevatedButton(
                        child: const Text('sendMessage(gmail)'),
                        onPressed: () {
                          Timer(const Duration(seconds: 10), () {
                            if (_firmwareVersion != -1) {
                              widget.blePlugin.sendMessage(
                                MessageBean(
                                  title: 'gmail',
                                  message: 'message',
                                  type: BleMessageType.gmail,
                                  versionCode: _firmwareVersion,
                                  isHs: true,
                                  isSmallScreen: true,
                                ),
                              );
                            }
                          });
                        }),
                    ElevatedButton(
                        child: const Text('sendMessage(uber)'),
                        onPressed: () {
                          Timer(const Duration(seconds: 10), () {
                            if (_firmwareVersion != -1) {
                              widget.blePlugin.sendMessage(
                                MessageBean(
                                  title: 'uber',
                                  message: 'message',
                                  type: BleMessageType.uber,
                                  versionCode: _firmwareVersion,
                                  isHs: true,
                                  isSmallScreen: true,
                                ),
                              );
                            }
                          });
                        }),
                    ElevatedButton(
                        child: const Text('sendMessage(snapchat)'),
                        onPressed: () {
                          Timer(const Duration(seconds: 10), () {
                            if (_firmwareVersion != -1) {
                              widget.blePlugin.sendMessage(
                                MessageBean(
                                  title: 'snapchat',
                                  message: 'message',
                                  type: BleMessageType.snapchat,
                                  versionCode: _firmwareVersion,
                                  isHs: true,
                                  isSmallScreen: true,
                                ),
                              );
                            }
                          });
                        }),
                    ElevatedButton(
                        child: const Text('sendMessage(linkEdin)'),
                        onPressed: () {
                          Timer(const Duration(seconds: 10), () {
                            if (_firmwareVersion != -1) {
                              widget.blePlugin.sendMessage(
                                MessageBean(
                                  title: 'linkEdin',
                                  message: 'message',
                                  type: BleMessageType.linkEdin,
                                  versionCode: _firmwareVersion,
                                  isHs: true,
                                  isSmallScreen: true,
                                ),
                              );
                            }
                          });
                        }),
                    ElevatedButton(
                        child: const Text('sendMessage(amazon)'),
                        onPressed: () {
                          Timer(const Duration(seconds: 10), () {
                            if (_firmwareVersion != -1) {
                              widget.blePlugin.sendMessage(
                                MessageBean(
                                  title: 'amazon',
                                  message: 'message',
                                  type: BleMessageType.amazon,
                                  versionCode: _firmwareVersion,
                                  isHs: true,
                                  isSmallScreen: true,
                                ),
                              );
                            }
                          });
                        }),
                    ElevatedButton(
                        child: const Text('sendMessage(tiktok)'),
                        onPressed: () {
                          Timer(const Duration(seconds: 10), () {
                            if (_firmwareVersion != -1) {
                              widget.blePlugin.sendMessage(
                                MessageBean(
                                  title: 'tiktok',
                                  message: 'message',
                                  type: BleMessageType.tiktok,
                                  versionCode: _firmwareVersion,
                                  isHs: true,
                                  isSmallScreen: true,
                                ),
                              );
                            }
                          });
                        }),
                    ElevatedButton(
                        child: const Text('sendMessage(lyft)'),
                        onPressed: () {
                          Timer(const Duration(seconds: 10), () {
                            if (_firmwareVersion != -1) {
                              widget.blePlugin.sendMessage(
                                MessageBean(
                                  title: 'lyft',
                                  message: 'message',
                                  type: BleMessageType.lyft,
                                  versionCode: _firmwareVersion,
                                  isHs: true,
                                  isSmallScreen: true,
                                ),
                              );
                            }
                          });
                        }),
                    ElevatedButton(
                        child: const Text('sendMessage(mail)'),
                        onPressed: () {
                          Timer(const Duration(seconds: 10), () {
                            if (_firmwareVersion != -1) {
                              widget.blePlugin.sendMessage(
                                MessageBean(
                                  title: 'mail',
                                  message: 'message',
                                  type: BleMessageType.mail,
                                  versionCode: _firmwareVersion,
                                  isHs: true,
                                  isSmallScreen: true,
                                ),
                              );
                            }
                          });
                        }),
                    ElevatedButton(
                        child: const Text('sendMessage(googleMaps)'),
                        onPressed: () {
                          Timer(const Duration(seconds: 10), () {
                            if (_firmwareVersion != -1) {
                              widget.blePlugin.sendMessage(
                                MessageBean(
                                  title: 'googleMaps',
                                  message: 'message',
                                  type: BleMessageType.googleMaps,
                                  versionCode: _firmwareVersion,
                                  isHs: true,
                                  isSmallScreen: true,
                                ),
                              );
                            }
                          });
                        }),
                    ElevatedButton(
                        child: const Text('sendMessage(slack)'),
                        onPressed: () {
                          Timer(const Duration(seconds: 10), () {
                            if (_firmwareVersion != -1) {
                              widget.blePlugin.sendMessage(
                                MessageBean(
                                  title: 'slack',
                                  message: 'message',
                                  type: BleMessageType.slack,
                                  versionCode: _firmwareVersion,
                                  isHs: true,
                                  isSmallScreen: true,
                                ),
                              );
                            }
                          });
                        }),
                    Text("number: $_number", style: const TextStyle(height: 1.5, fontSize: 14, color: Colors.grey)),
                    ElevatedButton(
                      child: const Text('android:endCall()'),
                      onPressed: () => widget.blePlugin.endCall,
                    ),
                    ElevatedButton(
                      child: const Text('android:sendCallContactName()'),
                      onPressed: () => widget.blePlugin.sendCallContactName("嘿嘿"),
                    ),
                  ]),
              CustomGestureDetector(
                  title: 'iOS old version of the news push',
                  childrenBCallBack: (CrossFadeState newDisplayState) {
                    setState(() {
                      displayState2 = newDisplayState;
                    });
                  },
                  displayState: displayState2,
                  children: <Widget>[
                    ElevatedButton(
                        child: const Text('1. ios:setNotification()'),
                        onPressed: () =>
                            widget.blePlugin.setNotification([NotificationType.facebook, NotificationType.gmail, NotificationType.kakao])),
                    Text("list: $_list", style: const TextStyle(height: 1.5, fontSize: 14, color: Colors.grey)),
                    ElevatedButton(
                        child: const Text('2. ios:getNotification'),
                        onPressed: () async {
                          NotificationBean notificationBean = await widget.blePlugin.getNotification;

                          if (!notificationBean.isNew!) {
                            setState(() {
                              _list = notificationBean.list!;
                            });
                          }
                        }),
                  ]),
              CustomGestureDetector(
                title: 'iOS new version of the news push',
                childrenBCallBack: (CrossFadeState newDisplayState) {
                  setState(() {
                    displayState3 = newDisplayState;
                  });
                },
                displayState: displayState3,
                children: <Widget>[
                  Text("messageType: $_messageType", style: const TextStyle(height: 1.5, fontSize: 14, color: Colors.grey)),
                  ElevatedButton(
                      child: const Text('1. queryMessageList'),
                      onPressed: () async {
                        List<int> messageType = await widget.blePlugin.queryMessageList;
                        setState(() {
                          _messageType = messageType;
                        });
                      }),
                  ElevatedButton(
                    child: const Text('2. ios:setNotification()'),
                    onPressed: () {
                      if (_messageType.isNotEmpty) {
                        List<int> list = List.filled(_messageType.length, 0, growable: false);
                        list[2] = 1;
                        list[3] = 1;
                        widget.blePlugin.setNotification(list);
                      }
                    },
                  ),
                  Text("newMessageType: $_newMessageType", style: const TextStyle(height: 1.5, fontSize: 14, color: Colors.grey)),
                  ElevatedButton(
                      child: const Text('3. ios:getNotification'),
                      onPressed: () async {
                        NotificationBean notificationBean = await widget.blePlugin.getNotification;
                        _newMessageType.clear();
                        if (notificationBean.isNew!) {
                          setState(() {
                            for (int i = 0; i < notificationBean.list!.length; i++) {
                              if (notificationBean.list![i] == 1) {
                                _newMessageType.add(_messageType[i]);
                              }
                            }
                          });
                        }
                      }),
                ],
              ),
            ]))));
  }
}
