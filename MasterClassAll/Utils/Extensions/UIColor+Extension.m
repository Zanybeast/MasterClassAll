//
//  UIColor+Extension.m
//  MasterClassAll
//
//  Created by carl on 2020/12/5.
//

#import "UIColor+Extension.h"

@implementation UIColor (Extension)

+ (instancetype)randomColor {
    CGFloat r = arc4random_uniform(256) / 255.0;
    CGFloat g = arc4random_uniform(256) / 255.0;
    CGFloat b = arc4random_uniform(256) / 255.0;
    return [UIColor colorWithRed:r green:g blue:b alpha:1.0];
}

@end
