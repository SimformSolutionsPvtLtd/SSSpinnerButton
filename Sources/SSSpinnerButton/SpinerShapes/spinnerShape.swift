//
//  spinnerShape.swift
//  SSSpinnerButton
//
//  Created by Bhargav Bajani on 01/06/18.
//  Copyright © 2018 Simform Solutions. All rights reserved.
//

import Foundation
import UIKit

/// Shape of checkmarks
///
/// - successMark:
/// - errorMark:
/// - failMark:
enum CheckMarkShape {
    case successMark
    case errorMark
    case failMark
    
    /// Return CALayer of specific shape
    ///
    /// - Parameters:
    ///   - frame: frame for draw area
    ///   - color: color of layer
    /// - Returns: CALayer of shape
    func layerWith(frame: CGRect, color: UIColor) -> CAShapeLayer {
        let layer: CAShapeLayer = SpinnerLayers()
        let path: UIBezierPath = UIBezierPath()
        switch self {
        case .successMark:
            layer.lineWidth = 2.5
            layer.strokeColor = color.cgColor
            layer.fillColor = UIColor.clear.cgColor
            let centerPoint = CGPoint(x: frame.height / 2, y: frame.width / 2)
            var firstPoint: CGPoint = centerPoint
            // Line 1
            firstPoint.x = frame.height * 0.2
            firstPoint.y = frame.height * 0.5
            path.move(to: firstPoint)
            var secondPoint: CGPoint = centerPoint
            secondPoint.x = frame.height * 0.35
            secondPoint.y = frame.height * 0.75
            path.addLine(to: secondPoint)
            // Line 2
            var thirdPoint: CGPoint = centerPoint
            thirdPoint.x = frame.height * 0.75
            thirdPoint.y = frame.height * 0.35
            path.addLine(to: thirdPoint)
        case .errorMark:
            layer.lineWidth = 4
            layer.strokeColor = color.cgColor
            layer.fillColor = color.cgColor
            let centerPoint = CGPoint(x: frame.height / 2, y: frame.width / 2)
            // Line 1
            var firstPoint: CGPoint = centerPoint
            firstPoint.x = frame.height * 0.5
            firstPoint.y = frame.height * 0.25
            path.move(to: firstPoint)
            var secondPoint: CGPoint = centerPoint
            secondPoint.x = frame.height * 0.5
            secondPoint.y = frame.height * 0.65
            path.addLine(to: secondPoint)
            // Line 2
            var thirdPoint: CGPoint = centerPoint
            thirdPoint.x = frame.height * 0.5
            thirdPoint.y = frame.height * 0.8
            path.move(to: thirdPoint)
            path.addArc(withCenter: thirdPoint, radius: 0.8, startAngle: 0, endAngle: CGFloat(360.toRadians), clockwise: true)
        case .failMark:
            layer.lineWidth = 2.5
            layer.strokeColor = color.cgColor
            layer.fillColor = UIColor.clear.cgColor
            let centerPoint = CGPoint(x: frame.height / 2, y: frame.width / 2)
            // Line 1
            var firstPoint: CGPoint = centerPoint
            firstPoint.x = frame.height * 0.25
            firstPoint.y = frame.height * 0.25
            path.move(to: firstPoint)
            var secondPoint: CGPoint = centerPoint
            secondPoint.x = frame.height * 0.75
            secondPoint.y = frame.height * 0.75
            path.addLine(to: secondPoint)
            // Line 2
            var thirdPoint: CGPoint = centerPoint
            thirdPoint.x = frame.height * 0.75
            thirdPoint.y = frame.height * 0.25
            path.move(to: thirdPoint)
            var fourthPoint: CGPoint = centerPoint
            fourthPoint.x = frame.height * 0.25
            fourthPoint.y = frame.height * 0.75
            path.addLine(to: fourthPoint)
        }
        
        layer.backgroundColor = nil
        layer.path = path.cgPath
        layer.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        return layer
    }
    
}

/// Shape of spinners
///
/// - ring:
/// - circle:
/// - line:
/// - stroke:
enum SpinnerShape {
    case ring
    case circle
    case line
    case stroke
    
    /// Return CALayer of specific shape
    ///
    /// - Parameters:
    ///   - size: size of draw shape area
    ///   - color: color of shape
    /// - Returns: CAlayer of shape
    func layerWith(size: CGSize, color: UIColor) -> CALayer {
        let layer: CAShapeLayer = SpinnerLayers()
        var path: UIBezierPath = UIBezierPath()
        
        switch self {
        case .circle:
            path.addArc(withCenter: CGPoint(x: size.width / 2, y: size.height / 2),
                        radius: (size.width / 2),
                        startAngle: 0,
                        endAngle: CGFloat(2 * Double.pi),
                        clockwise: false)
            layer.fillColor = color.cgColor
            
        case .ring:
            path.addArc(withCenter: CGPoint(x: size.width / 2, y: size.height / 2),
                        radius: (size.width / 2),
                        startAngle: CGFloat(-3 * Double.pi / 4),
                        endAngle: CGFloat(-Double.pi / 4),
                        clockwise: false)
            layer.fillColor = nil
            layer.strokeColor = color.cgColor
            layer.lineWidth = 2
            
        case .line:
            path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: size.width, height: size.height),
                                cornerRadius: size.width / 2)
            layer.fillColor = color.cgColor
            
        case .stroke:
            path.addArc(withCenter: CGPoint(x: size.width / 2, y: size.height / 2),
                        radius: size.width / 2,
                        startAngle: -(.pi / 2),
                        endAngle: .pi + .pi / 2,
                        clockwise: true)
            layer.fillColor = nil
            layer.strokeColor = color.cgColor
            layer.lineWidth = 2
        }
        layer.backgroundColor = nil
        layer.path = path.cgPath
        layer.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        
        return layer
    }

}
