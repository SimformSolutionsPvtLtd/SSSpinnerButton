//
//  SpinnerAnimationDelegate.swift
//  SSSpinnerButton
//
//  Created by Bhargav Bajani on 01/06/18.
//  Copyright © 2018 Simform Solutions. All rights reserved.
//

import Foundation
import UIKit

/// 
protocol SSSpinnerAnimationDelegate {
    
    /// setup spinner layer
    ///
    /// - Parameters:
    ///   - layer: layer Parent layer (Button layer)
    ///   - frame: frame of parant layer
    ///   - color: color of spinner
    ///   - spinnerSize: size of spinner layer
    func setupSpinnerAnimation(layer: CALayer, frame: CGRect, color: UIColor, spinnerSize: UInt?)

}
