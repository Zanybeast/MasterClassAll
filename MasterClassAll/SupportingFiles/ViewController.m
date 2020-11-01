//
//  ViewController.m
//  MasterClassAll
//
//  Created by carl on 2020/10/16.
//

#import "ViewController.h"
#import "TitleCell.h"
#import "SectionController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *hintImageView;

@property(nonatomic, strong) NSArray* sectionOfChapter;


@end

@implementation ViewController

- (NSArray *)sectionOfChapter {
    if(!_sectionOfChapter) {
        _sectionOfChapter = @[
            @[@"BaseUIAndScrollViewVC", @"SeperatePageVC"],
            @[@"AutoLayoutAndTableViewVC", @"LolHeroInfoVC"]
        ];
    }
    return _sectionOfChapter;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"TitleCell" bundle:nil] forCellReuseIdentifier:@"TitleCell"];
    
}

#pragma mark - Dark Mode Adjustment
//- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
//    if ([self.traitCollection userInterfaceStyle] == UIUserInterfaceStyleDark) {
//        self.hintImageView.image = [UIImage imageNamed:@"SelectAChapterDark"];
//    } else if ([self.traitCollection userInterfaceStyle] == UIUserInterfaceStyleLight) {
//        self.hintImageView.image = [UIImage imageNamed:@"SelectAChapter"];
//    }
//}

#pragma mark - UITableView DataSource And Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.sectionOfChapter.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TitleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TitleCell" forIndexPath:indexPath];
    
    NSString *title = [NSString stringWithFormat:@"Chapter%li", indexPath.row + 1];
    cell.titleStr = title;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    SectionController *controller = [[SectionController alloc] initWithNibName:@"SectionController" bundle:nil];
    
    NSArray *controllers = [self.sectionOfChapter objectAtIndex:indexPath.row];
    controller.sectionNumber = controllers.count;
    controller.controllers = controllers;
    
    [self.navigationController pushViewController:controller animated:YES];
}

@end
