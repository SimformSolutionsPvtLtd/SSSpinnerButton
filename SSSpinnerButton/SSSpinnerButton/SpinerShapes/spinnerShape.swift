//
//  spinnerShape.swift
//  SSSpinnerButton
//
//  Created by Bhargav Bajani on 01/06/18.
//  Copyright © 2018 Simform Solutions. All rights reserved.
//

import Foundation
import UIKit

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
            layer.lineWidth = 3
        }
        
        layer.backgroundColor = nil
        layer.path = path.cgPath
        layer.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        
        return layer
    }
    
}
