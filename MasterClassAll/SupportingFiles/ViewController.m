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
@property (nonatomic, strong) NSArray* chapterTitle;


@end

@implementation ViewController

- (BOOL)prefersStatusBarHidden {
    return NO;
}

- (NSArray *)sectionOfChapter {
    if(!_sectionOfChapter) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"chapterContent" ofType:@"plist"];
        _sectionOfChapter = [NSArray arrayWithContentsOfFile:path];
    }
    return _sectionOfChapter;
}

- (NSArray *)chapterTitle {
    if (_chapterTitle == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"chapters" ofType:@"plist"];
        _chapterTitle = [NSArray arrayWithContentsOfFile:path];
    }
    return _chapterTitle;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"TitleCell" bundle:nil] forCellReuseIdentifier:@"TitleCell"];
    
}

#pragma mark - UITableView DataSource And Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.sectionOfChapter.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TitleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TitleCell" forIndexPath:indexPath];
    
    NSString *title = self.chapterTitle[indexPath.row];
    
    NSString *titleStr = [NSString stringWithFormat:@"Chapter%li: %@", indexPath.row + 1, title];
    cell.titleStr = titleStr;
    
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
