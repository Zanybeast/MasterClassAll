//
//  NSString+Extension.m
//  MasterClassAll
//
//  Created by carl on 2020/11/24.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

- (NSString *)randomStringWithRandomLengthLessThan: (int)len {
    int randomLength = arc4random() % len;
    return [self randomStringWithLength:1 + randomLength];
}

- (NSString *)randomStringWithLength: (int)len {
    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";

    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];

    for (int i=0; i<len; i++) {
         [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random() % ([letters length] - 1)]];
    }

    return randomString;
}

@end
