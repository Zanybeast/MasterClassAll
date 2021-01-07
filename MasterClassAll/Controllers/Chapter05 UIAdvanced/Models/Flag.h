//
//  Flag.h
//  MasterClassAll
//
//  Created by carl on 2020/11/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Flag : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *icon;

+ (instancetype)initWithDict: (NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
