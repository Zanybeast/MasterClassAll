//
//  PickFlagVC.m
//  MasterClassAll
//
//  Created by carl on 2020/11/24.
//

#import "PickFlagVC.h"
#import "FlagPickerView.h"
#import "Flag.h"

@interface PickFlagVC () <UIPickerViewDelegate, UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

@property (strong, nonatomic) NSArray *flags;

@end

@implementation PickFlagVC

- (NSArray *)flags {
    if (_flags == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"flags" ofType:@"plist"];
        NSArray *dictArray = [NSArray arrayWithContentsOfFile:path];
        
        NSMutableArray *data = [NSMutableArray array];
        
        for (NSDictionary *dict in dictArray) {
            Flag *flag = [Flag initWithDict:dict];
            [data addObject:flag];
        }
        
        _flags = data;
    }
    return _flags;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - PICKERVIEW DELEGATE
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.flags.count;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 80;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    FlagPickerView *cell = [FlagPickerView flagPickerView];
    
    Flag *flag = self.flags[row];
    
    cell.flag = flag;
    
    return cell;
}

@end
