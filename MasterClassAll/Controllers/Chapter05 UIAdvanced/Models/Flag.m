//
//  Flag.m
//  MasterClassAll
//
//  Created by carl on 2020/11/24.
//

#import "Flag.h"

@implementation Flag

+ (instancetype)initWithDict:(NSDictionary *)dict {
    Flag *flag = [[Flag alloc] init];
    
    [flag setValuesForKeysWithDictionary:dict];
    
    return flag;
}

@end
