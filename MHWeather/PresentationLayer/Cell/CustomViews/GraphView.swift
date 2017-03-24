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
    
    var context: CGContext?
    var graphPoints: [HourForecast] = Array()
    var pointsForTemp: [CGPoint] = Array()
    var width: CGFloat = 0
    var height: CGFloat = 0
    let topBorder:CGFloat = 50
    let bottomBorder:CGFloat = 150
    let lableSize: CGSize = CGSize(width: 30.0, height: 20.0)
    
    override func draw(_ rect: CGRect) {
        
        width = rect.width
        height = rect.height - lableSize.height
        
        let columnXPoint = { (column:Int) -> CGFloat in
            let spacer = self.width / CGFloat(24)
            var x:CGFloat = CGFloat(column) * spacer
            x += 2
            return x
        }
        
        context = UIGraphicsGetCurrentContext()
        
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
            
            y = graphHeight + self.topBorder - y  // Flip the graph
            return y
        }
        
        // draw the line graph
        UIColor.white.setFill()
        UIColor.white.setStroke()
        
        //set up the points line
        let graphPath = UIBezierPath()
        graphPath.lineJoinStyle = .round
        
        //go to start of line
        let pointOne = CGPoint(x:columnXPoint(0),
                               y:columnYPoint(graphPoints[0].temp!))
        graphPath.move(to: pointOne)
        pointsForTemp.append(pointOne)
        //add points for each item in the graphPoints array
        //at the correct (x, y) for the point
        for i in 1...24 {
            let nextPoint = CGPoint(x:columnXPoint(i),
                                    y:columnYPoint(graphPoints[i].temp!))
            pointsForTemp.append(nextPoint)
            graphPath.addLine(to: nextPoint)
        }
        
        graphPath.stroke()
        
        //Create the clipping path for the graph gradient
        
        context!.saveGState()
        
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        
        let colorLocations:[CGFloat] = [0.0, 0.5]
        let colors = [startColor.withAlphaComponent(0.4).cgColor, endColor.withAlphaComponent(0.4).cgColor]
        let gradient = CGGradient(colorsSpace: colorSpace,
                                  colors: colors as CFArray,
                                  locations: colorLocations)
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
        let startPoint = CGPoint(x:0.0, y: highestYPoint)
        let endPoint = CGPoint(x:0.0, y:self.bounds.height)
        
        context!.drawLinearGradient(gradient!, start: startPoint, end: endPoint, options: CGGradientDrawingOptions(rawValue: 0))
        context!.restoreGState()
        
        graphPath.lineWidth = 2.0
        graphPath.stroke()
        
        //Draw the circles on top of graph stroke
//        for i in 0...24 {
//            var point = CGPoint(x:columnXPoint(i), y:columnYPoint(graphPoints[i].temp!))
//            point.x -= 5.0/2
//            point.y -= 5.0/2
//            
//            let circle = UIBezierPath(ovalIn:
//                CGRect(origin: point,
//                       size: CGSize(width: 5.0, height: 5.0)))
//            circle.fill()
//            
//        }
        
        //Draw horizontal graph lines on the top of everything
//        let linePath = UIBezierPath()
//        
//        
//        linePath.move(to: CGPoint(x:0.0, y: topBorder))
//        linePath.addLine(to: CGPoint(x: width ,
//                                     y:topBorder))
//        
//        //center line
//        linePath.move(to: CGPoint(x:0.0,
//                                  y: graphHeight/2 + topBorder))
//        linePath.addLine(to: CGPoint(x:width,
//                                     y:graphHeight/2 + topBorder))
//        
//        //bottom line
//        linePath.move(to: CGPoint(x:0.0,
//                                  y:height - bottomBorder))
//        linePath.addLine(to: CGPoint(x:width,
//                                     y:height - bottomBorder))
//        let color = UIColor(white: 1.0, alpha: 0.3)
//        color.setStroke()
//        
//        linePath.lineWidth = 1.0
//        linePath.stroke()
        
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
        
        drawLables()
        drawIconImages()
        drawBottomLables(fromArray:pointsForTemp)

    }
    
    func drawLables() {
        
        let pointsToDraw: [ObjectForLableInfo] = calculatePointsForDegrees(degreesArray: pointsForTemp)
        
        for i in 0..<pointsToDraw.count {
            let numberOne = "\(pointsToDraw[i].degrees)\u{00B0}"
            let numberOneRect = CGRect.init(x: pointsToDraw[i].pointToPost.x, y: pointsToDraw[i].pointToPost.y, width: lableSize.width, height: lableSize.height)
            
            let font = UIFont(name: "HelveticaNeue-Medium", size: 19)
            
            let numberOneAttributes = [
                NSFontAttributeName: font!,
                NSForegroundColorAttributeName: UIColor.white]
            numberOne.draw(in: numberOneRect,
                           withAttributes:numberOneAttributes)
        }
        
    }
    
    func drawIconImages() {
        
        let pointsToDraw: [ObjectForIconinfo] = calculatePointsForImages(degreesArray: pointsForTemp)
        for i in 0..<pointsToDraw.count {
           let image = NSURL(string: pointsToDraw[i].iconUrl)
                .flatMap { NSData(contentsOf: $0 as URL) }
                .flatMap { UIImage(data: $0 as Data) }

            image?.draw(in: pointsToDraw[i].pointToPost)
            drawDashSeparateLines(degreesArray: pointsToDraw)
        }
    }
    
    func drawDashSeparateLines(degreesArray: Array<ObjectForIconinfo>) {
        let linePathHor = UIBezierPath()
        
        for i in 1..<degreesArray.count {
            linePathHor.move(to: degreesArray[i].startPoint)
            linePathHor.addLine(to: CGPoint(x: degreesArray[i].startPoint.x,
                                            y:height - 20))
        }
        
        let  dashes: [ CGFloat ] = [ 3.0, 3.0 ]
        linePathHor.setLineDash(dashes, count: dashes.count, phase: 0.0)
        linePathHor.lineCapStyle = .butt
        let colorWhite = UIColor.white
        colorWhite.setStroke()
        
        linePathHor.lineWidth = 1.0
        linePathHor.stroke()

    }
    
    func drawBottomLables(fromArray array:[CGPoint]) {
        let width = lableSize.width * 1.8
        for i in 1...24 {
            if i % 3 == 0 {
                let textRect = CGRect(x: array[i].x - width / 2, y: height, width: width, height: lableSize.height) // rect to display the view in
                let textMask = CATextLayer()
                
                textMask.contentsScale = UIScreen.main.scale // sets the layer's scale to the main screen scale
                textMask.foregroundColor = UIColor.white.cgColor // an opaque color so that the mask covers the text
                
                let myAttributes = [
                    NSFontAttributeName: UIFont(name: "HelveticaNeue-Medium", size: 19.0)! , // font
                    NSForegroundColorAttributeName: UIColor.white                    // text color
                ]
                let myAttributedString = NSAttributedString(string: "\(graphPoints[i].hour! > 12 ? graphPoints[i].hour! - 12 : graphPoints[i].hour!)\(graphPoints[i].ampm!)", attributes: myAttributes )
                textMask.string = myAttributedString // your text here
                
                textMask.alignmentMode = kCAAlignmentCenter // centered text
                textMask.frame = textRect
                self.layer.addSublayer(textMask)
            }
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
    
    func calculatePointsForDegrees(degreesArray:[CGPoint]) -> Array<ObjectForLableInfo> {
        var newArray = Array<ObjectForLableInfo>()
        let spacer = self.width / CGFloat(24)
        var point = degreesArray[0]
        var qtyOfElements: CGFloat = 0
        for i in 1...24 {
            if point.y == degreesArray[i].y && i != 24 {
                qtyOfElements += 1
            } else {
                if qtyOfElements == 0 {
                    let obj = ObjectForLableInfo(pointToPost: CGPoint(x: point.x - lableSize.height / 2, y: point.y - lableSize.width), degrees: graphPoints[i-1].temp!)
                    newArray.append(obj)
                    point = degreesArray[i]
                } else {
                    let obj = ObjectForLableInfo(pointToPost: CGPoint(x: point.x  + (qtyOfElements * spacer) / 2, y: point.y - lableSize.width), degrees: graphPoints[i-1].temp!)
                    newArray.append(obj)
                    point = degreesArray[i]
                    qtyOfElements = 0
                }
            }
        }
        return newArray
    }
    
    
    func calculatePointsForImages(degreesArray:[CGPoint]) -> Array<ObjectForIconinfo> {
        var newArray = Array<ObjectForIconinfo>()
        let spacer = width / CGFloat(24)
        var point = degreesArray[0]
        var icon = graphPoints[0].icon
        var qtyOfElements: CGFloat = 0
        for i in 1...24 {
            if icon == graphPoints[i].icon && i != 24 {
                qtyOfElements += 1
            } else {
                if qtyOfElements == 0 {
                    let obj = ObjectForIconinfo(pointToPost: CGRect(x: point.x, y: height - bottomBorder / 1.2, width: spacer, height: spacer), iconUrl: graphPoints[i-1].iconUrl!, iconDesc: graphPoints[i-1].icon!, startPoint:point)
                    newArray.append(obj)
                    point = degreesArray[i]
                    icon = graphPoints[i].icon
                } else {
                    let obj = ObjectForIconinfo(pointToPost: CGRect(x: point.x  + (qtyOfElements * spacer) / 2, y: height - bottomBorder / 1.2, width: spacer, height: spacer), iconUrl: graphPoints[i-1].iconUrl!, iconDesc: graphPoints[i-1].icon!, startPoint:point)
                    newArray.append(obj)
                    point = degreesArray[i]
                    icon = graphPoints[i].icon
                    qtyOfElements = 0
                }
            }
        }
        return newArray
    }
}

internal struct ObjectForLableInfo {
    var pointToPost: CGPoint
    var degrees: Int
}

internal struct ObjectForIconinfo {
    var pointToPost: CGRect
    var iconUrl: String
    var iconDesc: String
    var startPoint: CGPoint
}
