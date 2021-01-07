//
//  LolHeroInfoVC.m
//  MasterClassAll
//
//  Created by carl on 2020/11/1.
//

#import "LolHeroInfoVC.h"
#import "Hero.h"
#import "HeroDetailVC.h"

@interface LolHeroInfoVC () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSArray *heroes;

@end

@implementation LolHeroInfoVC

- (NSArray *)heroes {
    if (_heroes == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"heroes" ofType:@"plist"];
        NSArray *dictArray = [NSArray arrayWithContentsOfFile:path];
        
        NSMutableArray *heroArray = [NSMutableArray array];
        for (NSDictionary *dict in dictArray) {
            Hero *hero = [Hero heroWithDict:dict];
            [heroArray addObject:hero];
        }
        
        _heroes = heroArray;
    }
    
    return _heroes;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - TABLEVIEW DATASOURCE
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.heroes.count * 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    }
    
    Hero *hero = self.heroes[indexPath.row % self.heroes.count];
    
    cell.textLabel.text = hero.name;
    cell.imageView.image = [UIImage imageNamed:hero.icon];
    cell.detailTextLabel.text = hero.intro;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Hero *hero = self.heroes[indexPath.row % self.heroes.count];
    
    HeroDetailVC *heroDetailVC = [[HeroDetailVC alloc] init];
    heroDetailVC.hero = hero;
    
    [self.navigationController pushViewController:heroDetailVC animated:NO];
    
}

@end
