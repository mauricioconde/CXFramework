//
//  CXDownloadInformer.swift
//  MCXFramework
//
//  Created by Mauricio Conde on 12/06/16.
//  Copyright © 2016 Mauricio Conde. All rights reserved.
//

import Foundation

/// Enum to manage the different states for background tasks
@objc public enum CXDownloadInformer: Int {
    case success
    case unknownTransferSize
    case unknowCXDownloadFileInfo
    case fileNameExists
    case unknowDestinationFileName
    case cantCopyFromTempDir
    case indexOutOfBounds
    
    public var description: String {
        switch self {
        case .success:
            return "Succes"
        case .unknownTransferSize:
            return "UnknownTransferSize"
        case .unknowCXDownloadFileInfo:
            return "UnknowCXDownloadFileInfo"
        case .fileNameExists:
            return "FileNameExists"
        case .unknowDestinationFileName:
            return "UnknowDestinationFileName"
        case .cantCopyFromTempDir:
            return "CantCopyFromTempDir"
        case .indexOutOfBounds:
            return "IndexOutOfBounds"
        }
    }
}
