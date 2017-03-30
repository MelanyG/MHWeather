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
//        context?.saveGState()
        
        UIColor.white.setStroke()
        UIColor(colorLiteralRed: 161/255, green: 218/255, blue: 253/255, alpha: 1.0).setFill()
        bezierPath.lineWidth = 5
        bezierPath.stroke()
        bezierPath.fill()
//        context?.restoreGState()
        
        context?.setShadow(offset: shadow.shadowOffset, blur: shadow.shadowBlurRadius, color: (shadow.shadowColor as! UIColor).cgColor)
//        let width = rect.width
//        let height = rect.height
//        let shadow = NSShadow()
//        shadow.shadowColor = UIColor.darkGray.withAlphaComponent(0.6)
//        shadow.shadowOffset = CGSize(width: 1, height: 1)
//        shadow.shadowBlurRadius = 3
//        
//        let bezierPath1 = UIBezierPath()
//        bezierPath1.move(to: CGPoint(x: rect.midX, y: 10))
//        bezierPath1.addCurve(to: CGPoint(x: rect.midX, y: height*0.8 ), controlPoint1: CGPoint(x: rect.midX*1.1, y: height/5 ), controlPoint2: CGPoint(x: width*1.5, y: height/4*3))
//        bezierPath1.addCurve(to: CGPoint(x: rect.midX, y: 10), controlPoint1: CGPoint(x: rect.midX*0.45, y: height/4*3), controlPoint2: CGPoint(x: rect.midX, y: 10))
//        UIColor.white.setStroke()
//        UIColor(colorLiteralRed: 161/255, green: 218/255, blue: 253/255, alpha: 1.0).setFill()
//        bezierPath1.lineWidth = 3
//        bezierPath1.lineJoinStyle = .round
//        bezierPath1.lineCapStyle = .round
//        bezierPath1.stroke()
//        bezierPath1.fill
    }
    

}
