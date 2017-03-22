//
//  GraphView
//  MHWeather
//
//  Created by Melaniia Hulianovych on 3/22/17.
//  Copyright © 2017 Melaniia Hulianovych. All rights reserved.
//

import UIKit

@IBDesignable class GraphView: UIView {
    
    //1 - the properties for the gradient
    @IBInspectable var startColor: UIColor = UIColor.red
    @IBInspectable var endColor: UIColor = UIColor.green
    
    var graphPoints: [HourForecast] = Array()
    
    override func draw(_ rect: CGRect) {
        let width = rect.width
        let height = rect.height
        
        
        let context = UIGraphicsGetCurrentContext()
        let colors = [startColor.cgColor, endColor.cgColor]
        
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        
        let colorLocations:[CGFloat] = [0.0, 1.0]
        
        
        let gradient = CGGradient(colorsSpace: colorSpace,
                                  colors: colors as CFArray,
                                  locations: colorLocations)
        
        var startPoint = CGPoint.zero
        var endPoint = CGPoint(x:0, y:self.bounds.height)
        context!.drawLinearGradient(gradient!,
                                    start: startPoint,
                                    end: endPoint,
                                    options: CGGradientDrawingOptions(rawValue: 0))
        
        
        
        
        let margin:CGFloat = 0.0
        let columnXPoint = { (column:Int) -> CGFloat in
            
            let spacer = (width - margin * 2 - 4) /
                CGFloat(24)
            var x:CGFloat = CGFloat(column) * spacer
            x += margin + 2
            return x
        }
        
        
        
        let topBorder:CGFloat = 50
        let bottomBorder:CGFloat = 150
        var maxValue = maxElementFrom(graphPoints: graphPoints)
        let minValue = minElementFrom(graphPoints: graphPoints)
        
        if minValue < 0 {
            maxValue += abs(minValue)
        }
        
        
        let graphHeight = height - topBorder - bottomBorder
        
        let columnYPoint = { (graphPoint:Int) -> CGFloat in
            var newgraph = graphPoint
            if minValue <= 0 {
                newgraph += abs(minValue)
            }
            var y:CGFloat = CGFloat(newgraph) / CGFloat(maxValue) * graphHeight
            
            y = graphHeight + topBorder - y  // Flip the graph
            return y
        }
        
        // draw the line graph
        
        UIColor.white.setFill()
        UIColor.white.setStroke()
        
        //set up the points line
        let graphPath = UIBezierPath()
        
        //go to start of line
        graphPath.move(to: CGPoint(x:columnXPoint(0),
                                   y:columnYPoint(graphPoints[0].temp!)))
        
        //add points for each item in the graphPoints array
        //at the correct (x, y) for the point
        for i in 1...24 {
            let nextPoint = CGPoint(x:columnXPoint(i),
                                    y:columnYPoint(graphPoints[i].temp!))
            print(nextPoint)
            graphPath.addLine(to: nextPoint)
        }
        
        graphPath.stroke()
        
        //Create the clipping path for the graph gradient
        
        context!.saveGState()
        
        
        let clippingPath = graphPath.copy() as! UIBezierPath
        
        
        clippingPath.addLine(to: CGPoint(
            x: columnXPoint(24),
            y:height))
        clippingPath.addLine(to: CGPoint(
            x:columnXPoint(0),
            y:height))
        clippingPath.close()
        
        
        clippingPath.addClip()
        
        
        let highestYPoint = columnYPoint(maxValue)
        startPoint = CGPoint(x:margin, y: highestYPoint)
        endPoint = CGPoint(x:margin, y:self.bounds.height)
        
        context!.drawLinearGradient(gradient!, start: startPoint, end: endPoint, options: CGGradientDrawingOptions(rawValue: 0))
        context!.restoreGState()
        
        
        graphPath.lineWidth = 2.0
        graphPath.stroke()
        
        //Draw the circles on top of graph stroke
        for i in 0...24 {
            var point = CGPoint(x:columnXPoint(i), y:columnYPoint(graphPoints[i].temp!))
            point.x -= 5.0/2
            point.y -= 5.0/2
            
            let circle = UIBezierPath(ovalIn:
                CGRect(origin: point,
                       size: CGSize(width: 5.0, height: 5.0)))
            circle.fill()
            
        }
        
        //Draw horizontal graph lines on the top of everything
        let linePath = UIBezierPath()
        
        
        linePath.move(to: CGPoint(x:margin, y: topBorder))
        linePath.addLine(to: CGPoint(x: width - margin,
                                     y:topBorder))
        
        //center line
        linePath.move(to: CGPoint(x:margin,
                                  y: graphHeight/2 + topBorder))
        linePath.addLine(to: CGPoint(x:width - margin,
                                     y:graphHeight/2 + topBorder))
        
        //bottom line
        linePath.move(to: CGPoint(x:margin,
                                  y:height - bottomBorder))
        linePath.addLine(to: CGPoint(x:width - margin,
                                     y:height - bottomBorder))
        let color = UIColor(white: 1.0, alpha: 0.3)
        color.setStroke()
        
        linePath.lineWidth = 1.0
        linePath.stroke()
        
        //Draw vertical graph lines on the top of everything
        let linePathHor = UIBezierPath()
        
        
        for i in 1...23 {
            linePathHor.move(to: CGPoint(x:columnXPoint(i), y: height))
            linePathHor.addLine(to: CGPoint(x: columnXPoint(i),
                                            y:height - 15))
        }
        
        let  dashes: [ CGFloat ] = [ 3.0, 3.0 ]
        linePathHor.setLineDash(dashes, count: dashes.count, phase: 0.0)
        linePathHor.lineCapStyle = .butt
        let colorWhite = UIColor.white
        colorWhite.setStroke()
        
        linePathHor.lineWidth = 1.0
        linePathHor.stroke()
        
        for i in 1...23 {
            let numberOne = "\(graphPoints[i].temp!)\u{00B0}"
            let numberOneRect = CGRect.init(x: columnXPoint(i) - 10, y: columnYPoint(graphPoints[i].temp!) - 30, width: 30, height: 20)
            
            let font = UIFont(name: "HelveticaNeue-Medium", size: 19)
            
            let numberOneAttributes = [
                NSFontAttributeName: font!,
                NSForegroundColorAttributeName: UIColor.white]
            numberOne.draw(in: numberOneRect,
                           withAttributes:numberOneAttributes)
        }
    }
    
    func maxElementFrom(graphPoints:[HourForecast]) ->Int{
        var max = graphPoints[0].temp!
        for i in 1...24 {
            if max < graphPoints[i].temp! {
                max = graphPoints[i].temp!
            }
        }
        return max
    }
    func minElementFrom(graphPoints:[HourForecast]) ->Int{
        var min = graphPoints[0].temp!
        for i in 1...24 {
            if min > graphPoints[i].temp! {
                min = graphPoints[i].temp!
            }
        }
        return min
    }
    
}
