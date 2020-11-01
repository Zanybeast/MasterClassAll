//
//  Shop.m
//  MasterClassAll
//
//  Created by carl on 2020/10/17.
//

#import "Shop.h"

@implementation Shop

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        self.icon = dict[@"icon"];
        self.name = dict[@"name"];
    }
    return self;
}

+ (instancetype)shopWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}

@end
