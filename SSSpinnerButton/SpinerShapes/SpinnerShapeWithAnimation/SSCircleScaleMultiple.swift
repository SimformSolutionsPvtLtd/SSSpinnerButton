//
//  SSCirclePulse.swift
//  SSSpinnerButton
//
//  Created by Pranay Patel on 16/04/21.
//  Copyright © 2021 Simform Solutions. All rights reserved.
//

import Foundation

class SSCircleScaleMultiple: SSSpinnerAnimationDelegate {
    
    /// setup spinner layer
    ///
    /// - Parameters:
    ///   - layer: layer Parent layer (Button layer)
    ///   - frame: frame of parant layer
    ///   - color: color of spinner
    ///   - spinnerSize: size of spinner layer
    func setupSpinnerAnimation(layer: CALayer, frame: CGRect, color: UIColor, spinnerSize: UInt?) {
        let sizeValue = min(frame.width, frame.height)
        let center = CGPoint(x: 0, y: 0)
        let duration: CFTimeInterval = 1
        let beginTime = CACurrentMediaTime()
        let beginTimes = [0, 0.2, 0.4]

        // Scale animation
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")

        scaleAnimation.duration = duration
        scaleAnimation.fromValue = 0
        scaleAnimation.toValue = 1

        // Opacity animation
        let opacityAnimation = CAKeyframeAnimation(keyPath: "opacity")
        opacityAnimation.duration = duration
        opacityAnimation.keyTimes = [0, 0.05, 1]
        opacityAnimation.values = [0, 1, 0]

        // Animation
        let animation = CAAnimationGroup()

        animation.animations = [scaleAnimation, opacityAnimation]
        animation.timingFunction = CAMediaTimingFunction(name: .linear)
        animation.duration = duration
        animation.repeatCount = HUGE
        animation.isRemovedOnCompletion = false

        // Draw balls
        for i in 0 ..< 3 {
            let circle = SpinnerShape.circle.layerWith(size: CGSize(width: sizeValue, height: sizeValue), color: color)
            let frame = CGRect(x: center.x, y: center.y, width: sizeValue, height: sizeValue)
            animation.beginTime = beginTime + beginTimes[i]
            circle.frame = frame
            circle.opacity = 0
            circle.add(animation, forKey: "animation")
            layer.addSublayer(circle)
        }
    }
}
