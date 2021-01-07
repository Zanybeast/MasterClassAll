//
//  Message.m
//  MasterClassAll
//
//  Created by carl on 2020/11/6.
//

#import "Message.h"

@implementation Message

+ (instancetype)messageWithDict:(NSDictionary *)dict {
    Message *message = [[Message alloc] init];
    
    [message setValuesForKeysWithDictionary:dict];
    
    return message;
}

@end
