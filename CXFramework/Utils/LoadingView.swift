//
//  LoadingView.swift
//  Cartilla
//
//  Created by Mauricio Conde on 26/05/16.
//  Copyright © 2016 JoseCarlos. All rights reserved.
//

import UIKit

public class LoadingView: UIView {
    struct Keys{
        static let loadingWidth = CGFloat(100)
        static let loadingHeight = CGFloat(100)
    }
    static var indicator: UIActivityIndicatorView!
    static var loadingView: UIView!
    static var loadingLbl: UILabel!
    static var containerView: UIView!
    
    
    
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK:- Static methods
    /// Shows a loading view above all views
    public static func show(on view: UIView? = nil){
        let screenBounds: CGRect = view != nil ? view!.bounds : UIScreen.main.bounds
        
        containerView = UIView(frame: screenBounds)
        containerView.backgroundColor = UIColor.black
        containerView.alpha = 0.5
        
        loadingView = UIView(frame: CGRect(x: (screenBounds.width - Keys.loadingWidth) / 2,
                                               y: (screenBounds.height - Keys.loadingHeight) / 2,
                                               width: Keys.loadingWidth,
                                               height: Keys.loadingHeight))
        loadingView.layer.cornerRadius = 15
        loadingView.backgroundColor = UIColor.white
        loadingView.alpha = 0.8
        
        indicator = UIActivityIndicatorView(frame: CGRect(x: (loadingView.bounds.size.width - 60) / 2,
                                                          y: (loadingView.bounds.size.height - 70) / 2,
                                                          width: 60,
                                                          height: 60))
        indicator.startAnimating()
        indicator.color = UIColor.black
        loadingView.addSubview(indicator)
        
        loadingLbl = UILabel(frame: CGRect(x: 0,
                                           y: Keys.loadingHeight - 30,
                                           width: Keys.loadingWidth,
                                           height: 20.0))
        loadingLbl.text = "Cargando..."
        loadingLbl.textColor = UIColor.gray
        loadingLbl.font = UIFont.boldSystemFont(ofSize: 8.0)
        loadingLbl.textAlignment = NSTextAlignment.center
        loadingView.addSubview(loadingLbl)
        
        guard view == nil else {
            view?.addSubview(containerView)
            view?.addSubview(loadingView)
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            return
        }
        if let w = UIApplication.shared.delegate?.window{
            if let window = w {
                window.addSubview(containerView)
                window.addSubview(loadingView)
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
            }
        }
    }
    
    /// Add a semi transparent black view
    public static func showMask(above view: UIView? = nil) {
        let screenBounds: CGRect = view != nil ? view!.bounds : UIScreen.main.bounds
        
        containerView = UIView(frame: screenBounds)
        containerView.backgroundColor = UIColor.black
        containerView.alpha = 0.5
        
        guard view == nil else {
            view?.addSubview(containerView)
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            return
        }
        if let w = UIApplication.shared.delegate?.window{
            if let window = w {
                window.addSubview(containerView)
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
            }
        }
    }
    
    public static func hide(){
        indicator.stopAnimating()
        containerView?.removeFromSuperview()
        containerView = nil
        loadingView?.removeFromSuperview()
        loadingView = nil
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}
