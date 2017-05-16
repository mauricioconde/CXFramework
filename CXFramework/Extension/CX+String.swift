//
//  CX+String.swift
//  CXFramework
//
//  Created by Mauricio Conde on 16/05/17.
//  Copyright © 2017 Mauricio Conde Xinastle. All rights reserved.
//

import UIKit

public extension String {
    
    /// Calculate the width of a text string of a specific font and font-size
    public func getPreferredSize(withFont font: UIFont) -> CGSize {
        return (self as NSString).size(attributes: [NSFontAttributeName: font])
    }
}
