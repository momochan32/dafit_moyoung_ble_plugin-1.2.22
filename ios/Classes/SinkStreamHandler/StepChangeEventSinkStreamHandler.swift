//
//  StepChangeEventSinkStreamHander.swift
//  moyoung_ble_plugin
//
//  Created by 魔样科技 on 2023/3/15.
//

import Foundation

class StepChangeEventSinkStreamHandler: NSObject {
    
    /// flutter:    接收实时的计步数据的监听
    public var stepChangeEventSink: FlutterEventSink? = nil

}

extension StepChangeEventSinkStreamHandler: FlutterStreamHandler {
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        self.stepChangeEventSink = events
        return nil
    }
    
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        self.stepChangeEventSink = nil
        return nil
    }
}
