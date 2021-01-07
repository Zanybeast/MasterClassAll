//
//  PaintView.h
//  MasterClassAll
//
//  Created by carl on 2020/12/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PaintView : UIView

@property (strong, nonatomic) UIColor *lineColor;
@property (assign, nonatomic) CGFloat lineWidth;

@property (strong, nonatomic) UIImage *image;

- (void)clear;
- (void)undo;

@end

NS_ASSUME_NONNULL_END
