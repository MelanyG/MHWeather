//
//  DropView.swift
//  MHWeather
//
//  Created by Melaniia Hulianovych on 3/23/17.
//  Copyright © 2017 Melaniia Hulianovych. All rights reserved.
//

import UIKit
import CoreMotion

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
    var motionManager: CMMotionManager {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.motionManager
    }
    
    override func draw(_ rect: CGRect) {
        
        
        bigHiddenDrop = DropLayer(rect,
                                  shouldFillLayer:true)
        bigHiddenDrop?.opacity = 1.0
        //        bigHiddenDrop?.transform = CATransform3DMakeScale(0.5, 0.5, 1.0)
        //        bigHiddenDrop?.isHidden = true
        
        
        layer.addSublayer(bigHiddenDrop)
        
        fallingWaterLayer = CAShapeLayer()
        fallingWaterLayer.frame = CGRect(origin: rect.origin, size: CGSize(width: rect.size.width * 3, height: rect.size.height))
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
                drawObliqueLine()
            }
        }
        let queue = OperationQueue()
        if motionManager.isAccelerometerAvailable {
            motionManager.deviceMotionUpdateInterval = 0.01
            motionManager.startDeviceMotionUpdates(to: queue) {
                [weak self] (data: CMDeviceMotion?, error: Error?) in
                if let acceleration = data?.gravity {
                    let rotation = atan2(acceleration.x, acceleration.y) - M_PI
                    OperationQueue.main.addOperation {
                        if rotation > 0.2 {
                            self?.bigHiddenDrop?.mask = self?.fallingWaterLayer
                            self?.bigHiddenDrop.transform = CATransform3DMakeAffineTransform(CGAffineTransform(rotationAngle: CGFloat(rotation)))
                        } else {
                            self?.bigHiddenDrop?.mask = self?.seaMaskLayer
                            self?.bigHiddenDrop.transform = CATransform3DMakeAffineTransform(CGAffineTransform(rotationAngle: CGFloat(0)))
                        }
                    }
                }
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
    
    func drawObliqueLine() {
        if obliqueLine == nil {
            let path = UIBezierPath()
            path.move(to: CGPoint(x: bounds.width * 0.2, y: bounds.height * 0.95 ))
            path.addLine(to: CGPoint(x: bounds.width * 0.8, y: bounds.height * 0.2))
            
            obliqueLine = CAShapeLayer()
            obliqueLine.path = path.cgPath
            obliqueLine.strokeColor = UIColor.white.cgColor
            obliqueLine.lineWidth = 5.0
            layer.addSublayer(obliqueLine)
        } else {
            obliqueLine.isHidden = false
        }
    }
    
    func resetAnimation() {
        if obliqueLine != nil {
            obliqueLine.isHidden = true
        }
      
        bigHiddenDrop.removeAllAnimations()
        bigHiddenDrop.bounds.origin.x = 0
        bigHiddenDrop.mask = fallingWaterLayer
        addAnimation()
    }
    
}
