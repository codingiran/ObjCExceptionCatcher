//
//  _ObjCExceptionCatcher.m
//  ObjCExceptionCatcher
//
//  Created by iran.qiu on 2023/8/11.
//

#import "include/_ObjCExceptionCatcher.h"

@implementation _ObjCExceptionCatcher

+ (BOOL)catchException:(__attribute__((noescape)) void (^)(void))tryBlock error:(__autoreleasing NSError **)error {
  @try {
      tryBlock();
      return YES;
  } @catch (NSException *exception) {
      *error = [[NSError alloc] initWithDomain:exception.name code:0 userInfo: @{
        NSUnderlyingErrorKey: exception,
        NSLocalizedDescriptionKey: exception.reason,
        @"CallStackSymbols": exception.callStackSymbols
      }];
      return NO;
  }
}

@end
