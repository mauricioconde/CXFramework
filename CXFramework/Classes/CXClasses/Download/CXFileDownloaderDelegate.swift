//
//  CXFileDownloaderDelegate.swift
//  MCXFramework
//
//  Created by Mauricio Conde on 14/06/16.
//  Copyright © 2016 Mauricio Conde. All rights reserved.
//

import Foundation

@objc public protocol CXFileDownloaderDelegate {
    /// Tells the delegate that the download for a single file
    /// has been started or paused
    ///
    /// - parameters:
    ///     - fdi: The CXFileDownloadInfo object associated with the download task
    ///     - didStartOrPauseDownloadingFile: if true indicates the download process
    ///             has been started otherwise the process has been paused
    ///     - index: The index of the 'CXFileDownloadInfo' object in the
    ///             array of Downloading files
    ///     - status: A constant inidating the status of the process. If one error occurs,
    ///     it is informed through this parameter
    func cxFileDownloader(_ fdi: CXFileDownloadInfo?,
                          didStartOrPauseDownloadingFile: Bool,
                          index: Int,
                          status: CXDownloadInformer)
    
    /// Tells the delegate that the download for a single file
    /// has been cancelled
    ///
    /// - parameters:k
    ///     - fdi: The CXFileDownloadInfo object associated with the download tas
    ///     - didStopDownloadingFile: Indicates if the download was cancelled
    ///     - index: The index of the 'CXFileDownloadInfo' object in the
    ///             array of Downloading files
    ///     - status: A constant inidating the status of the process. If one error occurs,
    ///     it is informed through this parameter
    func cxFileDownloader(_ fdi: CXFileDownloadInfo?,
                                   didStopDownloadingFile: Bool,
                                   index: Int,
                                   status: CXDownloadInformer)
    
    /// Tells the delegate that all associated downloads has been started
    ///
    /// - parameters:
    ///     - fdiArr: The array of 'CXFileDownloadInfo' associated with the downloads
    //      - didStartAllDownloads: Boolean value which indicates if all downloads has been started
    func cxFileDownloader(_ fdiArr: [CXFileDownloadInfo], didStartAllDownloads: Bool)
    
    /// Tells the delegate that all associated downloads has been cancelled
    ///
    /// - parameters:
    ///     - fdiArr: The array of 'CXFileDownloadInfo' associated with the downloads
    ///     - didStopAllDownloads: Boolean value which indicates if all downloads has been cancelled
    func cxFileDownloader(_ fdiArr: [CXFileDownloadInfo], didStopAllDownloads: Bool)
    
    /// Tells the delegate that the download progress for a single file
    /// has been updated
    ///
    /// - parameters:
    ///     - fdi: The 'CXFileDownloadInfo' object attached to the downloading file
    ///     - index: The index of the 'CXFileDownloadInfo' object inside the array of Downloads
    ///     - didUpdateDownloadProgress: The progress value
    ///     - status: A constant inidating the status of the process. If one error occurs,
    ///     it is informed through this parameter
    func cxFileDownloader(_ fdi:CXFileDownloadInfo?,
                                   index: Int,
                                   didUpdateDownloadProgress progress: Double,
                                   status: CXDownloadInformer)
    
    /// Tells the delegate the file has been downloaded and will be
    /// saved into the Documents directory.
    ///
    /// - parameters:
    ///     - didSaveFileAtDocumentsDir: Indicates if the file was saved successfully
    ///     - name: The file name
    ///     - status: The status after the file tried to be saved.If one error occurs,
    ///     it is informed through this parameter
    func cxFileDownloader(didSaveFileAtDocumentsDir saved: Bool, name: String?, status: CXDownloadInformer)
    
    /// Tells the delegate that the task finished transferring data
    /// Server errors are not reported through the error parameter. The only errors your delegate receives
    /// through the error parameter are client-side errors, such as being unable to resolve the hostname or
    /// connect to the host.
    ///
    /// - parameters: 
    ///     - fdi: The 'CXFileDownloadInfo' object attached to the downloading file
    //      - index: The index of the 'CXFileDownloadInfo' object inside the array of Downloads
    ///     - error: If an error occurred, an error object indicating how the transfer failed, otherwise NULL.
    func cxFileDownloader(_ fdi: CXFileDownloadInfo?, index: Int, didCompleteWithError error: Error?)
    
    /// Tells the delegate that all downloads are over. This delegate method is executed always in the
    /// main thread. You could use it, for example, to show a local notification to inform the user 
    /// that all download has been finished.
    func cxFileDownloaderDidFinishEventsForBackground()
    
    @objc optional func cxFileDownloader(_ didHandleError: CXDownloadInformer)
}
