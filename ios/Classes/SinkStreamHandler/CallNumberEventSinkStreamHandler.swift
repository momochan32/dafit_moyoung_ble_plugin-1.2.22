//
//  CallNumberEventSinkStreamHandler.swift
//  moyoung_ble_plugin
//
//  Created by 魔样科技 on 2023/3/16.
//

import Foundation

class CallNumberEventSinkStreamHandler: NSObject {
    
    /// flutter:    接收实时的计步数据的监听
    public var callNumberEventSink: FlutterEventSink? = nil

}

extension CallNumberEventSinkStreamHandler: FlutterStreamHandler {
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        self.callNumberEventSink = events
        return nil
    }
    
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        self.callNumberEventSink = nil
        return nil
    }
}
