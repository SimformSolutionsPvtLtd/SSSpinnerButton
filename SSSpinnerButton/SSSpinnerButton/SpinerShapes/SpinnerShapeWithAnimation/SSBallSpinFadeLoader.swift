//
//  SSBallSpinFadeLoader2.swift
//  SSSpinnerButton
//
//  Created by Bhargav Bajani on 01/06/18.
//  Copyright © 2018 Simform Solutions. All rights reserved.
//

import Foundation
import UIKit

///
class SSBallSpinFadeLoader: SSSpinnerAnimationDelegate {
    
    /// setup spinner layer
    ///
    /// - Parameters:
    ///   - layer: layer Parent layer (Button layer)
    ///   - frame: frame of parant layer
    ///   - color: color of spinner
    func setupSpinnerAnimation(layer: CALayer, frame: CGRect, color: UIColor) {
        
        let sizeValue = min(frame.width, frame.height)
        let center = CGPoint(x: (sizeValue/2.25), y: (sizeValue/2.25))
        let circleSpacing: CGFloat = 1
        let circleSize = (sizeValue  * circleSpacing) / 8
        
        let duration: CFTimeInterval = 1
        let beginTime = CACurrentMediaTime()
        let beginTimes: [CFTimeInterval] = [0, 0.12, 0.24, 0.36, 0.48, 0.6, 0.72, 0.84]
        
        // Scale animation
        let scaleAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        
        scaleAnimation.keyTimes = [0, 0.5, 1]
        scaleAnimation.values = [1, 0.4, 1]
        scaleAnimation.duration = duration
        
        // Opacity animation
        let opacityAnimaton = CAKeyframeAnimation(keyPath: "opacity")
        
        opacityAnimaton.keyTimes = [0, 0.5, 1]
        opacityAnimaton.values = [1, 0.3, 1]
        opacityAnimaton.duration = duration
        
        // Animation
        let animation = CAAnimationGroup()
        
        animation.animations = [scaleAnimation, opacityAnimaton]
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation.duration = duration
        animation.repeatCount = HUGE
        animation.isRemovedOnCompletion = false
        
        for i in 0 ..< 8 {
            let circle = circleAt(angle: CGFloat(Double.pi / 4) * CGFloat(i),
                                  size: circleSize,
                                  origin: center,
                                  containerSize: CGSize(width: sizeValue, height: sizeValue),
                                  color: color)
            
            animation.beginTime = beginTime + beginTimes[i]
            circle.add(animation, forKey: "animation")
            layer.addSublayer(circle)
        }

    }
    
    
    /// layer of Circle
    ///
    /// - Parameters:
    ///   - angle: position angle of circle
    ///   - size: size of spinner
    ///   - origin: center of spinner
    ///   - containerSize:
    ///   - color: spinner color
    /// - Returns: 
    func circleAt(angle: CGFloat, size: CGFloat, origin: CGPoint, containerSize: CGSize, color: UIColor) -> CALayer {
         let radius = (containerSize.width / 2 - size / 2 ) - 4
        let circle = SpinnerShape.circle.layerWith(size: CGSize(width: size, height: size), color: color)
        let frame = CGRect(
            x: origin.x + radius * (cos(angle)),
            y: origin.y + radius * (sin(angle)),
            width: size,
            height: size)
        
        circle.frame = frame
        
        return circle
    }
    
}
