//
//  BGTask.swift
//  SharedApp
//
//  Created by Mauricio Conde on 31/01/17.
//  Copyright © 2017 JoseCarlos. All rights reserved.
//

import Foundation

@objc class BGTask: NSObject{
    
    static func asyncTask(onPreExecute preExecute: @escaping ()->Void,
                          doInBackground bgTask: @escaping ()->Void,
                          onPostExecute completion: @escaping ()->Void) -> Void{
        
        
        let backgroundQueue = DispatchQueue(label: "com.cx.queue",
                                            qos: .background,
                                            target: nil)
        
        DispatchQueue.main.async {
            preExecute()
            backgroundQueue.async {
                bgTask()
                DispatchQueue.main.async {
                    completion()
                }
            }
        }
    }
}
