//
//  NSURL.swift
//  MCXFramework
//
//  Created by Mauricio Conde on 21/05/16.
//  Copyright © 2016 Mauricio Conde. All rights reserved.
//

import Foundation

public extension URL {    
    /// Opens the specified link into the phone's browser
    ///
    /// - parameters: 
    ///     - url: The URL link
    public static func openLink(_ url:String){
        let nsurl = URL(string:url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)!
        UIApplication.shared.openURL(nsurl)
        
    }    
}
