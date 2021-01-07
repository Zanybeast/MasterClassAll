//
//  ZZView.m
//  MasterClassAll
//
//  Created by carl on 2020/10/24.
//

#import "ZZView.h"


@interface ZZView ()

@property (strong, nonatomic) IBOutlet UIView *contentView;

@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation ZZView

- (void)awakeFromNib {
    [super awakeFromNib];
    ZLog(@"ZZView: awakeFromNib");
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setup];
        ZLog(@"ZZView: initWithCoder");
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        ZLog(@"ZZView: initWithFrame");
        [self setup];
    }
    return self;
}

- (void)setup {
    [[NSBundle mainBundle] loadNibNamed:@"ZZView" owner:self options:nil];
    [self addSubview:_contentView];
    self.contentView.frame = self.bounds;
    _label.text = @"awakeFromNib";
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
