//
//  ChatViewCell.m
//  MasterClassAll
//
//  Created by carl on 2020/11/6.
//

#import "ChatViewCell.h"
#import "Masonry.h"

@interface ChatViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *otherImageView;

@property (weak, nonatomic) IBOutlet UIImageView *meImageView;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;


@property (weak, nonatomic) IBOutlet UIButton *otherMessageContent;
@property (weak, nonatomic) IBOutlet UIButton *meMessageContent;

@property (weak, nonatomic) IBOutlet UIView *viewContainer;

@end

@implementation ChatViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.otherMessageContent.titleLabel.numberOfLines = 0;
    self.meMessageContent.titleLabel.numberOfLines = 0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setMessage:(Message *)message {
    
    _message = message;
    
    CGFloat avatorHeight = 0;
    CGFloat messageHeight = 0;
    
    if (message.isTimeHidden) {
        _timeLabel.hidden = YES;
        [_timeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
        
//        [_timeLabel layoutIfNeeded];
    } else {
        _timeLabel.hidden = NO;
        [_timeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(20.5);
        }];
        
        _timeLabel.text = message.time;
    }
    
    if (message.type == MessageTypeMe) {
        self.otherMessageContent.hidden = YES;
        self.otherImageView.hidden = YES;
        
        self.meMessageContent.hidden = NO;
        self.meImageView.hidden = NO;
        
        [self.meMessageContent setTitle:message.text forState:UIControlStateNormal];
        
        [self.meMessageContent layoutIfNeeded];
        
        [self.meMessageContent mas_updateConstraints:^(MASConstraintMaker *make) {
            CGFloat buttonHeight = self.meMessageContent.titleLabel.frame.size.height + 30;
            make.height.mas_equalTo(buttonHeight);
        }];
        
        [self.meMessageContent layoutIfNeeded];
        
        avatorHeight = CGRectGetMaxY(self.meImageView.frame);
        messageHeight = CGRectGetMaxY(self.meMessageContent.frame);
        
        [self.meMessageContent layoutIfNeeded];
        [self.viewContainer layoutIfNeeded];
        
        self.message.cellHeight = MAX(avatorHeight, messageHeight) + 40;
    } else if (message.type == MessageTypeOther) {
        self.otherMessageContent.hidden = NO;
        self.otherImageView.hidden = NO;
        
        self.meMessageContent.hidden = YES;
        self.meImageView.hidden = YES;
        
        [self.otherMessageContent setTitle:message.text forState:UIControlStateNormal];
        
        [self.otherMessageContent layoutIfNeeded];
        
        [self.otherMessageContent mas_updateConstraints:^(MASConstraintMaker *make) {
            CGFloat buttonHeight = self.otherMessageContent.titleLabel.frame.size.height + 30;
            make.height.mas_equalTo(buttonHeight);
        }];
        
        [self.otherMessageContent layoutIfNeeded];
        
        avatorHeight = CGRectGetMaxY(self.otherImageView.frame);
        messageHeight = CGRectGetMaxY(self.otherMessageContent.frame);
        
        [self.otherMessageContent layoutIfNeeded];
        [self.viewContainer layoutIfNeeded];
        
        self.message.cellHeight = MAX(avatorHeight, messageHeight) + 40;
    }
    
}



@end
