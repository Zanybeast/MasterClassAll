//
//  Contact.h
//  MasterClassAll
//
//  Created by carl on 2020/11/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Contact : NSObject <NSCoding, NSSecureCoding>

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *phoneNumber;
@property (strong, nonatomic) NSString *email;

+ (instancetype)initWithName: (NSString *)name phoneNumber: (NSString *)phoneNumber
                       email: (NSString *)email;

+ (instancetype)initWithName: (NSString *)name phoneNubmer: (NSString *)phoneNumber;
@end

NS_ASSUME_NONNULL_END
