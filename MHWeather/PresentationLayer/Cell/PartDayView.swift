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
    @IBOutlet weak var weatherDescription: UILabel!
   
    
    
    func initWithDate(dayPart:String,
                      imgUrl: String,
                      weathDesc:String) {
        
        if self.subviews.count == 0 {
            let nibs = Bundle.main.loadNibNamed("PartDayView", owner: self, options: nil)?.first as! PartDayView
            
            partOfTheDay = nibs.partOfTheDay
            imView = nibs.imView
            weatherDescription = nibs.weatherDescription
            nibs.frame = self.bounds
            nibs.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            self.addSubview(nibs)
        }

        partOfTheDay.text = dayPart
        imView.setImageWithURL(url: imgUrl)
        weatherDescription.text = "\(weathDesc)"

    }
    override func awakeFromNib() {
        super.awakeFromNib()
//        let nibs = Bundle.main.loadNibNamed("PartDayView", owner: nil, options: nil)?[0] as? UIView
//        self.addSubview(nibs!)

      //        let nibViews = Bundle.main.loadNibNamed("PartDayView", owner: self, options: nil) as? UIView
        // Initialization code
//       self = Bundle.main.loadNibNamed("PartDayView", owner: nil, options: nil)?[0]
    }
    
    private func commonInit() {
        Bundle(for: PartDayView.self).loadNibNamed("PartDayView", owner: self, options: nil)
//        guard let content = self else { return }
//        content.frame = self.bounds
//        content.autoresizingMask = [.FlexibleHeight, .FlexibleWidth]
//        self.addSubview(content)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
       // commonInit()
//        var nibs:PartDayView =
       
//              if self.subviews.count == 0 {
//                let nibs = Bundle.main.loadNibNamed("PartDayView", owner: self, options: nil)?.first as! PartDayView
//
//           partOfTheDay = nibs.partOfTheDay
//            imView = nibs.imView
//            weatherDescription = nibs.weatherDescription
//            nibs.frame = self.bounds
//            nibs.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//            self.addSubview(nibs as! UIView)
//        }
//        if nibs != nil {
//        partOfTheDay = nibs.partOfTheDay
//        imView = nibs.imView
//        weatherDescription = nibs.weatherDescription
//        nibs.frame = self.bounds
//        nibs.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        self.addSubview(nibs)
         // adding the top level view to the view hierarchy
        }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
}

