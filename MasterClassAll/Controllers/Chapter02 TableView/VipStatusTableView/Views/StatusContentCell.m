//
//  StatusContentCell.m
//  MasterClassAll
//
//  Created by carl on 2020/11/5.
//

#import "StatusContentCell.h"

@interface StatusContentCell ()
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIView *vipView;

@property (weak, nonatomic) IBOutlet UIView *contentImageContainer;
@property (weak, nonatomic) IBOutlet UIImageView *contentImageView;

@end

@implementation StatusContentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setStatus:(Status *)status {
    
    _status = status;
    
    self.avatarImageView.image = [UIImage imageNamed:status.icon];
    if (status.isVip) {
        self.nameLabel.textColor = [UIColor orangeColor];
        self.vipView.hidden = NO;
    } else {
        self.nameLabel.textColor = [UIColor blackColor];
        self.vipView.hidden = YES;
    }
    
    self.nameLabel.text = status.name;
    
    self.contentLabel.text = status.text;
    if (status.picture) {
        self.contentImageContainer.hidden = NO;
        self.contentImageView.image = [UIImage imageNamed:status.picture];
    } else {
        self.contentImageContainer.hidden = YES;
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
