//
//  CX+UITableView.swift
//  CXFramework
//
//  Created by Mauricio Conde on 07/05/17.
//  Copyright © 2017 Mauricio Conde Xinastle. All rights reserved.
//

import UIKit

public extension UITableView {
    
    /// Refresh the tableview sections
    public func cx_refreshDataAnimated(forSections: NSIndexSet? = nil) {
        let sections = forSections != nil ? forSections : NSIndexSet(index: 0)
        self.reloadSections(sections as! IndexSet, with: .automatic)
    }
    
    /// Configures a refresh control for this tableview
    ///
    /// - Parameters:
    ///     - title: The title to display
    ///     - color: The color for the indicator and title
    ///     - font: The font to use for the title
    ///     - target: The object that receives the action message.
    ///     - action: The action to send to target when the refresh control is active
    public func cx_configureRefreshCtrlWith(title: String,
                                            color: UIColor,
                                            font: UIFont? = nil,
                                            target: AnyObject,
                                            and action: Selector) -> UIRefreshControl {
        
        let theFont = font != nil ? font! : UIFont.systemFont(ofSize: 12.0)
        let attributes = [convertFromNSAttributedStringKey(NSAttributedString.Key.foregroundColor): color,
                          convertFromNSAttributedStringKey(NSAttributedString.Key.font): theFont]
        let refreshCntrl = UIRefreshControl()
        refreshCntrl.addTarget(target,
                               action: action,
                               for: UIControl.Event.valueChanged)
        refreshCntrl.attributedTitle = NSAttributedString(string: title, attributes: convertToOptionalNSAttributedStringKeyDictionary(attributes))
        refreshCntrl.tintColor = color
        self.addSubview(refreshCntrl)
        return refreshCntrl
    }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromNSAttributedStringKey(_ input: NSAttributedString.Key) -> String {
	return input.rawValue
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToOptionalNSAttributedStringKeyDictionary(_ input: [String: Any]?) -> [NSAttributedString.Key: Any]? {
	guard let input = input else { return nil }
	return Dictionary(uniqueKeysWithValues: input.map { key, value in (NSAttributedString.Key(rawValue: key), value)})
}
