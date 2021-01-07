//
//  NSUserDefaults+Extension.m
//  MasterClassAll
//
//  Created by carl on 2020/12/9.
//

#import "NSUserDefaults+Extension.h"

@implementation NSUserDefaults (Extension)

#pragma mark - Color Store
- (void)setColor:(UIColor *)color forKey:(NSString *)key {
    NSData *colorData = [NSKeyedArchiver archivedDataWithRootObject:color requiringSecureCoding:NO error:nil];
    [[NSUserDefaults standardUserDefaults] setObject:colorData forKey:key];
}

- (UIColor *)colorForKey:(NSString *)key {
    NSData *colorData = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    UIColor *color = [NSKeyedUnarchiver unarchivedObjectOfClass:[UIColor class] fromData:colorData error:nil];
    return color;
}

@end
