//
//  OpChatViewCell.h
//  MasterClassAll
//
//  Created by carl on 2020/11/21.
//

#import <UIKit/UIKit.h>
#import "Message.h"

NS_ASSUME_NONNULL_BEGIN

@interface OpChatViewCell : UITableViewCell

@property (strong, nonatomic) Message *message;

@property (assign, nonatomic) CGFloat cellHeight;

@end

NS_ASSUME_NONNULL_END
