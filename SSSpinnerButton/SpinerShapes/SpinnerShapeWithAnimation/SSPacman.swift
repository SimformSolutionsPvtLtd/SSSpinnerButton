//
//  SSPacman.swift
//  SSSpinnerButton
//
//  Created by Pranay Patel on 16/02/22.
//  Copyright © 2022 Simform Solutions. All rights reserved.
//

import Foundation

class SSPacman: SSSpinnerAnimationDelegate {
    
    func setupSpinnerAnimation(layer: CALayer, frame: CGRect, color: UIColor, spinnerSize: UInt?) {
        pacmanInLayer(layer, frame: frame, color: color)
        circleInLayer(layer, frame: frame, color: color)
    }
    
    func pacmanInLayer(_ layer: CALayer, frame: CGRect, color: UIColor) {
        let pacmanSize = frame.size.height / 3
        let pacmanDuration: CFTimeInterval = 1
        let timingFunction = CAMediaTimingFunction(name: .default)
        
        // Stroke start animation
        let strokeStartAnimation = CAKeyframeAnimation(keyPath: "strokeStart")
        
        strokeStartAnimation.keyTimes = [0, 0.5, 1]
        strokeStartAnimation.timingFunctions = [timingFunction, timingFunction]
        strokeStartAnimation.values = [0.125, 0, 0.125]
        strokeStartAnimation.duration = pacmanDuration
        
        // Stroke end animation
        let strokeEndAnimation = CAKeyframeAnimation(keyPath: "strokeEnd")
        
        strokeEndAnimation.keyTimes = [0, 0.5, 1]
        strokeEndAnimation.timingFunctions = [timingFunction, timingFunction]
        strokeEndAnimation.values = [0.875, 1, 0.875]
        strokeEndAnimation.duration = pacmanDuration
        
        // Animation
        let animation = CAAnimationGroup()
        
        animation.animations = [strokeStartAnimation, strokeEndAnimation]
        animation.duration = pacmanDuration
        animation.repeatCount = HUGE
        animation.isRemovedOnCompletion = false
        
        let pacman = SpinnerShape.pacman.layerWith(size: CGSize(width: pacmanSize, height: pacmanSize), color: color)
        let frame = CGRect(
            x: ((layer.bounds.size.height / 2) - (layer.bounds.size.height / 4)),
            y: (layer.bounds.size.height - pacmanSize) / 2,
            width: pacmanSize,
            height: pacmanSize
        )
        pacman.frame = frame
        pacman.add(animation, forKey: "animation")
        layer.addSublayer(pacman)

        
        }
    
    func circleInLayer(_ layer: CALayer, frame: CGRect, color: UIColor) {
        let circleSize = frame.size.height / 8
        let circleDuration: CFTimeInterval = 0.9
        
        // Translate animation
        let translateAnimation = CABasicAnimation(keyPath: "transform.translation.x")
        
        translateAnimation.fromValue = 0
        translateAnimation.toValue = -frame.size.height / 2
        translateAnimation.duration = circleDuration
        
        // Opacity animation
        let opacityAnimation = CABasicAnimation(keyPath: "opacity")
        
        opacityAnimation.fromValue = 1
        opacityAnimation.toValue = 0.7
        opacityAnimation.duration = circleDuration
        
        // Animation
        let animation = CAAnimationGroup()
        
        animation.animations = [translateAnimation, opacityAnimation]
        animation.timingFunction = CAMediaTimingFunction(name: .linear)
        animation.duration = circleDuration
        animation.repeatCount = HUGE
        animation.isRemovedOnCompletion = false
        
        let animatableLayer = SpinnerShape.circle.layerWith(size: CGSize(width: circleSize, height: circleSize), color: color)
        animatableLayer.frame = CGRect(x: ((layer.bounds.size.height / 2) + (layer.bounds.size.height / 4)), y: (layer.bounds.size.height - circleSize) / 2, width: circleSize, height: circleSize)
        animatableLayer.frame.size.height = circleSize
        animatableLayer.frame.size.width = circleSize
        animatableLayer.add(animation, forKey: "animation")
        layer.addSublayer(animatableLayer)
    }
}

