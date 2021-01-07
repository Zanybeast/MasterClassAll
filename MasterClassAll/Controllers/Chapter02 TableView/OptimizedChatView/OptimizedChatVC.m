//
//  OptimizedChatVC.m
//  MasterClassAll
//
//  Created by carl on 2020/11/21.
//

#import "OptimizedChatVC.h"
#import "Message.h"
#import "OpChatView.h"
#import "OpChatViewCell.h"


@interface OptimizedChatVC () <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewBottom;

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;

@property (strong, nonatomic) NSMutableArray *messages;

@property (assign, nonatomic) BOOL isScrollToBottom;

@end

@implementation OptimizedChatVC

//- (NSMutableArray *)messages {
//    if (_messages == nil) {
//        NSString *path = [[NSBundle mainBundle] pathForResource:@"messages" ofType:@"plist"];
//        NSArray *dictArray = [NSArray arrayWithContentsOfFile:path];
//
//        NSMutableArray *data = [NSMutableArray array];
//        Message *lastMessage = nil;
//
//        for (NSDictionary *dict in dictArray) {
//            Message *message = [Message messageWithDict:dict];
//            if (lastMessage == nil) {
//                message.timeHidden = NO;
//            } else {
//                message.timeHidden = [message.time isEqualToString:lastMessage.time];
//            }
//
//            [data addObject:message];
//
//            lastMessage = message;
//        }
//
//        _messages = data;
//    }
//
//    return _messages;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"messages" ofType:@"plist"];
    NSArray *dictArray = [NSArray arrayWithContentsOfFile:path];

    NSMutableArray *data = [NSMutableArray array];
    Message *lastMessage = nil;

    for (NSDictionary *dict in dictArray) {
        Message *message = [Message messageWithDict:dict];
        if (lastMessage == nil) {
            message.timeHidden = NO;
        } else {
            message.timeHidden = [message.time isEqualToString:lastMessage.time];
        }

        [data addObject:message];

        lastMessage = message;
    }

    self.messages = [NSMutableArray arrayWithArray:data];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"OpChatViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 200;
    //延迟显示 tableview, 让其先加载数据
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.tableView.hidden = NO;
        [self.tableView reloadData];
    });
    
    //TODO: 进入界面后滚动到页面最底部,该方法在这里不生效

    //让 textfield 文字间隔左边多少空白
    UIView *leftView = [[UIView alloc] init];
    leftView.frame = CGRectMake(0, 0, 5, 0);
    self.textField.leftView = leftView;
    self.textField.leftViewMode = UITextFieldViewModeAlways;
    
    #pragma mark - 监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (IBAction)scrollToBottom:(UIButton *)sender {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.messages.count - 1 inSection:0];
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:false];
}

#pragma mark - 键盘改变通知
- (void)keyboardWillChangeFrame: (NSNotification *)notification {
    //键盘最终的尺寸
    CGRect rect = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    //键盘弹出时间
    CGFloat duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    CGFloat textBottom = [UIScreen mainScreen].bounds.size.height - rect.origin.y;
//    self.bottomConstraint.constant = textBottom;
//    [UIView animateWithDuration:duration animations:^{
//        [self.view layoutIfNeeded];
//    }];
    
    [UIView animateWithDuration:duration animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(0, -textBottom);
    }];
    
}

#pragma mark - 生命周期
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}
//
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [self.tableView setContentOffset:CGPointMake(0, self.tableView.contentSize.height - self.tableView.bounds.size.height) animated:NO];
    
    ZLog(@"contentsize: %f, boundsheight: %f, frameheight: %f", self.tableView.contentSize.height, self.tableView.bounds.size.height, self.tableView.frame.size.height);
}

#pragma mark - TABLEVIEW DATASOURCE AND DELEGATE
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.messages.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OpChatViewCell *cell = (OpChatViewCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    Message *message = self.messages[indexPath.row];

    cell.message = message;
    
    return cell;
    
}

//尽量不要调用这个方法
//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 200;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    Message *message = self.messages[indexPath.row];

    return message.cellHeight;
}

//拖动 scrollView 退出键盘
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.textField endEditing:YES];
}

#pragma mark - TextField 代理
- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSString *text = textField.text;
    NSDictionary *dict = @{@"type": @0,
                           @"time": @"21:34",
                           @"text": text};
    Message *message = [Message messageWithDict:dict];
    [self.messages addObject:message];
    
    [self.tableView reloadData];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.messages.count - 1 inSection:0];
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:NO];
    
    [self.textField endEditing:YES];
    
    return true;
}

#pragma mark - View Dealloc
- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end


//TODO: 尝试在界面进入后就滚动到最后
//    self.group = dispatch_group_create();
//    self.queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    dispatch_group_enter(self.group);
//    dispatch_group_async(self.group, self.queue, ^{
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            self.tableView.hidden = false;
//
//            [self.tableView reloadData];
//
//        });
//        dispatch_group_leave(self.group);
//    });
//
//    dispatch_group_notify(group, queue, ^{
//        dispatch_async(dispatch_get_main_queue(), ^{
//            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.messages.count - 1 inSection:0];
//            [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:false];
//        });
//    });
