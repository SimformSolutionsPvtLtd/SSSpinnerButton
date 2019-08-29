#
#  Be sure to run `pod spec lint SSSpinnerButton.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.name         = "SSSpinnerButton"
  s.version      = "3.0.1"
  s.summary      = "SSSpinnerButton is an elegant button with a different spinner animations."

  #s.description  = "SSSpinnerButton is an elegant button with a different spinner animations."

  s.homepage     = 'https://github.com/simformsolutions/SSSpinnerButton.git'
  
  #s.license      = "MIT"
  s.license          = { :type => 'MIT', :file => 'LICENSE' }

  s.author             = { "Bhargav Bajani" => "bhargav.b@simformsolutions.com" }
  s.platform     = :ios  
  
  s.ios.deployment_target = "10.0"
  s.swift_version = '5.0'

  s.source       = { :git => "https://github.com/simformsolutions/SSSpinnerButton.git", :tag => "#{s.version}" }
  #s.source       = { :path => ".", :tag => "#{s.version}" }

  s.source_files  = 'SSSpinnerButton/**/*.swift'
  #s.pod_target_xcconfig = { 'SWIFT_VERSION' => '5.0' }
  s.documentation_url = 'docs/index.html'

end
