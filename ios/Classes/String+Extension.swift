//
//  String+Extension.swift
//  moyoung_ble_plugin
//
//  Created by 魔样科技 on 2022/6/1.
//

import Foundation

extension String {
    
    //十六进制转十进制
    func hexToDecamail() -> Int {
        var sum: Int = 0
        let str: String = self.uppercased()
        for i in str.utf8 {
            //0-9:从48开始
            sum = sum * 16 + Int(i) - 48
            //A-Z:从65开始
            if i >= 65 {
                sum -= 7
            }
        }
        return sum
    }
    
}
