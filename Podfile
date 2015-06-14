source 'https://github.com/CocoaPods/Specs'

platform :ios, '8.0'

inhibit_all_warnings!
use_frameworks!

target 'MovileNext', :exclusive => true do
    # Add Application pods here
    pod 'Alamofire'
    pod 'Argo'
    pod 'Result'
    pod 'TraktModels', :git => 'https://github.com/marcelofabri/TraktModels.git'
    
end

target :unit_tests, :exclusive => true do
  link_with 'UnitTests'
  pod 'Nimble'
  pod 'OHHTTPStubs'
end

