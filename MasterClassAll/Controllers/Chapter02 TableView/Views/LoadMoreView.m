//
//  LoadMoreView.m
//  MasterClassAll
//
//  Created by carl on 2020/11/23.
//

#import "LoadMoreView.h"

@interface LoadMoreView ()

@property (weak, nonatomic) IBOutlet UIButton *loadMoreButton;

@property (weak, nonatomic) IBOutlet UIView *loadingView;

@end

@implementation LoadMoreView

+ (instancetype)loadMoreView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (IBAction)loadMoreButtonClicked:(UIButton *)sender {
    self.loadMoreButton.hidden = YES;
    self.loadingView.hidden = NO;
    
    if ([self.delegate respondsToSelector:@selector(loadMoreViewDidClickedLoadMoreButton:)]) {
        [self.delegate loadMoreViewDidClickedLoadMoreButton:self];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"loadMore" object:nil];
}

- (void)endLoading {
    self.loadMoreButton.hidden = NO;
    self.loadingView.hidden = YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
