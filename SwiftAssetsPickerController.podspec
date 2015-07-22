Pod::Spec.new do |s|
s.name         = "SwiftAssetsPickerController"
s.version      = "0.1"
s.summary      = "Assets Picker"
s.description  = "Swift assets picker based on Photos framework from iOS 8 SDK"
s.homepage     = "https://github.com/maximbilan/SwiftAssetsPickerController"
s.license      = { :type => "MIT" }
s.author       = { "Maxim Bilan" => "maximb.mail@gmail.com" }
s.platform     = :ios, "8.0"
s.source       = { :git => "https://github.com/maximbilan/SwiftAssetsPickerController.git", :tag => "0.1" }
s.source_files = "Classes", "SwiftAssetsPickerController/Sources/**/*.{swift}"
s.resources	   = "SwiftAssetsPickerController/Resources/*.*"
s.requires_arc = true
s.dependency "CheckMarkView", "~> 0.2.2"
end