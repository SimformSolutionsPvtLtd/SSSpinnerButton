//
//  SsspinerBallClipRotate2.swift
//  SSSpinnerButton
//
//  Created by Bhargav Bajani on 01/06/18.
//  Copyright © 2018 Simform Solutions. All rights reserved.
//

import Foundation
import UIKit

/// 
class SSSpinnerBallClipRotate: SSSpinnerAnimationDelegate {
    
    ///  setup spinner layer
    ///
    /// - Parameters:
    ///   - layer: layer Parent layer (Button layer)
    ///   - frame: frame of parant layer
    ///   - color: color of spinner
    func setupSpinnerAnimation(layer: CALayer, frame: CGRect, color: UIColor) {
       
        let sizeValue = min(frame.width, frame.height)

        let ballClip = SpinnerShape.ring.layerWith(size: CGSize(width: sizeValue, height: sizeValue), color: color)
        ballClip.frame = CGRect(x: 0, y: 0, width: sizeValue, height: sizeValue)
        
        layer.addSublayer(ballClip)
        
        let scaleAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        
        scaleAnimation.keyTimes = [0, 0.5, 1].map { NSNumber(value: $0) }
        scaleAnimation.values = [0.8, 0.4, 0.8].map { NSNumber(value: $0) }
        
        // Rotate animation
        let rotateAnimation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
        
        rotateAnimation.keyTimes = scaleAnimation.keyTimes
        rotateAnimation.values = [0, Double.pi, 2 * Double.pi].map { NSNumber(value: $0) }
        let animationGroup = CAAnimationGroup()
        animationGroup.duration = 1
        animationGroup.repeatCount = .infinity
        animationGroup.animations = [scaleAnimation, rotateAnimation]
        ballClip.add(animationGroup, forKey: "animation")
    }
    
}
