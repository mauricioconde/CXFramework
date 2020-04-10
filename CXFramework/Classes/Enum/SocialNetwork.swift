//
//  SocialNetwork.swift
//  MCXFramework
//
//  Created by Mauricio Conde on 02/06/16.
//  Copyright © 2016 Mauricio Conde. All rights reserved.
//

/// Convenient enum to open social networks profiles
public enum SocialNetwork {
    case facebook, twitter, googlePlus, instagram
    
    /// builds the appropriate url for the social network
    ///
    /// - parameters:
    ///     - schemeId: The user page Id for the app scheme
    ///     - pageId: The user page Id for the http link
    ///
    ///**Note** Go to https://graph.facebook.com/PageName to get your facebook page id
    public func openPage(_ schemeId: String, pageId: String){
        switch self {
        case .facebook:
            openLink(String(format: "fb://profile/%@",schemeId),
                     page: String(format: "https://www.facebook.com/%@", pageId))
            return
        case .twitter:
            openLink(String(format: "twitter:///user?screen_name=%@",schemeId),
                     page: String(format: "https://twitter.com/%@", pageId))
            return
        case .googlePlus:
            openLink(String(format: "gplus://plus.google.com/u/0/%@",schemeId),
                     page: String(format: "https://plus.google.com/%@", pageId))
            return
        case .instagram:
            openLink(String(format: "instagram://user?username=%@",schemeId),
                     page: String(format: "https://www.instagram.com/%@", pageId))
            return
        }
    }
    
    /// Open a user perfil page in the corresponding app if it is installed on the device
    /// or in the phone browser if it is not
    ///
    /// - parameters:
    ///     - scheme: The user page id for the scheme url format
    ///     - page: The user page id for the url
    fileprivate func openLink(_ scheme: String, page: String){
        let nsurl = URL(string:scheme.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)!
        if UIApplication.shared.canOpenURL(nsurl) {
            URL.cx_openLink(scheme)
        }else{
            URL.cx_openLink(page)
        }
    }
}
