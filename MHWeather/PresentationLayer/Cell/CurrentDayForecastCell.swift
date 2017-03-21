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
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        dayForecast? = PartDayView.loadFromNibNamed(nibNamed: "PartDayView")!
//        nightForecast = PartDayView.instanceFromNib()
        // Initialization code
//        let yourXIB = Bundle.main.loadNibNamed(
//        "PartDayView",
//        owner: nil,
//        options: nil)?[0] as! PartDayView
//        dayForecast = yourXIB
//        dayForecast?.addSubview(yourXIB)
//        addNibFiles()
    }
    
    func addNibFiles () {
//        var dayFrame = dayForecast?.frame
//        dayFrame?.size.width = containerForPartDays.frame.size.width / 2
        dayForecast = Bundle.main.loadNibNamed("PartDayView", owner: self, options: nil)?[0] as? PartDayView
        dayForecast?.translatesAutoresizingMaskIntoConstraints = false
//        dayForecast?.frame = CGRect(x: 0, y: 8, width: containerForPartDays.frame.size.width / 2 - 20, height: containerForPartDays.frame.size.height - 20)
//        dayForecast?.frame = dayFrame!.
        
//        containerForPartDays.addSubview(dayForecast!)
//        let nightFrame = nightForecast?.frame
        nightForecast = Bundle.main.loadNibNamed("PartDayView", owner: self, options: nil)?[0] as? PartDayView
        nightForecast?.translatesAutoresizingMaskIntoConstraints = false
//        nightForecast?.frame = CGRect(x: containerForPartDays.frame.size.width / 2, y: 8, width: containerForPartDays.frame.size.width / 2 - 20, height: containerForPartDays.frame.size.height - 20)
//        containerForPartDays.addSubview(nightForecast!)
    addConstraintsToView(view1: dayForecast!, siblingView2: nightForecast!, toParentView: containerForPartDays!)
//        layoutIfNeeded()
//        nightForecast?.frame = nightFrame!
//        containerForPartDays.addSubview(nightForecast!)
    }
    
    func addConstraintsToView(view1: PartDayView, siblingView2: PartDayView, toParentView:UIView) {
        let widthConstraint = NSLayoutConstraint(
            item: view1,
            attribute: NSLayoutAttribute.width,
            relatedBy: NSLayoutRelation.equal,
            toItem: toParentView,
            attribute: NSLayoutAttribute.width,
            multiplier: 1,
            constant: 198)
        let topConstraint = NSLayoutConstraint(
            item: view1,
            attribute: NSLayoutAttribute.top,
            relatedBy: NSLayoutRelation.equal,
            toItem: toParentView,
            attribute: NSLayoutAttribute.top,
            multiplier: 1,
            constant: 8)
        let leadingConstraint = NSLayoutConstraint(
            item: view1,
            attribute: NSLayoutAttribute.leading,
            relatedBy: NSLayoutRelation.equal,
            toItem: toParentView,
            attribute: NSLayoutAttribute.leading,
            multiplier: 1,
            constant: 0)
        let bottomConstraint = NSLayoutConstraint(
            item: view1,
            attribute: NSLayoutAttribute.bottom,
            relatedBy: NSLayoutRelation.equal,
            toItem: toParentView,
            attribute: NSLayoutAttribute.bottom,
            multiplier: 1,
            constant: 8)
        
    //sibling2
        
        let leadingConstraintSib = NSLayoutConstraint(
            item: siblingView2,
            attribute: NSLayoutAttribute.leading,
            relatedBy: NSLayoutRelation.equal,
            toItem: view1,
            attribute: NSLayoutAttribute.leading,
            multiplier: 1,
            constant: 10)
        let topConstraintSib = NSLayoutConstraint(
            item: siblingView2,
            attribute: NSLayoutAttribute.top,
            relatedBy: NSLayoutRelation.equal,
            toItem: toParentView,
            attribute: NSLayoutAttribute.top,
            multiplier: 1,
            constant: 8)
        let trailingConstraintSib = NSLayoutConstraint(
            item: siblingView2,
            attribute: NSLayoutAttribute.leading,
            relatedBy: NSLayoutRelation.equal,
            toItem: toParentView,
            attribute: NSLayoutAttribute.leading,
            multiplier: 1,
            constant: 0)
        let bottomConstraintSib = NSLayoutConstraint(
            item: siblingView2,
            attribute: NSLayoutAttribute.bottom,
            relatedBy: NSLayoutRelation.equal,
            toItem: toParentView,
            attribute: NSLayoutAttribute.bottom,
            multiplier: 1,
            constant: 8)
        
        toParentView.addSubview(view1)
        toParentView.addSubview(siblingView2)
        view1.addConstraints([widthConstraint, topConstraint, leadingConstraint, bottomConstraint])
        siblingView2.addConstraints([leadingConstraintSib, topConstraintSib, trailingConstraintSib, bottomConstraintSib])
        NSLayoutConstraint.activate([widthConstraint, topConstraint, leadingConstraint, bottomConstraint, leadingConstraintSib, topConstraintSib, trailingConstraintSib, bottomConstraintSib])
//        let trailingConstraint = NSLayoutConstraint(
//            item: view2,
//            attribute: NSLayoutAttribute.leading,
//            relatedBy: NSLayoutRelation.equal,
//            toItem: toParentView,
//            attribute: NSLayoutAttribute.right,
//            multiplier: 1,
//            constant: 0)
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func configureCell(mainImgUrl:String, tempPerDay:Array<Any>) {
      
    }
}
