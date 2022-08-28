#
#  Be sure to run `pod spec lint MGJSONViewer.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  spec.name         = "MGJSONViewer"
  spec.version      = "0.1.1"
  spec.summary      = "JSON viewer for iOS"

  spec.description  = <<-DESC
  Its simple helper to view json for iOS
                   DESC

  spec.homepage     = "https://github.com/magirach/MGJSONViewer"
  spec.license      = "MIT"
  spec.author       = { "Moinuddin Girach" => "moinuddingirach@gmail.com" }
  spec.source       = { :git => "https://github.com/magirach/MGJSONViewer.git", :tag => "#{spec.version}" }

  spec.subspec 'Classes' do |ss|
      ss.source_files = 'MGJSONViewer/Classes/**/*'
  end
  
  spec.subspec 'Assets' do |ss|
      ss.resources = "MGJSONViewer/Assets/*.xcassets"
  end
  
  spec.ios.deployment_target = '13.0'
  spec.swift_versions = '5.0'

end
