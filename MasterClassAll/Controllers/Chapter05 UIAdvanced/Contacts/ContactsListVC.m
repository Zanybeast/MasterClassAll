//
//  ContactsListVC.m
//  MasterClassAll
//
//  Created by carl on 2020/11/27.
//

#import "ContactsListVC.h"
#import "ContactListCell.h"
#import "AddContactVC.h"
#import "EditContactVC.h"

#define ContactFilePath [ZFileUtil fullPathInDocumentWith:@"contacts.data"]

@interface ContactsListVC () <UITableViewDelegate, UITableViewDataSource, AddContactVCDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *contacts;

@property (strong, nonatomic) NSString *filePath;

@end


@implementation ContactsListVC

- (NSMutableArray *)contacts {
    if (_contacts == nil) {
        NSError *error = nil;
        NSMutableData *data = [NSMutableData dataWithContentsOfFile:ContactFilePath];
        
        _contacts = (NSMutableArray *)[NSKeyedUnarchiver unarchivedArrayOfObjectsOfClass:[Contact class] fromData:data error:&error];
        
        if (error != nil) {
            ZLog(@"%@", error.localizedDescription);
        }
        
        if (_contacts == nil) {
            _contacts = [NSMutableArray array];
        }
    }
    return _contacts;
}

#pragma mark - controller 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = [NSString stringWithFormat:@"%@的联系人", self.navTitle];
    
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithImage:[UIImage systemImageNamed:@"plus"] style:UIBarButtonItemStylePlain target:self action:@selector(toAddContactController)];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ContactListCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    
    self.navigationItem.rightBarButtonItem = rightBarItem;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

#pragma mark - 事件监听响应
- (void)toAddContactController {
    AddContactVC *addVC = [[AddContactVC alloc] init];
    //代理传值
//    addVC.delegate = self;
    //闭包传值
    addVC.getContact = ^(Contact * contact) {
        [self.contacts addObject:contact];
        //对联系人进行排序
        self.contacts = [NSMutableArray arrayWithArray:[self.contacts sortedArrayUsingSelector:@selector(compare:)]];
        [self.tableView reloadData];
        
        [self dataLocalized];
    };
    [self.navigationController pushViewController:addVC animated:YES];
}

#pragma mark - 数据持久化方法
//保存通讯录列表到本地
- (void)dataLocalized {
    [[NSKeyedArchiver archivedDataWithRootObject:self.contacts requiringSecureCoding:NO error:nil] writeToFile:ContactFilePath atomically:YES];
}

#pragma mark - CUSTOM DELEGATE
- (void)addContactVC:(AddContactVC *)addContactVC whenAddButtonClicked:(Contact *)contact {
    [self.contacts addObject:contact];
    self.contacts = [NSMutableArray arrayWithArray:[self.contacts sortedArrayUsingSelector:@selector(compare:)]];
    [self.tableView reloadData];
}

#pragma mark - TABLEVIEW DATASOURCE AND DELEGATE
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.contacts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ContactListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    Contact *c = self.contacts[indexPath.row];

    cell.contact = c;
    
    return cell;
}

#pragma mark - 点击联系人信息, 跳转到编辑界面
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    __block Contact *contact = self.contacts[indexPath.row];
    
    EditContactVC *editVC = [[EditContactVC alloc] init];
    editVC.contact = contact;
    editVC.saveCompleted = ^(Contact * _Nonnull alteredContact) {
        contact.name = alteredContact.name;
        contact.phoneNumber = alteredContact.phoneNumber;
        contact.email = alteredContact.email;
        [self.tableView reloadData];
        
        [self dataLocalized];
    };
    
    [self.navigationController pushViewController:editVC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.contacts removeObjectAtIndex:indexPath.row];
    
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    [self dataLocalized];
}

- (UISwipeActionsConfiguration *)tableView:(UITableView *)tableView leadingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UIContextualAction *action1 = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleNormal title:@"删除" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
        [self.contacts removeObjectAtIndex:indexPath.row];
        
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
        [self dataLocalized];
    }];
    action1.backgroundColor = [UIColor  redColor];
    
    UISwipeActionsConfiguration *configuration = [UISwipeActionsConfiguration configurationWithActions:@[action1]];
    
    return configuration;
}

- (UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath {
    UIContextualAction *action1 = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleDestructive title:@"删除" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
        [self.contacts removeObjectAtIndex:indexPath.row];
        
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
        [self dataLocalized];
    }];
//    action1.backgroundColor = [UIColor   blueColor];
    
    
    UIContextualAction *action2 = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleNormal title:@"号码隐藏" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
        Contact *contact = self.contacts[indexPath.row];
        
        NSString *hideStr = @"xxx-xxxx-xxxx";
        contact.phoneNumber = hideStr;
        
        [self.tableView reloadData];
    }];
    action2.backgroundColor = [UIColor   blueColor];
    
    UISwipeActionsConfiguration *configuration = [UISwipeActionsConfiguration configurationWithActions:@[action2, action1]];
    
    return configuration;
}

@end
