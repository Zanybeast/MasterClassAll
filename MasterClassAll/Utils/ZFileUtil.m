//
//  ZFileUtil.m
//  MasterClassAll
//
//  Created by carl on 2020/11/27.
//

#import "ZFileUtil.h"

@implementation ZFileUtil

+ (NSString *)getDocumentDirectory {
    NSArray *documents = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = documents[0];
    return documentPath;
}

+ (NSString *)fullPathInDocumentWith:(NSString *)fileName {
    NSString *documentPath = [ZFileUtil getDocumentDirectory];
    NSString *filePath = [documentPath stringByAppendingPathComponent:fileName];
    return filePath;
}

@end
