//
//  CX+UIApplication.swift
//  CXFramework
//
//  Created by Mauricio Conde on 06/02/17.
//  Copyright © 2017 Mauricio Conde Xinastle. All rights reserved.
//
import UIKit


// MARK:- Transition methods
public extension UIApplication{
    
    /// ---
    /// Changes the application current root view controller with the specified by 'vc' animated
    public static func cx_changeRootViewController(vc: UIViewController) {
        guard let appDelegate = UIApplication.shared.delegate else{
            return
        }
        guard let theWindow = appDelegate.window else{return}
        guard let window = theWindow else{return}
        guard let snapshot:UIView = window.snapshotView(afterScreenUpdates: true) else{return}
        
        vc.view.addSubview(snapshot)
        window.rootViewController = vc
        
        UIView
            .animate(
                withDuration: 0.3,
                animations: {
                    snapshot.layer.opacity = 0;
                    snapshot.layer.transform = CATransform3DMakeScale(1.5, 1.5, 1.5)
                },
                completion: {
                    (value) in
                    snapshot.removeFromSuperview()
            })
    }
    
    /// ---
    /// Changes the application current root view controller with the specified by 'vc'
    /// with a crossDisolve animation
    public func cx_changeRootVCAnimated(vc: UIViewController) {
        guard let appDelegate = UIApplication.shared.delegate else{
            return
        }
        guard let theWindow = appDelegate.window else{return}
        guard let window = theWindow else{return}
        
        UIView
            .transition(
                with: window,
                duration: 0.5,
                options: UIViewAnimationOptions.transitionCrossDissolve,
                animations: {window.rootViewController = vc},
                completion: nil)
    }
}
