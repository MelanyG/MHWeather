//
//  DropView.swift
//  MHWeather
//
//  Created by Melaniia Hulianovych on 3/23/17.
//  Copyright © 2017 Melaniia Hulianovych. All rights reserved.
//

import UIKit



class DropView: UIView {

    override func draw(_ rect: CGRect) {

        let dropLayer = CALayer()
        dropLayer.drawDrop(withRect:rect)
      
      self.layer.addSublayer(dropLayer)


    }
    
  
}
