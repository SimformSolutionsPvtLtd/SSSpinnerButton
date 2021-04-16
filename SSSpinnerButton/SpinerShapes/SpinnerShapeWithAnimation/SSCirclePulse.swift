//
//  SSCirclePulse.swift
//  SSSpinnerButton
//
//  Created by Pranay Patel on 16/04/21.
//  Copyright © 2021 Simform Solutions. All rights reserved.
//

import Foundation

class SSCirclePulse: SSSpinnerAnimationDelegate {
    
    /// setup spinner layer
    ///
    /// - Parameters:
    ///   - layer: layer Parent layer (Button layer)
    ///   - frame: frame of parant layer
    ///   - color: color of spinner
    ///   - spinnerSize: size of spinner layer
    func setupSpinnerAnimation(layer: CALayer, frame: CGRect, color: UIColor, spinnerSize: UInt?) {
        var sizeValue = min(frame.width, frame.height)
        var center = CGPoint(x: 0, y: 0)
        if spinnerSize != nil && CGFloat(spinnerSize!) < sizeValue {
            sizeValue =  max(CGFloat(spinnerSize!), 1.0)
            center = CGPoint(x: frame.height / 2 - sizeValue / 2, y: frame.height / 2 - sizeValue / 2)
        }
        // Inner circle
        let circleClip = SpinnerShape.circle.layerWith(size: CGSize(width: sizeValue, height: sizeValue), color: color)
        circleClip.frame = CGRect(x: center.x, y: center.y, width: sizeValue, height: sizeValue)
        circleClip.frame.size.height = sizeValue
        circleClip.frame.size.width = sizeValue
        layer.addSublayer(circleClip)
        
        let scaleAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        scaleAnimation.keyTimes = [0, 0.5, 1].map { NSNumber(value: $0) }
        scaleAnimation.values = [1, 0.4, 1].map { NSNumber(value: $0) }
        
        // Inner circle zoomIn and zoomOut animation
        let animationGroup = CAAnimationGroup()
        animationGroup.duration = 2
        animationGroup.repeatCount = .infinity
        animationGroup.animations = [scaleAnimation]
        circleClip.add(animationGroup, forKey: "animation")
        
        // Pulse circle
        let animatableLayer = SpinnerShape.circle.layerWith(size: CGSize(width: sizeValue, height: sizeValue), color: color)
        animatableLayer.frame = CGRect(x: center.x, y: center.y, width: sizeValue, height: sizeValue)
        animatableLayer.frame.size.height = sizeValue
        animatableLayer.frame.size.width = sizeValue
        layer.addSublayer(animatableLayer)
        
        // Inner circle zoomIn and zoomOut animation
        let layerAnimation = CABasicAnimation(keyPath: "transform.scale")
        layerAnimation.fromValue = 0.7
        layerAnimation.toValue = 2
        layerAnimation.isAdditive = false

        let layerAnimation2 = CABasicAnimation(keyPath: "opacity")
        layerAnimation2.fromValue = 1.5
        layerAnimation2.toValue = 0
        layerAnimation2.isAdditive = false

        let groupAnimation = CAAnimationGroup()
        groupAnimation.animations = [layerAnimation, layerAnimation2]
        groupAnimation.duration = CFTimeInterval(2)
        groupAnimation.fillMode = CAMediaTimingFillMode.forwards
        groupAnimation.isRemovedOnCompletion = true
        groupAnimation.repeatCount = .infinity
        animatableLayer.add(groupAnimation, forKey: "growingAnimation")
    }
}
