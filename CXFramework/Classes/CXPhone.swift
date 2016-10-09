//
//  Phone.swift
//  MCXFramework
//
//  Created by Mauricio Conde on 21/05/16.
//  Copyright © 2016 Mauricio Conde. All rights reserved.
//

import Foundation

/// Useful class to handle phone related tasks 
public class CXPhone {
    
    ///---
    /// Enables make a phone call through a phone app
    ///
    /// - parameters: 
    ///     - phone: The phone number
    public class func callNumber(_ phone:String){
        let phoneUrl = "tel://" + phone.replacingOccurrences(of: " ", with: "", options: NSString.CompareOptions.literal, range: nil)
        UIApplication.shared.openURL(URL(string: phoneUrl)!)
        
    }
}
