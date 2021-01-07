//
//  ContactListCell.h
//  MasterClassAll
//
//  Created by carl on 2020/11/27.
//

#import <UIKit/UIKit.h>
#import "Contact.h"

NS_ASSUME_NONNULL_BEGIN

@interface ContactListCell : UITableViewCell

@property (strong, nonatomic) Contact *contact;

@end

NS_ASSUME_NONNULL_END
