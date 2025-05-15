//
//  WatchFaceStoreResultModel.swift
//  moyoung_ble_plugin
//
//  Created by 魔样科技 on 2023/11/6.
//

import Foundation
import HandyJSON

struct WatchFaceStoreResultBeanModel: HandyJSON {
    var watchFaceStoreInfo: watchFaceStoreInfoBeanModel?
    var error: String = ""

}

struct watchFaceStoreInfoBeanModel: HandyJSON {
    var total: Int = 0
    var prePage: Int = 0
    var pageIndex: Int = 0
    var list: [WatchFaceBeanModel]?

}

struct WatchFaceBeanModel: HandyJSON {
    var id: Int = 0
    var preview: String = ""
    var file: String = ""

}
