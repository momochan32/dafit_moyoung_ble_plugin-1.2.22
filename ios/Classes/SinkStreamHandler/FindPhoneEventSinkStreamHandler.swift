//
//  FindPhoneEventSinkStreamHandler.swift
//  moyoung_ble_plugin
//
//  Created by 魔样科技 on 2023/3/16.
//

import Foundation

class FindPhoneEventSinkStreamHandler: NSObject {
    
    /// flutter:    接收实时的计步数据的监听
    public var findPhoneEventSink: FlutterEventSink? = nil

}

extension FindPhoneEventSinkStreamHandler: FlutterStreamHandler {
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        self.findPhoneEventSink = events
        return nil
    }
    
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        self.findPhoneEventSink = nil
        return nil
    }
}
