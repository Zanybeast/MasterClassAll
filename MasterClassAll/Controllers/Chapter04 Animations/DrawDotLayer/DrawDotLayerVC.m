//
//  DrawDotLayerVC.m
//  MasterClassAll
//
//  Created by carl on 2021/1/7.
//

#import "DrawDotLayerVC.h"
#import "DrawDotView.h"

@interface DrawDotLayerVC ()

@property (weak, nonatomic) IBOutlet DrawDotView *drawView;

@end

@implementation DrawDotLayerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)startDraw:(UIButton *)sender {
    [self.drawView startDraw];
}

- (IBAction)reDraw:(UIButton *)sender {
    [self.drawView reDraw];
}


@end
