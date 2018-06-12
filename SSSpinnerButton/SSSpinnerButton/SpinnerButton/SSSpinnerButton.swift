//
//  SSSpinnerButton.swift
//  SSSpinnerButton
//
//  Created by Bhargav Bajani on 11/05/18.
//  Copyright © 2018 Simform Solutions. All rights reserved.
//

import Foundation
import UIKit

// MARK: - 
extension CAGradientLayer {
    convenience init(frame: CGRect) {
        self.init()
        self.frame = frame
    }
}

///
open class SSSpinnerButton: UIButton {
    // MARK: - Properties
    internal var storedTitle: String?
    internal var storedBackgroundNormalImage: UIImage?
    internal var storedBackgroundSelectedImage: UIImage?
    internal var storedBackgroundDisabledImage: UIImage?
    internal var storedBackgroundHighlightedImage: UIImage?
    internal var storedNormalImage: UIImage?
    internal var storedSelectedImage: UIImage?
    internal var storedDisabledImage: UIImage?
    internal var storedHighlightedImage: UIImage?
    internal var storedBackgroundColor: UIColor?
    fileprivate var animationDuration: CFTimeInterval = 0.1
    
    fileprivate var isAnimating: Bool = false
    
    fileprivate var spinnerType: SpinnerType = .ballClipRotate
    
    /// Sets the button corner radius
    @IBInspectable var cornrRadius: CGFloat = 0 {
        willSet {
            layer.cornerRadius = newValue
        }
    }
    
    /// Sets the spinner color
    public var spinnerColor: UIColor = UIColor.gray
    
    /// Sets the button title for its normal state
    public var title: String? {
        get {
            return self.title(for: .normal)
        }
        set {
            self.setTitle(newValue, for: .normal)
        }
    }
    
    /// Sets the button title color.
    public var titleColor: UIColor? {
        get {
            return self.titleColor
        }
        set {
            self.setTitleColor(newValue, for: .normal)
        }
    }
    
    // MARK: - Initializers
    public required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        setUp()
    }
    
    /// init method
    ///
    /// - Parameter title: button title for normal state
    public init(title: String) {
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        setUp()
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        clipsToBounds = true
         gradientLayer.frame = self.bounds
    }
    
    
    /// Gradient 
    internal lazy var gradientLayer: CAGradientLayer = {
        let gradient = CAGradientLayer(frame: self.frame)
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        self.layer.insertSublayer(gradient, at: 0)
        return gradient
    }()
    
    /// Sets the colors for the gradient background
    public var gradientColors: [UIColor]? {
        willSet {
            gradientLayer.colors = newValue?.map({$0.cgColor})
        }
    }
    
}

private extension SSSpinnerButton {
    
    /// Default setup of Button UI and Lable
    func setUp() {
        
        if self.cornrRadius == 0 {
            self.cornrRadius = self.layer.cornerRadius
        }
        self.layer.cornerRadius = self.cornrRadius
        self.layer.masksToBounds = true
        
        if self.image(for: .normal) != nil && self.title != nil {
            let spacing: CGFloat = 10
            // the amount of spacing to appear between image and title\
            self.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: spacing)
            self.titleEdgeInsets = UIEdgeInsets(top: 0, left: spacing, bottom: 0, right: 0)
        }
        
    }
    
}

public extension SSSpinnerButton {
    
    /// Start Animation
    ///
    /// - Parameters:
    ///   - spinnerType: spinner Type ( ballClipRotate(default), ballSpinFade, lineSpinFade, circleStrokeSpin, ballRotateChase)
    ///   - spinnercolor: color of spinner (default = gray)
    ///   - complete: complation block (call after animation start)
    public func startAnimate(spinnerType: SpinnerType = .ballClipRotate, spinnercolor: UIColor = .gray, complete: (() -> Void)?) {
        if self.cornrRadius == 0 {
            self.cornrRadius = self.layer.cornerRadius
        }
        
        self.stopAnimation()
        isAnimating = true
        self.spinnerColor = spinnercolor
        self.spinnerType = spinnerType
        
        self.layer.cornerRadius = self.frame.height / 2
        self.collapseAnimation(complete: complete)
        
    }
    
    /// stop Animation and set button in actual state
    ///
    /// - Parameter complete: complation block (call after animation Stop)
    public func stopAnimate(complete: (() -> Void)?) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            self.backToDefaults(complete: complete)
        })
        
    }
    
}

private extension SSSpinnerButton {
    
    /// stop animation of specific spinner
    func stopAnimation() {
        for item in layer.sublayers! where item is SpinnerLayers {
            item.removeAllAnimations()
            item.removeFromSuperlayer()
        }
    }
    
    /// collapse animation
    func collapseAnimation(complete: (() -> Void)?) {
        
        storedTitle = title
        title = ""
        storedBackgroundNormalImage = self.backgroundImage(for: .normal)
        storedBackgroundDisabledImage = self.backgroundImage(for: .disabled)
        storedBackgroundSelectedImage = self.backgroundImage(for: .selected)
        storedBackgroundHighlightedImage = self.backgroundImage(for: .highlighted)
        storedNormalImage = self.image(for: .normal)
        storedDisabledImage = self.image(for: .disabled)
        storedSelectedImage = self.image(for: .selected)
        storedHighlightedImage = self.image(for: .highlighted)
        storedBackgroundColor = self.backgroundColor
        self.setImage(nil, for: .normal)
        self.setImage(nil, for: .disabled)
        self.setImage(nil, for: .selected)
        self.setImage(nil, for: .highlighted)
        isUserInteractionEnabled = false
        let animaton = CABasicAnimation(keyPath: "bounds.size.width")
        animaton.fromValue = bounds.width
        animaton.toValue =  bounds.height
        animaton.duration = animationDuration
        animaton.fillMode = kCAFillModeBoth
        animaton.isRemovedOnCompletion = false
        layer.add(animaton, forKey: animaton.keyPath)
        self.perform(#selector(startSpinner), with: nil, afterDelay: animationDuration)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration, execute: {
            if complete != nil {
                complete!()
            }
        })
        
    }
    
    /// set back to default state of button
    func backToDefaults(complete: (() -> Void)?) {
        if !isAnimating {
            return
        }
        self.stopAnimation()
        setTitle(storedTitle, for: .normal)
        self.setBackgroundImage(self.storedBackgroundNormalImage, for: .normal)
        self.setBackgroundImage(self.storedBackgroundDisabledImage, for: .disabled)
        self.setBackgroundImage(self.storedBackgroundSelectedImage, for: .selected)
        self.setBackgroundImage(self.storedBackgroundHighlightedImage, for: .highlighted)
        self.setImage(storedNormalImage, for: .normal)
        self.setImage(storedDisabledImage, for: .disabled)
        self.setImage(storedSelectedImage, for: .selected)
        self.setImage(storedHighlightedImage, for: .highlighted)
        isUserInteractionEnabled = true
        
        let animaton = CABasicAnimation(keyPath: "bounds.size.width")
        
        animaton.fromValue = frame.height
        animaton.toValue = frame.width
        animaton.duration = animationDuration
        animaton.fillMode = kCAFillModeForwards
        animaton.isRemovedOnCompletion = false
        
        layer.add(animaton, forKey: animaton.keyPath)
        isAnimating = false
        self.layer.cornerRadius = self.cornrRadius
        if complete != nil {
            complete!()
        }
        
    }
    
    /// start spinner
    @objc func startSpinner() {
        
        let animation: SSSpinnerAnimationDelegate = self.spinnerType.animation()
        animation.setupSpinnerAnimation(layer: self.layer, frame: self.bounds, color: self.spinnerColor)
    }
    
}
