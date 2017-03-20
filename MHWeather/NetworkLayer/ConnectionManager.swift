//
//  ConnectionManager.swift
//  MHWeather
//
//  Created by Melaniia Hulianovych on 3/6/17.
//  Copyright © 2017 Melaniia Hulianovych. All rights reserved.
//

import Foundation
import CoreLocation


class ConnectionManager {
    
    fileprivate struct Constants {
        static let ServerName = "https://api.wunderground.com/api/5ae5ac6f06196ca9/forecast/q/"
        static let Key = "5ae5ac6f06196ca9"
        static let Format = ".json"
    }
    let connectionManager:URLSession
    var latitude: String?
    var longitude: String?
    var url: String?


    
    static let sharedInstance : ConnectionManager = {
        let instance = ConnectionManager()
        return instance
    }()
    
    init() {
      
        connectionManager = URLSession.shared
    }
    
    func downloadByZipCode(zipCode: String, onCompletion:@escaping (_ result:CityForecastObject?) -> Void) {
        url = "\(Constants.ServerName) + \(zipCode).json"
        downLoadWeather(url!, onCompletion: onCompletion)
    }
    
    func downloadByLocationObject(object: LocationCellObject, onCompletion:@escaping (_ result:CityForecastObject?) -> Void) {
        downloadByCoordinates(long: object.longitude, lat: object.latitude, onCompletion: onCompletion)

 
        
    }
   
    func downloadByCoordinates(long: String, lat: String, onCompletion:@escaping (_ result:CityForecastObject?) -> Void) {
        url = "https://api.wunderground.com/api/5ae5ac6f06196ca9/forecast/hourly/geolookup/q/\(lat),\(long).json"
        downLoadWeather(url!, onCompletion: onCompletion)
    }
    
    func downLoadWeather(_ url:String, onCompletion:@escaping (_ result:CityForecastObject?) -> Void) {
        let requestURL: URL = URL(string: url)!
        let urlRequest: URLRequest = URLRequest(url: requestURL)
        let session = connectionManager
        let task = session.dataTask(with: urlRequest) {
            (data, response, error) -> Void in
            
            print("Task completed")
            if let data = data {
                do {
                    if let jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
//                        print(jsonResult)
                        
                        JSONParser.sharedParser.response = jsonResult
                        onCompletion(JSONParser.sharedParser.genarateMainSource())
//                        dispatch_async(dispatch_get_main_queue(), {
//                            
//                            if let results: NSArray = jsonResult["results"] as? NSArray {
//                                self.tableData = results
//                                self.Indextableview.reloadData()
//                            }
//                        })
                        
                    }
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
        task.resume()
        
    }
    
    
}



