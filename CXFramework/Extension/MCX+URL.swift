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
    public static func openLink(_ str:String){
        guard let strURL = str.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed),
            let url = URL(string: strURL) else {
                return
        }
        UIApplication.shared.openURL(url)
    }    
}
