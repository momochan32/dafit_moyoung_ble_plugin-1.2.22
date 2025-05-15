import 'dart:async';

import 'package:flutter/material.dart';
import 'package:moyoung_ble_plugin/moyoung_ble.dart';

class PaddingPage extends StatefulWidget {
  final MoYoungBle blePlugin;

  const PaddingPage({
    Key? key,
    required this.blePlugin,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PaddingPage();
  }
}

class _PaddingPage extends State<PaddingPage> {

  int _key = -1;
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Pairing"),
          automaticallyImplyLeading: false, // 禁用默认的返回按钮
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context); // 手动处理返回逻辑
            },
          ),
        ),
        body: Center(
          child: ListView(children: <Widget>[
            Text("key: $_key"),

            ElevatedButton(
                onPressed: () async {
                  int key = await widget.blePlugin.createBond([1, 2]);
                  setState(() {
                    _key = key;
                  });
                },
                child: const Text("createBond")),
          ]),
        ),
      ),
    );
  }
}
