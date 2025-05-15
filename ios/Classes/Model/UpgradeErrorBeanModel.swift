//
//  UpgradeErrorBeanModel.swift
//  moyoung_ble_plugin
//
//  Created by 魔样科技 on 2023/11/9.
//

import Foundation
import HandyJSON

struct UpgradeErrorBeanModel: HandyJSON {
    var error: Int = -1
    var errorContent: String = ""
}
