//
//  CX+IUTextField.swift
//  CXFramework
//
//  Created by Mauricio Conde on 16/05/17.
//  Copyright © 2017 Mauricio Conde Xinastle. All rights reserved.
//

import UIKit

public extension UITextField {
    
    /// Adds a toolbar with a done button
    ///
    /// - paramegters:
    ///     - title: The title for the **done** button
    ///     - tintColor: The buttton tint color
    ///     - andAction: The action to be performed once the **done** button is tapped
    public func cx_addDoneToolBarWith(title: String, tintColor: UIColor? = nil, andAction action: Selector){
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        
        if tintColor != nil {
            toolBar.tintColor = tintColor!
        }
        
        let doneButton = UIBarButtonItem(title: title,
                                         style: UIBarButtonItemStyle.done,
                                         target: self,
                                         action: action)
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace,
                                          target: nil,
                                          action: nil)
        toolBar.setItems([doneButton,spaceButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        toolBar.sizeToFit()
        
        self.inputAccessoryView = toolBar
    }
}
