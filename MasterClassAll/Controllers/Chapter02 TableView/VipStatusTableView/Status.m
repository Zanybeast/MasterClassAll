//
//  Status.m
//  MasterClassAll
//
//  Created by carl on 2020/11/5.
//

#import "Status.h"

@implementation Status

+ (instancetype)statusWithDict:(NSDictionary *)dict {
    Status *status = [[Status alloc] init];
    [status setValuesForKeysWithDictionary:dict];
    return status;
}

@end
