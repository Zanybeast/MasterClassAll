//
//  ContactListCell.m
//  MasterClassAll
//
//  Created by carl on 2020/11/27.
//

#import "ContactListCell.h"

@interface ContactListCell ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumberLabel;

@end

@implementation ContactListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setContact:(Contact *)contact {
    _contact = contact;
    
    self.nameLabel.text = contact.name;
    self.phoneNumberLabel.text = contact.phoneNumber;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
