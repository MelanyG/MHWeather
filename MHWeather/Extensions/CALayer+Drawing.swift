//
//  CALayer + Drawing.swift
//  MHWeather
//
//  Created by Melaniia Hulianovych on 3/24/17.
//  Copyright © 2017 Melaniia Hulianovych. All rights reserved.
//

import UIKit

extension CALayer {
    
    func drawDrop(withRect rect: CGRect) {

        let context = UIGraphicsGetCurrentContext()
        
        let shadow = NSShadow()
        shadow.shadowColor = UIColor.darkGray.withAlphaComponent(0.6)
        shadow.shadowOffset = CGSize(width: 1, height: 1)
        shadow.shadowBlurRadius = 3
        

        context?.saveGState()
        context?.translateBy(x: rect.width / 2 * 1.6, y: 20)
        
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: -63.15, y: 9.5))
        bezierPath.addCurve(to: CGPoint(x: -31.54, y: 67), controlPoint1: CGPoint(x: -55.12, y: 25.36), controlPoint2: CGPoint(x: -35.24, y: 59.07))
        bezierPath.addCurve(to: CGPoint(x: -64.06, y: 124.5), controlPoint1: CGPoint(x: -16.75, y: 98.73), controlPoint2: CGPoint(x: -41.19, y: 124.5))
        bezierPath.addCurve(to: CGPoint(x: -97.04, y: 67), controlPoint1: CGPoint(x: -93.45, y: 124.5), controlPoint2: CGPoint(x: -111.27, y: 92.78))

        bezierPath.addLine(to: CGPoint(x: -63.15, y: 9.5))
        bezierPath.lineJoinStyle = .round
        bezierPath.lineCapStyle = .round
        context?.saveGState()
        context?.setShadow(offset: shadow.shadowOffset, blur: shadow.shadowBlurRadius, color: (shadow.shadowColor as! UIColor).cgColor)
        UIColor.white.setStroke()
        bezierPath.lineWidth = 5
        bezierPath.stroke()
        context?.restoreGState()
    }
    

}
