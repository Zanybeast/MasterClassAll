//
//  ShopView.h
//  MasterClassAll
//
//  Created by carl on 2020/10/17.
//

#import <UIKit/UIKit.h>
#import "Shop.h"

NS_ASSUME_NONNULL_BEGIN

@interface ShopView : UIView

@property(nonatomic, strong) Shop* shop;

+(instancetype)shopView;

@end

NS_ASSUME_NONNULL_END
