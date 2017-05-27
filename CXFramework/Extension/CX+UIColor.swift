//
//  CX+UIColor.swift
//  CXFramework
//
//  Created by Mauricio Conde on 15/02/17.
//  Copyright © 2017 Mauricio Conde Xinastle. All rights reserved.
//

import Foundation
import UIKit

public extension UIColor{
    
    public convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    /// returns a new UIColor from its **Hexadecimal** representation
    public static func cx_fromHex(str:String) -> UIColor {
        var formattedStr: String = str.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        
        if (formattedStr.hasPrefix("#")) {
            formattedStr = formattedStr.substring(from: formattedStr.index(formattedStr.startIndex, offsetBy: 1))
        }
        
        if ((formattedStr.characters.count) != 6) {
            return UIColor.gray
        }
        var rgbValue:UInt32 = 0
        Scanner(string: formattedStr).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
