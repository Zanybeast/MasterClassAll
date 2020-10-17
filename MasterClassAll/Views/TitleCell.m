//
//  TitleCell.m
//  MasterClassAll
//
//  Created by carl on 2020/10/16.
//

#import "TitleCell.h"

@interface TitleCell()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation TitleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    

}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.titleColor != nil) {
        _titleLabel.textColor = self.titleColor;
    }
    if (self.font != nil) {
        _titleLabel.font = self.font;
    }
    if (self.customBackgroundColor != nil) {
        self.backgroundColor = self.customBackgroundColor;
    }
    
    _titleLabel.text = _titleStr;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
