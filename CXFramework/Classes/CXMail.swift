//
//  Mail.swift
//  MCXFramework
//
//  Created by Mauricio Conde on 21/05/16.
//  Copyright © 2016 Mauricio Conde. All rights reserved.
//

import Foundation

/// Useful class to handle mail related tasks 
public class CXMail {
    
    ///---
    /// Invoke the actions needed to send an email
    ///
    /// - parameters:
    ///     - url: The email URL
    public class func sendMail(_ url:String){
        let stringURL: NSString = "mailto:\(url)" as NSString;
        let url: URL = URL(string: stringURL as String)!
        UIApplication.shared.openURL(url)
    }
    
    ///---
    /// Check if the provided email is a valid one
    ///
    /// - parameters:
    ///     - email: The email to be verified
    ///
    /// - returns: A boolean value which indicates either is a valid email or is invalid
    class open func isValidEmail(_ email:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        return emailTest.evaluate(with: email)
        
    }
}
