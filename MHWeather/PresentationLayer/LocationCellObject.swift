//
//  LocationCellObject.swift
//  MHWeather
//
//  Created by Melaniia Hulianovych on 3/10/17.
//  Copyright © 2017 Melaniia Hulianovych. All rights reserved.
//

import UIKit

class LocationCellObject {

    var imgName: String
    var textLbl: String
    var latitude: String
    var longitude: String
    
    init(img: String, text: String, updLatitude: String, updLongitude: String) {
        imgName = img
        textLbl = text
        latitude = updLatitude
        longitude = updLongitude
    }
    
    public func getImage() ->UIImage {
        let im = UIImage(named: imgName)
        return im!
    }
    
}
