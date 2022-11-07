//
//  SSCircleWave.swift
//  SSSpinnerButton
//
//  Created by Pranay Patel on 16/04/21.
//  Copyright © 2021 Simform Solutions. All rights reserved.
//

import Foundation
import UIKit

class SSCircleWaveSpin: SSSpinnerAnimationDelegate {
    
    ///  setup spinner layer
    ///
    /// - Parameters:
    ///   - layer: layer Parent layer (Button layer)
    ///   - frame: frame of parant layer
    ///   - color: color of spinner
    ///   - spinnerSize: size of spinner
    var pulseLayers = [CAShapeLayer]()

    func setupSpinnerAnimation(layer: CALayer, frame: CGRect, color: UIColor, spinnerSize: UInt?) {
        for _ in 0...3 {
            let pulseLayerPath = UIBezierPath(arcCenter: .zero, radius: CGFloat(spinnerSize ?? 0) , startAngle: CGFloat(0), endAngle: CGFloat(Double.pi * 2), clockwise: true)
            let pulseLayer = SpinnerLayers()
            pulseLayer.path = pulseLayerPath.cgPath
            pulseLayer.lineWidth = 1.0
            pulseLayer.fillColor = UIColor.clear.cgColor
            pulseLayer.lineCap = CAShapeLayerLineCap.round
            pulseLayer.position = CGPoint(x: CGFloat(spinnerSize ?? 0) , y: CGFloat(spinnerSize ?? 0))
            layer.addSublayer(pulseLayer)
            pulseLayers.append(pulseLayer)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.animation(index: 0, color: color)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.animation(index: 1, color: color)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    self.animation(index: 2, color: color)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                        self.animation(index: 3, color: color)
                    }
                }
            }
        }
    }
    
    func animation(index: Int, color: UIColor) {
        pulseLayers[index].strokeColor = color.cgColor
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.duration = 1.5
        animation.toValue = 0.9
        animation.fromValue = 0.0
        animation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        animation.repeatCount = .infinity
        pulseLayers[index].add(animation, forKey: "scale")
        
        let opacityAnimation = CABasicAnimation(keyPath: #keyPath(CALayer.opacity))
        opacityAnimation.duration = 2.0
        opacityAnimation.toValue = 0.0
        opacityAnimation.fromValue = 0.9
        opacityAnimation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        opacityAnimation.repeatCount = .infinity
        pulseLayers[index].add(animation, forKey: "opacity")
    }
}
