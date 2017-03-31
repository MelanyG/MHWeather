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
    var locationOfCellYPosition: CGFloat = 0
    var alreadyStoppedMotion = true
    //    var closureSaver: ((_ result:CityForecastObject?) -> Void)?
    //    var locationManager: CLLocationManager = CLLocationManager()
    
    //    required init(coder aDecoder: NSCoder) {
    //        super.(coder: aDecoder)
    //    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        conMan = ConnectionManager.sharedInstance
        weatherTableView.register(UINib(nibName: "CurrentDayForecastCell", bundle: nil), forCellReuseIdentifier: "CurrentDayCell")
        weatherTableView.register(UINib(nibName: "WeekTableCell", bundle: nil), forCellReuseIdentifier: "WeekTableCell")
        //        weatherTableView.register(BaseTableViewCell.self, forCellReuseIdentifier: "GraphCell")
        weatherTableView.delegate = self
        navBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navBar.shadowImage = UIImage()
        navBar.isTranslucent = true
        navBar.cityName.text = visualLocation?.textLbl
        //        self.navigationController?.view.backgroundColor = UIColor.clear
        //        conMan?.downLoadWeather("https://api.wunderground.com/api/5ae5ac6f06196ca9/forecast10day/q/CA/San_Francisco.json")
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopMotionManager()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 7
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
            if currentCityForecast?.weatherDaysArray[0].iconUrl != nil {
                cell?.mainImage.setImageWithURL(url: (currentCityForecast?.weatherDaysArray[0].iconUrl)!)
            }
            guard let partDayWeather = currentCityForecast?.weatherDaysArray[0].halfDayArray?[0] else { return cell! }
            cell?.dayForecast?.initWithDate(dayPart: partDayWeather.dayPart!, imgUrl: partDayWeather.iconUrl!, weathDesc: partDayWeather.weatherCondDescr!)
            
            guard let partDayWeatherNight = currentCityForecast?.weatherDaysArray[0].halfDayArray?[1] else { return cell! }
            cell?.nightForecast?.initWithDate(dayPart: partDayWeatherNight.dayPart!, imgUrl: partDayWeatherNight.iconUrl!, weathDesc: partDayWeatherNight.weatherCondDescr!)
            return cell!
        } else if indexPath.row == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ForecastCell", for: indexPath)
            
            return cell
        } else if indexPath.row == 4 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "GraphCell", for: indexPath) as? BaseTableViewCell
            let data = getValidDataFrom(array: (currentCityForecast?.hourForecastArray)!)
            cell?.graphView.graphPoints = (currentCityForecast?.hourForecastArray)!
            return cell!
            
        } else if indexPath.row == 5 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "WeekTableCell", for: indexPath) as? WeekTableCell
            cell?.dataSourse = (currentCityForecast?.weatherDaysArray)!
            cell?.backgroundColor = UIColor.clear
            return cell!
        }
        else if indexPath.row == 6 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DropTableViewCell", for: indexPath) as? DropTableViewCell
            alreadyStoppedMotion = false
            locationOfCellYPosition = (cell?.frame.origin.y)!
            return cell!
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "EmptyCell", for: indexPath)
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 1 {
            return 300
        } else if indexPath.row == 3 || indexPath.row == 2{
            return 50
        } else if indexPath.row == 4 || indexPath.row == 5 {
            return 500
        } else if indexPath.row == 6 {
            return 360
        } else {
            return view.bounds.size.height - 360
        }
    }
    
    func getValidDataFrom(array:[HourForecast]) -> [HourForecast] {
        var ar: [HourForecast] = Array()
        let date = Date()
        let calendar = Calendar.current
        
        let day = calendar.component(.day, from: date)
        let hour = calendar.component(.hour, from: date)
        
        
        
        for i in 0..<array.count {
            if array[i].day == day {
                if array[i].hour == hour {
                    let arra = Array(array[i..<(i + 25)])
                    
                    return arra
                }
            }
        }
        
        
        return ar
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
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.frame.origin.y + scrollView.frame.size.height < locationOfCellYPosition && !alreadyStoppedMotion {
            stopMotionManager()
        }
    }
    
    func stopMotionManager() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if appDelegate.motionManager.isDeviceMotionActive {
            appDelegate.motionManager.stopDeviceMotionUpdates()
            alreadyStoppedMotion = true
        }
    }
    
}



extension StartViewController: LocationSelectionDelegate {
    func locationSelected(newLocation: LocationCellObject, selectedIndex:Int) {
        visualLocation = newLocation
        pageIndex = selectedIndex
        //        conMan?.downloadByLocationObject(object: visualLocation!) {
        //            [unowned self] (result: CityForecastObject?) in
        //            guard let keyCity = self.visualLocation?.textLbl else { return }
        //            self.currentCityForecast = result
        //            DispatchQueue.main.async {
        //                self.weatherTableView.reloadData()
        //                self.navBar.cityName.text = keyCity
        //            }
        //            DataSource.sharedDataSource.citiesForecast[keyCity] = result
        //        }
        
        //        guard let keyCity = visualLocation?.textLbl else { return }
        //        currentCityForecast = DataSource.sharedDataSource.citiesForecast[keyCity]!
        
    }
}
