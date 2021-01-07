//
//  FlagPickerView.m
//  MasterClassAll
//
//  Created by carl on 2020/11/24.
//

#import "FlagPickerView.h"

@interface FlagPickerView ()

@property (weak, nonatomic) IBOutlet UIImageView *flagImageView;
@property (weak, nonatomic) IBOutlet UILabel *countryLabel;

@end

@implementation FlagPickerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
}

+ (instancetype)flagPickerView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)setFlag:(Flag *)flag {
    _flag = flag;
    
    [self.flagImageView setImage:[UIImage imageNamed:flag.icon]];
    self.countryLabel.text = flag.name;
}

@end
