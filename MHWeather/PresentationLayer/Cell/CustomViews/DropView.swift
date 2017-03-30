//
//  DropView.swift
//  MHWeather
//
//  Created by Melaniia Hulianovych on 3/23/17.
//  Copyright © 2017 Melaniia Hulianovych. All rights reserved.
//

import UIKit



class DropView: UIView, CAAnimationDelegate {
    
    var mainLayer: DropLayer!
    var bigHiddenDrop: DropLayer!
    var fallingWaterLayer: CAShapeLayer!
    var seaMaskLayer: WavesLayer!
    var obliqueLine: CAShapeLayer!
    var dropLevel: CGFloat = 0
    var setWatherLevel: CGFloat {
        return dropLevel - 1
    }
    
    override func draw(_ rect: CGRect) {
        
        
        bigHiddenDrop = DropLayer(rect,
                                  shouldFillLayer:true)
        bigHiddenDrop?.opacity = 1.0
        //        bigHiddenDrop?.transform = CATransform3DMakeScale(0.5, 0.5, 1.0)
        //        bigHiddenDrop?.isHidden = true
        
        
        layer.addSublayer(bigHiddenDrop)
        
        fallingWaterLayer = CAShapeLayer()
        fallingWaterLayer.frame = rect
        fallingWaterLayer.fillColor = UIColor.blue.cgColor
        let path = CGPath(rect:fallingWaterLayer.bounds, transform:nil)
        fallingWaterLayer.path = path
        mainLayer = DropLayer(rect, shouldFillLayer:false)
        layer.addSublayer(mainLayer!)
        bigHiddenDrop.mask = fallingWaterLayer
        addAnimation()
   
    }
    
    func addAnimation() {
        let animation = CABasicAnimation(keyPath: "bounds.origin.y")
        animation.toValue = bounds.size.width * setWatherLevel
        animation.duration = 1
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        animation.fillMode = kCAFillModeBoth
        animation.isRemovedOnCompletion = false
        animation.delegate = self
        bigHiddenDrop?.add(animation, forKey: animation.keyPath)
        
        seaMaskLayer = WavesLayer()
        seaMaskLayer.frame = CGRect(x: -3 * bounds.width, y: 0, width: bounds.width * 4, height: bounds.height)
        seaMaskLayer.setNeedsDisplay()
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        
        if (anim as! CABasicAnimation).keyPath == "bounds.origin.y" && setWatherLevel != 0 {
            if dropLevel != 0 {
                bigHiddenDrop?.mask = seaMaskLayer
                animate()
            } else {
                drawOblique()
            }
        }
    }
    
    func animate() {
        
        let waveAnimation: CABasicAnimation = CABasicAnimation(keyPath: "bounds.origin.x")
        waveAnimation.toValue = -100
        waveAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        waveAnimation.duration = 5
        waveAnimation.repeatCount = Float.infinity
        bigHiddenDrop.add(waveAnimation, forKey: waveAnimation.keyPath)
        
    }
    
    func drawOblique() {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: bounds.width * 0.2, y: bounds.height * 0.95 ))
        path.addLine(to: CGPoint(x: bounds.width * 0.8, y: bounds.height * 0.2))
        
        obliqueLine = CAShapeLayer()
        obliqueLine.path = path.cgPath
        obliqueLine.strokeColor = UIColor.white.cgColor
        obliqueLine.lineWidth = 5.0
        layer.addSublayer(obliqueLine)
    }

}
