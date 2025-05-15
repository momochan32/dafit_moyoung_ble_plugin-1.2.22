import 'dart:async';

import 'package:flutter/services.dart';
import 'package:moyoung_ble_plugin/impl/channel_names.dart';
import 'package:moyoung_ble_plugin/impl/moyoung_beans.dart';

class MYEventStreams {
  Stream<BleScanBean> get bleScanEveStm {
    return const EventChannel(ChannelNames.eventScanDevice)
        .receiveBroadcastStream()
        .map((dynamic event) {
      return bleScanBeanFromJson(event.toString());
    });
  }

  Stream<ConnectStateBean> get stateEveStm {
    return const EventChannel(ChannelNames.eventConnectionState)
        .receiveBroadcastStream()
        .map((dynamic event) {
      return connectStateBeanFromJson(event);
    });
  }

  Stream<StepsChangeBean> get stepsChangeEveStm {
    return const EventChannel(ChannelNames.eventStepsChange)
        .receiveBroadcastStream()
        .map((dynamic event) {
      // if (event is int) {
      //   return StepsChangeBean(
      //       stepsInfo: StepsChange(calories: 0, distance: 0, steps: 0, time: 0),
      //       timeType: 0);
      // } else {
      //   return stepsChangeBeanFromJson(event.toString());
      // }
      return stepsChangeBeanFromJson(event);
    });
  }

  Stream<DeviceBatteryBean> get deviceBatteryEveStm {
    return const EventChannel(ChannelNames.eventDeviceBattery)
        .receiveBroadcastStream()
        .map((dynamic event) {
      return deviceBatteryBeanFromJson(event);
    });
  }

  Stream<WeatherChangeBean> get weatherChangeEveStm {
    return const EventChannel(ChannelNames.eventWeatherChange)
        .receiveBroadcastStream()
        .map((dynamic event) {
      return weatherChangeBeanFromJson(event);
    });
  }

  Stream<StepsDetailBean> get stepsDetailEveStm {
    return const EventChannel(ChannelNames.eventStepsDetail)
        .receiveBroadcastStream()
        .map((dynamic event) {
      StepsDetailBean stepsDetailBean = stepsDetailBeanFromJson(event);
      /// 这里需要把步数大于10000的数替换成0
      for(var i = 0; i < stepsDetailBean.stepsCategoryInfo!.stepsList!.length; i++) {
        if (stepsDetailBean.stepsCategoryInfo!.stepsList![i] >= 10000) {
          stepsDetailBean.stepsCategoryInfo!.stepsList![i] = 0;
        }
      }
      return stepsDetailBean;
    });
  }

  Stream<SleepBean> get sleepChangeEveStm {
    return const EventChannel(ChannelNames.eventSleepChange)
        .receiveBroadcastStream()
        .map((dynamic event) {
      return sleepBeanFromJson(event);
    });
  }

  Stream<OTABean> get oTAEveStm {
    return const EventChannel(ChannelNames.eventOTA)
        .receiveBroadcastStream()
        .map((dynamic event) {
      return oTABeanFromJson(event);
    });
  }

  Stream<HeartRateBean> get heartRateEveStm {
    return const EventChannel(ChannelNames.eventHeartRate)
        .receiveBroadcastStream()
        .map((dynamic event) {
      return heartRateBeanFromJson(event);
    });
  }

  Stream<BloodPressureBean> get bloodPressureEveStm {
    return const EventChannel(ChannelNames.eventBloodPressure)
        .receiveBroadcastStream()
        .map((dynamic event) {
      return bloodPressureBeanFromJson(event);
    });
  }

  Stream<BloodOxygenBean> get bloodOxygenEveStm {
    return const EventChannel(ChannelNames.eventBloodOxyGen)
        .receiveBroadcastStream()
        .map((dynamic event) {
      return bloodOxygenBeanFromJson(event);
    });
  }

  Stream<CameraBean> get cameraEveStm {
    return const EventChannel(ChannelNames.eventBloodOxygen)
        .receiveBroadcastStream()
        .map((dynamic event) {
      return cameraBeanFromJson(event);
    });
  }

  Stream<int> get phoneEveStm {
    return const EventChannel(ChannelNames.eventPhone)
        .receiveBroadcastStream()
        .map((dynamic event) {
      return event;
    });
  }

  Stream<int> get deviceRssiEveStm {
    return const EventChannel(ChannelNames.eventDeviceRssi)
        .receiveBroadcastStream()
        .map((dynamic event) {
      return event;
    });
  }

  Stream<FileTransBean> get fileTransEveStm {
    return const EventChannel(ChannelNames.eventFileTrans)
        .receiveBroadcastStream()
        .map((dynamic event) {
      return fileTransBeanFromJson(event);
    });
  }

  Stream<FileTransBean> get wfFileTransEveStm {
    return const EventChannel(ChannelNames.eventWFFileTrans)
        .receiveBroadcastStream()
        .map((dynamic event) {
      // FileTransBean a = fileTransBeanFromJson(event);
      // print("Flutter接收到了文件传输回调，回调进度是：${a.progress}，回调的状态是：${a.type}");
      return fileTransBeanFromJson(event);
    });
  }

  Stream<EcgBean> get ecgEveStm {
    return const EventChannel(ChannelNames.eventEcg)
        .receiveBroadcastStream()
        .map((dynamic event) {
      return ecgBeanFromJson(event);
    });
  }

  Stream<FileTransBean> get tactAvatarEveStm {
    return const EventChannel(ChannelNames.eventContactAvatar)
        .receiveBroadcastStream()
        .map((dynamic event) {
      return fileTransBeanFromJson(event);
    });
  }

  Stream<String> get callNumberEveStm {
    return const EventChannel(ChannelNames.eventCallNumber)
        .receiveBroadcastStream()
        .map((dynamic event) {
      return event;
    });
  }

  Stream<FindPhoneBean> get findPhoneEveStm {
    return const EventChannel(ChannelNames.eventFindPhone)
        .receiveBroadcastStream()
        .map((dynamic event) {
      return findPhoneBeanFromJson(event);
    });
  }

  Stream<int> get trainingStateEveStm {
    return const EventChannel(ChannelNames.eventTrainingState)
        .receiveBroadcastStream()
        .map((dynamic event) {
      return event;
    });
  }

  Stream<TempChangeBean> get tempChangeEveStm {
    return const EventChannel(ChannelNames.eventTempChange)
        .receiveBroadcastStream()
        .map((dynamic event) {
      return tempChangeBeanFromJson(event);
    });
  }

  Stream<ContactListenBean> get tactEveStm {
    return const EventChannel(ChannelNames.eventContact)
        .receiveBroadcastStream()
        .map((dynamic event) {
      return contactListenBeanFromJson(event);
    });
  }

  Stream<bool> get batterySavingEveStm {
    return const EventChannel(ChannelNames.eventBatterySaving)
        .receiveBroadcastStream()
        .map((dynamic event) {
      return event;
    });
  }

  Stream<TrainBean> get trainingEveStm {
    return const EventChannel(ChannelNames.eventTrain)
        .receiveBroadcastStream()
        .map((dynamic event) {
          TrainBean trainBean = trainBeanFromJson(event);
      return trainBean;
    });
  }

  Stream<dynamic> get sosChangeEveStm {
    return const EventChannel(ChannelNames.eventSosChange)
        .receiveBroadcastStream()
        .map((dynamic event) {
      return event;
    });
  }

  Stream<HrvHandlerBean> get newHrvEveStm {
    return const EventChannel(ChannelNames.eventNewHrv)
        .receiveBroadcastStream()
        .map((dynamic event) {
      return hrvHandlerBeanFromJson(event);
    });
  }

  Stream<StressHandlerBean> get stressEveStm {
    return const EventChannel(ChannelNames.eventStress)
        .receiveBroadcastStream()
        .map((dynamic event) {
      return stressHandlerBeanFromJson(event);
    });
  }

  Stream<CalendarEventBean> get calendarEventEveStem {
    return const EventChannel(ChannelNames.eventCalendarEvent)
        .receiveBroadcastStream()
        .map((dynamic event) {
      return calendarEventBeanFromJson(event);
    });
  }

  Stream<int> get gpsChangeEveStm {
    return const EventChannel(ChannelNames.eventGpsChangeEvent)
        .receiveBroadcastStream()
        .map((dynamic event) {
      return 1;
    });
  }
}
