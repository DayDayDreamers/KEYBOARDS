<p align="center">
  <img src="http://i.imgur.com/x2E68WN.png" alt="CodableAlamofire"/>
</p>

[![Build Status](https://travis-ci.org/Otbivnoe/CodableAlamofire.svg?branch=master)](https://travis-ci.org/Otbivnoe/CodableAlamofire)
![Swift 4.0.x](https://img.shields.io/badge/Swift-4.0-orange.svg)
[![SPM compatible](https://img.shields.io/badge/SPM-compatible-brightgreen.svg)](https://github.com/apple/swift-package-manager)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Version](https://img.shields.io/cocoapods/v/CodableAlamofire.svg?style=flat)](http://cocoadocs.org/docsets/CodableAlamofire)
![platforms](https://img.shields.io/badge/platforms-iOS%20%7C%20macOS%20%7C%20tvOS%20%7C%20watchOS%20%7C%20Linux-333333.svg)

**Swift 4 introduces a new `Codable` protocol that lets you serialize and deserialize custom data types without writing any special code and without having to worry about losing your value types. 🎉**

**Awesome, isn't it? And this library helps you write less code! It's an extension for `Alamofire` that converts `JSON` data into `Decodable` object.**

### Useful Resources:
- [Encoding and Decoding Custom Types](https://developer.apple.com/documentation/foundation/archives_and_serialization/encoding_and_decoding_custom_types) - Article by Apple
- [Using JSON with Custom Types](https://developer.apple.com/documentation/foundation/archives_and_serialization/using_json_with_custom_types) - Swift Playground
- Also there is a special session from `WWDC2017` that covers this new feature - [What's New in Foundation](https://developer.apple.com/videos/play/wwdc2017/212/)

# Usage

Let's decode a simple json file:
```
{
    "result": {
        "libraries": [
            {
                "name": "Alamofire",
       