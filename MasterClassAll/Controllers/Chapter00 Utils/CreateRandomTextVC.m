//
//  CreateRandomTextVC.m
//  MasterClassAll
//
//  Created by carl on 2020/12/24.
//

#import "CreateRandomTextVC.h"

@interface CreateRandomTextVC ()
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation CreateRandomTextVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableString *finalStr = [NSMutableString stringWithString:@""];
    
    int wordNumber = arc4random() % 150 + 120;
    for (int i = wordNumber; i > 0; i--) {
        int wordLength = arc4random() % 20;
        if (i % 9 == 0) {
            [finalStr appendString:@"\n"];
        }
        if (wordLength == 5 ||
            wordLength == 7 ||
            wordLength == 11 ||
            wordLength == 16) {
            continue;
        } else {
            NSString *randomStr = [[NSString alloc] randomStringWithLength:wordLength];
            [finalStr appendString:[NSString stringWithFormat:@"%@ ", randomStr]];
        }
    }
    
    _textView.text = finalStr;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
