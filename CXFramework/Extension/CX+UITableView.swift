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
    public func refreshDataAnimated(forSections: NSIndexSet? = nil) {
        let sections = forSections != nil ? forSections : NSIndexSet(index: 0)
        self.reloadSections(sections as! IndexSet, with: .automatic)
    }
}
