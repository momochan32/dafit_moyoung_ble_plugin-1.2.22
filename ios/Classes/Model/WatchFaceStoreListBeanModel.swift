//
//  WatchFaceStoreListModel.swift
//  moyoung_ble_plugin
//
//  Created by 魔样科技 on 2023/11/6.
//

import Foundation
import HandyJSON

struct WatchFaceStoreListBeanModel: HandyJSON {
    var watchFaceStoreTagList: WatchFaceStoreTagListBeanModel?
    var tagId: Int = 0

}
