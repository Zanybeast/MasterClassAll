//
//  OpChatViewCell.m
//  MasterClassAll
//
//  Created by carl on 2020/11/21.
//

#import "OpChatViewCell.h"

@interface OpChatViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *timeLabelHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labelToTopConstraint;

@property (weak, nonatomic) IBOutlet UIImageView *otherAvator;
@property (weak, nonatomic) IBOutlet UIView *otherAvatorContainer;
@property (weak, nonatomic) IBOutlet UILabel *otherMessage;
@property (weak, nonatomic) IBOutlet UIImageView *otherBackground;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *otherToLabelConstraint;

@property (weak, nonatomic) IBOutlet UIImageView *meAvator;
@property (weak, nonatomic) IBOutlet UIView *meAvatorContainer;
@property (weak, nonatomic) IBOutlet UILabel *meMessage;
@property (weak, nonatomic) IBOutlet UIImageView *meBackground;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *meToLabelConstraint;

@end

@implementation OpChatViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
}

- (void)setMessage:(Message *)message {
    _message = message;
    
    CGFloat cellHeight = 0;
    
    if (message.isTimeHidden) {
        self.timeLabel.hidden = YES;
        
        self.timeLabelHeight.constant = 0;
        self.labelToTopConstraint.constant = 0;
        
        self.otherToLabelConstraint.constant = 0;
        self.meToLabelConstraint.constant = 0;
    } else {
        self.timeLabel.hidden = NO;
        self.timeLabel.text = message.time;
        self.timeLabelHeight.constant = 20;
        self.labelToTopConstraint.constant = 10;
        
        self.otherToLabelConstraint.constant = 10;
        self.meToLabelConstraint.constant = 10;
        cellHeight += 30;
        //timeLabel 到头像的间隔
        cellHeight += 10;
    }
    
    if (message.type == MessageTypeMe) {
        CGFloat messageHeight = [self showAvator:self.meAvator showContainer:self.meAvatorContainer
                                     showMessage:self.meMessage showBackground:self.meBackground
                                      hideAvator:self.otherAvator hideContainer:self.otherAvatorContainer
                                     hideMessage:self.otherMessage hideBackground:self.otherBackground];
        
        cellHeight += messageHeight;
    } else {
        CGFloat messageHeight = [self showAvator:self.otherAvator showContainer:self.otherAvatorContainer
                                     showMessage:self.otherMessage showBackground:self.otherBackground
                                      hideAvator:self.meAvator hideContainer:self.meAvatorContainer
                                     hideMessage:self.meMessage hideBackground:self.meBackground];
        
        cellHeight += messageHeight;
    }
    
    self.message.cellHeight = cellHeight + 10;
    self.cellHeight = cellHeight + 10;
    
}

- (CGFloat)showAvator: (UIImageView *)showAvator showContainer: (UIView *)showContainer
       showMessage: (UILabel *)showMessage showBackground: (UIImageView *)showBg
        hideAvator: (UIImageView *)hideAvator hideContainer: (UIView *)hideContainer
       hideMessage: (UILabel *)hideMessage hideBackground: (UIImageView *)hideBg {
    hideAvator.hidden = YES;
    hideContainer.hidden = YES;
    hideMessage.hidden = YES;
    hideBg.hidden = YES;
    
    showAvator.hidden = NO;
    showContainer.hidden = NO;
    showMessage.hidden = NO;
    showBg.hidden = NO;
    
    showMessage.text = self.message.text;
    
    CGFloat labelHeight = showMessage.intrinsicContentSize.height;
    
    if (labelHeight + 30 < 50) {
        labelHeight = 50;
    } else {
        labelHeight += 30;
    }
    
    return labelHeight;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
