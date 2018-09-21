Pod::Spec.new do |s|
s.name         = "SwiftAssetsPickerController"
s.version      = "0.4.1"
s.summary      = "Assets Picker Controller"
s.description  = "A simple assets picker controller based on iOS 8 Photos framework. Supports iCloud photos and videos. It's written in Swift."
s.homepage     = "https://github.com/maximbilan/SwiftAssetsPickerController"
s.license      = { :type => "MIT" }
s.author       = { "Maxim Bilan" => "maximb.mail@gmail.com" }
s.platform     = :ios, "8.0"
s.source       = { :git => "https://github.com/maximbilan/SwiftAssetsPickerController.git", :tag => s.version.to_s }
s.source_files = "Classes", "SwiftAssetsPickerController/Sources/**/*.{swift}"
s.resources	   = "SwiftAssetsPickerController/Resources/*.*"
s.requires_arc = true
s.dependency "CheckMarkView", "~> 0.4.3"
end