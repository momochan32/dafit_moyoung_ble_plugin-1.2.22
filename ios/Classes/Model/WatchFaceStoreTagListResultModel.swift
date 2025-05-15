//
//  WatchFaceStoreTagListResultModel.swift
//  moyoung_ble_plugin
//
//  Created by 魔样科技 on 2023/11/8.
//

import Foundation
import HandyJSON

struct WatchFaceStoreTagListResultModel: HandyJSON {
    var list: [WatchFaceStoreTagInfoModel] = []
    var error: String = ""
}

struct WatchFaceStoreTagInfoModel: HandyJSON {
    var tagId: Int = -1
    var tagName: String = ""
    var list: [WatchFaceStoreItemModel] = []
}

struct WatchFaceStoreItemModel: HandyJSON {
    var id: Int = -1
    var name: String = ""
    var size: Int = -1
    var download: Int = -1
    var preview: String = ""
}
