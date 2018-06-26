//
//  SSCheckMark.swift
//  SSSpinnerButton
//
//  Created by Bhargav Bajani on 07/06/18.
//  Copyright © 2018 Simform Solutions. All rights reserved.
//
import UIKit
import Foundation
///
class SSCheckMark: SSSpinnerAnimationDelegate {
    
    ///  setup spinner layer
    ///
    /// - Parameters:
    ///   - layer: layer Parent layer (Button layer)
    ///   - frame: frame of parant layer
    ///   - color: color of spinner
    func setupSpinnerAnimation(layer: CALayer, frame: CGRect, color: UIColor, completion: (() -> Void)?) {
        let defaultPadding: CGFloat = 4.0
                let sizeValue = max(min(frame.width, frame.height) - defaultPadding, 1.0)
                let center = CGPoint(x: (sizeValue/2) + (defaultPadding / 2), y: (sizeValue/2) + (defaultPadding / 2))
        
        
        let circleLayer = SpinnerLayers()
        
        let path = UIBezierPath()
        let startAngle = CGFloat((-90) / 180.0 * Double.pi) // 60
        
        let endAngle = CGFloat((200) / 180.0 * Double.pi)  // 190
        path.addArc(withCenter: center, radius: (sizeValue/2.0) - 3, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        path.move(to: CGPoint(x: sizeValue * 0.05 + 2, y: sizeValue * 0.3 ))
                path.addLine(to: CGPoint(x: sizeValue / 3 + 2, y: sizeValue * 0.8))
                path.addLine(to: CGPoint(x: sizeValue - 3 + 2, y: sizeValue * 0.2))
        
        
        circleLayer.position = CGPoint(x: 0,
                                       y: 0);
        circleLayer.path = path.cgPath
        circleLayer.fillColor = UIColor.clear.cgColor;
        circleLayer.strokeColor = color.cgColor
        circleLayer.lineCap = kCALineCapRound
        circleLayer.lineWidth = 2;
        circleLayer.actions = [
            "strokeStart": NSNull(),
            "strokeEnd": NSNull(),
            "transform": NSNull()
        ]
        layer.addSublayer(circleLayer)
        
        CATransaction.begin()
        let strokeStart = CABasicAnimation(keyPath: "strokeStart")
        let strokeEnd = CABasicAnimation(keyPath: "strokeEnd")
        strokeEnd.fromValue = 0.00
        strokeEnd.toValue = 0.93
        strokeEnd.duration = 00.5 // 0.0*factor
        let timing = CAMediaTimingFunction(controlPoints: 0.3, 0.6, 0.8, 1)
        strokeEnd.timingFunction = timing
        
        strokeStart.fromValue = 0.0
        strokeStart.toValue = 0
        strokeStart.duration =  0.25 // 7.0*factor
        strokeStart.beginTime =  CACurrentMediaTime() + 0.0 // *factor
        strokeStart.fillMode = kCAFillModeBackwards
        strokeStart.timingFunction = timing
        circleLayer.strokeStart = 0.72
       
        circleLayer.strokeEnd = 0.93
        CATransaction.setCompletionBlock {
            if completion != nil {
                completion!()
            }
            
            print("compete")
        }
        circleLayer.add(strokeEnd, forKey: "strokeEnd")
        circleLayer.add(strokeStart, forKey: "strokeStart")
        CATransaction.commit()
      
        
//        let defaultPadding: CGFloat = 4.0
//        let sizeValue = max(min(frame.width, frame.height) - defaultPadding, 1.0)
////        let center = CGPoint(x: (sizeValue/2) + (defaultPadding / 2), y: (sizeValue/2) + (defaultPadding / 2))
//
//        let path = UIBezierPath()
//        path.move(to: CGPoint(x: sizeValue * 0.25, y: sizeValue * 3 / 5))
//        path.addLine(to: CGPoint(x: sizeValue / 3, y: sizeValue - 5))
//        path.addLine(to: CGPoint(x: sizeValue - 5, y: sizeValue * 0.3))
//
//        let checkMarkLayer: CAShapeLayer = SpinnerLayers()
//        checkMarkLayer.backgroundColor = nil
//        checkMarkLayer.path = path.cgPath
//        checkMarkLayer.frame = CGRect(x: 0, y: 0, width: sizeValue, height: sizeValue)
//
//        checkMarkLayer.strokeColor = color.cgColor
//        checkMarkLayer.fillColor = nil
//        checkMarkLayer.lineWidth = 2
//        checkMarkLayer.lineJoin = kCALineJoinBevel
//
//        layer.addSublayer(checkMarkLayer)
//
//        let strokeEndAnimation = CABasicAnimation(keyPath: "strokeEnd")
//        strokeEndAnimation.duration = 0.5
//        strokeEndAnimation.timingFunction = CAMediaTimingFunction(controlPoints: 0.4, 0.0, 0.2, 1.0)
//        strokeEndAnimation.fromValue = 0
//        strokeEndAnimation.toValue = 1
//
//        checkMarkLayer.add(strokeEndAnimation, forKey: "strokeEnd")
        
    }
  
    
    
    
}
