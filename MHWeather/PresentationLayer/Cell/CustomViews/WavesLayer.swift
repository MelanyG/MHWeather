//
//  WavesLayer.swift
//  Drop
//
//  Created by Melaniia Hulianovych on 3/29/17.
//  Copyright © 2017 Melaniia Hulianovych. All rights reserved.
//

import UIKit

class WavesLayer: CAShapeLayer {
    
    let animationDuration: CFTimeInterval = 1.18
    
    override init() {
        super.init()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(in ctx: CGContext) {
        
        contentsScale = UIScreen.main.scale
        ctx.setStrokeColorSpace(CGColorSpaceCreateDeviceRGB())
        
        
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        let colorLocations:[CGFloat] = [1, 1]
        let colors = [UIColor(colorLiteralRed: 161/255, green: 218/255, blue: 253/255, alpha: 1.0).cgColor, UIColor(colorLiteralRed: 161/255, green: 218/255, blue: 253/255, alpha: 1.0).cgColor]
        let gradient = CGGradient(colorsSpace: colorSpace,
                                  colors: colors as CFArray,
                                  locations: colorLocations)
  
        let startPoint = CGPoint(x:0.0, y: 0.0)
        let endPoint = CGPoint(x:0.0, y:self.bounds.height)
        
        ctx.setLineJoin(.miter)
        
        ctx.addPath(seashelfStart)
        ctx.clip()
        
        
        ctx.drawLinearGradient(gradient!, start: startPoint, end: endPoint, options: CGGradientDrawingOptions(rawValue: 0))
        ctx.setLineWidth(5.0)
        
        ctx.addPath(seashelfStart)
        ctx.setStrokeColor(UIColor.white.cgColor)
        ctx.strokePath()
        
        
    }
    var qty: CGFloat {
        return bounds.size.width / width
    }
    
    var width: CGFloat {
        return 20
    }
    
    var height: CGFloat {
        return bounds.size.height / 12
    }
    
    var seashelfStart: CGMutablePath {
        let arcPath = CGMutablePath()
        arcPath.move(to: CGPoint(x: -5, y: 0))
        
        for i in 1...Int(qty) {
           arcPath.addQuadCurve(to: CGPoint(x:width * CGFloat(i), y:0), control: CGPoint(x:width * CGFloat(i - 1) + width / 2, y: height))
        }
        arcPath.addLine(to: CGPoint(x: bounds.size.width + 5, y: bounds.size.height + 5))
        arcPath.addLine(to: CGPoint(x: -5, y: bounds.size.height + 5))
        arcPath.addLine(to: CGPoint(x: -5, y: 0))
        arcPath.closeSubpath()
        return arcPath
    }
    
}
