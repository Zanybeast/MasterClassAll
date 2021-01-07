//
//  Deal.h
//  MasterClassAll
//
//  Created by carl on 2020/11/3.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Deal : NSObject<NSCopying>

@property (strong, nonatomic) NSString *buyCount;
@property (strong, nonatomic) NSString *icon;
@property (strong, nonatomic) NSString *price;
@property (strong, nonatomic) NSString *title;
//标记该属性是否打钩
@property (assign, nonatomic, getter=isChecked) BOOL checked;

+(instancetype)dealWithDict: (NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
