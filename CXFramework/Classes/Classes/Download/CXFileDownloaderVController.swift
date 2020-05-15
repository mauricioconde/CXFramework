//
//  CXFileDownloaderVController.swift
//  MCXFramework
//
//  Created by Mauricio Conde on 12/06/16.
//  Copyright © 2016 Mauricio Conde. All rights reserved.
//  inspired from: http://www.appcoda.com/background-transfer-service-ios7/
//  https://www.raywenderlich.com/158106/urlsession-tutorial-getting-started


import Foundation
import UIKit


/// Convenient class to handle file downloads from a server
open class CXFileDownloaderVController: UIViewController, URLSessionDelegate, URLSessionDownloadDelegate {
    public var cxDownloadDelegate: CXFileDownloaderDelegate?
    var downloadSession: URLSession!
    
    // MARK:- Lifecycle
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        //Create the session configuration
        let sc = URLSessionConfiguration.background(withIdentifier: sessionConfigID)
        sc.httpMaximumConnectionsPerHost = MAXIMUM_CONNECTIONS_PER_HOST
        
        //Instantiate the session property using the sessionConfiguration object
        downloadSession = URLSession(configuration: sc, delegate: self, delegateQueue: nil)
        
        print("    * Download task configured with id: \(sessionConfigID)")
    }
    
    
    // MARK:- Keys
    
    public struct Keys {
        static let INVALID_ARRAY_INDEX = -1
    }
    
    // MARK:- Computing properties
    
    open var MAXIMUM_CONNECTIONS_PER_HOST: Int {
        return 1
    }
    
    open var downloadFiles: [CXFileDownloadInfo] {
        return []
    }
    
    open var sessionConfigID: String {
        return  Date().cx_toMillisAsStr
    }
    
    // MARK:- Actions
    
    /// Starts the download process for a single file
    open func startOrPauseDownloadingFileAtIndex(_ index: Int) {
        guard index >= 0 && index < downloadFiles.count else {
            return
        }
        
        let fdi = downloadFiles[index]
        
        if !fdi.isDownloading {
            fdi.isDownloading = !fdi.isDownloading
            
            if fdi.taskId == CXFileDownloadInfo.INVALID_TASK_ID {
                // Create a new task providing the appropriate URL as the download source
                // Keep the new task identifier &
                // Start the task
                fdi.downloadTask = downloadSession.downloadTask(with: URL(string: fdi.downloadSource)!)
                fdi.taskId = fdi.downloadTask.taskIdentifier
                fdi.downloadTask.resume()
                
                DispatchQueue.main.async(execute: {
                    self.cxDownloadDelegate?.cxFileDownloader(fdi,
                                                              didStartOrPauseDownloadingFile: .started,
                                                              index: index,
                                                              error: nil)
                })
                
            }else{
                // Resume download task
                // & keep the new download task identifier
                fdi.downloadTask = downloadSession.downloadTask(withResumeData: fdi.taskResumeData)
                fdi.downloadTask.resume()
                fdi.taskId = fdi.downloadTask.taskIdentifier
                
                DispatchQueue.main.async(execute: {
                    self.cxDownloadDelegate?.cxFileDownloader(fdi,
                                                              didStartOrPauseDownloadingFile: .restarted,
                                                              index: index,
                                                              error: nil)
                })
            }
        } else {
            fdi.isDownloading = !fdi.isDownloading
            
            // Pause the task by cancelling it and storing the resume data.
            fdi.downloadTask.cancel(byProducingResumeData: { (resumeData) in
                if resumeData != nil {
                    fdi.taskResumeData = resumeData
                    
                    DispatchQueue.main.async(execute: {
                        self.cxDownloadDelegate?.cxFileDownloader(fdi,
                                                                  didStartOrPauseDownloadingFile: .paused,
                                                                  index: index,
                                                                  error: nil)
                    })
                }
            })
        }
    }
    
    /// Stops the download process for a single file
    open func stopDownloadingFileAtIndex(_ index: Int) {
        guard index >= 0 && index < downloadFiles.count else {
            return
        }
        
        let fdi = downloadFiles[index]
        
        fdi.downloadTask.cancel()
        fdi.isDownloading = false
        fdi.taskId = CXFileDownloadInfo.INVALID_TASK_ID
        fdi.downloadProgress = 0
        fdi.downloadTask = nil
        
        DispatchQueue.main.async(execute: {
            self.cxDownloadDelegate?.cxFileDownloader(fdi,
                                                      didStopDownloadingFile: true,
                                                      index: index,
                                                      error: nil)
        })
    }
    
    /// Starts the download process for all files
    @IBAction open func startAllDownloads() {
        for fdi in downloadFiles {
            if !fdi.isDownloading {
                // Check if should create a new download task using a URL, or using resume data.
                if fdi.taskId == CXFileDownloadInfo.INVALID_TASK_ID {
                    fdi.downloadTask = downloadSession.downloadTask(with: URL(string: fdi.downloadSource)!)
                }else{
                    fdi.downloadTask = downloadSession.downloadTask(withResumeData: fdi.taskResumeData)
                }
                // Keep the new taskId
                fdi.taskId = fdi.downloadTask.taskIdentifier
                // Start the download
                fdi.downloadTask.resume()
                // Indicate for each file that is being downloaded.
                fdi.isDownloading = true
            }
        }
        
        
        DispatchQueue.main.async(execute: {
            self.cxDownloadDelegate?.cxFileDownloader(self.downloadFiles, didStartAllDownloads: true)
        })
    }
    
    /// Stops the download process for all files
    @IBAction open func stopAllDownloads() {
        for fdi in downloadFiles {
            if fdi.isDownloading {
                fdi.downloadTask.cancel()
                fdi.isDownloading = false
                fdi.taskId = CXFileDownloadInfo.INVALID_TASK_ID
                fdi.downloadProgress = 0
                fdi.downloadTask = nil
            }
        }
        
        DispatchQueue.main.async(execute: {
            self.cxDownloadDelegate?.cxFileDownloader(self.downloadFiles, didStopAllDownloads: true)
        })
    }
    
    fileprivate func getFileDownloadInfoIndexWithTaskID(_ taskIdenfifier: Int) -> Int? {
        for (index,fdi) in downloadFiles.enumerated(){
            if fdi.taskId == taskIdenfifier {
                return index
            }
        }
        return nil
    }
    
    // MARK:- Download delegates
    
    // Get the download progress
    @objc open func urlSession(_ session: URLSession,
                                 downloadTask: URLSessionDownloadTask,
                                 didWriteData bytesWritten: Int64,
                                 totalBytesWritten: Int64,
                                 totalBytesExpectedToWrite: Int64) {
        
        // Locate the FileDownloadInfo object among all based on the taskIdentifier property of the task.
        guard let index = getFileDownloadInfoIndexWithTaskID(downloadTask.taskIdentifier) else {
            //Cant retrieve CXDownloadFileInfo object
            return
        }
        
        let fdi = downloadFiles[index]
        
        guard totalBytesExpectedToWrite != NSURLSessionTransferSizeUnknown else {
            //Unknow transfer size
            DispatchQueue.main.async {
                self.cxDownloadDelegate?.cxFileDownloader(fdi,
                                                          index: index,
                                                          didUpdateDownloadProgress: 0.0,
                                                          error: .unknownTransferSize)
            }
            return
        }
        
        DispatchQueue.main.async {
            fdi.downloadProgress = Double(totalBytesWritten) / Double(totalBytesExpectedToWrite)
            self.cxDownloadDelegate?.cxFileDownloader(fdi,
                                                      index: index,
                                                      didUpdateDownloadProgress: fdi.downloadProgress,
                                                      error: nil)
        }
    }
    
    /// Called when each download finish to do all the finishing actions,
    /// such as copying the downloaded file from the temporary location to the Documents directory
    @objc open func urlSession(_ session: URLSession,
                               downloadTask: URLSessionDownloadTask,
                               didFinishDownloadingTo location: URL) {
        
        print("    CXFileDownloader.")
        print("    * Finished downloading to \(location).")
        
        let fileManager = FileManager()
        
        guard let index = getFileDownloadInfoIndexWithTaskID(downloadTask.taskIdentifier) else {
            // Cant find the related obj in 'DownloadFiles' array
           
            print("    * Cant find the related obj in 'DownloadFiles' array")
            DispatchQueue.main.async(execute: {
                self.cxDownloadDelegate?.cxFileDownloader(didFinishDownloading: true,
                                                didSaveFileAtDocumentsDir: false,
                                                name: nil,
                                                index: CXFileDownloadInfo.INVALID_TASK_ID,
                                                status: .cantFindRelatedFile)
            })
            return
        }
        
        print("    * File internal index reference \(index).")
        
        guard let destinationFileName = downloadFiles[index].downloadSource.components(separatedBy: "/").last else {
            //Cant save the file because
            //cant retrieve the destination file name
            
            print("    * Cant retrieve the destination file name")
            DispatchQueue.main.async(execute: {
                self.cxDownloadDelegate?.cxFileDownloader(didFinishDownloading: true,
                                                didSaveFileAtDocumentsDir: false,
                                                name: nil,
                                                index: CXFileDownloadInfo.INVALID_TASK_ID,
                                                status: .unknowDestinationFileName)
            })
            return
        }
        
        print("    * Destination FileName \(destinationFileName).")
        
        let filePath = CXDataStorage.pathForFileAtDocumentsDirectory(destinationFileName)
        let destinationURL = URL(fileURLWithPath: filePath)
        
        if fileManager.fileExists(atPath: destinationURL.path) {
            do{
                try fileManager.removeItem(at: destinationURL)
            }
            catch{
                //Cant save the file. because
                //there is another file with the same name
                DispatchQueue.main.async(execute: {
                    self.cxDownloadDelegate?.cxFileDownloader(didFinishDownloading: true,
                                                    didSaveFileAtDocumentsDir: false,
                                                    name: nil,
                                                    index: CXFileDownloadInfo.INVALID_TASK_ID,
                                                    status: .fileNameExists)
                })
                return
            }
        }
        
        do {
            try fileManager.copyItem(at: location, to: destinationURL)
            
            let fdi = downloadFiles[index]
            
            fdi.isDownloading = false
            fdi.downloadComplete = true
            fdi.taskId = CXFileDownloadInfo.INVALID_TASK_ID
            fdi.taskResumeData = nil
            
            DispatchQueue.main.async(execute: {
                print("    * File copied to Docs dir \(destinationFileName).")
                
                self.cxDownloadDelegate?.cxFileDownloader(didFinishDownloading: true,
                                                didSaveFileAtDocumentsDir: true,
                                                name: destinationFileName,
                                                index: index,
                                                status: .success)
            })
            
        } catch {
            // Unable to relocate file from temp directory
            // to the app documents dir
            DispatchQueue.main.async(execute: {
                print("    * Cant copy from temp dir")
                
                self.cxDownloadDelegate?.cxFileDownloader(didFinishDownloading: true,
                                                didSaveFileAtDocumentsDir: false,
                                                name: nil,
                                                index: CXFileDownloadInfo.INVALID_TASK_ID,
                                                status: .cantCopyFromTempDir)
            })
        }
    }
    
    @objc open func urlSession(_ session: URLSession,
                                 task: URLSessionTask,
                                 didCompleteWithError error: Error?) {
        
        guard let index = getFileDownloadInfoIndexWithTaskID(task.taskIdentifier) else {
            cxDownloadDelegate?.cxFileDownloader(nil,
                                                 index: CXFileDownloadInfo.INVALID_TASK_ID,
                                                 didCompleteWithError: error)
            return
        }
        
        if let e = error?.localizedDescription {
            print("    * CXFileDownloader. Download completed with error")
            print(e)
            cxDownloadDelegate?.cxFileDownloader(nil,
                                                 index: index,
                                                 didCompleteWithError: error)
        }
    }
}
