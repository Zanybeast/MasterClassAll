//
//  PickerViewDemoVC.m
//  MasterClassAll
//
//  Created by carl on 2020/11/24.
//

#import "PickerViewDemoVC.h"

@interface PickerViewDemoVC () <UIPickerViewDelegate, UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *fruitLabel;
@property (weak, nonatomic) IBOutlet UILabel *stapleLabel;
@property (weak, nonatomic) IBOutlet UILabel *juiceLabel;

@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

@property (strong, nonatomic) NSArray *foods;

@end

@implementation PickerViewDemoVC

- (NSArray *)foods {
    if (_foods == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"foods" ofType:@"plist"];
        NSArray *dataArray = [NSArray arrayWithContentsOfFile:path];
        
        _foods = dataArray;
    }
    return _foods;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.fruitLabel.text = self.foods[0][0];
    self.stapleLabel.text = self.foods[1][0];
    self.juiceLabel.text = self.foods[2][0];
}

- (IBAction)randomChoice:(UIButton *)sender {
    for (int i = 0; i < self.foods.count; i++) {
        NSUInteger rowCount = [self.foods[i] count];
        
        int randomRow = arc4random_uniform((uint32_t)rowCount);
        
        [self.pickerView selectRow:randomRow inComponent:i animated:YES];
        [self pickerView:self.pickerView didSelectRow:randomRow inComponent:i];
    }
}

#pragma mark - PICKERVIEW DELEGATE
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return self.foods.count;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [self.foods[component] count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *title = self.foods[component][row];
    return title;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 45;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    switch (component) {
        case 0:
            self.fruitLabel.text = self.foods[component][row];
            break;
        case 1:
            self.stapleLabel.text = self.foods[component][row];
            break;
        case 2:
            self.juiceLabel.text = self.foods[component][row];
            break;
        default:
            break;
    }
}

@end
