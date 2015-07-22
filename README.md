# SwiftAssetsPickerController

[![Version](https://img.shields.io/cocoapods/v/SwiftAssetsPickerController.svg?style=flat)](http://cocoadocs.org/docsets/SwiftAssetsPickerController)
[![License](https://img.shields.io/cocoapods/l/SwiftAssetsPickerController.svg?style=flat)](http://cocoadocs.org/docsets/SwiftAssetsPickerController)
[![Platform](https://img.shields.io/cocoapods/p/SwiftAssetsPickerController.svg?style=flat)](http://cocoadocs.org/docsets/SwiftAssetsPickerController)

Unfortunately <i>Apple</i> doesn't provide accessory type property for <i>UICollectionViewCell</i>, such as for <i>UITableViewCell</i>, so I provide custom way to create checkmark. Just simple view which draws programmatically checkmark with some styles.

![alt tag](https://raw.github.com/maximbilan/SwiftAssetsPickerController/master/img/img1.png)
![alt tag](https://raw.github.com/maximbilan/SwiftAssetsPickerController/master/img/img2.png)

# Installation

<b>Manual:</b>
<pre>
Copy CheckMarkView.swift to your project.
</pre>

<b>Cocoapods:</b>
<pre>
pod 'CheckMarkView'
</pre>

## How to use

You can create from code, or setup view in the <i>Storyboard</i>, <i>XIB</i>.

<pre>
let checkMarkView = CheckMarkView()
</pre>

For controlling you have <i>checked</i> property.
And <i>style</i> property for unchecked view. There are some styles:

<pre>
enum CheckMarkStyle: Int {
    case Nothing
    case OpenCircle
    case GrayedOut
}
</pre>

## License

SwiftAssetsPickerController is available under the MIT license. See the LICENSE file for more info.
