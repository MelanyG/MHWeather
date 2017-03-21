//
//  DayCell
//  MHWeather
//
//  Created by Melaniia Hulianovych on 3/21/17.
//  Copyright © 2017 Melaniia Hulianovych. All rights reserved.
//

import UIKit

class DayCell: UICollectionViewCell {

    
    @IBOutlet weak var dayOfWeek: UILabel!
    @IBOutlet weak var imageWeather: UIImageView!
    @IBOutlet weak var toptemp: UILabel!
    @IBOutlet weak var lowTemp: UILabel!
    
    
    func setUpCell(withDay day:DayWeather) {
        
        lowTemp.text = "\(day.minTemp!)\u{00B0}"
        toptemp.text = "\(day.maxTemp!)\u{00B0}"
        imageWeather.setImageWithURL(url: day.iconUrl!)
        guard let week = day.day?.weekShort else { return }
        guard let dayM = day.day?.day else { return }
        guard let month = day.day?.month else { return }
        if month / 10 > 0 {
            dayOfWeek.text = "\(week) \(month)/\(dayM)"
        } else {
            dayOfWeek.text = "\(week) 0\(month)/\(dayM)"
        }
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
