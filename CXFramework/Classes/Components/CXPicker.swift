//
//  CXPicker.swift
//  RCI
//
//  Created by Mauricio Conde on 23/05/17.
//  Copyright © 2017 DEX. All rights reserved.
//

import UIKit

@objc public protocol CXPickerDelegate {
    func pickerDataView(pickerData: CXPicker, selectedIndex index: Int)
    @objc optional func shouldPickerBeginEditing(_ pickerData: CXPicker) -> Bool
    @objc optional func pickerDataViewNoItems(_ pickerData: CXPicker)
    @objc optional func onPickerDataViewBeginEditing(_ pickerData: CXPicker)
}
public protocol  CXPickerDataSource {
    // Let the dataSource retrieve/create the items array and returns the total
    func createArrayOfItemsFor(pickerData: CXPicker) -> Bool
    func titleFor(pickerData: CXPicker, atIndex index: Int) -> String
    func numberOfRowsFor(pickerData: CXPicker) -> Int
}


/// Custom class to show pickerView
public class CXPicker: UIView {
    
    // MARK:- Public variables
    public var delegate: CXPickerDelegate?
    public var dataSource: CXPickerDataSource?
    
    
    // MARK:- Private attributes
    fileprivate var picker: UIPickerView!
    fileprivate var toolBar: UIToolbar!
    fileprivate var bgView: UIView!
    fileprivate var selectedIndex: Int? = nil
    fileprivate var totalItems: Int = 0
    fileprivate var placeSearchTimer: Timer! = nil
    
    

    // MARK:- Public methods
    public func show(withTintColor color: UIColor, acceptTitle ok: String, cancelTitle cancel: String, wait: Bool = false) {
        if let shouldContinue = delegate?.shouldPickerBeginEditing?(self) {
            if !shouldContinue {return}
        }
        
        selectedIndex = nil
        
        BGTask.asyncTask(
            onPreExecute:{
                if wait == true {
                    LoadingView.show()
                }
        },
            doInBackground: {
                self.delegate?.onPickerDataViewBeginEditing?(self)
                
                // Let the dataSource retrieve/create the items array and returns the total
                if let created = self.dataSource?.createArrayOfItemsFor(pickerData: self), created {
                    let count = self.dataSource?.numberOfRowsFor(pickerData: self)
                    self.totalItems = count != nil ? count! : 0
                } else {
                    self.totalItems = 0
                }
        },
            onPostExecute: {
                
                if self.totalItems <= 0{
                    debugPrint("No items for picker data")
                    LoadingView.hide()
                    self.delegate?.pickerDataViewNoItems?(self)
                    return
                }
                
                let screenSize = UIScreen.main.bounds.size
                let window:UIWindow = (UIApplication.shared.delegate?.window!)!
                
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.destroyPicker))
                self.bgView = UIView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height))
                self.bgView.backgroundColor = UIColor.black
                self.bgView.alpha = 0.0
                self.bgView.addGestureRecognizer(tapGesture)
                
                let pickerFrame = CGRect(x: 0,
                                         y: screenSize.height,
                                         width: screenSize.width,
                                         height: Keys.pickerHeight)
                self.picker = UIPickerView(frame: pickerFrame)
                self.picker.backgroundColor = UIColor.white
                self.picker.alpha = 1
                self.picker.delegate = self
                self.picker.dataSource = self
                
                
                let btnAcept = UIBarButtonItem(title:"   ".appending(ok),
                                               style: UIBarButtonItem.Style.done,
                                               target: self,
                                               action: #selector(self.selectItem))
                let toolbarFrame = CGRect(x: 0,
                                          y: screenSize.height,
                                          width: screenSize.width,
                                          height: Keys.toolbarHeight)
                self.toolBar = UIToolbar(frame: toolbarFrame)
                self.toolBar.tintColor = color
                self.toolBar.setItems([btnAcept], animated: true)
                
                LoadingView.hide()
                window.addSubview(self.bgView)
                window.addSubview(self.toolBar)
                window.addSubview(self.picker)
                
                self.bgView.cxFadeIn(alpha: 0.5, withCompletion: nil)
                
                UIView.animate(withDuration: 0.2, animations: {
                    self.toolBar.frame.origin.y = screenSize.height - (Keys.toolbarHeight + Keys.pickerHeight)
                    self.picker.frame.origin.y = screenSize.height - Keys.pickerHeight
                })
        })
    }
    
    
    
    // MARK:- Internal methods
    
    @objc
    private func selectItem(){
        if selectedIndex == nil{
            // Get the UIPicker's selected index
            selectedIndex =  picker.selectedRow(inComponent: 0)
        }
        
        bgView.removeFromSuperview()
        bgView = nil
        picker.removeFromSuperview()
        picker = nil
        toolBar.removeFromSuperview()
        toolBar = nil
        if selectedIndex != nil{
            delegate?.pickerDataView(pickerData: self, selectedIndex: selectedIndex!)
        }
    }
    
    @objc
    private func destroyPicker(){
        let screenSize = UIScreen.main.bounds.size
        
        selectedIndex = nil
        totalItems = 0
        
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.2, delay: 0.0, options:[], animations: {
                self.bgView.alpha = 0.0
                self.picker.frame.origin.y = screenSize.height
                self.toolBar.frame.origin.y = screenSize.height
            }, completion: { finished in
                self.picker.removeFromSuperview()
                self.toolBar.removeFromSuperview()
                self.bgView.removeFromSuperview()
                self.bgView = nil
                self.picker = nil
            })
        }
    }
    
    
    // MARK:- Keys
    
    fileprivate struct Keys {
        static let nibName: String = "CXPicker"
        static let pickerHeight = CGFloat(150)
        static let toolbarHeight = CGFloat(40)
    }
}


// MARK:- UIPickerViewDataSource

extension CXPicker: UIPickerViewDataSource {
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        guard let total = dataSource?.numberOfRowsFor(pickerData: self) else {
            return 0
        }
        return total
    }
}

// MARK:- UIPickerViewDelegate

extension CXPicker: UIPickerViewDelegate {
    
    public func pickerView(_ pickerView: UIPickerView,
                           titleForRow row: Int,
                           forComponent component: Int) -> String? {
        if let title = dataSource?.titleFor(pickerData: self, atIndex: row) {
            return title
        }
        return "- Seleccionar -"
    }
}
