//
//  ContactAvatarEventSinkStreamHandler.swift
//  moyoung_ble_plugin
//
//  Created by 魔样科技 on 2023/3/16.
//

import Foundation

class ContactAvatarEventSinkStreamHandler: NSObject {
    
    /// flutter:    接收实时的计步数据的监听
    public var contactAvatarEventSink: FlutterEventSink? = nil

}

extension ContactAvatarEventSinkStreamHandler: FlutterStreamHandler {
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        self.contactAvatarEventSink = events
        return nil
    }
    
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        self.contactAvatarEventSink = nil
        return nil
    }
}
