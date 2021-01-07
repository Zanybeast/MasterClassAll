//
//  ZFileUtil.h
//  MasterClassAll
//
//  Created by carl on 2020/11/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZFileUtil : NSObject

+ (NSString *)getDocumentDirectory;
+ (NSString *)fullPathInDocumentWith: (NSString *)fileName;

@end

NS_ASSUME_NONNULL_END
