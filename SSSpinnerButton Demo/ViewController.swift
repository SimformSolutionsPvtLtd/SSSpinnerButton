//
//  ViewController.swift
//  SSSpinnerButton
//
//  Created by Bhargav Bajani on 05/06/18.
//  Copyright © 2018 Simform Solutions. All rights reserved.
//

import UIKit
import SSSpinnerButton

class ViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var btnClipRotate: SSSpinnerButton!
    @IBOutlet weak var btnSpinFade: SSSpinnerButton!
    @IBOutlet weak var btnLineSpinFade: SSSpinnerButton!
    @IBOutlet weak var btnBallRotateChase: SSSpinnerButton!
    @IBOutlet weak var btnCircleStrokeSpin: SSSpinnerButton!
    @IBOutlet weak var btnRippleEffect: SSSpinnerButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnRippleEffect.setRippleEffect(rippleEffectAnimationDuration: 0.3, initialOpacity: 0.5, rippleEffectColor: .black, rippleEffectPercent: 0.45, initalRippleEffectPercent: 0.3)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onSpinnnerButtonClick(_ sender: SSSpinnerButton) {
        let arr: [SpinnerType] = [.ballClipRotate, .ballSpinFade, .lineSpinFade, .ballRotateChase, .circleStrokeSpin, .ballClipRotate, .ballSpinFade, .lineSpinFade, .ballRotateChase, .pacman, .circleScaleMultiple, .circleWaveSpin]
        
        // MARK: Start Animating
        sender.startAnimate(spinnerType: arr[sender.tag], spinnercolor: .white, spinnerSize: 20, complete: nil)
        Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { (_) in
            if sender.tag == 5 {
                // MARK: Stop Animating with completion type and back to default
                // MARK: completion type is fail
                sender.stopAnimatingWithCompletionType(completionType: .fail, complete: {
                    // Your completion actions
                })
                return
            }
            if  sender.tag == 6 {
                // MARK: Stop Animating with completion type and back to default
                // MARK: completion type is fail
                sender.stopAnimationWithCompletionTypeAndBackToDefaults(completionType: .fail, backToDefaults: true, complete: {
                    // Your completion actions
                })
                return
            }
            if sender.tag == 7 {
                // MARK: Stop animating with completion type
                // MARK: completion type is success
                sender.stopAnimatingWithCompletionType(completionType: .success, complete: nil)
                return
            }
            if sender.tag == 8 {
                // MARK: Stop animating with completion type
                // MARK: completion type is error
                sender.stopAnimatingWithCompletionType(completionType: .error, complete: nil)
                return
            }
            // MARK: Stop animating without completion
            sender.stopAnimate(complete: {
                // Your completion actions
            })
            
        }

    }

}
