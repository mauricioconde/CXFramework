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
    public func cx_getPreferredSize(withFont font: UIFont) -> CGSize {
        return (self as NSString).size(withAttributes: convertToOptionalNSAttributedStringKeyDictionary([convertFromNSAttributedStringKey(NSAttributedString.Key.font): font]))
    }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToOptionalNSAttributedStringKeyDictionary(_ input: [String: Any]?) -> [NSAttributedString.Key: Any]? {
	guard let input = input else { return nil }
	return Dictionary(uniqueKeysWithValues: input.map { key, value in (NSAttributedString.Key(rawValue: key), value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromNSAttributedStringKey(_ input: NSAttributedString.Key) -> String {
	return input.rawValue
}
