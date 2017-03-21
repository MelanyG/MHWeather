//
//  UIView+LoadNib.swift
//  MHWeather
//
//  Created by Melaniia Hulianovych on 3/20/17.
//  Copyright © 2017 Melaniia Hulianovych. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func loadFromNibNamed(nibNamed: String, bundle : Bundle? = nil) -> PartDayView? {
        return UINib(
            nibName: nibNamed,
            bundle: bundle
            ).instantiate(withOwner: self, options: nil)[0] as? UIView as! PartDayView?
    }
}
