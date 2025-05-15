//
//  SupportWatchFaceBeanModel.swift
//  moyoung_ble_plugin
//
//  Created by 魔样科技 on 2023/11/6.
//

import Foundation
import HandyJSON

struct SupportWatchFaceBeanModel: HandyJSON {
    var type: String = ""
    var supportWatchFaceInfo: SupportWatchFaceInfoModel = SupportWatchFaceInfoModel()
    var sifliSupportWatchFaceInfo: SifliSupportWatchFaceInfoModel = SifliSupportWatchFaceInfoModel()
    var jieliSupportWatchFaceInfo: JieliSupportWatchFaceInfoModel = JieliSupportWatchFaceInfoModel()
}

struct SupportWatchFaceInfoModel: HandyJSON {
    var displayWatchFace: Int = 0
    var supportWatchFaceList: [Int] = []
}

struct SifliSupportWatchFaceInfoModel: HandyJSON {
    var typeList: [Int] = []
    var list: [SifliWatchFaceModel] = []
}

struct JieliSupportWatchFaceInfoModel: HandyJSON {
    var displayWatchFace: Int = 0
    var watchFaceMaxSize: Int = 0
    var supportTypeList: [Int] = []
}

struct SifliWatchFaceModel: HandyJSON {
    var id: Int = 0
    var state: String = ""
}


