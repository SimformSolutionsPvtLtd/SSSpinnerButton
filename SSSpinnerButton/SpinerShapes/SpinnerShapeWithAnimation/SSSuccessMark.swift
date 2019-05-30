//
//  SSCheckMark.swift
//  SSSpinnerButton
//
//  Created by Ketan Chopda on 29/08/18.
//  Copyright © 2018 Simform Solutions. All rights reserved.
//

import UIKit
///
class SSSuccessMark: SSSpinnerAnimationDelegate {
    
    ///  setup spinner layer
    ///
    /// - Parameters:
    ///   - layer: layer Parent layer (Button layer)
    ///   - frame: frame of parant layer
    ///   - color: color of spinner
    ///   - spinnerSize: size of spinner
    func setupSpinnerAnimation(layer: CALayer, frame: CGRect, color: UIColor, spinnerSize: UInt?) {
        
        // add layer
        let successMark = CheckMarkShape.successMark.layerWith(frame: frame, color: color)
        layer.addSublayer(successMark)

        // end status
        let strokeEnd: CGFloat = 10
        successMark.strokeEnd = strokeEnd

        // animation
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = 1.0
        animation.fromValue = 0.0
        animation.toValue = strokeEnd
        successMark.add(animation, forKey: nil)
    }
    
}
