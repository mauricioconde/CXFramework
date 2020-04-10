//
//  CXUtility.swift
//  CXFramework
//
//  Created by Mauricio Conde on 22/02/17.
//  Copyright © 2017 Mauricio Conde Xinastle. All rights reserved.
//

import Foundation

public class Utility{
    /// ---
    /// Returns the class name as String
    public static func classNameAsString(_ obj: Any) -> String {
        //prints more readable results for dictionaries, arrays, Int, etc
        return String(describing: type(of: obj))
    }
}
