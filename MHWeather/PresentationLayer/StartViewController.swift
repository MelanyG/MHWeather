//
//  StartViewController.swift
//  MHWeather
//
//  Created by Melaniia Hulianovych on 3/6/17.
//  Copyright © 2017 Melaniia Hulianovych. All rights reserved.
//

import UIKit
import CoreLocation

class StartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var customNavBar: UIView!
    @IBOutlet weak var weatherTableView: UITableView!
    
    var visualLocation: LocationCellObject?
    var conMan: ConnectionManager?
   //    var locationManager: CLLocationManager = CLLocationManager()
    
//    required init(coder aDecoder: NSCoder) {
//        super.(coder: aDecoder)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        conMan = ConnectionManager.sharedInstance
        weatherTableView.register(UINib(nibName: "CurrentDayForecastCell", bundle: nil), forCellReuseIdentifier: "CurrentDayCell")
weatherTableView.delegate = self
//        conMan?.downLoadWeather("https://api.wunderground.com/api/5ae5ac6f06196ca9/forecast10day/q/CA/San_Francisco.json")
     
        // Do any additional setup after loading the view.
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 1 {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CurrentDayCell", for: indexPath) as? CurrentDayForecastCell

        cell?.bigTempLable.text = "40\u{00B0}"
            return cell!
        } else {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmptyCell", for: indexPath)
            return cell
        }

    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 1 {
            return 250
        } else {
            return view.bounds.size.height - 300
        }
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
        conMan?.downloadByLocationObject(object: visualLocation!)
    }
}
