//
//  CustomMap.swift
//  TheWheatherApp
//
//  Created by Parvez Belim on 15/7/21.
//

import UIKit
import MapKit

class CustomMap: MKMapView {

    func setupMapRegionFor(location: CLLocation){
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        let latDelta: CLLocationDegrees = 0.05
        let lonDelta: CLLocationDegrees = 0.05
        
        let span:MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta)
        let location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        let region: MKCoordinateRegion = MKCoordinateRegion(center: location, span: span)
        self.setRegion(region, animated: true)
        self.showsUserLocation = true
    }
}
