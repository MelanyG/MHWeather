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
        guard let hourForecastday = response?.object(forKey:"hourly_forecast") as? Array<Any> else { return nil }
        
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
        parseHours(hourForecast: hourForecastday)
        guard let location = response?.object(forKey: "location") as? Dictionary<String, Any> else { return nil }
        guard let city = location["city"] as? String else { return nil }
        newCity?.cityName = city
        return newCity
        
    }
    
    func parseHours(hourForecast:Array<Any>) {
        let count = hourForecast.count
        for i in 0..<count {
            let newHour = HourForecast()
            guard let hourF = hourForecast[i] as? Dictionary<String, Any> else { return }
            guard let time = hourF["FCTTIME"] as? Dictionary<String, Any> else { return }
            guard let day = time["mday"] as? String else { return }
            guard let hour = time["hour"] as? String else { return }
            guard let ampm = time["ampm"] as? String else { return }
            guard let pop = hourF["pop"] as? String else { return }
            guard let humidity = hourF["humidity"] as? String else { return }
            guard let icon_URL = hourF["icon_url"] as? String else { return }
            guard let icon = hourF["icon"] as? String else { return }
            guard let temperat = hourF["temp"] as? Dictionary<String, Any> else { return }
            guard let temp = temperat["metric"] as? String else { return }

            
            newHour.day = Int(day)
            newHour.hour = Int(hour)
            newHour.ampm = ampm
            newHour.humidity = Int(humidity)
            newHour.iconUrl = icon_URL
            newHour.icon = icon
            newHour.temp = Int(temp)
            newHour.pop = Int(pop)
            newCity?.hourForecastArray.append(newHour)
        }
    }
    
    func parseforecastDay(forecastday: Dictionary<String, Any>) {
        
        guard let icon = forecastday["icon_url"] as? NSMutableString else { return }
        guard let conditions = forecastday["conditions"] as? String else { return }
        guard let low = forecastday["low"] as? Dictionary<String, String> else { return }
        guard let high = forecastday["high"] as? Dictionary<String, String> else { return }
        guard let date = forecastday["date"] as? Dictionary<String, Any> else { return }
        
        let dayWeather = DayWeather()
        dayWeather.day = parseDate(date: date)
        dayWeather.iconUrl = icon as String?
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
        someHalf.pop = Int(half["pop"] as! String)
        return someHalf
    }
    
}
