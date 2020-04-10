//
//  CXFileDownloader.swift
//  MCXFramework
//
//  Created by Mauricio Conde on 12/06/16.
//  Copyright © 2016 Mauricio Conde. All rights reserved.
//  inspired from: http://www.appcoda.com/background-transfer-service-ios7/

import Foundation

/// Convenient class to handle file downloads from a server
open class CXFileDownloader: NSObject, URLSessionDelegate, URLSessionDownloadDelegate{
    let INVALID_ARRAY_INDEX = -1
    let SESSION_CONFIG_ID: String
    let MAXIMUM_CONNECTIONS_PER_HOST: Int
    var session: Foundation.URLSession!
    var fileDownloadDataArr: [CXFileDownloadInfo]
    
    var dataSource: CXFileDownloaderDataSource
    public var delegate: CXFileDownloaderDelegate?
    
    
    
    
    public init(dataSource: CXFileDownloaderDataSource){
        self.dataSource              = dataSource
        SESSION_CONFIG_ID            = dataSource.sessionConfigIDForCXFileDownloader()
        MAXIMUM_CONNECTIONS_PER_HOST = dataSource.maximumConnectionsPerHostForCXFileDownloader()
        fileDownloadDataArr          = dataSource.arrayForCXFileDownloader()
        
        //Create the session configuration
        let sc = URLSessionConfiguration.background(withIdentifier: SESSION_CONFIG_ID)
        sc.httpMaximumConnectionsPerHost = MAXIMUM_CONNECTIONS_PER_HOST
        
        super.init()
        //Instantiate the session property using the sessionConfiguration object
        session = Foundation.URLSession(configuration: sc,
                               delegate: self,
                               delegateQueue: nil)
    }
    
    
    
    
    //MARK:- Class methods
    /// Starts the download process for a single file
    open func startOrPauseDownloadingFileAtIndex(_ index: Int){
        guard (index >= 0 && index < fileDownloadDataArr.count) else {
            delegate?.cxFileDownloader(nil,
                                       didStartOrPauseDownloadingFile: false,
                                       index: index,
                                       status: CXDownloadInformer.indexOutOfBounds)
            return
        }
        let fdi = fileDownloadDataArr[index]
        if !fdi.isDownloading {
            if fdi.taskId == -1 {
                //Create a new task providing the appropriate URL as the download source
                //Keep the new task identifier &
                //Start the task
                fdi.downloadTask = session.downloadTask(with: URL(string: fdi.downloadSource)!)
                fdi.taskId = fdi.downloadTask.taskIdentifier
                fdi.downloadTask.resume()
                
                //TODO check if this must to be called in the UI queue
                delegate?.cxFileDownloader(fdi,
                                            didStartOrPauseDownloadingFile: true,
                                            index: index,
                                            status: CXDownloadInformer.success)
                
            }else{
                //Resume download task
                //& keep the new download task identifier
                fdi.downloadTask = session.downloadTask(withResumeData: fdi.taskResumeData)
                fdi.downloadTask.resume()
                fdi.taskId = fdi.downloadTask.taskIdentifier
                
                //TODO check if this must to be called in the UI queue
                delegate?.cxFileDownloader(fdi,
                                            didStartOrPauseDownloadingFile: true,
                                            index: index,
                                            status: CXDownloadInformer.success)
            }
        }else{
            //Pause the task by canceling it and storing the resume data.
            fdi.downloadTask.cancel(byProducingResumeData: { (resumeData) in
                if(resumeData != nil){
                    fdi.taskResumeData = resumeData
                    
                    //TODO check if this must to be called in the UI queue
                    self.delegate?.cxFileDownloader(fdi,
                        didStartOrPauseDownloadingFile: false,
                        index: index,
                        status: CXDownloadInformer.success)
                }
            })
        }
        fdi.isDownloading = !fdi.isDownloading
    }
    
    /// Stops the download process for a single file
    open func stopDownloadingFileAtIndex(_ index: Int){
        guard (index >= 0 && index < fileDownloadDataArr.count) else {
            delegate?.cxFileDownloader(nil,
                                       didStopDownloadingFile: false,
                                       index: index,
                                       status: CXDownloadInformer.indexOutOfBounds)
            return
        }
        let fdi = fileDownloadDataArr[index]
        fdi.downloadTask.cancel()
        fdi.isDownloading = false
        fdi.taskId = -1
        fdi.downloadProgress = 0
        fdi.downloadTask = nil
        
        //TODO check if this must to be called in the UI queue
        delegate?.cxFileDownloader(fdi,
                                    didStopDownloadingFile: true,
                                    index: index,
                                    status: CXDownloadInformer.success)
        
    }
    
    /// Starts the download process for all files
    open func startAllDownloads(){
        for fdi in fileDownloadDataArr{
            if !fdi.isDownloading{
                // Check if should create a new download task using a URL, or using resume data.
                if fdi.taskId == -1 {
                    fdi.downloadTask = session.downloadTask(with: URL(string: fdi.downloadSource)!)
                }else{
                    fdi.downloadTask = session.downloadTask(withResumeData: fdi.taskResumeData)
                }
                // Keep the new taskId
                fdi.taskId = fdi.downloadTask.taskIdentifier
                // Start the download
                fdi.downloadTask.resume()
                // Indicate for each file that is being downloaded.
                fdi.isDownloading = true
            }
        }
        //TODO check if this must to be called in the UI queue
        delegate?.cxFileDownloader(fileDownloadDataArr, didStartAllDownloads: true)
    }
    
    /// Stops the download process for all files
    open func stopAllDownloads(){
        for fdi in fileDownloadDataArr{
            if fdi.isDownloading{
                fdi.downloadTask.cancel()
                fdi.isDownloading = false
                fdi.taskId = -1
                fdi.downloadProgress = 0
                fdi.downloadTask = nil
            }
        }
        //TODO check if this must to be called in the UI queue
        delegate?.cxFileDownloader(fileDownloadDataArr, didStopAllDownloads: true)
    }
    
    fileprivate func getFileDownloadInfoIndexWithTaskID(_ taskIdenfifier: Int) -> Int{
        for (index,fdi) in fileDownloadDataArr.enumerated(){
            if(fdi.taskId == taskIdenfifier) {return index}
        }
        return INVALID_ARRAY_INDEX
    }
    
    
    
    
    // MARK:- Download delegates
    // Get the download progress
    @objc open func urlSession(_ session: URLSession,
                                 downloadTask: URLSessionDownloadTask,
                                 didWriteData bytesWritten: Int64,
                                              totalBytesWritten: Int64,
                                              totalBytesExpectedToWrite: Int64) {
        
        guard totalBytesExpectedToWrite != NSURLSessionTransferSizeUnknown else {
            //Unknow transfer size
            DispatchQueue.main.async(execute: { 
                self.delegate?.cxFileDownloader(nil,
                    index: self.INVALID_ARRAY_INDEX,
                    didUpdateDownloadProgress: 0.0,
                    status: CXDownloadInformer.unknownTransferSize)
            })
            return
        }
        
        //Locate the FileDownloadInfo object among all based on the taskIdentifier property of the task.
        let index = getFileDownloadInfoIndexWithTaskID(downloadTask.taskIdentifier)
        guard index != INVALID_ARRAY_INDEX else {
            //Cant retrieve CXDownloadFileInfo object
            DispatchQueue.main.async(execute: {
                self.delegate?.cxFileDownloader(nil,
                    index: self.INVALID_ARRAY_INDEX,
                    didUpdateDownloadProgress: 0.0,
                    status: CXDownloadInformer.unknowCXDownloadFileInfo)
            })
            return
        }
        
        let fdi = fileDownloadDataArr[index]
        DispatchQueue.main.async {
            fdi.downloadProgress = Double(totalBytesWritten) / Double(totalBytesExpectedToWrite)
            self.delegate?.cxFileDownloader(fdi,
                                             index: index,
                                             didUpdateDownloadProgress: fdi.downloadProgress,
                                             status: CXDownloadInformer.success)
        }
    }
    
    // Save file when Download has finished in the Documents directory
    @objc open func urlSession(_ session: URLSession,
                                 downloadTask: URLSessionDownloadTask,
                                 didFinishDownloadingTo location: URL) {
        
        let fileManager = FileManager()
        guard let destinationFileName = downloadTask.originalRequest?.url?.lastPathComponent else{
            //Cant save the file because
            //cant retrieve the destination file name
            DispatchQueue.main.async(execute: {
                self.delegate?.cxFileDownloader(didSaveFileAtDocumentsDir: false,
                    name: nil,
                    status: CXDownloadInformer.unknowDestinationFileName)
            })
            return
        }
        
        let destinationURL = URL(string:CXDataStorage.pathForFileAtDocumentsDirectory(destinationFileName))
        if fileManager.fileExists(atPath: destinationURL!.path){
            do{ try fileManager.removeItem(at: destinationURL!) }
            catch{
                //Cant save the file. because
                //there is another file with the same name
                DispatchQueue.main.async(execute: {
                    self.delegate?.cxFileDownloader(didSaveFileAtDocumentsDir: false,
                        name: nil,
                        status: CXDownloadInformer.fileNameExists)
                })
                return
            }
        }
        
        let index = getFileDownloadInfoIndexWithTaskID(downloadTask.taskIdentifier)
        if (try? fileManager.copyItem(at: location, to: destinationURL!)) != nil && index > 0{
            let fdi = fileDownloadDataArr[index]
            
            fdi.isDownloading = false
            fdi.downloadComplete = true
            fdi.taskId = -1
            fdi.taskResumeData = nil
            DispatchQueue.main.async(execute: {
                DispatchQueue.main.async(execute: {
                    self.delegate?.cxFileDownloader(didSaveFileAtDocumentsDir: true,
                        name: destinationFileName,
                        status: CXDownloadInformer.success)
                })
            })
            
        }else{
            // Unable to relocate file from temp directory 
            // to the app documents dir
            DispatchQueue.main.async(execute: {
                self.delegate?.cxFileDownloader(didSaveFileAtDocumentsDir: false,
                    name: nil,
                    status: CXDownloadInformer.cantCopyFromTempDir)
            })
        }
    }
    
    @objc open func urlSession(_ session: URLSession,
                                 task: URLSessionTask,
                                 didCompleteWithError error: Error?) {
        let index = getFileDownloadInfoIndexWithTaskID(task.taskIdentifier)
        guard index != INVALID_ARRAY_INDEX else{
            delegate?.cxFileDownloader(nil, index: INVALID_ARRAY_INDEX, didCompleteWithError: error)
            return
        }
        
        if error != nil {
            print("Download completed with error")
            if let e = error?.localizedDescription {
                print(e)
            }
        }else{
            print("Download finished successfully.")
        }
        delegate?.cxFileDownloader(fileDownloadDataArr[index], index: index, didCompleteWithError: error)
    }
    
    // Called when the system has no more messages to send to our app after a background transfer
    open func urlSessionDidFinishEvents(forBackgroundURLSession session: URLSession) {
        // Check if all download tasks have been finished.
        session.getTasksWithCompletionHandler { (dataTasks, uploadTasks, downloadtasks) in
            if downloadtasks.count == 0 {
                // Copy locally the completion handler.
                guard let completitionHandler = self.dataSource.backgroundTransferCompletionHandler else {
                    return
                }
                
                // Make nil the backgroundTransferCompletionHandler
                self.dataSource.backgroundTransferCompletionHandler = nil
                
                OperationQueue.main.addOperation({ 
                    // Call the completion handler to tell the system that there are no other background transfers
                    // it always must to take place in the main thread
                    completitionHandler()
                    
                    // Tell the delegate all downloads are over
                    self.delegate?.cxFileDownloaderDidFinishEventsForBackground()
                })
            }
        }
    }
    
    
}
