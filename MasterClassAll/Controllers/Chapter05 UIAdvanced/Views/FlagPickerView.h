//
//  FlagPickerView.h
//  MasterClassAll
//
//  Created by carl on 2020/11/24.
//

#import <UIKit/UIKit.h>
#import "Flag.h"

NS_ASSUME_NONNULL_BEGIN

@interface FlagPickerView : UIView

@property (strong, nonatomic) Flag *flag;

+ (instancetype)flagPickerView;

@end

NS_ASSUME_NONNULL_END
