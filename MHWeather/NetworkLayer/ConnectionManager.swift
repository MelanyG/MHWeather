//
//  ConnectionManager.swift
//  MHWeather
//
//  Created by Melaniia Hulianovych on 3/6/17.
//  Copyright © 2017 Melaniia Hulianovych. All rights reserved.
//

import Foundation

class ConnectionManager {
    
    let connectionManager:URLSession
    
    static let sharedInstance : ConnectionManager = {
        let instance = ConnectionManager()
        return instance
    }()
    
    init() {
        connectionManager = URLSession.shared
    }
    
    func downLoadWeather(_ url:String) {
        let requestURL: URL = URL(string: url)!
        let urlRequest: URLRequest = URLRequest(url: requestURL)
        let session = connectionManager
        let task = session.dataTask(with: urlRequest) {
            (data, response, error) -> Void in
            
            print("Task completed")
            if let data = data {
                do {
                    if let jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                        print(jsonResult)
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


