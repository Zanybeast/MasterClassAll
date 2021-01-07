//
//  NSString+Extension.h
//  MasterClassAll
//
//  Created by carl on 2020/11/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Extension)

- (NSString *)randomStringWithRandomLengthLessThan: (int)len;
- (NSString *)randomStringWithLength: (int)len;

@end

NS_ASSUME_NONNULL_END
