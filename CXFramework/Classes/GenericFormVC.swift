//
//  GenericFormVC.swift
//  Cartilla
//
//  Created by Mauricio Conde on 02/11/16.
//  Copyright © 2016 JoseCarlos. All rights reserved.
//
import Foundation
import UIKit

class GenericFormVC: UIViewController {
    @IBOutlet var scrollView: UIScrollView!
    
    ///The title to be displayed on the Navigation bar
    var navBarTitle: String = ""
    ///To keep track which textfield is begin edited and move the view properly
    var activeField: UITextField!
    

    override func viewDidLoad() {
        LoadingView.show()
        super.viewDidLoad()
        configureView()
        LoadingView.hide()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        /// Set the configuration to move the view properly every time the
        /// Keyboard is shown, also configures the view to hide the keyboard when
        /// the user touches the screen outside any textfield
        registerForKeyboardNotifications()
        hideKeyboardOnViewTouch()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        let center = NotificationCenter.default
        center.removeObserver(self, name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        center.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    ///Configures the Keyboard notifications to keep track the keyboard behaviour
    func registerForKeyboardNotifications(){
        let center = NotificationCenter.default
        center.addObserver(self,
                           selector: #selector(self.keyboardWasShown),
                           name: NSNotification.Name.UIKeyboardDidShow,
                           object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWasShown),
                                               name:  NSNotification.Name.UIKeyboardDidChangeFrame,
                                               object: nil)
        center.addObserver(self,
                           selector: #selector(self.keyboardWillBeHidden),
                           name: NSNotification.Name.UIKeyboardWillHide,
                           object: nil)
    }
    
    /// Called when the UIKeyboardDidShowNotification is sent.
    func keyboardWasShown(notification: NSNotification){
        guard activeField != nil else{return}
        let info = notification.userInfo
        let kbSize = (info?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
        let kbToolbarHeight: CGFloat = 40 //we allways add a toolbar to the keyboard
        
        guard kbSize != nil else {return}
        let screenHeight = UIScreen.main.bounds.size.height
        let Ymax = screenHeight - (kbSize!.height + kbToolbarHeight)
        //Get the textField Y position according to main view
        var txtFieldYpos = activeField.convert(activeField.bounds, to: view).origin.y
        txtFieldYpos = txtFieldYpos + activeField.frame.size.height
        
        
        guard txtFieldYpos > Ymax else{return}
        //Active text field is hidden by keyboard, scroll it so it's visible
        let txtFrame = activeField.frame
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize!.height + 20, right: 0.0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
        let rect = CGRect(x: txtFrame.origin.x,
                          y: txtFrame.origin.y + 20,
                          width: txtFrame.size.width,
                          height: txtFrame.size.height)
        scrollView.scrollRectToVisible(rect, animated: true)
    }
    
    /// Called when the UIKeyboardWillHideNotification is sent
    func keyboardWillBeHidden(notification: NSNotification){
        let contentInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    func configureView(){
        self.navigationItem.title = navBarTitle
    }
}




extension GenericFormVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeField = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        activeField = nil
    }
}




//MARK:- Keyboard related methods
public extension UIViewController {
    
    /// Dismisses the keyboard when touching anywhere outside UITextField
    func hideKeyboardOnViewTouch() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    /// Causes the view (or one of its embedded text fields) to resign the 1st responder status
    /// - note: if you want to dismiss the keyboard when touching outside UITextField use
    /// 'hideKeyboardOnViewTouch' method instead
    func hideKeyboard(){
        self.view.endEditing(true)
    }
}
