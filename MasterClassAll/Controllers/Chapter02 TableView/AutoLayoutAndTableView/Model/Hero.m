//
//  Hero.m
//  MasterClassAll
//
//  Created by carl on 2020/11/1.
//

#import "Hero.h"

@implementation Hero

+ (instancetype)heroWithDict:(NSDictionary *)dict {
    Hero *hero = [[Hero alloc] init];
    
    [hero setValuesForKeysWithDictionary:dict];
    return hero;
}
@end
