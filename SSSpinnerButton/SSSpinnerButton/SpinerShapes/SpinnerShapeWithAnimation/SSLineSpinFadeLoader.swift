//
//  SSLineSpinFadeLoader2.swift
//  SSSpinnerButton
//
//  Created by Bhargav Bajani on 01/06/18.
//  Copyright © 2018 Simform Solutions. All rights reserved.
//

import Foundation
import UIKit

/// 
class SSLineSpinFadeLoader: SSSpinnerAnimationDelegate {
    
    /// setup spinner layer
    ///
    /// - Parameters:
    ///   - layer: layer Parent layer (Button layer)
    ///   - frame: frame of parant layer
    ///   - color: color of spinner
    func setupSpinnerAnimation(layer: CALayer, frame: CGRect, color: UIColor) {
        
        let defaultPadding: CGFloat = 4.0
        
        let sizeValue = max(min(frame.width, frame.height) - defaultPadding, 1.0)
        let center = CGPoint(x: (sizeValue/2) + (defaultPadding / 2), y: (sizeValue/2) + (defaultPadding / 2))
        let duration: CFTimeInterval = 1.2
        let beginTime = CACurrentMediaTime()
        let beginTimes: [CFTimeInterval] = [0.12, 0.24, 0.36, 0.48, 0.6, 0.72, 0.84, 0.96]
        let timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        // Animation
        let animation = CAKeyframeAnimation(keyPath: "opacity")
        
        animation.keyTimes = [0, 0.5, 1]
        animation.timingFunctions = [timingFunction, timingFunction]
        animation.values = [1, 0.1, 1]
        animation.duration = duration
        animation.repeatCount = HUGE
        animation.isRemovedOnCompletion = false
        
        let lineSpacing: CGFloat = 2
        let lineSize = CGSize(width: max((sizeValue - 4 * lineSpacing) / 8, 1.0), height: max((sizeValue - 2 * lineSpacing) / 3, 1.0))
       
        // Draw lines
        for i in 0 ..< 8 {
            let line = lineAt(angle: CGFloat(Double.pi / 4 * Double(i)),
                              size: lineSize,
                              origin: center,
                              containerSize: CGSize(width: sizeValue, height: sizeValue),
                              color: color)
            
            
            animation.beginTime = beginTime + beginTimes[i]
            line.add(animation, forKey: "animation")
            layer.addSublayer(line)
        }
        
        
    }
    
    func lineAt(angle: CGFloat, size: CGSize, origin: CGPoint, containerSize: CGSize, color: UIColor) -> CALayer {
        let radius = (containerSize.width / 2 - max(size.width, size.height) / 2) - 2
        let lineContainerSize = CGSize(width: max(size.width, size.height), height: max(size.width, size.height))
        let lineContainer = SpinnerLayers()
        let lineContainerFrame = CGRect(
            x: origin.x + radius * (cos(angle) - 0.5),
            y: origin.y + radius * (sin(angle) - 0.5),
            width: lineContainerSize.width,
            height: lineContainerSize.height)
        let line = SpinnerShape.line.layerWith(size: size, color: color)
        let lineFrame = CGRect(
            x: (lineContainerSize.width - size.width) / 2,
            y: (lineContainerSize.height - size.height) / 2,
            width: size.width,
            height: size.height)
        
        lineContainer.frame = lineContainerFrame
        line.frame = lineFrame
        lineContainer.addSublayer(line)
        lineContainer.sublayerTransform = CATransform3DMakeRotation(CGFloat(Double.pi / 2) + angle, 0, 0, 1)
        
        return lineContainer
    }
    
}
