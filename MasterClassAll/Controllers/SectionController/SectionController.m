//
//  SectionController.m
//  MasterClassAll
//
//  Created by carl on 2020/10/17.
//

#import "SectionController.h"
#import "TitleCell.h"

@interface SectionController ()

@end

@implementation SectionController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"TitleCell" bundle:nil] forCellReuseIdentifier:@"TitleCell"];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.sectionNumber;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TitleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TitleCell" forIndexPath:indexPath];
    
    NSString *title = [NSString stringWithFormat:@"Section%li", indexPath.row + 1];
    cell.titleColor = [UIColor purpleColor];
    cell.font = [UIFont fontWithName:@"Arial Bold" size:20];
    cell.customBackgroundColor = [UIColor systemGray5Color];
    cell.titleStr = title;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *className = [self.controllers objectAtIndex:indexPath.row];
    UIViewController *controller = [self createControllerWithString:className];
    NSString *title;
    if (className.length > 2) {
        title = [className substringToIndex:[className length] - 2];
    } else {
        title = @"Theme";
    }
    controller.navigationItem.title = title;
    
    [self.navigationController pushViewController:controller animated:YES];
    
}

- (UIViewController *)createControllerWithString: (NSString *)name {
    NSLog(@"%@", name);
    id theClass = [[NSClassFromString(name) alloc] init];
    
    return theClass;
}

@end
