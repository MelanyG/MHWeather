//
//  Protocols.swift
//  MHWeather
//
//  Created by Melaniia Hulianovych on 3/10/17.
//  Copyright © 2017 Melaniia Hulianovych. All rights reserved.
//

import Foundation


protocol LocationSelectionDelegate: class {
    func locationSelected(newLocation: LocationCellObject, selectedIndex:Int)
}
