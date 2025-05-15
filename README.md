# MoYoung Ble Plugin



## 1 Introduction

Welcome to use this plugin. This is a Flutter plugin for communicating with the watch.



### 1.1Platform Support

| Android | iOS |
| :-----: | :-: |
|   ✔️   | ✔️  |



### 1.2 Usage

To use this plugin, add `moyoung_ble_plugin` as a dependency in your `pubspec.yaml` file.

```
moyoung_ble_plugin: ^latestVersion
```



### 1.3 Project configuration

- **Android**

1.Perform the following configuration when generating apk for code obfuscation. Please add the following configuration to your `proguard-rules.pro` file.

```
-keep class com.crrepa.ble.** { *; }
-keep class com.moyoung.moyoung_ble_plugin.** { *; }
```

2.In your App Module, modify the following configuration.

```
android {
    ...
    defaultConfig {
        ...
        minSdkVersion 18
        ...
    }
    ...
}
```

- **IOS**

1.You need to add it to the `info.plist` .

```
<key>NSAppTransportSecurity</key>
<dict>
    <key>NSAllowsArbitraryLoads</key>
    <true/>
</dict>
<key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
<string>Use the location to sync weather from your phone to your watch.</string>
<key>NSBluetoothAlwaysUsageDescription</key>
<string>Use the Bluetooth to connect to your Nokia Watch</string>
<key>NSCalendarsUsageDescription</key>
<string>Use the calendar to sync events from your phone to your watch.</string>
<key>NSCameraUsageDescription</key>
<string>Use the camera to scan the QR code on your watch screen.</string>
<key>NSContactsUsageDescription</key>
<string>The selected contacts will be added to your Watch contacts.</string>
<key>NSPhotoLibraryUsageDescription</key>
<string>Use the Photo to change your watch face.</string>
<key>UIApplicationSupportsIndirectInputEvents</key>
<true/>
<key>UIBackgroundModes</key>
<array>
<string>bluetooth-central</string>
</array>
```

2.Use terminal, in your path for project,use `pod install` to import the library.

3.You need to check your podfile.lock, and if the library version in the file is different from pubspec.yaml, you need to synchronize the library version in podfile.lock to pubspec.yaml, and then pod install.

**For example:**
In podfile. Lock

- flutter_contacts (0.0.1) :

In pubspec yaml
Flutter_contacts: ^ 1.1.4
**You must change flutter_contacts (0.0.1) in podfile.lock to Flutter_contacts (1.1.4)**


### 1.4 Example

- **First setp**

  Import package.

  ```da
  import 'package:moyoung_ble_plugin/moyoung_ble.dart';
  ```

- **Second step**

  Apply for some permissions:  [location, storage].

  - *Tip1: You need to apply for these permissions yourself*

  - *Tip2:  Of course you can use the example in the [Example project](https://github.com/QinShuangyu/MoYoungWatchFlutterSDK) to apply for permissions.  But, please note the configuration of permissions in this file:`AndroidManifest.xml`*

- **Third step**

  Use in pages.

  ```dart
  class _MyAppState extends State<MyApp> {
    final _streamSubscriptions = <StreamSubscription<dynamic>>[];
    final MoYoungBle _blePlugin = MoYoungBle();
    final List<BleScanBean> _deviceList = [];
  
    @override
    void initState() {
      super.initState();
      subscriptStream();
    }
  
    void subscriptStream() {
      _streamSubscriptions.add(
        _blePlugin.bleScanEveStm.listen(
          (BleScanBean event) async {
            setState(() {
              if (event.isCompleted) {
                //Scan completed, do something
              } else {
                _deviceList.add(event);
              }
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
  
    // Scanning bluetooth devices
    void startScan() {
      if (!mounted) return;
      _blePlugin.startScan(10*1000).then((value) => {
        setState(() {
          // Do something.
          print(value ? "Scanning" : "Have not started");
        })
      }).onError((error, stackTrace) => {
        //Usually some permissions are not requested
        print(error.toString())
      });
    }
  }
  ```



### 1.5 Detailed usage document

[Click to Wiki](https://qcdn.moyoung.com/markdown/wiki.md?download).


### 1.6 Full sample project

The Example project contains details about how the code is used.

[Click to Example](https://github.com/QinShuangyu/MoYoungWatchFlutterSDK).


### 1.7 GNU GENERAL PUBLIC LICENSE License

[Click to License](https://pub.dev/packages/moyoung_ble_plugin/license).