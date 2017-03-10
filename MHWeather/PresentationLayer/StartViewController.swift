//
//  StartViewController.swift
//  MHWeather
//
//  Created by Melaniia Hulianovych on 3/6/17.
//  Copyright © 2017 Melaniia Hulianovych. All rights reserved.
//

import UIKit
import CoreLocation

class StartViewController: UIViewController, CLLocationManagerDelegate {

    var visualLocation: LocationCellObject
    var conMan: ConnectionManager?
    var locationManager: CLLocationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        conMan = ConnectionManager.sharedInstance

//        conMan?.downLoadWeather("https://api.wunderground.com/api/5ae5ac6f06196ca9/forecast10day/q/CA/San_Francisco.json")
     
        // Do any additional setup after loading the view.
    }

    func getCurrentLocation() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation])
    {
        if locations.count < 1 { return }
        let latestLocation: CLLocation = locations[locations.count - 1]

        let latitude = String(format: "%.4f", latestLocation.coordinate.latitude)
        let longitude = String(format: "%.4f", latestLocation.coordinate.longitude)
        manager.stopUpdatingLocation()
        conMan?.downLoadWeather("https://api.wunderground.com/api/5ae5ac6f06196ca9/forecast/q/ + \(latitude) + \(longitude).json")
        //        horizontalAccuracy.text = String(format: "%.4f",
        //                                         latestLocation.horizontalAccuracy)
        //        altitude.text = String(format: "%.4f",
        //                               latestLocation.altitude)
        //        verticalAccuracy.text = String(format: "%.4f",
        //                                       latestLocation.verticalAccuracy)
        
//        if startLocation == nil {
//            startLocation = latestLocation
//        }
        
        //        let distanceBetween: CLLocationDistance =
        //            latestLocation.distance(from: startLocation)
        
        //        distance.text = String(format: "%.2f", distanceBetween)
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didFailWithError error: Error) {
        let alertCtrl = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        present(alertCtrl, animated: true, completion: nil)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension StartViewController: LocationSelectionDelegate {
    func locationSelected(newLocation: LocationCellObject) {
        visualLocation = newLocation
    
    }
}
