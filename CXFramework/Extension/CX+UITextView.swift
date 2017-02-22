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
    public func justifYText() {
        guard let text = self.text else {return}
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.justified
        
        let attributedString = NSAttributedString(string: text,
                                                  attributes: [
                                                    NSParagraphStyleAttributeName: paragraphStyle,
                                                    NSBaselineOffsetAttributeName: NSNumber(value: 0)
            ])
        
        self.attributedText = attributedString
    }
}
