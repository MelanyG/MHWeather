//
//  DataSource.swift
//  MHWeather
//
//  Created by Melaniia Hulianovych on 3/15/17.
//  Copyright © 2017 Melaniia Hulianovych. All rights reserved.
//

import Foundation
import UIKit

struct Icon:Hashable {
    var iconUrl: String?
    var image: UIImage?
    
    public var hashValue: Int {
        return (iconUrl ?? "").hashValue
    }
    
    public static func == (lhs: Icon, rhs: Icon) -> Bool {
        return lhs.iconUrl == rhs.iconUrl
    }
}

class DataSource {

    var citiesForecast: Dictionary<String, CityForecastObject?> = Dictionary()
    var gifIconsSet: Dictionary<String, UIImage>? = Dictionary()
    var locationPoints = [LocationCellObject?]()
    
    
    static let sharedDataSource : DataSource = {
        let instance = DataSource()
        return instance
    }()
    
    init() {
        locationPoints.append(LocationCellObject(img: "controls-share", text: "Share", updLatitude: "", updLongitude: ""))
        locationPoints.append(LocationCellObject(img: "selectedPin", text: "EditLocations", updLatitude: "", updLongitude: ""))
        locationPoints.append(LocationCellObject(img: "pin", text: "New York", updLatitude: "40.730610", updLongitude: "-73.935242"))
        locationPoints.append(LocationCellObject(img: "pin", text: "Paris", updLatitude: "48.864716", updLongitude: "2.349014"))
        locationPoints.append(LocationCellObject(img: "pin", text: "Chicago", updLatitude: "41.881832", updLongitude: "-87.623177"))
        locationPoints.append(LocationCellObject(img: "pin", text: "Lviv", updLatitude: "49.8397", updLongitude: "24.0297"))
    }
}
