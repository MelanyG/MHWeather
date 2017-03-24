//
//  DashView.swift
//  MHWeather
//
//  Created by Melaniia Hulianovych on 3/13/17.
//  Copyright © 2017 Melaniia Hulianovych. All rights reserved.
//

import UIKit

class DashView: UIView {


    override func draw(_ rect: CGRect) {
        let  path = UIBezierPath()
        
        let  p0 = CGPoint(x: self.bounds.minX, y: self.bounds.midY)
        path.move(to: p0)
        
        let  p1 = CGPoint(x: self.bounds.maxX,y: self.bounds.midY)
        
        path.addLine(to: p1)
        
        let  dashes: [ CGFloat ] = [ 4.0, 4.0 ]
        path.setLineDash(dashes, count: dashes.count, phase: 0.0)
        
        path.lineWidth = 1.0
        path.lineCapStyle = .butt
        UIColor.white.withAlphaComponent(0.6).set()
        path.stroke()
    }
 

}
