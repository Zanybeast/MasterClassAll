//
//  EditContactVC.h
//  MasterClassAll
//
//  Created by carl on 2020/11/27.
//

#import <UIKit/UIKit.h>
#import "Contact.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^SaveBlock)(Contact *alteredContact);

@interface EditContactVC : UIViewController

@property (strong, nonatomic) Contact *contact;

@property (copy, nonatomic, nullable) SaveBlock saveCompleted;

@end

NS_ASSUME_NONNULL_END
