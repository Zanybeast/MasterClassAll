//
//  TableViewDemo01VC.m
//  MasterClassAll
//
//  Created by carl on 2020/11/1.
//

#import "TableViewDemo01VC.h"
#import "CarM1.h"
#import "CarGroup.h"

@interface TableViewDemo01VC () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSArray *groups;

@end

@implementation TableViewDemo01VC

- (NSArray *)groups {
    if (_groups == nil) {
        CarGroup *group0 = [[CarGroup alloc] init];
        group0.header = @"德系";
        group0.footer = @"德系车";
        group0.cars = @[
                        [CarM1 carWithName:@"奥迪" icon:@"m_9_100"],
                        [CarM1 carWithName:@"宝马" icon:@"m_3_100"],
                        [CarM1 carWithName:@"奔驰" icon:@"m_2_100"]
                        ];
        
        CarGroup *group1 = [[CarGroup alloc] init];
        group1.header = @"日系";
        group1.footer = @"日系车";
        group1.cars = @[
                        [CarM1 carWithName:@"奥迪1" icon:@"m_9_100"],
                        [CarM1 carWithName:@"奔驰1" icon:@"m_2_100"],
                        [CarM1 carWithName:@"奥迪1" icon:@"m_9_100"],
                        [CarM1 carWithName:@"奔驰1" icon:@"m_2_100"],
                        [CarM1 carWithName:@"奥迪1" icon:@"m_9_100"],
                        [CarM1 carWithName:@"奔驰1" icon:@"m_2_100"],
                        [CarM1 carWithName:@"奥迪1" icon:@"m_9_100"],
                        [CarM1 carWithName:@"奔驰1" icon:@"m_2_100"],
                        [CarM1 carWithName:@"奥迪1" icon:@"m_9_100"],
                        [CarM1 carWithName:@"奔驰1" icon:@"m_2_100"],
                        [CarM1 carWithName:@"奥迪1" icon:@"m_9_100"],
                        [CarM1 carWithName:@"奔驰1" icon:@"m_2_100"]
                        ];
        
        CarGroup *group2 = [[CarGroup alloc] init];
        group2.header = @"日系";
        group2.footer = @"日系车";
        group2.cars = @[
                        [CarM1 carWithName:@"奥迪2" icon:@"m_9_100"],
                        [CarM1 carWithName:@"奔驰2" icon:@"m_2_100"]
                        ];
        
        _groups = @[group0, group1, group2];
    }
    
    return _groups;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}


#pragma mark - TABLEVIEW DATASOURCE AND DELEGATE
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.groups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    CarGroup *group = self.groups[section];
    return group.cars.count;
}
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    
    CarGroup *group = self.groups[indexPath.section];
    CarM1 *car = group.cars[indexPath.row];
    
    cell.textLabel.text = car.name;
    cell.imageView.image = [UIImage imageNamed:car.icon];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    CarGroup *group = self.groups[section];
    return group.header;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    CarGroup *group = self.groups[section];
    return group.footer;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}


@end
