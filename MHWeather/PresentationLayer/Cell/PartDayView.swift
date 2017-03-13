//
//  PartDayView.swift
//  MHWeather
//
//  Created by Melaniia Hulianovych on 3/13/17.
//  Copyright © 2017 Melaniia Hulianovych. All rights reserved.
//

import UIKit

class PartDayView: UIView {

    @IBOutlet weak var partOfTheDay: UILabel!
    @IBOutlet weak var imView: UIImageView!
    @IBOutlet weak var topTemperature: UILabel!
    @IBOutlet weak var bottomTemperature: UILabel!
    
    
    func initWithDate(dayPart:String,
                      imgUrl: String,
                      topTemp:String,
                      bottomTemp:String) {
        partOfTheDay.text = dayPart
//        imView.img =
        topTemperature.text = "\(topTemp)\u{00B0}"
        bottomTemperature.text = "\(bottomTemp)\u{00B0}"
        
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
