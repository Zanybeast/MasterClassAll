//
//  Province.m
//  MasterClassAll
//
//  Created by carl on 2020/11/26.
//

#import "Province.h"

@implementation Province

+ (instancetype)initWithDict:(NSDictionary *)dict {
    Province *province = [[Province alloc] init];
    [province setValuesForKeysWithDictionary:dict];
    return province;
}

@end
