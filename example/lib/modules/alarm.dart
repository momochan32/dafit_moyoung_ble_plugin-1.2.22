import 'package:flutter/material.dart';
import 'package:moyoung_ble_plugin/moyoung_ble.dart';

import '../components/base/CustomGestureDetector.dart';

class AlarmPage extends StatefulWidget {
  final MoYoungBle blePlugin;

  const AlarmPage({Key? key, required this.blePlugin}) : super(key: key);

  @override
  State<AlarmPage> createState() {
    return _AlarmPage();
  }
}

class _AlarmPage extends State<AlarmPage> {
  List<AlarmClockBean> _list = [];
  bool _isNew = false;

  CrossFadeState displayState1 = CrossFadeState.showSecond;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Alarm"),
          automaticallyImplyLeading: false, // 禁用默认的返回按钮
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context); // 手动处理返回逻辑
            },
          ),
        ),
        body: Center(
          child: ListView(
            children: [
              CustomGestureDetector(
                  title: 'send Contacts',
                  childrenBCallBack: (CrossFadeState newDisplayState) {
                    setState(() {
                      displayState1 = newDisplayState;
                    });
                  },
                  displayState: displayState1,
                  children: <Widget>[
                    Text("isNew: $_isNew", style: const TextStyle(height: 1.5, fontSize: 14, color: Colors.grey)),
                    Text("list: ${_list.map((e) => alarmClockBeanToJson(e))}", style: const TextStyle(height: 1.5, fontSize: 14, color: Colors.grey)),

                    // ElevatedButton(
                    //     child: const Text('sendAlarmClock()'),
                    //     onPressed: () => widget.blePlugin.sendAlarm(AlarmClockBean(
                    //         enable: true,
                    //         hour: 1,
                    //         id: AlarmClockBean.firstClock,
                    //         minute: 0,
                    //         repeatMode: AlarmClockBean.everyday))),
                    // ElevatedButton(
                    //     child: const Text('queryAllAlarmClock()'),
                    //     onPressed: () async {
                    //       List<AlarmClockBean> list =
                    //           await widget.blePlugin.queryAllAlarm;
                    //       setState(() {
                    //         _list = list;
                    //       });
                    //     }),
                    ElevatedButton(
                        child: const Text('sendNewAlarm()'),
                        onPressed: () => widget.blePlugin.sendNewAlarm(
                            AlarmClockBean(enable: true, hour: 1, id: AlarmClockBean.firstClock, minute: 0, repeatMode: AlarmClockBean.everyday))),
                    ElevatedButton(
                        child: const Text("deleteNewAlarm()"), onPressed: () => widget.blePlugin.deleteNewAlarm(AlarmClockBean.firstClock)),
                    ElevatedButton(child: const Text("deleteAllNewAlarm()"), onPressed: () => widget.blePlugin.deleteAllNewAlarm()),
                    ElevatedButton(
                        child: const Text("queryAllNewAlarm()"),
                        onPressed: () async {
                          AlarmBean alarm = await widget.blePlugin.queryAllNewAlarm;
                          setState(() {
                            _list = alarm.list;
                            _isNew = alarm.isNew;
                          });
                        }),
                  ])
            ],
          ),
        ),
      ),
    );
  }
}
