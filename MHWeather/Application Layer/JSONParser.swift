//
//  JSONParser.swift
//  MHWeather
//
//  Created by Melaniia Hulianovych on 3/13/17.
//  Copyright © 2017 Melaniia Hulianovych. All rights reserved.
//

import Foundation
import UIKit

class JSONParser {
    
    var response: NSDictionary? {
        didSet {
//            genarateMainSource()
        }
    }
    
    var newCity:CityForecastObject?
    
    static let sharedParser : JSONParser = {
        let instance = JSONParser()
        return instance
    }()
    
    func genarateMainSource() -> CityForecastObject? {
        
        newCity = nil
        newCity = CityForecastObject()
        //       newCity.cityName =
        //        newCity.weatherConditionName =
        guard let forecast = response?.object(forKey: "forecast") as? Dictionary<String, Any> else { return nil }
        guard let simpleforecast = forecast["simpleforecast"] as? Dictionary<String, Any> else { return nil }
        guard let forecastday = simpleforecast["forecastday"] as? Array<Any> else { return nil }
        for i in 0..<forecastday.count {
            parseforecastDay(forecastday: forecastday[i] as! Dictionary<String, Any>)
        }
        guard let textforecast = forecast["txt_forecast"] as? Dictionary<String, Any> else { return nil }
        guard let forecastPerDay = textforecast["forecastday"] as? Array<Any> else { return nil }
        var halfDayForecastArray = Array<PartDayWeather>()
        for j in 0..<forecastPerDay.count {
            halfDayForecastArray.append(parseHalfDayForecast(half: forecastPerDay[j] as! Dictionary<String, Any>))
        }
        guard let array = newCity?.weatherDaysArray else { return nil }
        var index = halfDayForecastArray.count - 1
        var indexGen = array.count - 1
        for _ in 0..<array.count {
            for _ in 0...1 {
                newCity?.weatherDaysArray[indexGen].halfDayArray?.append(halfDayForecastArray[index])
                index = index - 1
            }
            indexGen = indexGen - 1
        }
        guard let location = response?.object(forKey: "location") as? Dictionary<String, Any> else { return nil }
        guard let city = location["city"] as? String else { return nil }
        newCity?.cityName = city
        return newCity
        
    }
    
    
    
    func parseforecastDay(forecastday: Dictionary<String, Any>) {
        
        guard let icon = forecastday["icon_url"] as? String else { return }
        //        newCity?.genWeatherIconUrl = icon
        guard let conditions = forecastday["conditions"] as? String else { return }
        //        newCity?.weatherConditionName = conditions
        guard let low = forecastday["low"] as? Dictionary<String, String> else { return }
        //        newCity?.lowerTempPerDay =  low["celsius"] as? Int
        guard let high = forecastday["high"] as? Dictionary<String, String> else { return }
        //        newCity?.higherTempPerDay =  high["celsius"] as? Int
        guard let date = forecastday["date"] as? Dictionary<String, Any> else { return }
        
        let dayWeather = DayWeather()
        dayWeather.day = parseDate(date: date)
        dayWeather.iconUrl = icon
        dayWeather.minTemp = Int(low["celsius"]!)
        dayWeather.maxTemp = Int(high["celsius"]!)
       
        dayWeather.conditions = conditions
        newCity?.weatherDaysArray.append(dayWeather)
        
    }
    
    func parseDate(date:Dictionary<String, Any>) -> FullDay {
        
        let someDay = date["day"] as! Int
        let someMonth = date["month"] as! Int
        let someYear = date["year"] as! Int
        let someWeekShort = date["weekday_short"] as! String
        return  FullDay(someDay, forMonth:someMonth, forYear:someYear, weekDay:someWeekShort)
        
    }
    
    func parseHalfDayForecast(half:Dictionary<String, Any>) -> PartDayWeather {
        let someHalf = PartDayWeather()
        someHalf.dayPart = half["title"] as? String
        someHalf.weatherCondDescr = half["fcttext_metric"] as? String
        someHalf.iconUrl = half["icon_url"] as? String
        return someHalf
    }
    
}
