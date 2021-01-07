//
//  NSUserDefaults+Extension.h
//  MasterClassAll
//
//  Created by carl on 2020/12/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSUserDefaults (Extension)

#pragma mark - Store Color
- (void)setColor: (UIColor *)color forKey: (NSString *)key;
- (UIColor *)colorForKey: (NSString *)key;

@end

NS_ASSUME_NONNULL_END
