//
//  CXImage.swift
//  CXFramework
//
//  Created by Mauricio Conde on 03/06/17.
//  Copyright © 2017 Mauricio Conde Xinastle. All rights reserved.
//

import UIKit


public struct CXImage {
    
    public static var barBtn_back: UIImage {
        guard let img = UIImage(named: Image.barBtn_back) else {
            return UIImage()
        }
        return img
    }
}

struct Image {
    public static let barBtn_back = "barBtn_back"
}
