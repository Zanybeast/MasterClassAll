//
//  Deal.m
//  MasterClassAll
//
//  Created by carl on 2020/11/3.
//

#import "Deal.h"

@interface Deal() 

@end

@implementation Deal

+ (instancetype)dealWithDict:(NSDictionary *)dict {
    Deal *deal = [[self alloc] init];
    
    [deal setValuesForKeysWithDictionary:dict];
    
    return deal;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

- (nonnull id)copyWithZone:(nullable NSZone *)zone {
    Deal *deal = [[Deal alloc] init];
    deal.buyCount = self.buyCount;
    deal.icon = self.icon;
    deal.price = self.price;
    deal.title = self.title;
    return deal;
}

@end
