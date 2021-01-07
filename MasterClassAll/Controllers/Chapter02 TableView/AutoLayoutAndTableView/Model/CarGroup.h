//
//  CarGroup.h
//  MasterClassAll
//
//  Created by carl on 2020/11/1.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CarGroup : NSObject

@property (strong, nonatomic) NSString *header;
@property (strong, nonatomic) NSString *footer;

@property (strong, nonatomic) NSArray *cars;

@end

NS_ASSUME_NONNULL_END
