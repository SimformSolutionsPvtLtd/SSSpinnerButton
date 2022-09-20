//
//  Extensions.swift
//  SSSpinnerButton
//
//  Created by Ketan Chopda on 30/08/18.
//  Copyright © 2018 Simform Solutions. All rights reserved.
//

import Foundation

// MARK: - return angle to degree/ radians
extension FloatingPoint {
    var toRadians: Self { return self * .pi / 180 }
    var toDegree: Self { return self * 180 / .pi }
}
