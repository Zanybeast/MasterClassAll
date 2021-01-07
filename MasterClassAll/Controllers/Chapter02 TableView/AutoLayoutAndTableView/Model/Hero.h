//
//  Hero.h
//  MasterClassAll
//
//  Created by carl on 2020/11/1.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Hero : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *icon;
@property (strong, nonatomic) NSString *intro;

+ (instancetype)heroWithDict: (NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
