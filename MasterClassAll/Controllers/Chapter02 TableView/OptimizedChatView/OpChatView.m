//
//  OpChatView.m
//  MasterClassAll
//
//  Created by carl on 2020/11/21.
//

#import "OpChatView.h"
#import "Masonry.h"
#import "MyButton.h"


@interface OpChatView ()

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UIImageView *meImageView;
@property (weak, nonatomic) IBOutlet UIButton *meMessageButton;

@property (weak, nonatomic) IBOutlet UIImageView *otherImageView;
@property (weak, nonatomic) IBOutlet UIButton *otherMessageButton;

@end

@implementation OpChatView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.meMessageButton.titleLabel.numberOfLines = 0;
    self.otherMessageButton.titleLabel.numberOfLines = 0;
}

- (void)setMessage:(Message *)message {
    _message = message;
    
    if (message.isTimeHidden) {
        self.timeLabel.hidden = YES;
        [self.timeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
    } else {
        self.timeLabel.hidden = NO;
        self.timeLabel.text = message.time;
        [self.timeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(21);
        }];
    }
    
    if (message.type == MessageTypeMe) {
        [self settingShowTextButton:self.meMessageButton showIconView:self.meImageView
                     hideTextButton:self.otherMessageButton hideIconView:self.otherImageView
//                   showButtonHeight:self.meHeight
         ];
    } else {
        [self settingShowTextButton:self.otherMessageButton showIconView:self.otherImageView
                     hideTextButton:self.meMessageButton hideIconView:self.meImageView
//                   showButtonHeight:self.otherHeight
         ];
    }
}

- (void)settingShowTextButton:(UIButton *)showTextButton showIconView:(UIImageView *)showIconView
               hideTextButton:(UIButton *)hideTextButton hideIconView:(UIImageView *)hideIconView
//             showButtonHeight:(NSLayoutConstraint *)buttonHeight
{
    hideTextButton.hidden = YES;
    hideIconView.hidden = YES;
    
    showTextButton.hidden = NO;
    showIconView.hidden = NO;
    
    // 设置按钮的文字
    [showTextButton setTitle:self.message.text forState:UIControlStateNormal];
    
    CGFloat labelHeight = showTextButton.titleLabel.intrinsicContentSize.height;
    ZLog(@"labelHeight: %f", labelHeight);
    
    [showTextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(labelHeight + 30);
    }];
    
//    buttonHeight.constant = showTextButton.titleLabel.frame.size.height;
    
//    [showTextButton sizeToFit];
    
//    CGSize size = [self.message.text sizeWithFont:[UIFont systemFontOfSize:18]];
//    if (self.message.isTimeHidden) {
//        [showTextButton setFrame:CGRectMake(70, 15, size.width, size.height)];
//    } else {
//        [showTextButton setFrame:CGRectMake(70, 35, size.width, size.height)];
//    }

    
//    // 强制更新
//    [showTextButton layoutIfNeeded];
//    
//    // 设置按钮的高度就是titleLabel的高度
//    [showTextButton mas_updateConstraints:^(MASConstraintMaker *make) {
//        CGFloat buttonH = showTextButton.titleLabel.frame.size.height + 30;
//        make.height.mas_equalTo(buttonH);
//    }];
//    
//    // 强制更新
//    [showTextButton layoutIfNeeded];
    
    // 计算当前cell的高度
    CGFloat buttonMaxY = CGRectGetMaxY(showTextButton.frame);
    CGFloat iconMaxY = CGRectGetMaxY(showIconView.frame);
    
    ZLog(@"buttonY: %f", buttonMaxY);
    ZLog(@"iconY: %f", iconMaxY);
    
    self.message.cellHeight = MAX(buttonMaxY, iconMaxY) + 10;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
