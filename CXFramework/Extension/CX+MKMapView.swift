//
//  CX+MKMapView.swift
//  CXFramework
//
//  Created by Mauricio Conde on 02/06/17.
//  Copyright © 2017 Mauricio Conde Xinastle. All rights reserved.
//

import MapKit

public typealias Edges = (ne: CLLocationCoordinate2D, sw: CLLocationCoordinate2D)
public extension MKMapView {
    
    /// Returns the current edges visibles on screen 
    var cxEdgePoints: Edges {
        let nePoint = CGPoint(x: self.bounds.maxX, y: self.bounds.origin.y)
        let swPoint = CGPoint(x: self.bounds.minX, y: self.bounds.maxY)
        let neCoord = self.convert(nePoint, toCoordinateFrom: self)
        let swCoord = self.convert(swPoint, toCoordinateFrom: self)
        return (ne: neCoord, sw: swCoord)
    }
}
