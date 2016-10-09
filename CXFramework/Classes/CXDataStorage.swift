//
//  CXDataStorage.swift
//  MCXFramework
//
//  Created by Mauricio Conde on 06/06/16.
//  Copyright © 2016 Mauricio Conde. All rights reserved.
//

/// Convenient class to managing file paths of app
public class CXDataStorage{
    
    /// Defines static variables holding the most common directory paths for an app
    /// like the 'library' or 'documents' directory
    public struct Directory {
        /// The documents directory for the app
        public static let documents = (NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory,
            FileManager.SearchPathDomainMask.userDomainMask, true)[0])
        
        /// The library directory for the app
        public static let library = (NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.libraryDirectory,
            FileManager.SearchPathDomainMask.userDomainMask, true)[0])
    }
    
    /// Returns the path of a file specified by name inside the Library directory.
    /// This method can be used to get the path for a new file or to get the path of an
    /// existing file inside this directory
    ///
    /// - parameters
    ///     - filename: The file name of a file
    public static func pathForFileAtLibraryDirectory(_ filename : String )-> String {
        return CXDataStorage.Directory.library + "/" + filename
        
    }
    
    /// Returns the path of a file specified by name inside the Documents directory.
    /// This method can be used to get the path for a new file or to get the path of an
    /// existing file inside this directory
    ///
    /// - parameters: 
    ///     - filename: The file name of a file
    public static func pathForFileAtDocumentsDirectory(_ filename : String )-> String {
        return CXDataStorage.Directory.documents + "/" + filename
        
    }
    
}
