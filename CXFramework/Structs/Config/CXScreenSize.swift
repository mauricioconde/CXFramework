//
//  CXScreenSize.swift
//  CXFramework
//
//  Created by Mauricio Conde on 02/06/17.
//  Copyright © 2017 Mauricio Conde Xinastle. All rights reserved.
//

public struct CXScreenSize {
    static let WIDTH = UIScreen.main.bounds.size.width
    static let HEIGHT = UIScreen.main.bounds.size.height
    static let MAX_LENGTH = max(CXScreenSize.WIDTH, CXScreenSize.HEIGHT)
    static let MIN_LENGTH = min(CXScreenSize.WIDTH, CXScreenSize.HEIGHT)
}
