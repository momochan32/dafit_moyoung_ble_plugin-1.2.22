## 0.0.1
Project uploaded for the first time.

## 0.0.2
Uploading some unfinished functions.

## 0.0.3
Upload complete function, to be tested.

## 0.0.4
Update README.md

## 0.0.5
Add Wiki.md

## 0.0.6
Update interfaces

## 0.0.7
1.Update interfaces
2.Optimize the document

## 1.0.0
Modify some method names

## 1.0.1
Modify some documents

## 1.0.2
Modify the IOS platform adaptation problem

## 1.0.3
Fix Android 11 dynamic permission application bug.
iOS canceled automatic reconnection, and added methods reconnect and connectDevice.

## 1.0.4
1. The Realtek SDK is removeed.
2. Added the following methods related to target setting：
    ① sendDailyGoals
    ② queryDailyGoals
    ③ sendTrainingDayGoals
    ④ queryTrainingDayGoals
    ⑤ sendTrainingDays
    ⑥ queryTrainingDay
3. Added support for switches for some push notifications
Please check the WIki documentation for details

## 1.0.5
1. Fix the method isConnected on the Android side.
2. Added some new methods of native SDK.

## 1.0.6
1. iOS adds support for querying historical sports data.

## 1.0.7
1. iOS added to get today's/yesterday's calorie and blood oxygen data counted every half hour.   

## 1.0.8
1. The Realtek SDK is removeed. 
2. Method of updating the upload of the local watch face file.

## 1.0.9
1. Remove the print method used for SDK internal debugging.
2. Android SDK removed realtek.

## 1.0.10
1. Method of updating the upload of the local watch face file.

## 1.0.11
1. Modify some methods.
2. All channel monitoring of Flutter-iOS has been separated.

## 1.0.12
1. Turn off debug log.

## 1.0.13
1. The watch face upload method is adapted to some models
2. The blood oxygen time format is unified
3. Added heart rate acquisition interval for iOS

## 1.0.14
1. Fix the issue that the watch face uploads an error on Android

## 1.0.15
1. Added sleep goal setting, delayed photo taking, and half-hour data statistics interface.

## 1.0.16
1. Edit wiki link.

## 1.0.17
1. Android sdk remove realtek

## 1.0.18
1. Added distance target setting
2. Added startTime to iOS's all-day heart rate measurement

## 1.0.19
1. Fix the type error problem when the body temperature monitor is running on an iOS device.

## 1.0.20
1. ios new methods queryMessageList, sendNotificationState, queryNotificationState
2. Fix iOS alarm clock algorithm

## 1.0.21
1. Added the case of Android background message push.

## 1.0.22
1. Remove services from AndroidManifest.xml.

## 1.0.23
1. Merged the camera method.

## 1.0.24
1. Fix iOS frammwork exception problem when merging

## 1.0.25
1. Fix the problem that the photo taken by the old device does not return data due to the photo taken method.(iOS)

## 1.0.26
1. Fix the problem that the photo taken by the old device does not return data due to the photo taken method.(Android)

## 1.0.27
1. Merge notification method on IOS side

## 1.0.28
1. iOS and Android unified heart rate start time throughout the day
2. Example of Modification Notification

## 1.0.29
1. Modify the singleton pattern

## 1.0.30
1. The method of obtaining 24-hour heart rate on the iOS side adds a new time interval

## 1.0.31
1. Fixed the 24-hour heart rate data out of sync issue for Android and iOS 
2. Fixed the problem that the message push type was wrong

## 1.0.32
1. Fixed the incomplete display of city names in the weather
2. Fixed the problem of displaying Other for some notification types

## 1.0.33
1. Added a method to obtain exercise heart rate

## 1.0.34
1. Added a method to query customize version(Android)
2. Added the setting title field of the parameters of the message push method

## 1.0.35
1. Added a method to query customize version(iOS)

## 1.0.36
1. Fix the issue that rem sleep data cannot be obtained on iOS devices

## 1.0.37
1. Close iOS log

## 1.0.38
1. The queryCustomizeVersion method adds a version number precondition

## 1.0.39
1. Fix the problem that the preconditions of Android queryCustomVersion do not take effect

## 1.0.40
1. Fix the problem that iOS devices cannot add alarm clocks

## 1.0.41
1. Fixed the problem that some monitoring channels of Android are empty

## 1.0.42
1. Fixed the problem of error reporting in the notification interface of some iOS models
2. Fixed the problem that some versions did not respond when getting the custom version number

## 1.0.43
1. Fix the issue of error reporting when using queryCustomizeVersion on some devices

## 1.0.44
1. Android has added a new method for listening to incoming call notifications

## 1.0.45
1. Added automatic reconnection parameter for connection method and connection state monitoring: autoConnect
2. Synchronize Android and iOS interval  data format

## 1.0.46
1. Fix Flutter version out of sync issue

## 1.0.47
1. Modified the data structure of the camera callback
2. Android removes a useless permission

## 1.0.48
1. Added the judgment of whether to support delayed photo taking

## 1.0.49
1. Optimize the judgment of whether to support the delayed photo taking function

## 1.0.50
1. Compatible with the latest version of Flutter SDK

## 1.0.51
1. Fix: Bluetooth reconnection null pointer problem
2. Added: log of incoming call notification
3. Modify the logic of reconnection

## 1.0.52
1. IOS adds a new method: queryUUID
2. Remove: log of incoming call notification

## 1.0.53
1. Modify the color algorithm of the dial layout

## 1.0.54
1. Android adds automatic connection log

## 1.0.55
1. Android remove automatic connection log

## 1.0.56
1. Fix the problem that the background image and thumbnail of the custom watch face may be blurred.

## 1.0.57
1. Fix the crash problem caused by empty Activity

## 1.0.58
1. Android's method channel is changed from the UI thread to the main thread

## 1.0.59
1. Extract the method to turn on bluetooth

## 1.0.60
1. Fix the problem that the bottom layer of Android's queryCustomizeVersion method calls the version twice.

## 1.0.61
1. Fix the problem that after the foreground service connects to the watch, calling the disconnect method from the UI thread fails.

## 1.0.62
1. Commented out the code for clearing bluetooth and incoming call monitoring
2. After the foreground service is connected to the watch, the UI process cannot monitor the incoming call notification problem

## 1.0.63
1. Fixed the problem that the background image of the watch face was blurred on Android devices.
2. Modified the type of dial font color.

## 1.0.64
1. The native communication between Android and Flutter is changed to a singleton mode.

## 1.0.65
1. The logic of reconnecting after closing the application.

## 1.0.66
1. Process the incoming dial background image to avoid upload failure due to mismatched width and height of the background image.

## 1.0.67
1. Fix the problem that the background image uploaded by some watches is blurred on iOS devices.

## 1.0.68
1. iOS queryTodayHeartRate adds time interval calculation.

## 1.0.69
1. Fix the wrong start time of queryTodayHeartRate on iOS devices.

## 1.0.70
1. Newly added to determine whether the device is connected before reconnecting.

## 1.0.71
1. Fixed the problem that Android cannot reconnect in the background.

## 1.0.72
1. Try to fix version incompatibility.

## 1.0.73
1. Fixed the problem that some mobile phones could not be reconnected.

## 1.0.74
1. Try to fix version incompatibility.

## 1.0.75
1. Fixed the problem that some mobile phones could not be reconnected.

## 1.0.76 
1. Fixed the problem that clicking the normal connection will also reconnect

## 1.0.77
1. Deprecated method sendSedentaryReminderPeriod.
2. Added message push type.
3. Fixed the issue that the wrong data such as 60158 occasionally appeared in the step number in the step number details.

## 1.0.78
1. Re-enable method: sendSedentaryReminderPeriod.

## 1.0.79
1.Solve the issue of incorrect log format in the previous version.

## 1.1.0
1.Added firmware updates and watch faces for Sifli and JieLi.

## 1.1.1
1.Mapped the enum of the watch type returned by the querySupportWatchFace interface.

## 1.1.2
1. Added a feature to end phone calls on your watch.
2. Fixed an issue with ITECH Active 3 failing to retrieve custom version numbers.

## 1.1.3
1. Optimized the text color variation issue CRPHeartRateInfoin the watch face layout on Android devices.
2. Adapted the exercise records for ITech Active 3.

## 1.1.4
1. Fixed the issue on Android where retrieving the new alarm list returned null.
2. Enhanced the methods queryHistoryTraining and queryTraining for obtaining the updated version of exercise history records.

## 1.1.5
1. We've added a new method: sendWatchFaceId for adapting Jieli's watch face uploads.

## 1.1.6
1. Optimized Method: Query History Training.

## 1.1.7
1. Standardize the timestamp format to seconds.

## 1.1.8
1. Scan the method to add the return value 'platform' for the platform class.
2. integrate the firmware upgrades for Sifli and Jieli into the existing firmware upgrade method.

## 1.1.9
1. We've optimized the method for OTA updates and streamlined the process to uniformly use 'StartOTA' for all OTA upgrades.

## 1.2.0
1. Optimize Jieli's OTA upgrades and fitness data interfaces.

## 1.2.1
1. Adapted for Android 14.

## 1.2.2
1. Remove unnecessary awaits and optimize performance.

## 1.2.3
1. Adding result(nil) to iOS and Android methods ensures code readability and maintainability.
2. Remove the check for whether it is already connected before establishing the connection on the Android side.

## 1.2.4
1. The connection method on the iOS side has been updated to include logic for connecting devices via UUID and MAC address.
2. The sleep data now includes an additional parameter called 'details'.

## 1.2.5
1. Improved the monitoring of mobile phone search.

## 1.2.6
1. Optimize parameter judgment of iOS connection method.

## 1.2.7
1. Optimize the method of the alarm clock.

## 1.2.8
1. Fixed the issue of incorrect assignment of motion data on the iOS side.

## 1.2.9
1. Fix the problem of being unable to upload contacts.

## 1.2.10
1. Fix the problem that queryDisplayTime cannot be used.

## 1.2.11
1. Fix the issue of incorrect transmission object of real-time heart rate on the iOS side. 

## 1.2.12
1. Fixed the RTK error reporting information that occasionally occurred on Android.

## 1.2.13
1. Add the check whether the connection is already established before connecting on Android.

## 1.2.14
1. Modify the callback field of 24-hour heart rate;
2. Optimize the null exception reported by eventSink.

## 1.2.15
1. Fix the issue of incorrect sleep data type.

## 1.2.16
1. The type of sleep data on the iOS side corresponds to the type of Flutter, both being Int. 

## 1.2.17
1. New sendWatchFaceBackground stamp, self-defined table background rotation.

## 1.2.18
1. queryTrainingHeartRate Filter data.

## 1.2.19
1. Filter the invalid data in the sports data.

## 1.2.20
1、 Adapt to flutter sdk 3.24.5 (Note: This version is only adapted to sdk, demo has not been updated synchronously, and will be updated later).

## 1.2.21
1、Improve the acquisition of all-day heart rate and all-day stress data.

## 1.2.22
1、iOS terminal adapts to SiFli platform to obtain historical data of steps and sleep.