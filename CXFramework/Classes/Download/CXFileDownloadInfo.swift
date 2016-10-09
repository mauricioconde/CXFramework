//
//  CXFileDownloadInfo.swift
//  MCXFramework
//
//  Created by Mauricio Conde on 06/06/16.
//  Copyright © 2016 Mauricio Conde. All rights reserved.
//


/// Class that helps keep vital data about download file throughout a project
open class CXFileDownloadInfo: NSObject {
    /// Constant to indicates an invalid download task identifier
    public static let INVALID_TASK_ID = -1
    
    /// Keeps a title describing the file to be downloaded (not the file name)
    public var fileTitle: String!
    
    /// The URL source where a file should be downloaded from as a String object
    public var downloadSource: String!
    
    /// A NSURLSessionDownloadTask object that will be used to keep a strong reference to the download task of a file
    public var downloadTask: URLSessionDownloadTask!
    
    /// A NSData object that keeps the data produced by a cancelled download task that can be resumed at a later time
    /// (in other words, when it’s paused)
    public var taskResumeData: Data!
    
    /// The download progress of a file as reported by the NSURLSession delegate methods
    public var downloadProgress: Double
    
    /// Indicates whether a file is being downloaded or not
    public var isDownloading: Bool
    
    /// Indicates whether a file download has been completed
    public var downloadComplete: Bool
    
    /// When a download task is initiated, the NSURLSession sssigns it a unique identifier
    /// so it can be distinguished among others. The identifier values start from 0. This property
    /// is used to assign the task identifier value of the downloadTask property (even though the
    /// downloadTask object has its own taskIdentifier property)
    public var taskId: Int
    
    
    
    
    
    /// Creates a new CXFileDownloadInfo object 
    /// with a file title and the download url (as String)
    ///
    /// - parameters: 
    ///     - fileTitle: The file title describing the file to be downloaded
    ///     - downloadSource: The URL source where a file should be downloaded from 
    public init(fileTitle: String, downloadSource: String){
        self.fileTitle = fileTitle
        self.downloadSource = downloadSource
        self.downloadProgress = 0.0
        self.isDownloading = false
        self.downloadComplete = false
        self.taskId = CXFileDownloadInfo.INVALID_TASK_ID
    }
}
