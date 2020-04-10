//
//  CX+UITextView.swift
//  CXFramework
//
//  Created by Mauricio Conde on 22/02/17.
//  Copyright © 2017 Mauricio Conde Xinastle. All rights reserved.
//

import Foundation

public extension UITextView {
    
    /// Justifies the text only if the UILabel already has a text otherwise no action is performed
    public func cx_justifYText() {
        guard let text = self.text else {return}
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.justified
        
        let attributedString = NSAttributedString(string: text,
                                                  attributes: convertToOptionalNSAttributedStringKeyDictionary([
                                                    convertFromNSAttributedStringKey(NSAttributedString.Key.paragraphStyle): paragraphStyle,
                                                    convertFromNSAttributedStringKey(NSAttributedString.Key.baselineOffset): NSNumber(value: 0)
            ]))
        
        self.attributedText = attributedString
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
