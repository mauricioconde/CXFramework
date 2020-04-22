//
//  CXCollapsibleHeaderVController.swift
//  SharedApp
//
//  Created by Mauricio Conde on 05/07/17.
//  Copyright © 2017 dxDevelop. All rights reserved.
//

import UIKit

open class CXCollapsibleHeaderVController: UIViewController {
    // MARK:- Attributes
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var lblTopConstr: NSLayoutConstraint!
    public var navBarTitle: String = ""
    var isBlurViewAdded = false
    var headerBlurImageView: UIVisualEffectView!
    
    // At this offset the Header stops its transformations
    var offsetHeaderStop: CGFloat!
    
    var headerTranslation: CGFloat!
    
    // At this offset the label Header stops its transformations
    var offsetLblHeader: CGFloat!
    
    
    // MARK:- Computing properties
    public var toolbarHeight: CGFloat {
        return 44
    }
    
    
    // MARK:- Init
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        lblHeader.text = navBarTitle
        scrollView?.delegate = self
    }
    
    override open func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if isBlurViewAdded {
            return
        }
        
        // Header - Blurred image
        let rect = CGRect(x: 0, y: 0, width: view.bounds.width, height: viewHeader.bounds.height)
        let blurEffect: UIVisualEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        
        headerBlurImageView = UIVisualEffectView(effect: blurEffect)
        headerBlurImageView.frame = rect
        headerBlurImageView.alpha = 0.0
        
        viewHeader.insertSubview(headerBlurImageView, belowSubview: lblHeader)
        viewHeader.clipsToBounds = true
        
        isBlurViewAdded = true
        offsetHeaderStop = viewHeader.bounds.size.height - (toolbarHeight + Keys.statusBarHeight)
        
        
        // ----------------------------------------------------------------------------
        // Calculate the amount of points the lblHeader must to be translated on Y axis
        // to be positioned at the middle of the toolbar when the header is totally collapsed
        // ----------------------------------------------------------------------------
        
        let lblFrame = lblHeader.frame
        let topPadding: CGFloat = (toolbarHeight - lblFrame.size.height) / 2
        
        headerTranslation = Keys.distanceFromLblToHeader + lblFrame.size.height + topPadding
        lblTopConstr.constant = Keys.distanceFromLblToHeader
        
        view.layoutIfNeeded()
    }
    
    
    struct Keys {
        static let blurPercentage: CGFloat = 1 //100%
        static let statusBarHeight: CGFloat = 20
        static let distanceFromLblToHeader: CGFloat = 100 //arbitrary value
    }
}


extension CXCollapsibleHeaderVController: UIScrollViewDelegate {
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        var headerTransform = CATransform3DIdentity
        
        // PULL DOWN
        if offset < 0 {
            let headerScaleFactor: CGFloat = abs(offset) / viewHeader.bounds.height
            let headerSizevariation = ((viewHeader.bounds.height * (1.0 + headerScaleFactor)) - viewHeader.bounds.height)/2.0
            headerTransform = CATransform3DTranslate(headerTransform, 0, headerSizevariation, 0)
            headerTransform = CATransform3DScale(headerTransform, 1.0 + headerScaleFactor, 1.0 + headerScaleFactor, 0)
            
            viewHeader.layer.transform = headerTransform
            return
        }
        
        // SCROLL UP/DOWN
        
        // Header
        // The Header should translate vertically following the offset until it reaches the desired height
        // Just transform the Header defining a minimum value that is the point at which the Header will stop its transition
        headerTransform = CATransform3DTranslate(headerTransform, 0, max(-offsetHeaderStop, -offset), 0)
        viewHeader.layer.transform = headerTransform
    
        // Header lbl
        let dy = min(offset, offsetHeaderStop) * headerTranslation / offsetHeaderStop
        let labelTransform = CATransform3DMakeTranslation(0, -1.0 * dy, 0)
        lblHeader.layer.transform = labelTransform
        
        // Blur
        // Set blur percentage
        headerBlurImageView?.alpha = (min(offset, offsetHeaderStop) * Keys.blurPercentage) / offsetHeaderStop
        
        if offset >= offsetHeaderStop {
            viewHeader.layer.zPosition = 100
        }else {
            viewHeader.layer.zPosition = 0
        }
    }
    
    override open var preferredStatusBarStyle: UIStatusBarStyle{
        return UIStatusBarStyle.lightContent
    }
}
