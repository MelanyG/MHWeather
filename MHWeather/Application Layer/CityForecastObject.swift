//
//  CityForecastObject.swift
//  MHWeather
//
//  Created by Melaniia Hulianovych on 3/13/17.
//  Copyright © 2017 Melaniia Hulianovych. All rights reserved.
//

import Foundation

class DayWeather {

    var day:FullDay?
    var iconUrl:String?
    var maxTemp:Int?
    var minTemp:Int?
    var conditions: String?
    var averageTemp:Int? {
        get {
            return (maxTemp! + minTemp!) / 2
        }
    }
    var halfDayArray:Array<PartDayWeather>? = Array()
}

class FullDay {
    var day: Int?
    var month: Int?
    var year: Int?
    var weekShort: String?
    
    init(_ forDay:Int, forMonth:Int, forYear:Int, weekDay:String) {
        day = forDay
        month = forMonth
        year = forYear
        weekShort = weekDay
    }
}

class HourForecast {
    var day: Int?
    var hour: Int?
    var ampm: String?
    var iconUrl: String?
    var humidity: Int?
    var temp: Int?
}

class PartDayWeather {
    var dayPart: String?
    var weatherCondDescr: String?
    var iconUrl: String?
    
}

class CityForecastObject {
    
    typealias partDayWeather = (day: String, hour: Int, imageUrl: String )
    
    var cityName: String?

    var weatherDaysArray: Array<DayWeather> = Array()
    var hourForecastArray: Array<HourForecast> = Array()
    
    var day: FullDay?
    
}
