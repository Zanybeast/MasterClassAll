//
//  PickDateNProvinceVC.m
//  MasterClassAll
//
//  Created by carl on 2020/11/26.
//

#import "PickDateNProvinceVC.h"
#import "Province.h"


@interface PickDateNProvinceVC () <UIPickerViewDelegate, UITextFieldDelegate, UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UITextField *dateTextField;

@property (weak, nonatomic) IBOutlet UITextField *cityTextField;

@property (strong, nonatomic) UIDatePicker *datePicker;
@property (strong, nonatomic) UIPickerView *cityPickerView;

@property (strong, nonatomic) NSArray *provinces;

@property (assign, nonatomic) NSInteger selectedProvinceIndex;
@property (assign, nonatomic) NSInteger lastSelectedCity;

@end

@implementation PickDateNProvinceVC

- (NSArray *)provinces {
    if (_provinces == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"provinces" ofType:@"plist"];
        NSArray *dictArray = [NSArray arrayWithContentsOfFile:path];
        
        NSMutableArray *data = [NSMutableArray array];
        
        for (NSDictionary *dict in dictArray) {
            Province *province = [Province initWithDict:dict];
            [data addObject:province];
        }
        
        _provinces = data;
    }
    
    return _provinces;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupDatePickerForTextField];
    [self setupCityPickerView];
    
}

#pragma mark - 设置日期选择器
- (void)setupDatePickerForTextField {
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    self.datePicker = datePicker;
    
    datePicker.preferredDatePickerStyle = UIDatePickerStyleWheels;
    datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
    datePicker.datePickerMode = UIDatePickerModeDate;
    
    [datePicker addTarget:self action:@selector(dateChangeInPicker:) forControlEvents:UIControlEventValueChanged];
    
    self.dateTextField.inputView = datePicker;
}

- (void)setupCityPickerView {
    UIPickerView *pickerView = [[UIPickerView alloc] init];
    self.cityPickerView = pickerView;
    
    pickerView.delegate = self;
    pickerView.dataSource = self;
    
    self.cityTextField.inputView = pickerView;
}

#pragma mark - 监听事件
- (void)dateChangeInPicker: (UIDatePicker *)datePicker {
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSString *date = [fmt stringFromDate:datePicker.date];
    
    self.dateTextField.text = date;
}

#pragma mark - TEXTFIELD DELEGATE
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (textField == self.dateTextField) {
        [self dateChangeInPicker:self.datePicker];
    } else {
        [self pickerView:self.cityPickerView didSelectRow:0 inComponent:0];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    return NO;
}

#pragma mark - PICKERVIEW DELEGATE
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    ZLog(@"numberOfComponentsInPickerView");
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    ZLog(@"numberOfRowsInComponent");
    if (component == 0) {
        return self.provinces.count;
    } else {
        Province *province = self.provinces[self.selectedProvinceIndex];
        return province.cities.count;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    ZLog(@"titleForRow");
    if (component == 0) {
        Province *province = self.provinces[row];
        return province.name;
    } else {
        NSInteger indexOfProvince = [self.cityPickerView selectedRowInComponent:0];
        Province *province = self.provinces[indexOfProvince];
        return province.cities[row];
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    ZLog(@"didSelectRow");
    if (component == 0) {
        self.selectedProvinceIndex = [pickerView selectedRowInComponent:0];
        [pickerView reloadComponent:1];
        [pickerView selectRow:0 inComponent:1 animated:YES];
    }
    
    Province *province = self.provinces[self.selectedProvinceIndex];
    NSInteger selectedCity = [pickerView selectedRowInComponent:1];
    NSString *cityName = cityName = province.cities[selectedCity];
    
    self.cityTextField.text = [NSString stringWithFormat:@"%@-%@", province.name, cityName];
}

@end
