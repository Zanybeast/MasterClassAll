//
//  ChatVC.m
//  MasterClassAll
//
//  Created by carl on 2020/11/6.
//

#import "ChatVC.h"
#import "Message.h"
#import "ChatViewCell.h"

@interface ChatVC () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSMutableArray* messages;

@end

@implementation ChatVC

- (NSMutableArray *)messages {
    if (_messages == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"messages" ofType:@"plist"];
        NSArray *dictArray = [NSArray arrayWithContentsOfFile:path];
        
        NSMutableArray *messagesArray = [NSMutableArray array];
        Message *lastMessage = nil;
        for (NSDictionary *dict in dictArray) {
            Message *message = [Message messageWithDict:dict];
            if (lastMessage == nil) {
                message.timeHidden = false;
            } else {
                message.timeHidden = [message.time isEqualToString:lastMessage.time];
            }
            [messagesArray addObject:message];
            lastMessage = message;
        }
        
        _messages = messagesArray;
    }
    return _messages;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ChatViewCell" bundle:nil] forCellReuseIdentifier:@"ChatViewCell"];
}

#pragma mark - TABLEVIEW DATASOURCE AND DELEGATE
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.messages.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ChatViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChatViewCell" forIndexPath:indexPath];
    
    Message *message = self.messages[indexPath.row];
    
    cell.message = message;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    Message *message = self.messages[indexPath.row];
    
    return message.cellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 200;
}

@end
