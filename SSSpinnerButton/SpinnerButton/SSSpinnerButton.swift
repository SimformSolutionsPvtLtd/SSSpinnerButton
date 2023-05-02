//
//  SSSpinnerButton.swift
//  SSSpinnerButton
//
//  Created by Bhargav Bajani on 11/05/18.
//  Copyright © 2018 Simform Solutions. All rights reserved.
//

import Foundation
import UIKit

public enum CompletionType {
    case none
    case success
    case error
    case fail
}
///
open class SSSpinnerButton: UIButton {
    // MARK: - Properties
    internal var storedNormalTitle: String?
    internal var storedSelectedTitle: String?
    internal var storedDisableTitle: String?
    internal var storedHighlitedTitle: String?
    
    public var rippleEffectAnimationDuration = 0.0
    public var initialOpacity = 0.0
    public var rippleEffectColor = UIColor.white
    public var rippleEffectPercent = CGFloat(0.0)
    public var initialRippleEffectPercent: CGFloat = CGFloat(0.0)
    
    internal var storedAttributedNormalTitle: NSAttributedString?
    internal var storedAttributedSelectedTitle: NSAttributedString?
    internal var storedAttributedDisableTitle: NSAttributedString?
    internal var storedAttributedHighlitedTitle: NSAttributedString?
    
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
    
    fileprivate var spinnerType: SpinnerType = Config.spinnerType
    
    fileprivate var storedWidth: CGFloat?
    fileprivate var storedHeight: CGFloat?
    
    /// Sets the button corner radius
    @IBInspectable var cornerRadius: CGFloat = 0 {
        willSet {
            layer.cornerRadius = newValue
        }
    }
    @IBInspectable var setRippleEffect: Bool = false {
        didSet {
            if setRippleEffect {
                self.setRippleEffect(rippleEffectAnimationDuration: 0.3, initialOpacity: 0.5, rippleEffectColor: rippleEffectColor, rippleEffectPercent: 0.45, initialRippleEffectPercent: 0.3)
            }
        }
    }
    
    /// Sets the spinner color
    public var spinnerColor: UIColor = Config.spinnerColor
    
    var spinnerSize: UInt? = Config.spinnerSize
    /// Sets the button title for its normal state
    
    
    
    public var normalTitle: String? {
        get {
            return self.title(for: .normal)
        }
        set {
            
            self.setTitle(newValue, for: .normal)
        }
    }
    
    /// Sets the button title for its selected state
    public var selectedTitle: String? {
        get {
            return self.title(for: .selected)
        }
        set {
            self.setTitle(newValue, for: .selected)
        }
    }
    
    /// Sets the button title for its disabled state
    public var disabledTitle: String? {
        get {
            return self.title(for: .disabled)
        }
        set {
            self.setTitle(newValue, for: .disabled)
        }
    }
    
    /// Sets the button title for its highlighted state
    public var highlightedTitle: String? {
        get {
            return self.title(for: .highlighted)
        }
        set {
            self.setTitle(newValue, for: .highlighted)
        }
    }
    
    /// Sets the button attributed title for its normal state
    public var attributedNormalTitle: NSAttributedString? {
        get {
            return self.attributedTitle(for: .normal)
        } set {
            self.setAttributedTitle(newValue, for: .normal)
        }
    }
    
    /// Sets the button attributed title for its normal state
    public var attributedSelectedTitle: NSAttributedString? {
        get {
            return self.attributedTitle(for: .selected)
        } set {
            self.setAttributedTitle(newValue, for: .selected)
        }
    }

    /// Sets the button attributed title for its normal state
    public var attributedDisableTitle: NSAttributedString? {
        get {
            return self.attributedTitle(for: .disabled)
        } set {
            self.setAttributedTitle(newValue, for: .disabled)
        }
    }
    
    /// Sets the button attributed title for its normal state
    public var attributedHighlitedTitle: NSAttributedString? {
        get {
            return self.attributedTitle(for: .highlighted)
        } set {
            self.setAttributedTitle(newValue, for: .highlighted)
        }
    }
    
    // MARK: - Initializers
    public required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        setUp()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
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
    }
    
}

public extension SSSpinnerButton {
    
    func setRippleEffect(rippleEffectAnimationDuration: Double, initialOpacity: Double,rippleEffectColor: UIColor,rippleEffectPercent: CGFloat,initialRippleEffectPercent: CGFloat) {
        self.rippleEffectAnimationDuration = rippleEffectAnimationDuration
        self.initialOpacity = initialOpacity
        self.rippleEffectColor = rippleEffectColor
        self.rippleEffectPercent = rippleEffectPercent
        self.initialRippleEffectPercent = initialRippleEffectPercent
    }
}

public extension SSSpinnerButton{
    
    override open func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        
        var shapeLayer = CAShapeLayer()
        if shapeLayer.superlayer != nil {
            shapeLayer.removeFromSuperlayer()
        }
        shapeLayer = CAShapeLayer()
        // let center = CGPoint(x: bounds.width/CGFloat(Constants.TWO), y: bounds.height/CGFloat(Constants.TWO))
        let diagnolLength = sqrt(bounds.width*bounds.width + bounds.height*bounds.height)
        let path = UIBezierPath(arcCenter: touch.location(in: self), radius: 0.5*diagnolLength*initialRippleEffectPercent, startAngle: CGFloat(0), endAngle: (CGFloat(Double(360) * .pi) / CGFloat(180)), clockwise: true)
        shapeLayer.path = path.cgPath
        shapeLayer.opacity = Float(initialOpacity)
        shapeLayer.fillColor = rippleEffectColor.cgColor
        shapeLayer.strokeColor = rippleEffectColor.cgColor
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        shapeLayer.frame = bounds
        layer.addSublayer(shapeLayer)
        let circleEnlargeAnimation = CABasicAnimation(keyPath: "transform.scale")
        circleEnlargeAnimation.fromValue = 1
        circleEnlargeAnimation.toValue = rippleEffectPercent/initialRippleEffectPercent
        circleEnlargeAnimation.duration = Double(rippleEffectAnimationDuration) * 0.7
        circleEnlargeAnimation.fillMode = CAMediaTimingFillMode.forwards
        circleEnlargeAnimation.isRemovedOnCompletion = false
        circleEnlargeAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
        let fadingOutAnimation = CABasicAnimation(keyPath: "opacity")
        fadingOutAnimation.fromValue = initialOpacity
        fadingOutAnimation.toValue = 0
        fadingOutAnimation.duration = Double(rippleEffectAnimationDuration) * 0.8
        fadingOutAnimation.beginTime = Double(rippleEffectAnimationDuration) * 0.2
        fadingOutAnimation.fillMode = CAMediaTimingFillMode.forwards
        fadingOutAnimation.isRemovedOnCompletion = false
        fadingOutAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
        let group = CAAnimationGroup()
        group.animations = [circleEnlargeAnimation, fadingOutAnimation]
        group.duration = CFTimeInterval(rippleEffectAnimationDuration)
        group.fillMode = CAMediaTimingFillMode.forwards
        group.isRemovedOnCompletion = false
        CATransaction.begin()
        shapeLayer.add(group, forKey: nil)
        CATransaction.commit()
        return super.beginTracking(touch, with: event)
    }
}

private extension SSSpinnerButton {
    
    /// Default setup of Button UI and Lable
    func setUp() {
        
        self.removeAnimationLayer()
        if self.cornerRadius == 0 {
            self.cornerRadius = self.layer.cornerRadius
        }
        if layer.sublayers != nil {
            
            for item in layer.sublayers! where item is CAGradientLayer {
                
                item.cornerRadius = self.cornerRadius
                item.masksToBounds = true
            }
        }
        self.layer.cornerRadius = self.cornerRadius
        self.layer.masksToBounds = true
        
        if self.image(for: .normal) != nil && self.normalTitle != nil {
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
    func startAnimate(spinnerType: SpinnerType = Config.spinnerType, spinnercolor: UIColor = Config.spinnerColor, complete: (() -> Void)?) {
        self.startAnimate(spinnerType: spinnerType , spinnercolor: spinnercolor, spinnerSize: nil, complete: complete)
    }
    
    /// Start Animation
    ///
    /// - Parameters:
    ///   - spinnerType: spinner Type ( ballClipRotate(default), ballSpinFade, lineSpinFade, circleStrokeSpin, ballRotateChase)
    ///   - spinnercolor: color of spinner (default = gray)
    ///   - spinnerSize: size of spinner layer
    ///   - complete: complation block (call after animation start)
    func startAnimate(spinnerType: SpinnerType = Config.spinnerType, spinnercolor: UIColor = Config.spinnerColor, spinnerSize: UInt? = nil, complete: (() -> Void)?) {
        if self.cornerRadius == 0 {
            self.cornerRadius = self.layer.cornerRadius
        }
        
        self.removeAnimationLayer()
        isAnimating = true
        self.spinnerColor = spinnercolor
        self.spinnerType = spinnerType
        self.spinnerSize = spinnerSize ?? Config.spinnerSize
        
        self.layer.cornerRadius = self.frame.height / 2
        if layer.sublayers != nil {
            
            for item in layer.sublayers! where item is CAGradientLayer {
            
                item.cornerRadius = self.frame.height / 2
            
            }
        }
        self.collapseAnimation(complete: complete)
        
    }
    
    /// stop animation and set button in actual state
    ///
    /// - Parameter complete: complation block (call after animation Stop)
    func stopAnimate(complete: (() -> Void)?) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            self.backToDefaults(completionType: .none, setToDefaults: false, complete: complete)
        })
    }
    
    /// stop animation and set to default with completion type
    ///
    /// - Parameters:
    ///   - completionType: completion type
    ///   - backToDefaults: back to default state
    ///   - complete: complation block (call after animation Stop)
    func stopAnimationWithCompletionTypeAndBackToDefaults(completionType: CompletionType, backToDefaults: Bool, complete: (() -> Void)?) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            self.backToDefaults(completionType: completionType, setToDefaults: backToDefaults, complete: complete)
        })
    }
    
    /// stop animation with completion type
    ///
    /// - Parameters:
    ///   - completionType: completion type
    ///   - complete: complation block (call after animation Stop)
    func stopAnimatingWithCompletionType(completionType: CompletionType, complete: (() -> Void)?) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            self.backToDefaults(completionType: completionType, setToDefaults: false, complete: complete)
        })
    }
    
}

private extension SSSpinnerButton {
    
    /// remove animation layer of specific spinner
    func removeAnimationLayer() {
        if layer.sublayers != nil {
            for item in layer.sublayers! where item is SpinnerLayers {
                item.removeAllAnimations()
                item.removeFromSuperlayer()
            }
        }
    }
    
    /// collapse animation
    ///
    /// - Parameter complete: complation block (call after animation Stop)
    func collapseAnimation(complete: (() -> Void)?) {
        
        storedNormalTitle = normalTitle
        normalTitle = nil
        
        storedSelectedTitle = selectedTitle
        selectedTitle = nil
        
        storedDisableTitle = disabledTitle
        disabledTitle = nil
        
        storedHighlitedTitle = highlightedTitle
        highlightedTitle = nil
        
        storedAttributedNormalTitle = attributedNormalTitle
        attributedNormalTitle = nil
        
        storedAttributedSelectedTitle = attributedSelectedTitle
        attributedSelectedTitle = nil
        
        storedAttributedDisableTitle = attributedDisableTitle
        attributedDisableTitle = nil
        
        storedAttributedHighlitedTitle = attributedHighlitedTitle
        attributedHighlitedTitle = nil
        
        
        storedBackgroundNormalImage = self.backgroundImage(for: .normal)
        storedBackgroundDisabledImage = self.backgroundImage(for: .disabled)
        storedBackgroundSelectedImage = self.backgroundImage(for: .selected)
        storedBackgroundHighlightedImage = self.backgroundImage(for: .highlighted)
        
        storedNormalImage = self.image(for: .normal)
        storedDisabledImage = self.image(for: .disabled)
        storedSelectedImage = self.image(for: .selected)
        storedHighlightedImage = self.image(for: .highlighted)
        
        storedBackgroundColor = self.backgroundColor
        storedWidth = frame.width
        storedHeight = frame.height
        
        self.setImage(nil, for: .normal)
        self.setImage(nil, for: .disabled)
        self.setImage(nil, for: .selected)
        self.setImage(nil, for: .highlighted)
        isUserInteractionEnabled = false
        
        let animation = CABasicAnimation(keyPath: "bounds.size.width")
        animation.fromValue = bounds.width
        animation.toValue =  bounds.height
        animation.duration = animationDuration
        animation.fillMode = CAMediaTimingFillMode.both
        animation.isRemovedOnCompletion = false
        if layer.sublayers != nil {
            
            for item in layer.sublayers! where item is CAGradientLayer {
                item.add(animation, forKey: animation.keyPath)
            }
        }
        layer.add(animation, forKey: animation.keyPath)
        self.perform(#selector(startSpinner), with: nil, afterDelay: animationDuration)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration, execute: {
            if complete != nil {
                complete!()
            }
        })
        
    }
        
    /// set back to default state of button
    ///
    /// - Parameters:
    ///   - completionType: completion type
    ///   - setToDefaults: back to default state
    ///   - complete: complation block (call after animation Stop)
    func backToDefaults(completionType: CompletionType, setToDefaults: Bool, complete: (() -> Void)?) {
        if !isAnimating {
            return
        }
        self.removeAnimationLayer()
        switch completionType {
        case .none:
            self.setDefaultDataToButton(complete: complete)
            return
        case .success:
            let animation: SSSpinnerAnimationDelegate = SpinnerCompletionType.checkMark.animation()
            animation.setupSpinnerAnimation(layer: self.layer, frame: self.frame, color: self.spinnerColor, spinnerSize: self.spinnerSize)
        case .error:
            let animation: SSSpinnerAnimationDelegate = SpinnerCompletionType.errorMark.animation()
            animation.setupSpinnerAnimation(layer: self.layer, frame: self.frame, color: self.spinnerColor, spinnerSize: self.spinnerSize)
        case .fail:
            let animation: SSSpinnerAnimationDelegate = SpinnerCompletionType.failMark.animation()
            animation.setupSpinnerAnimation(layer: self.layer, frame: self.frame, color: self.spinnerColor, spinnerSize: self.spinnerSize)
        }
        
        if completionType != .none {
            if setToDefaults {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.setDefaultDataToButton(complete: complete)
                    self.isUserInteractionEnabled = true
                }
            } else {
                
                if complete != nil {
                    complete!()
                }
                self.isUserInteractionEnabled = true
            }
        }
        self.isUserInteractionEnabled = true
    }
    
    /// set default state
    ///
    /// - Parameter complete: complation block (call after animation Stop)
    func setDefaultDataToButton(complete: (() -> Void)?) {
        
        
        self.removeAnimationLayer()
        self.setTitle(self.storedNormalTitle, for: .normal)
        self.setTitle(self.storedSelectedTitle, for: .selected)
        self.setTitle(self.storedDisableTitle, for: .disabled)
        self.setTitle(self.storedHighlitedTitle, for: .highlighted)
        
        if self.storedAttributedNormalTitle != nil {
            self.setAttributedTitle(self.storedAttributedNormalTitle, for: .normal)
        }
        
        if self.storedAttributedSelectedTitle != nil {
            self.setAttributedTitle(self.storedAttributedSelectedTitle, for: .selected)
        }
        
        if self.storedAttributedDisableTitle != nil {
            self.setAttributedTitle(self.storedAttributedDisableTitle, for: .disabled)
        }
       
        if self.storedAttributedHighlitedTitle != nil {
            self.setAttributedTitle(self.storedAttributedHighlitedTitle, for: .highlighted)
        }
        
        self.setBackgroundImage(self.storedBackgroundNormalImage, for: .normal)
        self.setBackgroundImage(self.storedBackgroundDisabledImage, for: .disabled)
        self.setBackgroundImage(self.storedBackgroundSelectedImage, for: .selected)
        self.setBackgroundImage(self.storedBackgroundHighlightedImage, for: .highlighted)
        self.setImage(self.storedNormalImage, for: .normal)
        self.setImage(self.storedDisabledImage, for: .disabled)
        self.setImage(self.storedSelectedImage, for: .selected)
        self.setImage(self.storedHighlightedImage, for: .highlighted)
        self.isUserInteractionEnabled = true
        
        let animation = CABasicAnimation(keyPath: "bounds.size.width")
        animation.fromValue = storedHeight
        animation.toValue = storedWidth
        animation.duration = self.animationDuration
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.isRemovedOnCompletion = false
        
        self.layer.add(animation, forKey: animation.keyPath)
        if self.layer.sublayers != nil {
            
            for item in self.layer.sublayers! where item is CAGradientLayer {
                item.add(animation, forKey: animation.keyPath)
                item.cornerRadius = self.cornerRadius
            }
        }
        self.isAnimating = false
        self.layer.cornerRadius = self.cornerRadius
        if complete != nil {
            complete!()
            }
        
    }
    
    /// start spinner
    @objc func startSpinner() {
        
        let animation: SSSpinnerAnimationDelegate = self.spinnerType.animation()
        animation.setupSpinnerAnimation(layer: self.layer, frame: self.bounds, color: self.spinnerColor, spinnerSize: self.spinnerSize)
    }
    
}


extension SSSpinnerButton {
    
    public struct Config {
        public static var spinnerType: SpinnerType = .ballClipRotate
        public static var spinnerColor: UIColor = .gray
        public static var spinnerSize: UInt? = nil
    }
}
