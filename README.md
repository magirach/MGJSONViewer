# MGJSONViewer

[![CI Status](https://img.shields.io/travis/Moinuddin Girach/MGJSONViewer.svg?style=flat)](https://travis-ci.org/Moinuddin Girach/MGJSONViewer)
[![Version](https://img.shields.io/cocoapods/v/MGJSONViewer.svg?style=flat)](https://cocoapods.org/pods/MGJSONViewer)
[![License](https://img.shields.io/cocoapods/l/MGJSONViewer.svg?style=flat)](https://cocoapods.org/pods/MGJSONViewer)
[![Platform](https://img.shields.io/cocoapods/p/MGJSONViewer.svg?style=flat)](https://cocoapods.org/pods/MGJSONViewer)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

MGJSONViewer is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'MGJSONViewer'
```

## Use

```Swift
let jsonViewer = MGJSONViewer()
//Load json from file
jsonViewer.loadData(fileName: "json", ext: "txt")

//Load JSON from data
jsonViewer.loadData(data: data)
```

## Author

Moinuddin Girach, moinuddingirach@gmail.com

## License

MGJSONViewer is available under the MIT license. See the LICENSE file for more info.
