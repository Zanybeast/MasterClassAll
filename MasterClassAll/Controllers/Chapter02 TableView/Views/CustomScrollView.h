//
//  CustomScrollView.h
//  MasterClassAll
//
//  Created by carl on 2020/11/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomScrollView : UIView

@property (strong, nonatomic) NSArray *imagesArray;

@property (strong, nonatomic) UIColor *selectedColor;

@property (strong, nonatomic) UIColor *deselectedColor;

+(instancetype)customScrollViewWith: (NSArray *)images selectedColor: (UIColor *)selCol deselectedColor: (UIColor *)deselCol;
+(instancetype)customScrollViewWith: (NSArray *)images;

@end

NS_ASSUME_NONNULL_END
