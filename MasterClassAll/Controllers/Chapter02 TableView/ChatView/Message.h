//
//  Message.h
//  MasterClassAll
//
//  Created by carl on 2020/11/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum {
    MessageTypeMe = 0,
    MessageTypeOther = 1
} MessageType;

@interface Message : NSObject

@property (strong, nonatomic) NSString* text;
@property (strong, nonatomic) NSString* time;
@property (assign, nonatomic) MessageType type;

@property (assign, nonatomic) CGFloat cellHeight;

@property (assign, nonatomic, getter=isTimeHidden) BOOL timeHidden;

+ (instancetype)messageWithDict: (NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
