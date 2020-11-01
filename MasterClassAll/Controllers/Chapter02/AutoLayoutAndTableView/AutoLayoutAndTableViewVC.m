//
//  AutoLayoutAndTableViewVC.m
//  MasterClassAll
//
//  Created by carl on 2020/10/17.
//

#import "AutoLayoutAndTableViewVC.h"
#import "UIView+Extension.h"
#import "TableViewDemo00VC.h"
#import "TableViewDemo01VC.h"
#import "Masonry.h"

@interface AutoLayoutAndTableViewVC ()

@property (strong, nonatomic) UIView *redView;
@property (strong, nonatomic) UIButton *toTableViewButton;
@property (strong, nonatomic) UIButton *toTableViewButton01;


@end

@implementation AutoLayoutAndTableViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addAnRedView];
    [self addButton];
    [self addButton01];
}

- (void)addButton {
    self.toTableViewButton = [[UIButton alloc] init];
    [self.toTableViewButton setTitle:@"To TableView" forState:UIControlStateNormal];
    [self.toTableViewButton setBackgroundColor: [UIColor systemGray5Color]];
    [self.toTableViewButton setTitleColor: [UIColor redColor] forState:UIControlStateNormal];
    
    [self.view addSubview:self.toTableViewButton];
    
    [self.toTableViewButton addTarget:self action:@selector(toTableViewDemo00) forControlEvents:UIControlEventTouchUpInside];
    [self.toTableViewButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.redView.mas_centerX);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(60);
        make.top.equalTo(self.redView.mas_bottom).offset(20);
    }];
    
    [self.toTableViewButton drawCornerWithRadius:30];
}

- (void)addButton01 {
    self.toTableViewButton01 = [[UIButton alloc] init];
    [self.toTableViewButton01 setTitle:@"To TableView" forState:UIControlStateNormal];
    [self.toTableViewButton01 setBackgroundColor: [UIColor systemGray5Color]];
    [self.toTableViewButton01 setTitleColor: [UIColor redColor] forState:UIControlStateNormal];
    
    [self.view addSubview:self.toTableViewButton01];
    
    [self.toTableViewButton01 addTarget:self action:@selector(toTableViewDemo01) forControlEvents:UIControlEventTouchUpInside];
    [self.toTableViewButton01 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.redView.mas_centerX);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(60);
        make.bottom.equalTo(self.redView.mas_top).offset(-20);
    }];
    
    [self.toTableViewButton01 drawCornerWithRadius:30];
}



- (void)toTableViewDemo00 {
    TableViewDemo00VC *vc = [[TableViewDemo00VC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)toTableViewDemo01 {
    TableViewDemo01VC *vc = [[TableViewDemo01VC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)addAnRedView {
    self.redView = [[UIView alloc] init];
    self.redView.translatesAutoresizingMaskIntoConstraints = NO;
    self.redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.redView];
    
    NSLayoutConstraint *centerXConstraint = [NSLayoutConstraint constraintWithItem:self.redView
                                                                         attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual
                                                                            toItem:self.view
                                                                         attribute:NSLayoutAttributeCenterX
                                                                        multiplier:1.0 constant:0];
    NSLayoutConstraint *centerYConstraint = [NSLayoutConstraint constraintWithItem:self.redView
                                                                         attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual
                                                                            toItem:self.view
                                                                         attribute:NSLayoutAttributeCenterY
                                                                        multiplier:1.0 constant:0];
    NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:self.redView
                                                                       attribute:NSLayoutAttributeWidth
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:nil
                                                                       attribute:NSLayoutAttributeNotAnAttribute
                                                                      multiplier:0.0 constant:200];
    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:self.redView
                                                                        attribute:NSLayoutAttributeHeight
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:nil
                                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                                       multiplier:0.0 constant:200];
    
    [NSLayoutConstraint activateConstraints:@[centerXConstraint,
                                              centerYConstraint,
                                              widthConstraint,
                                              heightConstraint]];
    
}


@end
