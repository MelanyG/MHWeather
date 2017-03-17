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


    @IBOutlet weak var navBar: TransparentNavigationBar!
    @IBOutlet weak var weatherTableView: UITableView!
    var currentCityForecast:CityForecastObject?
    var visualLocation: LocationCellObject?
    var conMan: ConnectionManager?
    var pageIndex: Int = 0
//    var closureSaver: ((_ result:CityForecastObject?) -> Void)?
   //    var locationManager: CLLocationManager = CLLocationManager()
    
//    required init(coder aDecoder: NSCoder) {
//        super.(coder: aDecoder)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        conMan = ConnectionManager.sharedInstance
        weatherTableView.register(UINib(nibName: "CurrentDayForecastCell", bundle: nil), forCellReuseIdentifier: "CurrentDayCell")
weatherTableView.delegate = self
        navBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navBar.shadowImage = UIImage()
        navBar.isTranslucent = true
//        self.navigationController?.view.backgroundColor = UIColor.clear
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
            cell?.mainLable.text = currentCityForecast?.weatherDaysArray[0].conditions
            if currentCityForecast?.weatherDaysArray[0].maxTemp != nil {
                cell?.topTemp.text = "\((currentCityForecast?.weatherDaysArray[0].maxTemp)!)"
            }
            if currentCityForecast?.weatherDaysArray[0].minTemp != nil {
                cell?.lowTemp.text = "\((currentCityForecast?.weatherDaysArray[0].minTemp)!)"
            }
            if currentCityForecast?.weatherDaysArray[0].averageTemp != nil {
                cell?.bigTempLable.text = "\((currentCityForecast?.weatherDaysArray[0].averageTemp)!)\u{00B0}"
            }
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
            return view.bounds.size.height - 350
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
    func locationSelected(newLocation: LocationCellObject, selectedIndex:Int) {
        visualLocation = newLocation
        pageIndex = selectedIndex
        conMan?.downloadByLocationObject(object: visualLocation!) {
            [unowned self] (result: CityForecastObject?) in
            guard let keyCity = self.visualLocation?.textLbl else { return }
            self.currentCityForecast = result
            DispatchQueue.main.async {
                self.weatherTableView.reloadData()
                self.navBar.cityName.text = keyCity
            }
            DataSource.sharedDataSource.citiesForecast[keyCity] = result
        }
           
//        guard let keyCity = visualLocation?.textLbl else { return }
//        currentCityForecast = DataSource.sharedDataSource.citiesForecast[keyCity]!
    
    }
}
