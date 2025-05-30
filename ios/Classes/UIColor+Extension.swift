//
//  UIColor+Extension.swift
//  moyoung_ble_plugin
//
//  Created by 魔样科技 on 2022/6/1.
//

import Foundation

extension UIColor {
    
    //Hex String -> UIColor
    
    convenience init(hexString: String) {
        let hexString = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
        let scanner = Scanner (string: hexString)
        
        if hexString.hasPrefix("#") {
        scanner.scanLocation = 1
        }
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        
        let mask = 0x000000FF
        let r = Int (color >> 16) & mask
        let g = Int (color >> 8) & mask
        let b = Int(color) & mask
        
        let red = CGFloat(r) / 255.0
        let green = CGFloat (g) / 255.0
        let blue = CGFloat (b) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: 1)
    }
    
    //UIColor -> hex string
    var hexString: String? {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        let multiplier = CGFloat(255.000000)
        
        guard self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) else {
            return nil
        }
        
        if alpha == 1.0 {
            return String(
                format: "%02x%02x%02x",
                Int (red * multiplier),
                Int (green * multiplier),
                Int (blue * multiplier)
            )
        }
        else {
            return String(
                format: "%02x%02x%02x%02x",
                Int(red * multiplier),
                Int(green * multiplier),
                Int(blue * multiplier),
                Int(alpha * multiplier)
            )
        }
    }
}
