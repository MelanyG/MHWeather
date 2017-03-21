//
//  CurrentDayForecastCell.swift
//  MHWeather
//
//  Created by Melaniia Hulianovych on 3/13/17.
//  Copyright © 2017 Melaniia Hulianovych. All rights reserved.
//

import UIKit

class CurrentDayForecastCell: BaseTableViewCell {
    
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var mainLable: UILabel!
    @IBOutlet weak var topTemp: UILabel!
    @IBOutlet weak var lowTemp: UILabel!
    
    @IBOutlet weak var bigTempLable: UILabel!
    @IBOutlet weak var containerForPartDays: UIView!
    @IBOutlet weak var dayForecast: PartDayView?
    @IBOutlet weak var nightForecast: PartDayView?
    @IBOutlet weak var upArrow: UIImageView!
    @IBOutlet weak var downArrow: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        upArrow.maskDownloadImageView()
        downArrow.maskDownloadImageView()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func configureCell(mainImgUrl:String, tempPerDay:Array<Any>) {
      
    }
}
