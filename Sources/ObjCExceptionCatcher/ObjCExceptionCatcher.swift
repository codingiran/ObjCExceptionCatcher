//
//  ObjCExceptionCatcher.swift
//  ObjCExceptionCatcher
//
//  Created by iran.qiu on 2023/8/11.
//

@_implementationOnly import Foundation
@_implementationOnly import ObjCExceptionCatcher_Private

public enum ObjCExceptionCatcher {
    /**
     Catch a Objective-C exception.

     - Returns: The value returned from the given callback.

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
         //=> Error: The operation couldn’t be completed. [valueForUndefinedKey:]: this class is not key value coding-compliant for the key nope.
     }
     ```
     */
    @discardableResult
    public static func catchException<T>(callback: () throws -> T) throws -> T {
        var returnValue: T!
        var returnError: Error?

        try _ObjCExceptionCatcher.catchException {
            do {
                returnValue = try callback()
            } catch {
                returnError = error
            }
        }

        if let returnError {
            throw returnError
        }

        return returnValue
    }
}
