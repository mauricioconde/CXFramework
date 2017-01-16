//
//  MCX+UImage.swift
//  MCXFramework
//
//  Created by Mauricio Conde on 02/06/16.
//  Copyright © 2016 Mauricio Conde. All rights reserved.
//

import UIKit

public extension UIImage {
    /// ---
    /// Resizes an image
    ///
    /// - parameters:
    ///     - width: The new image width
    ///     - height: The new image height
    ///
    /// - returns: A new UIImage object with the specified dimensions
    public func resize(width : CGFloat, height : CGFloat)-> UIImage!{
        UIGraphicsBeginImageContext(CGSize(width: width, height: height))
        self.draw(in: CGRect(x: 0, y: 0, width: width, height: height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}
