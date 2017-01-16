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
    /// Sets an image to the 'leftBarButtonItem' property of the navigation item and
    /// configures it with the specified action and target
    ///
    /// - parameters:
    ///     - imgName: The image name
    ///     - target: The object that receives the action message.
    ///     - action: The action to send to target when this item is selected.
    public func configureImageForLeftBarButtonItem(imgName: String,
                                                   target: AnyObject?,
                                                   action: Selector){
        var icon: UIImageView!
        
        let image  = UIImage(named: imgName)?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        icon = UIImageView(image: image?.resize(width: 30, height: 30))
        icon.alpha = 0.5
        
        guard let items = self.navigationItem.leftBarButtonItems else{
            let lBarBtnItem = UIBarButtonItem(image: icon.image,
                                              style: UIBarButtonItemStyle.plain,
                                              target: self,
                                              action: action)
            self.navigationItem.leftBarButtonItem = lBarBtnItem
            return
        }
        
        let lBarBtnItem: UIBarButtonItem = self.navigationItem.leftBarButtonItems!.first!
        lBarBtnItem.customView = icon
        lBarBtnItem.target = target != nil ? target : self
        lBarBtnItem.action = action
    }
}
