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

    var response:NSDictionary? {
        get {
            return self.response
        }
        set(newResponse) {
            self.response = newResponse
        }
    }
    
    static let sharedParser : JSONParser = {
        let instance = JSONParser()
        return instance
    }()
    
    func genarateMainSource() {
    
    }
    
}
