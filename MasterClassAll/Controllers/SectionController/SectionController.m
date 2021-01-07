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
    
    NSString *sectionIndex = [NSString stringWithFormat:@"Section%li", indexPath.row + 1];
    NSString *theme = [self getTitleNameWithIndex:indexPath.row];
    NSString *title = [NSString stringWithFormat: @"%@  [%@]", sectionIndex, theme];
    
    cell.titleColor = [UIColor purpleColor];
    cell.font = [UIFont fontWithName:@"Arial Bold" size:18];
    cell.customBackgroundColor = [UIColor systemGray5Color];
    
    cell.titleStr = title;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *className = [self getTitleNameWithIndex:indexPath.row];
    UIViewController *controller = [self createControllerWithString:className];
    
    [self.navigationController pushViewController:controller animated:YES];
    
}

- (NSString *)getTitleNameWithIndex: (NSInteger)index {
    NSString *title = [self.controllers objectAtIndex: index];
    return title;
}

- (UIViewController *)createControllerWithString: (NSString *)name {
    ZLog(@"%@", name);
    UIViewController* theClass = [[NSClassFromString(name) alloc] init];
    
    NSString *title;
    if (name.length > 2) {
        title = [name substringToIndex:[name length] - 2];
    } else {
        title = @"Theme";
    }
    theClass.navigationItem.title = title;
    
    return theClass;
}

@end
