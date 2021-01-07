//
//  AddContactVC.h
//  MasterClassAll
//
//  Created by carl on 2020/11/27.
//

#import <UIKit/UIKit.h>
#import "Contact.h"

NS_ASSUME_NONNULL_BEGIN

@class AddContactVC;
//定义一个block
typedef void(^GetContactInfo)(Contact *);
#pragma mark - 代理模式反向传值
@protocol AddContactVCDelegate <NSObject>

@optional
- (void)addContactVC: (AddContactVC *)addContactVC whenAddButtonClicked: (Contact *)contact;

@end

@interface AddContactVC : UIViewController

@property (weak, nonatomic) id<AddContactVCDelegate> delegate;

#pragma mark - 闭包模式反向传值
@property (copy, nonatomic, nullable) GetContactInfo getContact;

@end

NS_ASSUME_NONNULL_END
