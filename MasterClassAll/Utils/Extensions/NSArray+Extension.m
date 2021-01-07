//
//  NSArray+Extension.m
//  MasterClassAll
//
//  Created by carl on 2020/12/5.
//

#import "NSArray+Extension.h"

@implementation NSArray (Extension)

+ (instancetype)randomIntegerArrayWithRandomCapacity:(int)capacity {
    int length = arc4random_uniform(capacity) + 2;
    NSMutableArray *result = [NSMutableArray array];
    for (int i = 0; i < length; i++) {
        int number = arc4random_uniform(100) + 1;
        [result addObject:@(number)];
    }
    return result;
}

@end
