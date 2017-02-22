//
//  CX+NSObject.swift
//  CXFramework
//
//  Created by Mauricio Conde on 22/02/17.
//  Copyright © 2017 Mauricio Conde Xinastle. All rights reserved.
//

import Foundation

public extension NSObject {
    
    /// ---
    /// Holds the object class name as String.
    /// Also you could use 'CXUtility.classNameAsString(_ obj: Any) -> String'
    public var theClassName: String {
        return NSStringFromClass(type(of: self))
    }
}
