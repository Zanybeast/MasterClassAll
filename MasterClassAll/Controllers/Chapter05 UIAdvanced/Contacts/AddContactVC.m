//
//  AddContactVC.m
//  MasterClassAll
//
//  Created by carl on 2020/11/27.
//

#import "AddContactVC.h"


@interface AddContactVC () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIButton *addButton;

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;

@end

@implementation AddContactVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.addButton.enabled = NO;
    
    [self.nameTextField addTarget:self action:@selector(textDidChanged) forControlEvents:UIControlEventEditingChanged];
    [self.phoneTextField addTarget:self action:@selector(textDidChanged) forControlEvents:UIControlEventEditingChanged];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.nameTextField becomeFirstResponder];
}

- (void)textDidChanged {
    self.addButton.enabled = self.nameTextField.text.length && self.phoneTextField.text.length;
}

- (IBAction)addButtonClicked:(UIButton *)sender {
    Contact *contact = [Contact initWithName:self.nameTextField.text phoneNubmer:self.phoneTextField.text];
    if (self.delegate && [self.delegate respondsToSelector:@selector(addContactVC:whenAddButtonClicked:)]) {
        [self.delegate addContactVC:self whenAddButtonClicked:contact];
    }
    self.getContact(contact);
    
    [self.navigationController popViewControllerAnimated:YES];
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
