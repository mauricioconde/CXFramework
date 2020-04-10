//
//  CX+MKPointAnnotation.swift
//  CXFramework
//
//  Created by Mauricio Conde on 02/06/16.
//  Copyright © 2016 Mauricio Conde. All rights reserved.
//

import Foundation
import MapKit

public extension MKPointAnnotation {
    
    public convenience init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String){
        self.init()
        self.coordinate = coordinate;
        self.title = title;
        self.subtitle = subtitle;
    }
}
