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
    
    public static func cx_performCurlAnimation(fromView: UIView,
                                               toView:UIView,
                                               curpUp: Bool,
                                               completion: (()->Void)?){
        var animation = UIView.AnimationOptions.transitionCurlUp
        if !curpUp{
            animation = UIView.AnimationOptions.transitionCurlDown
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
    
    public static func cx_performTransitionAnimation(fromView: UIView, toView:UIView, completion: (()->Void)?){
        UIView.transition(from: fromView,
                          to: toView,
                          duration: 0.5,
                          options: UIView.AnimationOptions.transitionCrossDissolve,
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
    
    /// Adds an horizontal gradient color effect
    public func cx_addGradient(fromColor: UIColor, toColor: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [ fromColor.cgColor, toColor.cgColor]
        gradientLayer.locations = [ 0.0, 1.0]
        gradientLayer.frame = self.bounds
        self.layer.addSublayer(gradientLayer)
    }
    
    /// Adds a gradient color effect
    public func cx_applyGradientWith(colors:[UIColor], diagonalMode: Bool, horizontalMode: Bool){
        let layer = CAGradientLayer()
        layer.frame = self.bounds
        
        if horizontalMode {
            layer.startPoint = diagonalMode ? CGPoint(x: 1, y: 0) : CGPoint(x: 0, y: 0.5)
            layer.endPoint   = diagonalMode ? CGPoint(x: 0, y: 1) : CGPoint(x: 1, y: 0.5)
        } else {
            layer.startPoint = diagonalMode ? CGPoint(x: 0, y: 0) : CGPoint(x: 0.5, y: 0)
            layer.endPoint   = diagonalMode ? CGPoint(x: 1, y: 1) : CGPoint(x: 0.5, y: 1)
        }
        layer.locations = [ 0.0, 1.0]
        layer.colors = colors
        self.layer.addSublayer(layer)
    }
}
