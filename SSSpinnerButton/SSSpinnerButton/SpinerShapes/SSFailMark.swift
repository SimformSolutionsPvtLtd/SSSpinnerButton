//
//  SSErrorMark.swift
//  SSSpinnerButton
//
//  Created by Bhargav Bajani on 07/06/18.
//  Copyright © 2018 Simform Solutions. All rights reserved.
//
import UIKit
import Foundation
///
class SSFailMark: SSSpinnerAnimationDelegate {
    
    /// setup spinner layer
    ///
    /// - Parameters:
    ///   - layer: layer Parent layer (Button layer)
    ///   - frame: frame of parant layer
    ///   - color: color of spinner
    ///   - spinnerSize: size of spinner
    func setupSpinnerAnimation(layer: CALayer, frame: CGRect, color: UIColor, spinnerSize: UInt?) {

        // add layer
        let failMark = CheckMarkShape.failMark.layerWith(frame: frame, color: color)
        layer.addSublayer(failMark)
        
        // end status
        let strokeEnd: CGFloat = 10
        failMark.strokeEnd = strokeEnd
        
        // animation
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = 3.0
        animation.fromValue = 0.0
        animation.toValue = strokeEnd
        failMark.add(animation, forKey: nil)
        
    }
    
}
