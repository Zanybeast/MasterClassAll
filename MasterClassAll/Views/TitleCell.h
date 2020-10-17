//
//  TitleCell.h
//  MasterClassAll
//
//  Created by carl on 2020/10/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TitleCell : UITableViewCell

@property(nonatomic, strong) NSString* titleStr;
@property(nonatomic, strong) UIColor* titleColor;
@property(nonatomic, strong) UIFont* font;
@property(nonatomic, strong) UIColor* customBackgroundColor;

@end

NS_ASSUME_NONNULL_END
