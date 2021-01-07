//
//  ShopView.m
//  MasterClassAll
//
//  Created by carl on 2020/10/17.
//

#import "ShopView.h"

@interface ShopView()

@property(nonatomic, strong) UIImageView* iconImageView;
@property(nonatomic, strong) UILabel* titleLabel;

@end

@implementation ShopView

+ (instancetype)shopView {
    return [[self alloc] init];
}

//Lazy load titleLabel
- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        UILabel* label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:11];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor redColor];
        [self addSubview:label];
        _titleLabel = label;
    }
    return _titleLabel;
}

//Lazy load imageView
- (UIImageView *)iconImageView {
    if (_iconImageView == nil) {
        UIImageView *iconView = [[UIImageView alloc] init];
        iconView.backgroundColor = [UIColor blueColor];
        [self addSubview:iconView];
        _iconImageView = iconView;
    }
    return _iconImageView;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat viewWidth = self.frame.size.width;
    CGFloat viewHeight = self.frame.size.height;
    
    self.iconImageView.frame = CGRectMake(0, 0, viewWidth, viewWidth);
    self.titleLabel.frame = CGRectMake(0, viewWidth, viewWidth, viewHeight - viewWidth);
}

- (void)setShop:(Shop *)shop {
    _shop = shop;
    
    self.titleLabel.text = shop.name;
    self.iconImageView.image = [UIImage imageNamed:shop.icon];
}

@end
