# SSspinnerButton


SSSpinnerButton is an elegant button with a different spinner animations.

[![Swift Version][swift-image]][swift-url]
[![Build Status][travis-image]][travis-url]
[![License][license-image]][license-url]
[![Platform][platform-image]][platform-url]
[![PRs Welcome][PR-image]][PR-url]

![Alt text](https://github.com/simformsolutions/SSSpinnerButton/blob/master/SSSpinnerButton.gif?raw=true)

# Features!
  - Rounded button when spinner active
  - Various spinner animations
  - Dynamic spinner size
  - Spinner with completion types (Success, fail, error)
  - CocoaPods

# Requirements
  - iOS 10.0+
  - Xcode 9+

# Installation
 **CocoaPods**
 
- You can use CocoaPods to install SSSpinnerButton by adding it to your Podfile:

       use_frameworks!
       pod 'SSSpinnerButton'

-  
       import UIKit
       import SSSpinnerButton

**Carthage**

Add `github simformsolutions/SSSpinnerButton` to your project's Cartfile

**Manually**
-   Download and drop **SSSpinnerButton** folder in your project.
-   Congratulations!

# Usage example

-   In the storyboard add a UIButton and change its class to SSSpinnerButton
   ![Alt text](https://github.com/simformsolutions/SSSpinnerButton/blob/master/SpinnerButtonStoryBoard.png?raw=true)
   
    **StartAnimation**

        button.startAnimate(spinnerType: SpinnerType.ballClipRotate, spinnercolor: UIColor.red, spinnerSize: 20, complete: {
            // Your code here
        })
   
    
    **StopAnimation**
      
        button.stopAnimate(complete: {
            // Your code here
        })
    
    **StopAnimation with completion types**
    
        button.stopAnimatingWithCompletionType(completionType: .success, complete: {
            // Your code here
        })
        
    **StopAnimation with completion types and back to defaults**
    
        button.stopAnimationWithCompletionTypeAndBackToDefaults(completionType: .fail, backToDefaults: true, complete: {
            // Your code here
        })

# Migration
**Version 3.0.1**
- This version requires Xcode 10.2 and Swift 5.0.

**Version 2.0.1**
- This version requires Xcode 10.1 and Swift 4.2.
#  Contribute
-   We would love you for the contribution to SSspinnerButton, check the LICENSE file for more info.
 
#  Meta
-    Distributed under the MIT license. See LICENSE for more information.


# Inspired 
-   Spinner animations inspired from [NVActivityIndicatorView](https://github.com/ninjaprox/NVActivityIndicatorView)

    
[swift-image]:https://img.shields.io/badge/swift-5.0-orange.svg
[swift-url]: https://swift.org/
[license-image]: https://img.shields.io/badge/License-MIT-blue.svg
[license-url]: LICENSE
[travis-image]: https://img.shields.io/travis/dbader/node-datadog-metrics/master.svg?style=flat-square
[travis-url]: https://travis-ci.org/dbader/node-datadog-metrics
[codebeat-image]: https://codebeat.co/assets/svg/badges/C-ffb83f-7198e9a1b7ad7f73977b0c9a5c7c3fffbfa25f262510e5681fd8f5a3188216b0.svg
[codebeat-url]: https://codebeat.co/projects/github-com-vsouza-awesomeios-com
[platform-image]:https://img.shields.io/cocoapods/p/LFAlertController.svg?style=flat
[platform-url]:http://cocoapods.org/pods/LFAlertController
[cocoa-image]:https://img.shields.io/cocoapods/v/EZSwiftExtensions.svg
[cocoa-url]:https://img.shields.io/cocoapods/v/LFAlertController.svg
[PR-image]:https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square
[PR-url]:http://makeapullrequest.com
