//
//  MyButton.m
//  MasterClassAll
//
//  Created by carl on 2020/11/21.
//

#import "MyButton.h"

@implementation MyButton

- (CGSize)intrinsicContentSize {
    return self.titleLabel.intrinsicContentSize;;
    
//    CGSize labelSize = [self.titleLabel sizeThatFits:CGSizeMake(self.frame.size.width, CGFLOAT_MAX)];
//    CGSize buttonSize = CGSizeMake(labelSize.width + self.titleEdgeInsets.left + self.titleEdgeInsets.right,
//                                   labelSize.height + self.titleEdgeInsets.top + self.titleEdgeInsets.bottom);
//    return buttonSize;
    
    
//    return CGSizeMake(self.frame.size.width, self.titleLabel.frame.size.height);
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.titleLabel.preferredMaxLayoutWidth = self.titleLabel.frame.size.width;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
