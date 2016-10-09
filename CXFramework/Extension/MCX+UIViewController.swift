//
//  MCX+UIViewController.swift
//  MCXFramework
//
//  Created by Mauricio Conde on 13/09/16.
//  Copyright © 2016 Mauricio Conde. All rights reserved.
//
import UIKit

public extension UIViewController {
    
    /// ---
    /// Sets an image to the 'leftBarButtonItem' property of the navigation item
    ///
    /// - parameters:
    ///     - imgName: The image name
    public func configureImageForLefttBarButtonItem(_ imgName: String){
        var icon: UIImageView!
        
        icon = UIImageView(image: UIImage(named: imgName))
        icon.alpha = 0.5
        let lBarBtnItem = UIBarButtonItem(customView: icon)
        self.navigationItem.leftBarButtonItem = lBarBtnItem
    }
}
