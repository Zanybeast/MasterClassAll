//
//  ZZLabel.m
//  MasterClassAll
//
//  Created by carl on 2020/10/24.
//

#import "ZZLabel.h"

@implementation ZZLabel

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.text = @"InitWithCoder";
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.text = @"InitWithFrame";
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.text = @"AwakeFromNib";
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
