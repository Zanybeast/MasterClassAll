//
//  TurnPlateVC.m
//  MasterClassAll
//
//  Created by carl on 2021/1/6.
//

#import "TurnPlateVC.h"
#import "PlateView.h"

@interface TurnPlateVC ()

@property (strong, nonatomic) PlateView *plateView;

@end


@implementation TurnPlateVC

- (void)viewDidLoad {
    [super viewDidLoad];

    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    PlateView *plateView = [PlateView plateView];
    plateView.frame = CGRectMake(0, 0, 268, 268);
    
    plateView.center = self.view.center;
    
    self.plateView = plateView;
    
    [self.view addSubview:plateView];
}


- (IBAction)startRotate:(UIButton *)sender {
    [self.plateView startRotate];
}

- (IBAction)stopRotate:(UIButton *)sender {
    [self.plateView pause];
}








@end
