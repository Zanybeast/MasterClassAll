//
//  InvertedImageVC.m
//  MasterClassAll
//
//  Created by carl on 2021/1/7.
//

#import "InvertedImageVC.h"
#import "ReplView.h"

#define OFFSET -0.1

@interface InvertedImageVC ()
@property (weak, nonatomic) IBOutlet ReplView *replView;

@end

@implementation InvertedImageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CAReplicatorLayer *replLayer = (CAReplicatorLayer *)(self.replView.layer);
    
    replLayer.instanceCount = 2;
    
    CATransform3D transform = CATransform3DMakeTranslation(0, self.replView.bounds.size.width, 0);
    transform = CATransform3DRotate(transform, M_PI, 1, 0, 0);
    
    replLayer.instanceTransform = transform;
    
    replLayer.instanceAlphaOffset = OFFSET;
    
    replLayer.instanceRedOffset = OFFSET;
    replLayer.instanceGreenOffset = OFFSET;
    replLayer.instanceBlueOffset = OFFSET;
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
