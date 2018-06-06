//
//  ViewController.swift
//  SSSpinnerButton
//
//  Created by Bhargav Bajani on 05/06/18.
//  Copyright © 2018 Simform Solutions. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var btnClipRotate: SSSpinnerButton!
    @IBOutlet weak var btnSpinFade: SSSpinnerButton!
    @IBOutlet weak var btnLineSpinFade: SSSpinnerButton!
    @IBOutlet weak var btnBallRotateChase: SSSpinnerButton!
    @IBOutlet weak var btnCircleStrokeSpin: SSSpinnerButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onSpinnnerButtonClick(_ sender: SSSpinnerButton) {
       
        let arr: [SpinnerType] = [.ballClipRotate, .ballSpinFade, .lineSpinFade, .ballRotateChase, .circleStrokeSpin]
        
        sender.startAnimate(spinnerType: arr[sender.tag], spinnercolor: .white, complete: nil)
        
        Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { (_) in
            sender.stopAnimate(complete: {
            })
            
        }

    }

}
