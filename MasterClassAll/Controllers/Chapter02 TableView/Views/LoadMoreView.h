//
//  LoadMoreView.h
//  MasterClassAll
//
//  Created by carl on 2020/11/23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class LoadMoreView;

@protocol LoadMoreViewDelegate <NSObject>

@optional
- (void)loadMoreViewDidClickedLoadMoreButton: (LoadMoreView *)footer;

@end

@interface LoadMoreView : UIView

+ (instancetype)loadMoreView;

- (void)endLoading;

@property (weak, nonatomic) id<LoadMoreViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
