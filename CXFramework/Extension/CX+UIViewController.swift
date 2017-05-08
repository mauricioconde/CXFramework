//
//  CX+UIViewController.swift
//  CXFramework
//
//  Created by Mauricio Conde on 13/09/16.
//  Copyright © 2016 Mauricio Conde. All rights reserved.
//
import UIKit

// MARK:- UINavBar methods
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
        
        guard self.navigationItem.leftBarButtonItems != nil else{
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
    
    /// ---
    /// Sets an image to the 'rightBarButtonItem' property of the navigation item and
    /// configures it with the specified action and target
    ///
    /// - parameters:
    ///     - imgName: The image name
    ///     - target: The object that receives the action message.
    ///     - action: The action to send to target when this item is selected.
    public func configureImageForRightBarButtonItem(imgName: String,
                                                   target: AnyObject?,
                                                   action: Selector){
        var icon: UIImageView!
        
        let image  = UIImage(named: imgName)?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        icon = UIImageView(image: image?.resize(width: 30, height: 30))
        icon.alpha = 0.5
        
        guard self.navigationItem.rightBarButtonItems != nil else{
            let rBarBtnItem = UIBarButtonItem(image: icon.image,
                                              style: UIBarButtonItemStyle.plain,
                                              target: self,
                                              action: action)
            self.navigationItem.rightBarButtonItem = rBarBtnItem
            return
        }
        
        let rBarBtnItem: UIBarButtonItem = self.navigationItem.rightBarButtonItems!.first!
        rBarBtnItem.customView = icon
        rBarBtnItem.target = target != nil ? target : self
        rBarBtnItem.action = action
    }
    
    public func configureImagesForLeftBarButtons(imgNames: [String],
                                                 target: AnyObject?,
                                                 actions: [Selector]) {
        guard imgNames.count == actions.count else {
            return
        }
        
        var icon: UIImageView!
        var buttons: [UIBarButtonItem] = []
        for(index,imgName) in imgNames.enumerated() {
            let image  = UIImage(named: imgName)?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
            icon = UIImageView(image: image?.resize(width: 30, height: 30))
            icon.alpha = 0.5
            buttons.append(UIBarButtonItem(image: icon.image,
                                           style: UIBarButtonItemStyle.plain,
                                           target: self,
                                           action: actions[index]))
        }
        self.navigationItem.leftBarButtonItems = buttons
    }
}

// MARK:- Alert related methods
public extension UIViewController {
    /// ---
    /// Shows a new UIAlertController configured with a title, a message and an array of actions
    ///
    /// - parameters:
    ///     - title: The alert's title
    ///     - message: The alert's message
    ///     - actions: An array of UIAlertAction to attach to the Alert
    ///     - style: Optional value to specify the alert style. Default .ActionSheet
    public func showAlertWithActions(title: String?,
                                     message: String?,
                                     actions: [UIAlertAction],
                                     style: UIAlertControllerStyle = .actionSheet){
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: style)
        
        for (_,action) in actions.enumerated() {
            alert.addAction(action)
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    /// ---
    /// Shows a new UIAlertController configured with a title, a message and a callback
    /// for the OK button
    ///
    /// - parameters:
    ///     - title: The harcoded corresponding to the Title to be displayed
    ///     - message: The harcoded corresponding to the Message to be displayed
    ///     - okAction: The callback to be executed when the 'OK' button is pressed
    public func showAlert(withTitle title: String?, message: String, okAction: (()->Void)?){
        let alert = UIAlertController(title: (title != nil) ? title : nil,
                                      message: message,
                                      preferredStyle: UIAlertControllerStyle.alert)
        
        let action = UIAlertAction(title: "Aceptar",
                                   style: UIAlertActionStyle.cancel,
                                   handler: {(action) in
                                    if okAction != nil {okAction!()}
        })
        alert.addAction(action)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    /// ---
    /// Shows a new UIAlertController configured with a title, a message and and a callback
    /// for the OK button
    /// - parameters:
    ///     - title: The harcoded corresponding to the Title to be displayed
    ///     - message: The harcoded corresponding to the Message to be displayed
    ///     - okAction: The callback to be executed when the 'OK' button is pressed
    public func showOkCancelAlert(withTitle title: String?,
                                  message: String,
                                  okAction: (()->Void)?){
        let alert = UIAlertController(title: (title != nil) ? title : nil,
                                      message: message,
                                      preferredStyle: UIAlertControllerStyle.alert)
        
        let action = UIAlertAction(title: "Aceptar",
                                   style: UIAlertActionStyle.cancel,
                                   handler: {(action) in
                                    if okAction != nil {okAction!()}
        })
        let cancelAction = UIAlertAction(title: "Cancelar",
                                         style: UIAlertActionStyle.default,
                                         handler: nil)
        alert.addAction(action)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK:- Navigation related methods
extension UIViewController {
    
    public func closeVC() {
        guard self.navigationController != nil else {
            self.dismiss(animated: true, completion: nil)
            return
        }
        navigationController!.popViewController(animated: true)
    }
    
    public func presentVC(_ vc: UIViewController) {
        guard self.navigationController != nil else {
            self.present(vc, animated: true, completion: nil)
            return
        }
        self.navigationController!.pushViewController(vc, animated: true)
    }
}
