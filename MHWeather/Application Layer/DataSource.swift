//
//  DataSource.swift
//  MHWeather
//
//  Created by Melaniia Hulianovych on 3/15/17.
//  Copyright © 2017 Melaniia Hulianovych. All rights reserved.
//

import Foundation

class DataSource {

    var citiesForecast: Dictionary<String, CityForecastObject?> = Dictionary()
    
    static let sharedDataSource : DataSource = {
        let instance = DataSource()
        return instance
    }()
}
