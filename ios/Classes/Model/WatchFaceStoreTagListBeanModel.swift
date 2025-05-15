//
//  WatchFaceStoreTagListModel.swift
//  bluetooth_enable_fork
//
//  Created by 魔样科技 on 2023/11/6.
//

import Foundation
import HandyJSON

struct WatchFaceStoreTagListBeanModel: HandyJSON {
    var storeType: String = ""
    var typeList: [Int] = []
    var firmwareVersion: String = ""
    var perPageCount: Int = 0
    var pageIndex: Int = 0
    var maxSize: Int = 0
    var apiVersion: Int = 0
    var feature: Int = 0

}
