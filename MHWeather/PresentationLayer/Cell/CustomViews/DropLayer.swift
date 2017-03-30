//
//  DropLayer.swift
//  Drop
//
//  Created by Melaniia Hulianovych on 3/27/17.
//  Copyright © 2017 Melaniia Hulianovych. All rights reserved.
//

import UIKit

class DropLayer: CALayer, CAAnimationDelegate {
    
    var drawFillColor = false
    
    init(_ rect:CGRect, shouldFillLayer:Bool) {
        super.init()
        self.frame = rect
        drawFillColor = shouldFillLayer
        
        setNeedsDisplay()
    }
    
    override init(layer: Any) {
        super.init(layer: layer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(in ctx: CGContext) {
        let width = frame.size.width/2
        let height = frame.size.height
        contentsScale = UIScreen.main.scale
        let shadow = NSShadow()
        shadow.shadowColor = UIColor.black.withAlphaComponent(1)
        shadow.shadowOffset = CGSize(width: 1, height: 1)
        shadow.shadowBlurRadius = 7
        let offset: CGFloat = 5
        let path = CGMutablePath()
        path.move(to: CGPoint(x: width, y: offset))
        path.addQuadCurve(to: CGPoint(x:width, y:height - offset), control: CGPoint(x:width*2.2, y:height*0.85))
        path.addQuadCurve(to: CGPoint(x:width, y:offset), control: CGPoint(x:width*(-0.2), y:height*0.85))
        ctx.addPath(path)
        ctx.setLineWidth(5.0)
        ctx.setLineCap(.round)
        
        if !drawFillColor {
            ctx.setStrokeColor(UIColor.white.cgColor)
            ctx.setShadow(offset: shadow.shadowOffset, blur: shadow.shadowBlurRadius, color: (shadow.shadowColor as! UIColor).cgColor)
            ctx.strokePath()
        } else {
            ctx.setFillColor(UIColor(colorLiteralRed: 161/255, green: 218/255, blue: 253/255, alpha: 1.0).cgColor)
            ctx.fillPath()
            
        }
 
        ctx.setStrokeColorSpace(CGColorSpaceCreateDeviceRGB())
    }
 
}
