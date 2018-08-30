//
//  SpinnerTypes.swift
//  SSSpinnerButton
//
//  Created by Bhargav Bajani on 01/06/18.
//  Copyright © 2018 Simform Solutions. All rights reserved.
//

import Foundation
import UIKit

/// Spinner Types
///
/// - ballClipRotate:
/// - ballSpinFade:
/// - lineSpinFade:
/// - ballRotateChase:
/// - circleStrokeSpin:
/// - checkMark:
/// - failMark:
/// - errorMark:
public enum SpinnerType: Int {
    /**
     BallClipRotate.
     
     - returns: Instance of SSSpinnerBallClipRotate.
     */
    case ballClipRotate
    /**
     BallSpinFade.
     
     - returns: Instance of SSBallSpinFadeLoader.
     */
    case ballSpinFade
    /**
     LineSpinFade.
     
     - returns: Instance of SSLineSpinFadeLoader.
     */
    case lineSpinFade
    /**
     BallRotateChase.
     
     - returns: Instance of SSBallRotateChase.
     */
    case ballRotateChase
    /**
     CircleStrokeSpin.
     
     - returns: Instance of SSCircleStrokeSpin.
     */
    case circleStrokeSpin
    /**
     CircleStrokeSpin.
     
     - returns: Instance of SSCheckMark.
     */
    case checkMark
    /**
     CircleStrokeSpin.
     
     - returns: Instance of SSFailMark.
     */
    case failMark
    /**
     CircleStrokeSpin.
     
     - returns: Instance of SSErrorMark.
     */
    case errorMark
    
    /// Animation of spinner
    ///
    /// - Returns: 
    func animation() -> SSSpinnerAnimationDelegate {
        switch self {
        case .ballClipRotate:
            return SSSpinnerBallClipRotate()
        case .ballSpinFade:
            return SSBallSpinFadeLoader()
        case .lineSpinFade:
            return SSLineSpinFadeLoader()
        case .ballRotateChase:
            return SSBallRotateChase()
        case .circleStrokeSpin:
            return SSCircleStrokeSpin()
        case .checkMark:
            return SSSuccessMark()
        case .failMark:
            return SSFailMark()
        case .errorMark:
            return SSErrorMark()
        }
    }
    
}
