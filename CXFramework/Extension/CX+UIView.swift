//
//  CX+UIView.swift
//  CXFramework
//
//  Created by Mauricio Conde on 15/02/17.
//  Copyright © 2017 Mauricio Conde Xinastle. All rights reserved.
//

import Foundation
import UIKit

// MARK:- Transition methods
public extension UIView{
    public static func performCurlAnimation(fromView: UIView,
                                            toView:UIView,
                                            curpUp: Bool,
                                            completion: (()->Void)?){
        var animation = UIViewAnimationOptions.transitionCurlUp
        if !curpUp{
            animation = UIViewAnimationOptions.transitionCurlDown
        }
        // Transition using a page curl.
        UIView.transition(from: fromView,
                          to: toView,
                          duration: 0.5,
                          options: animation,
                          completion: {(finished) in
                            if finished && completion != nil{
                                completion!()
                            }
        })
    }
    
    public static func performTransitionAnimation(fromView: UIView, toView:UIView, completion: (()->Void)?){
        UIView.transition(from: fromView,
                          to: toView,
                          duration: 0.5,
                          options: UIViewAnimationOptions.transitionCrossDissolve,
                          completion: {(finished: Bool) in
                            if completion != nil{
                                DispatchQueue.main.async {
                                    completion!()
                                }
                            }
        })
    }
}

// MARK:- Style methods
public extension UIView {
    
    /// Adds a gradient color effect
    public func addGradient(fromColor: UIColor, toColor: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [ fromColor.cgColor, toColor.cgColor]
        gradientLayer.locations = [ 0.0, 1.0]
        gradientLayer.frame = self.bounds
        self.layer.addSublayer(gradientLayer)
    }
}
