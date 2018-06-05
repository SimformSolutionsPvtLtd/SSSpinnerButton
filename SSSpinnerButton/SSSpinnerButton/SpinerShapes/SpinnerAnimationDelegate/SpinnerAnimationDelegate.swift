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
    func setupSpinnerAnimation(layer: CALayer, frame: CGRect, color: UIColor)
}
