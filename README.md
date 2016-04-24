# SwiftAssetsPickerController

[![Version](https://img.shields.io/cocoapods/v/SwiftAssetsPickerController.svg?style=flat)](http://cocoadocs.org/docsets/SwiftAssetsPickerController)
[![License](https://img.shields.io/cocoapods/l/SwiftAssetsPickerController.svg?style=flat)](http://cocoadocs.org/docsets/SwiftAssetsPickerController)
[![Platform](https://img.shields.io/cocoapods/p/SwiftAssetsPickerController.svg?style=flat)](http://cocoadocs.org/docsets/SwiftAssetsPickerController)

Simple assets picker controller based on <i>iOS 8</i> <i>Photos</i> framework. Supports <i>iCloud</i> photos and videos. It's written in <i>Swift</i>.

![alt tag](https://raw.github.com/maximbilan/SwiftAssetsPickerController/master/img/img1.png)
![alt tag](https://raw.github.com/maximbilan/SwiftAssetsPickerController/master/img/img2.png)

# Installation

<b>CocoaPods:</b>
<pre>
pod 'SwiftAssetsPickerController'
</pre>

<b>Manual:</b>
<pre>
Copy AssetsPickerController.swift and AssetsPickerGridController.swift to your project.
Also framework uses CheckMarkView, you can found <a href="https://github.com/maximbilan/CheckMarkView">here</a>.
</pre>

## How to use

It's really simple. Just see the example:

<pre>
let assetsPickerController = AssetsPickerController()
assetsPickerController.didSelectAssets = {(assets: Array<PHAsset!>) -> () in
    println(assets)
}
let navigationController = UINavigationController(rootViewController: rootListAssets)
presentViewController(navigationController, animated: true, completion: nil)
</pre>

## License

SwiftAssetsPickerController is available under the MIT license. See the LICENSE file for more info.
