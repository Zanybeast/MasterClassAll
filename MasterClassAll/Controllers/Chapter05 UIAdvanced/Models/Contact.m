//
//  Contact.m
//  MasterClassAll
//
//  Created by carl on 2020/11/27.
//

#import "Contact.h"

#define kName @"name"
#define kPhone @"phone"
#define kEmail @"emali"

@implementation Contact

+ (instancetype)initWithName:(NSString *)name phoneNubmer:(NSString *)phoneNumber {
    return [Contact initWithName:name phoneNumber:phoneNumber email:@""];
}

+ (instancetype)initWithName:(NSString *)name phoneNumber:(NSString *)phoneNumber email:(NSString *)email {
    Contact *contact = [[Contact alloc] init];
    contact.name = name;
    contact.phoneNumber = phoneNumber;
    contact.email = email;
    return contact;
}

- (NSComparisonResult)compare:(Contact *)other
{
    return [self.name compare:other.name];
}

- (nullable instancetype)initWithCoder:(nonnull NSCoder *)coder {
    if (self = [super init]) {
        self.name = [coder decodeObjectForKey:kName];
        self.phoneNumber = [coder decodeObjectForKey:kPhone];
        self.email = [coder decodeObjectForKey:kEmail];
    }
    return self;
}

- (void)encodeWithCoder:(nonnull NSCoder *)coder {
    [coder encodeObject:_name forKey:kName];
    [coder encodeObject:_phoneNumber forKey:kPhone];
    [coder encodeObject:_email forKey:kEmail];
}

+ (BOOL)supportsSecureCoding {
    return YES;
}

@end



