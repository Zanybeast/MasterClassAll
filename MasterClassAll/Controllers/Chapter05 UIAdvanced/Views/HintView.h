//
//  HintView.h
//  MasterClassAll
//
//  Created by carl on 2020/11/28.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HintView : UIView

@property (strong, nonatomic) NSString *text;

+ (instancetype)hintViewWithText: (NSString *)text;

@end

NS_ASSUME_NONNULL_END
