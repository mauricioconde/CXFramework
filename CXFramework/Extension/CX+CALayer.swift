//
//  CX+CALayer.swift
//  CXFramework
//
//  Created by Mauricio Conde on 22/02/17.
//  Copyright © 2017 Mauricio Conde Xinastle. All rights reserved.
//

import Foundation
import UIKit
/*
 To set border &/or shadow through Interface Builder:
 - In the 'user-defined runtime attributes' section (Identity inspector)
 - Make sure the UIView is selected, and add the following runtime attributes:
 + layer.borderWidth, Number, 1
 + layer.borderIBColor, Color, someColor
 + layer.shadowIBColor, Color, someColor
 + layer.shadowOpacity, Number, 0.8
 + layer.shadowOffset, size, {5,5}
 + layer.cornerRadius, Number, 5
 */
public extension CALayer {
    public func setBorderIBColor(color:UIColor){
        self.borderColor = color.cgColor
    }
    
    public func borderIBColor()->UIColor{
        return UIColor(cgColor: self.borderColor!)
    }
    
    public func setShadowIBColor(color:UIColor){
        self.shadowColor = color.cgColor
    }
    public func shadowIBColor()->UIColor{
        return UIColor(cgColor: self.shadowColor!)
    }
}
