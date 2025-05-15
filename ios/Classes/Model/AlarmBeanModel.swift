//
//  AlarmBeanModel.swift
//  moyoung_ble_plugin
//
//  Created by 魔样科技 on 2024/3/1.
//

import UIKit
import HandyJSON

struct AlarmBeanModel: HandyJSON {
    var list: [AlarmInfoModel] = []
    var isNew: Bool = false
}

struct AlarmInfoModel: HandyJSON {
    var id: Int = -1
    var enable: Bool = false
    var hour: Int = 0
    var minute: Int = 0
    var repeatMode: Int = 0
}
