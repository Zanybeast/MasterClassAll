//
//  Province.h
//  MasterClassAll
//
//  Created by carl on 2020/11/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Province : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSArray *cities;

+ (instancetype)initWithDict: (NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
