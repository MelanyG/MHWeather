//
//  CityForecastObject.swift
//  MHWeather
//
//  Created by Melaniia Hulianovych on 3/13/17.
//  Copyright © 2017 Melaniia Hulianovych. All rights reserved.
//

import Foundation

class CityForecastObject {
    
    typealias partDayWeather = (day: String, hour: Int, imageUrl: String )
    
    var name: String
    var lowerTempPerDay: Int
    var higherTempPerDay: Int
    var genWeatherIconUrl: String
    var currentTemp: Int
    
    
}
