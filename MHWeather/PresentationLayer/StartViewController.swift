//
//  StartViewController.swift
//  MHWeather
//
//  Created by Melaniia Hulianovych on 3/6/17.
//  Copyright © 2017 Melaniia Hulianovych. All rights reserved.
//

import UIKit
import CoreLocation

class StartViewController: UIViewController {

    var visualLocation: LocationCellObject?
    var conMan: ConnectionManager?
//    var locationManager: CLLocationManager = CLLocationManager()
    
//    required init(coder aDecoder: NSCoder) {
//        super.(coder: aDecoder)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        conMan = ConnectionManager.sharedInstance

//        conMan?.downLoadWeather("https://api.wunderground.com/api/5ae5ac6f06196ca9/forecast10day/q/CA/San_Francisco.json")
     
        // Do any additional setup after loading the view.
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
