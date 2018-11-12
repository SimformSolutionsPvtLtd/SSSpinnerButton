//
//  SSErrorMark.swift
//  SSSpinnerButton
//
//  Created by Ketan Chopda on 30/08/18.
//  Copyright © 2018 Simform Solutions. All rights reserved.
//

import UIKit
import Foundation
///
class SSErrorMark: SSSpinnerAnimationDelegate {
    
    /// setup spinner layer
    ///
    /// - Parameters:
    ///   - layer: layer Parent layer (Button layer)
    ///   - frame: frame of parant layer
    ///   - color: color of spinner
    ///   - spinnerSize: size of spinner layer
    func setupSpinnerAnimation(layer: CALayer, frame: CGRect, color: UIColor, spinnerSize: UInt?) {
        
        // add layer
        let errorMark = CheckMarkShape.errorMark.layerWith(frame: frame, color: color)
        layer.addSublayer(errorMark)

        // end status
        let strokeEnd: CGFloat = 10
        errorMark.strokeEnd = strokeEnd

        // animation
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = 2.0
        animation.fromValue = 0.0
        animation.toValue = strokeEnd
        animation.isRemovedOnCompletion = true
        errorMark.add(animation, forKey: animation.keyPath)
        
        // shake animation
        let anim = CABasicAnimation(keyPath: "transform.rotation.z")
        anim.fromValue = (-Double.pi / 10)
        anim.toValue = (Double.pi / 10)
        anim.duration = 0.08
        anim.repeatCount = 4
        anim.autoreverses = true
        anim.isRemovedOnCompletion = true
        layer.add(anim, forKey: anim.keyPath)
    }
    
}
