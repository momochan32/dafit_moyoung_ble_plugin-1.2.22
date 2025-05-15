//
//  OTAResultModel.swift
//  moyoung_ble_plugin
//
//  Created by 魔样科技 on 2023/11/9.
//

import Foundation
import HandyJSON

struct OTAResultModel: HandyJSON {
    var type: Int = -1
    var upgradeProgress: Int = -1
    var start: Bool = false
    var upgradeError: UpgradeErrorBeanModel = UpgradeErrorBeanModel()
}
