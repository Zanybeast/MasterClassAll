//
//  EmptyWebViewVC.m
//  MasterClassAll
//
//  Created by carl on 2020/11/4.
//

#import "EmptyWebViewVC.h"

#import <WebKit/WKWebView.h>

@interface EmptyWebViewVC () <UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet WKWebView *webView;

@end

@implementation EmptyWebViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURL *url = [NSURL URLWithString:@"https://www.baidu.com"];

    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    
    NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSArray *cookieArr = [cookieJar cookies];
    for (NSHTTPCookie *cookie in cookieArr) {
        ZLog(@"WebView cookie -> %@", cookie);
    }
    
    [self.webView addObserver:self forKeyPath:@"URL" options:NSKeyValueObservingOptionNew context:nil];
    
    //返回手势
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleNavigationTransition:)];
    [self.view addGestureRecognizer:panGesture];
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"URL"]) {
        NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
        NSArray *cookieArr = [cookieJar cookies];
        for (NSHTTPCookie *cookie in cookieArr) {
            ZLog(@"WebView cookie -> %@", cookie);
        }
    }
}


//处理页面的返回手势
- (void)handleNavigationTransition: (UIGestureRecognizer *)ges {
    if (self.webView.canGoBack == YES) {
        [self.webView goBack];
    } else {
        ZLog(@"No Go Back");
    }
}


@end
