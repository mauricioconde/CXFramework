//
//  LoadingView.swift
//  Cartilla
//
//  Created by Diego on 26/05/16.
//  Copyright © 2016 JoseCarlos. All rights reserved.
//

import UIKit

class LoadingView: UIView {
    struct Keys{
        static let loadingWidth = CGFloat(50)
        static let loadingHeight = CGFloat(50)
    }
    static var indicator: UIActivityIndicatorView!
    static var loadingLbl: UILabel!
    static var containerView: UIView!
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK:- Static methods
    
    //Temporal fix until the refactor is completed
    static func show(view: UIView){
        LoadingView.show()
    }
    
    /// Shows a loading view above all views
    static func show(){
        let screenBounds: CGRect = UIScreen.main.bounds
        
        containerView = UIView(frame: screenBounds)
        containerView.backgroundColor = UIColor.black
        containerView.alpha = 0.5
        
        let frame = CGRect(x: (screenBounds.width - Keys.loadingWidth) / 2,
                           y: (screenBounds.height - Keys.loadingHeight) / 2,
                           width: Keys.loadingWidth,
                           height: Keys.loadingHeight)
        indicator = UIActivityIndicatorView(frame: frame)
        indicator.alpha = 0.5
        
        loadingLbl = UILabel(frame: CGRect(x: (screenBounds.width - 140.0) / 2,
                                           y: screenBounds.height / 2 - Keys.loadingHeight,
                                           width: 140.0,
                                           height: 21.0))
        loadingLbl.text = "Cargando..."
        loadingLbl.textColor = UIColor.white
        loadingLbl.textAlignment = NSTextAlignment.center
        
        if let w = UIApplication.shared.delegate?.window{
            if let window = w{
                loadingLbl.center = window.center
                window.addSubview(containerView)
                window.addSubview(indicator)
                window.addSubview(loadingLbl)
                indicator.startAnimating()
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
            }
        }
    }
    
    static func hide(){
        indicator.stopAnimating()
        containerView?.removeFromSuperview()
        containerView = nil
        indicator?.removeFromSuperview()
        indicator = nil
        loadingLbl?.removeFromSuperview()
        loadingLbl = nil
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}
