//
//  WatchFaceDetailResultBeanModel.swift
//  moyoung_ble_plugin
//
//  Created by 魔样科技 on 2023/11/6.
//

import Foundation
import HandyJSON

struct WatchFaceDetailResultBeanModel: HandyJSON {
    var error : String = ""
    var watchFaceDetailsInfo: WatchFaceDetailsBeanModel?
    var watchFaceBean: WatchFaceBeanModel?
}


struct WatchFaceDetailsBeanModel: HandyJSON {
    var id: Int = 0
    var name: String = ""
    var download: Int = 0
    var size: Int = 0
    var file: String = ""
    var preview: String = ""
    var remarkCn: String = ""
    var remarkEn: String = ""
    var recommendWatchFaceList: [RecommendWatchFaceBeanModel] = []
}

struct RecommendWatchFaceBeanModel: HandyJSON {
    var id: Int = 0
    var name: String = ""
    var size: Int = 0
    var preview: String = ""
}

