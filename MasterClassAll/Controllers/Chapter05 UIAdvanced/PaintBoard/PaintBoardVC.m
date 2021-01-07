//
//  PaintBoardVC.m
//  MasterClassAll
//
//  Created by carl on 2020/12/8.
//

#import "PaintBoardVC.h"
#import "PaintView.h"
#import "PaintImageView.h"

#define COLOR_KEY @"lineColorForPaintBoard"
#define LINE_WIDTH_KEY @"lineWidthForPaintBoard"
#define IMAGE_PATH_KEY @"imagePathForPaintBoard"

@interface PaintBoardVC () <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIColorPickerViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *navBackButton;

@property (weak, nonatomic) IBOutlet UISlider *slider;

@property (weak, nonatomic) IBOutlet PaintView *paintView;

@end

@implementation PaintBoardVC

#pragma mark - 懒加载属性

#pragma mark - 状态栏和导航栏处理
- (BOOL)prefersStatusBarHidden {
    return YES;
}

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self perstanceInitialization];
}
//取回持久化本地数据
- (void)perstanceInitialization {
    //线宽 - 本地数据
    if ([[NSUserDefaults standardUserDefaults] doubleForKey:LINE_WIDTH_KEY]) {
        self.paintView.lineWidth = [[NSUserDefaults standardUserDefaults] doubleForKey:LINE_WIDTH_KEY];
        [self.slider setValue:self.paintView.lineWidth];
    }
    //颜色 - 本地数据
    if ([[NSUserDefaults standardUserDefaults] colorForKey:COLOR_KEY]) {
        self.paintView.lineColor = [[NSUserDefaults standardUserDefaults] colorForKey:COLOR_KEY];
    }
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(changeButtonColor) userInfo:nil repeats:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBarHidden = NO;
}

#pragma mark - 监听事件
- (void)changeButtonColor {
    [self.navBackButton setTitleColor:[UIColor randomColor] forState:UIControlStateNormal];
}

#pragma mark - 按钮点击事件
- (IBAction)backToPreView:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
//清屏
- (IBAction)clearButton:(UIBarButtonItem *)sender {
    [self.paintView clear];
}
//撤销
- (IBAction)undoClicked:(UIBarButtonItem *)sender {
    [self.paintView undo];
}
//橡皮檫
- (IBAction)eraseClicked:(id)sender {
    self.paintView.lineColor = [UIColor whiteColor];
}
//选择图片
- (IBAction)choosePictureClicked:(UIBarButtonItem *)sender {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    
    imagePicker.delegate = self;
    
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:imagePicker animated:YES completion:nil];
}
//保存
- (IBAction)saveClicked:(UIBarButtonItem *)sender {
    UIGraphicsBeginImageContextWithOptions(self.paintView.bounds.size, NO, 0);
    
    CGContextRef ref = UIGraphicsGetCurrentContext();
    
    [self.paintView.layer renderInContext:ref];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}
//选择画笔颜色
- (IBAction)chooseColorClicked:(UIButton *)sender {
    UIColorPickerViewController *picker = [[UIColorPickerViewController alloc] init];
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:nil];
}

- (IBAction)lineWidthChanged:(UISlider *)sender {
    self.paintView.lineWidth = sender.value;
    [[NSUserDefaults standardUserDefaults] setDouble:sender.value forKey:LINE_WIDTH_KEY];
}

//保存图片成功
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    ZLog(@"图片保存成功");
}

//图片选择代理
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    PaintImageView *paintIV = [[PaintImageView alloc] initWithFrame:self.paintView.bounds];
    
    paintIV.ImageFinishedDrawToPaintBoard = ^(UIImage * _Nonnull image) {
        self.paintView.image = image;
    };
    
    [self.paintView addSubview:paintIV];
    
    paintIV.image = image;
    
    [self dismissViewControllerAnimated:picker completion:nil];
}
#pragma mark - 颜色选择代理
- (void)colorPickerViewControllerDidSelectColor:(UIColorPickerViewController *)viewController {
    UIColor *selectedColor = viewController.selectedColor;
    self.paintView.lineColor = selectedColor;
    [[NSUserDefaults standardUserDefaults] setColor:selectedColor forKey:COLOR_KEY];
}

- (void)colorPickerViewControllerDidFinish:(UIColorPickerViewController *)viewController {
    [self dismissViewControllerAnimated:viewController completion:nil];
}


@end
