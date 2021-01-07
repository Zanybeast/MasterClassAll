//
//  DealCell.m
//  MasterClassAll
//
//  Created by carl on 2020/11/1.
//

#import "DealCell.h"

@interface DealCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *buyCount;

@property (weak, nonatomic) IBOutlet UIImageView *checkedImageView;
@end

@implementation DealCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setDeal:(Deal *)deal {
    _deal = deal;
    
    [self.iconImageView setImage: [UIImage imageNamed: deal.icon]];
    self.title.text = deal.title;
    self.price.text = [NSString stringWithFormat:@"¥%@", deal.price];
    self.buyCount.text = [NSString stringWithFormat:@"%@人已购买", deal.buyCount];
    
    self.checkedImageView.hidden = !deal.isChecked;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
