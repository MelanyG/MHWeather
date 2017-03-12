//
//  LocationManager.swift
//  MHWeather
//
//  Created by Melaniia Hulianovych on 3/10/17.
//  Copyright © 2017 Melaniia Hulianovych. All rights reserved.
//

import Foundation
import CoreLocation

class LocationManager:CLLocationManager, CLLocationManagerDelegate {
    
var locationManager: CLLocationManager = CLLocationManager()
    var currentLocation: CLLocation?
    
    func getLocation() {
        
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()

    }
    
    
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation])
    {
        currentLocation = locations[locations.count - 1]
        
//        latitude.text = String(format: "%.4f",
//                               latestLocation.coordinate.latitude)
//        longitude.text = String(format: "%.4f",
//                                latestLocation.coordinate.longitude)
//        horizontalAccuracy.text = String(format: "%.4f",
//                                         latestLocation.horizontalAccuracy)
//        altitude.text = String(format: "%.4f",
//                               latestLocation.altitude)
//        verticalAccuracy.text = String(format: "%.4f",
//                                       latestLocation.verticalAccuracy)
        

        
//        let distanceBetween: CLLocationDistance =
//            latestLocation.distance(from: startLocation)
        
//        distance.text = String(format: "%.2f", distanceBetween)
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didFailWithError error: Error) {
        
    }
}
