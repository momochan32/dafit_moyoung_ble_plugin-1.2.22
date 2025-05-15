//
//  WatchFaceStoreTypeBeanModel.swift
//  moyoung_ble_plugin
//
//  Created by 魔样科技 on 2023/11/6.
//

import Foundation
import HandyJSON

struct WatchFaceStoreTypeBeanModel: HandyJSON {
    var storeType: String = ""
    var id: Int = 0
    var firmwareVersion: String = ""
    var apiVersion: Int = 0
    var feature: Int = 0
    var maxSize: Int = 0
}
