//
//  TrainBeanModel.swift
//  moyoung_ble_plugin
//
//  Created by 魔样科技 on 2023/11/21.
//

import Foundation
import HandyJSON

struct TrainBeanModel: HandyJSON {
    var historyTrainList: [HistoryTrainListModel] = []
    var trainingList: [TrainingInfoModel] = []
    var type: Int = 0
}

struct TrainingInfoModel: HandyJSON {
    var type: Int = -1
    var startTime: Int = 0
    var endTime: Int = 0
    var validTime: Int = 0
    var steps: Int = 0
    var distance: Int = 0
    var calories: Int = 0
    var hrList: [Int] = []
}


struct HistoryTrainListModel: HandyJSON {
    var type: Int = -1
    var startTime: Int = 0
    var id: Int = 0
}
