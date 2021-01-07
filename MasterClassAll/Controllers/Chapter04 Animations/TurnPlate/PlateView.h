//
//  PlateView.h
//  MasterClassAll
//
//  Created by carl on 2021/1/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PlateView : UIView

+ (instancetype)plateView;

- (void)startRotate;
- (void)pause;

@end

NS_ASSUME_NONNULL_END
