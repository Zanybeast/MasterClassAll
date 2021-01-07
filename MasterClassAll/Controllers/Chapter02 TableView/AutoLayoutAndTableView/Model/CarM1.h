//
//  CarM1.h
//  MasterClassAll
//
//  Created by carl on 2020/11/1.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CarM1 : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *icon;

+ (instancetype)carWithName: (NSString*)name icon: (NSString*)icon;

@end

NS_ASSUME_NONNULL_END
