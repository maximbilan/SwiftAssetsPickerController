Pod::Spec.new do |s|
s.name         = "SwiftAssetsPickerController"
s.version      = "0.3.0"
s.summary      = "Assets Picker Controller"
s.description  = "Simple assets picker controller based on iOS 8 Photos framework. Supports iCloud photos and videos. It's written in Swift."
s.homepage     = "https://github.com/maximbilan/SwiftAssetsPickerController"
s.license      = { :type => "MIT" }
s.author       = { "Maxim Bilan" => "maximb.mail@gmail.com" }
s.platform     = :ios, "8.0"
s.source       = { :git => "https://github.com/maximbilan/SwiftAssetsPickerController.git", :tag => "0.3.0" }
s.source_files = "Classes", "SwiftAssetsPickerController/Sources/**/*.{swift}"
s.resources	   = "SwiftAssetsPickerController/Resources/*.*"
s.requires_arc = true
s.dependency "CheckMarkView", "~> 0.2.4"
end