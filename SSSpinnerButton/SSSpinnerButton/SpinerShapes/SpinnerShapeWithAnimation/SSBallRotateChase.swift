//
//  SSBallRotateChase.swift
//  SSSpinnerButton
//
//  Created by Bhargav Bajani on 01/06/18.
//  Copyright © 2018 Simform Solutions. All rights reserved.
//

import Foundation
import UIKit
///
class SSBallRotateChase: SSSpinnerAnimationDelegate {
    
    /// setup spinner layer
    ///
    /// - Parameters:
    ///   - layer: layer Parent layer (Button layer)
    ///   - frame: frame of parant layer
    ///   - color: color of spinner
    func setupSpinnerAnimation(layer: CALayer, frame: CGRect, color: UIColor) {
        
        let defaultPadding: CGFloat = 10.0
        
        let size =  max(min(frame.width, frame.height) - defaultPadding, 1.0)
        let center = CGPoint(x: (size/2) + (defaultPadding / 2), y: (size/2) + (defaultPadding / 2))
        let circleSize = size / 6
        for i in 0 ..< 5 {
            let factor = Float(i) * 1 / 5
            let circle = SpinnerShape.circle.layerWith(size: CGSize(width: circleSize, height: circleSize), color: color)
            let animation = rotateAnimation(factor, x: center.x, y: center.y, size: CGSize(width: size - circleSize, height: size - circleSize))
            
            circle.frame = CGRect(x: 0, y: 0, width: circleSize, height: circleSize)
            circle.add(animation, forKey: "animation")
            layer.addSublayer(circle)
        }
    }
    
    
    /// Rotate animation
    ///
    /// - Parameters:
    ///   - rate: rate of rotation
    ///   - x: X value of center
    ///   - y: Y value of center
    ///   - size: size of spinner
    /// - Returns: Rotate Animation group
    func rotateAnimation(_ rate: Float, x: CGFloat, y: CGFloat, size: CGSize) -> CAAnimationGroup {
        let duration: CFTimeInterval = 1.5
        let fromScale = 1 - rate
        let toScale = 0.2 + rate
        let timeFunc = CAMediaTimingFunction(controlPoints: 0.5, 0.15 + rate, 0.25, 1)
        
        // Scale animation
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.duration = duration
        scaleAnimation.repeatCount = HUGE
        scaleAnimation.fromValue = fromScale
        scaleAnimation.toValue = toScale
        
        // Position animation
        let positionAnimation = CAKeyframeAnimation(keyPath: "position")
        positionAnimation.duration = duration
        positionAnimation.repeatCount = HUGE
        positionAnimation.path = UIBezierPath(arcCenter: CGPoint(x: x, y: y), radius: size.width / 2, startAngle: CGFloat(3 * Double.pi * 0.5), endAngle: CGFloat(3 * Double.pi * 0.5 + 2 * Double.pi), clockwise: true).cgPath
        
        // Aniamtion
        let animation = CAAnimationGroup()
        animation.animations = [scaleAnimation, positionAnimation]
        animation.timingFunction = timeFunc
        animation.duration = duration
        animation.repeatCount = HUGE
        animation.isRemovedOnCompletion = false
        
        return animation
    }
    
}
