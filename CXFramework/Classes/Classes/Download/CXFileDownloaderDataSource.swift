//
//  CXFileDownloaderDataSource.swift
//  MCXFramework
//
//  Created by Mauricio Conde on 14/06/16.
//  Copyright © 2016 Mauricio Conde. All rights reserved.
//

import Foundation

public protocol CXFileDownloaderDataSource {
    /// Completition handler passed to the app through the 
    /// application:handleEventsForBackgroundURLSession:completionHandler: application delegate method.
    /// The completion handler of the parameter must be stored locally in the appDelegate
    /// because it must be called when all downloads are finished so the system knows that no more background
    /// activity is required (all transfers are complete) and any reserved resources to be freed up.
    ///
    /// Of course, upon each download finish, 
    /// the URLSession:downloadTask:didFinishDownloadingToURL: delegate method is called to 
    /// do all the finishing actions, such as copying the downloaded file from the temporary location
    /// to the Documents directory.
    ///
    /// - Note:
    /// This variable must to refer to the local reference stored in the appDelegate
    var backgroundTransferCompletionHandler: (()->Void)? {get set}
    
    /// Returns an array of 'CXFileDownloadInfo' corresponding
    /// with all files that will be downloaded
    func arrayForCXFileDownloader() -> [CXFileDownloadInfo]
    
    /// Returns an identifier which uniquely identifies the session
    /// started by the app in the system.
    /// It’s not possible two sessions with the same identifier to exist at the same time.
    func sessionConfigIDForCXFileDownloader() -> String
    
    /// Indicates the maximum number of simultaneous downloads
    /// to take place at once
    func maximumConnectionsPerHostForCXFileDownloader() -> Int
    
}
