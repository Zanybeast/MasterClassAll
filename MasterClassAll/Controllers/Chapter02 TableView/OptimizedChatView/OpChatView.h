//
//  OpChatView.h
//  MasterClassAll
//
//  Created by carl on 2020/11/21.
//

#import <UIKit/UIKit.h>
#import "Message.h"

NS_ASSUME_NONNULL_BEGIN

@interface OpChatView : UITableViewCell

@property (strong, nonatomic) Message *message;

@end

NS_ASSUME_NONNULL_END
