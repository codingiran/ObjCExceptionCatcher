# ObjCExceptionCatcher

> Catch [Objective-C exceptions](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/Exceptions/Tasks/HandlingExceptions.html) in Swift

There are many Cocoa APIs that can throw exceptions that cannot be caught in Swift (`NSKeyedUnarchiver`, `NSTask`,  `NSObject#value(forKey:)`, etc). This package wraps an Objective-C exception handler to make it possible to catch such exceptions.

*The ability to catch exceptions should really be built into Swift. If you agree, duplicate [this](https://github.com/feedback-assistant/reports/issues/74) Feedback Assistant report.*

## Install

Add the following to `Package.swift`:

```swift
.package(url: "https://github.com/codingiran/ObjCExceptionCatcher", from: "1.0.0")
```

[Or add the package in Xcode.](https://developer.apple.com/documentation/xcode/adding_package_dependencies_to_your_app)

## Usage

```swift
import Foundation
import ObjCExceptionCatcher

final class Foo: NSObject {}

do {
    let value = try ObjCExceptionCatcher.catchException {
        return Foo().value(forKey: "nope")
    }

    print("Value:", value)
} catch {
    print("Error:", error.localizedDescription)
    //=> Error: [valueForUndefinedKey:]: this class is not key value coding-compliant for the key nope.

    debugPrint(error)
    /*
    Error Domain=NSUnknownKeyException Code=0 "[valueForUndefinedKey:]: this class is not key value coding-compliant for the key nope." UserInfo={CallStackSymbols=(
    0   CoreFoundation                      0x00007fff361798ab __exceptionPreprocess + 250
    1   libobjc.A.dylib                     0x00007fff6c3ea805 objc_exception_throw + 48
    2   CoreFoundation                      0x00007fff361a230c -[NSException raise] + 9
    3   Foundation                          0x00007fff388f86c4 -[NSObject(NSKeyValueCoding) valueForUndefinedKey:] + 222
    4   Foundation                          0x00007fff3876f8fd -[NSObject(NSKeyValueCoding) valueForKey:] + 317
    …
    */
}
```

## Acknowledgement

- [ExceptionCatcher](https://github.com/sindresorhus/ExceptionCatcher) - Original implement
