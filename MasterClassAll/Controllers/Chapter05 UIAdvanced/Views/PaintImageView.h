//
//  PaintImageView.h
//  MasterClassAll
//
//  Created by carl on 2020/12/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PaintImageView : UIView

@property (strong, nonatomic) UIImage *image;

@property (strong, nonatomic) void(^ImageFinishedDrawToPaintBoard)(UIImage *image);


@end

NS_ASSUME_NONNULL_END
