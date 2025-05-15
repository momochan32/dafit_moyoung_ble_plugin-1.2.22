//
//  CalendarEventSinkStreamHandler.swift
//  moyoung_ble_plugin
//
//  Created by 魔样科技 on 2023/3/16.
//

import Foundation

class CalendarEventSinkStreamHandler: NSObject {
    
    /// flutter:    接收实时的计步数据的监听
    public var calendarEventSink: FlutterEventSink? = nil

}

extension CalendarEventSinkStreamHandler: FlutterStreamHandler {
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        self.calendarEventSink = events
        return nil
    }
    
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        self.calendarEventSink = nil
        return nil
    }
}
