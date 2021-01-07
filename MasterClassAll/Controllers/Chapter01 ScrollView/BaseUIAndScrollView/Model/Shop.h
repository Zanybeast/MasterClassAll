//
//  Shop.h
//  MasterClassAll
//
//  Created by carl on 2020/10/17.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Shop : NSObject

@property(nonatomic, strong) NSString* icon;
@property(nonatomic, strong) NSString* name;

- (instancetype)initWithDict: (NSDictionary *)dict;
+ (instancetype)shopWithDict: (NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
