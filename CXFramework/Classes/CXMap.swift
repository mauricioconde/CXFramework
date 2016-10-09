//
//  CXMap.swift
//  MCXFramework
//
//  Created by Mauricio Conde on 21/05/16.
//  Copyright © 2016 Mauricio Conde. All rights reserved.
//

import Foundation
import MapKit

/// Useful class to handle Maps related tasks
public class CXMap{
    
    ///---
    /// Center the map view around a specific point denoted by its latitude and its longitude
    ///
    /// - parameters: 
    ///     - mapView: The mapView that focuses
    ///     - latitude: The latitude point
    ///     - longitude: The longitude point
    ///     - latitudeDelta: The zoom for the latitude
    ///     - longitudeDelta: The zoom for the longitude
    public class func setMapRegion(_ mapView: MKMapView,
                                latitude: CLLocationDegrees,
                                longitude: CLLocationDegrees,
                                latitudeDelta: CLLocationDegrees = 0.007,
                                longitudeDelta: CLLocationDegrees = 0.007){
        
        let location    = CLLocationCoordinate2DMake(latitude, longitude)
        let span        = MKCoordinateSpan(latitudeDelta: latitudeDelta, longitudeDelta: longitudeDelta)
        let region      = MKCoordinateRegion(center: location, span: span)
        
        mapView.setRegion(region, animated: true)
    }
    
    public class func addPointAnnotation(_ mapView: MKMapView,
                                         lattitud: CLLocationDegrees,
                                         longitude: CLLocationDegrees,
                                         title: String,
                                         subtitle: String){
        
        let location    = CLLocationCoordinate2D(latitude: lattitud, longitude: longitude)
        let annotation  = MKPointAnnotation(coordinate: location, title: title, subtitle: subtitle)
        
        mapView.addAnnotation(annotation)
    }
}
