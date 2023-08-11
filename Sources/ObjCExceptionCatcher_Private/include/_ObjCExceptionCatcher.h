//
//  _ObjCExceptionCatcher.h
//  ObjCExceptionCatcher
//
//  Created by iran.qiu on 2023/8/11.
//
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface _ObjCExceptionCatcher : NSObject

+ (BOOL)catchException:(__attribute__((noescape)) void (^)(void))tryBlock error:(__autoreleasing NSError **)error;

@end

NS_ASSUME_NONNULL_END
