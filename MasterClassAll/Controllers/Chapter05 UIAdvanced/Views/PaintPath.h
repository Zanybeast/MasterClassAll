//
//  PaintPath.h
//  MasterClassAll
//
//  Created by carl on 2020/12/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PaintPath : UIBezierPath<NSSecureCoding, NSCoding>

@property (strong, nonatomic) UIColor *pathColor;

@end

NS_ASSUME_NONNULL_END
