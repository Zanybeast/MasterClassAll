//
//  Status.h
//  MasterClassAll
//
//  Created by carl on 2020/11/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Status : NSObject

@property (strong, nonatomic) NSString* text;
@property (strong, nonatomic) NSString* icon;
@property (strong, nonatomic) NSString* name;
@property (strong, nonatomic) NSString* picture;
@property (assign, nonatomic, getter=isVip) BOOL vip;

+ (instancetype)statusWithDict: (NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
