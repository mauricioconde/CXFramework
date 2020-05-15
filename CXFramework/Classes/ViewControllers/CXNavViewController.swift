//
//  CXNavViewController.swift
//  SharedApp
//
//  Created by Mauricio Conde on 13/05/17.
//  Copyright © 2017 dxDevelop. All rights reserved.
//

import UIKit

/// UINavigationController specialized class that:
///
/// * Informs about the push and pop events occurred in it.
/// * Shares a configured **backBarButton** with the appropriate pop action
/// according to the current status of the controller stack
/// 
/// Ideal for updating the navigation bar of some UINavigationController that is in a superior hierarchical level
open class CXNavViewController: UINavigationController {
    fileprivate var totalVC = 0
    public var cxNavDelegate: CXNavViewControllerDelegate? = nil
    public var cxNavDataSource: CXNavViewControllerDataSource? = nil
    public var navId: String? = nil
    
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }
    
    @objc fileprivate func popVC() {
        popViewController(animated: true)
    }
}


// MARK:- UINavigationControllerDelegate
extension CXNavViewController: UINavigationControllerDelegate {
    
    public func navigationController(_ navigationController: UINavigationController,
                                     didShow viewController: UIViewController, animated: Bool) {
        
        let newVCtotal = viewControllers.count
        if totalVC == 0, newVCtotal == 1 {
            // This is the 1st appereance of root view controller
            // when the nav controller is loaded so
            // no push or pop actions has been performed
            return
        }
        
        var img: UIImage! = cxNavDataSource?.barBtnBackImg
        img = img != nil ? img : CXImage.barBtn_back
        
        guard totalVC > newVCtotal else {
            // it was a push
            totalVC = newVCtotal
            let backBtn = UIBarButtonItem(image: img,
                                          style: .plain,
                                          target: self,
                                          action: #selector(self.popVC))
            
            cxNavDelegate?.cxNavViewController(withNavId: navId,
                                               didPushViewControllerWithTitle: viewController.title,
                                               andBackBtn: backBtn)
            return
        }
        
        // it was a pop
        totalVC = newVCtotal
        guard totalVC > 1 else {
            cxNavDelegate?.cxNavViewController(withNavId: navId,
                                               didPopToRootViewControllerWithTitle: viewController.title)
            return
        }
        let backBtn = UIBarButtonItem(image: img,
                                      style: .plain,
                                      target: self,
                                      action: #selector(self.popVC))
        
        cxNavDelegate?.cxNavViewController(withNavId: navId,
                                           didPopViewControllerWithTitle: viewController.title,
                                           andBackBtn: backBtn)
    }
}


// MARK:- Protocols
public protocol CXNavViewControllerDelegate {
    func cxNavViewController(withNavId id: String?,
                             didPushViewControllerWithTitle title: String?,
                             andBackBtn backBtn: UIBarButtonItem)
    func cxNavViewController(withNavId id: String?,
                             didPopViewControllerWithTitle title: String?,
                             andBackBtn backBtn: UIBarButtonItem)
    func cxNavViewController(withNavId id: String?,
                             didPopToRootViewControllerWithTitle title: String?)
}


public protocol CXNavViewControllerDataSource {
    var barBtnBackImg: UIImage? { get }
}
