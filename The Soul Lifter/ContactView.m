//
//  ContactView.m
//  The Soul Lifter
//
//  Created by Matthew Wagner on 1/11/15.
//  Copyright (c) 2015 Planet Soul. All rights reserved.
//

#import "ContactView.h"

@implementation ContactView

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self){
        surfBlue = [UIColor colorWithRed:99.0f/255.0f green:209.0f/255.0f blue:244.0f/255.0f alpha:1.0f];
        self.backgroundColor = surfBlue;
        [self buildView];
    }
    return self;
}

-(void)buildView {
    // Name
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, self.frame.size.width - 40, 40)];
    nameLabel.text = @"Name";
    nameLabel.textColor = [UIColor whiteColor];
    [self addSubview:nameLabel];
    
    self.nameField = [[UITextField alloc] initWithFrame:CGRectMake(20, 60, self.frame.size.width - 40, 40)];
    self.nameField.backgroundColor = [UIColor whiteColor];
    self.nameField.keyboardType = UIKeyboardTypeAlphabet;
    self.nameField.delegate = self;
    self.nameField.textColor = surfBlue;
    [self.nameField setReturnKeyType:UIReturnKeyDone];
    [self addSubview:self.nameField];
    
    // Email
    UILabel *emailLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 120, self.frame.size.width - 40, 40)];
    emailLabel.text = @"Email";
    emailLabel.textColor = [UIColor whiteColor];
    [self addSubview:emailLabel];
    
    self.emailField = [[UITextField alloc] initWithFrame:CGRectMake(20, 160, self.frame.size.width - 40, 40)];
    self.emailField.backgroundColor = [UIColor whiteColor];
    self.emailField.keyboardType = UIKeyboardTypeEmailAddress;
    self.emailField.textColor = surfBlue;
    self.emailField.delegate = self;
    [self.emailField setReturnKeyType:UIReturnKeyDone];
    [self addSubview:self.emailField];
    
    // Message
    UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 220, self.frame.size.width - 40, 40)];
    messageLabel.text = @"Message";
    messageLabel.textColor = [UIColor whiteColor];
    [self addSubview:messageLabel];
    
    self.messageField = [[UITextView alloc] initWithFrame:CGRectMake(20, 260, self.frame.size.width - 40, 80)];
    self.messageField.keyboardType = UIKeyboardTypeAlphabet;
    self.messageField.backgroundColor = [UIColor whiteColor];
    self.messageField.textColor = surfBlue;
    self.messageField.delegate = self;
    [self.messageField setReturnKeyType:UIReturnKeyDone];
    [self addSubview:self.messageField];
    
    
    // Send
    UIButton *submitButton = [[UIButton alloc] initWithFrame:CGRectMake(22, 360, self.frame.size.width - 44, 40)];
    submitButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    submitButton.titleLabel.textColor = [UIColor whiteColor];
    [submitButton setTitle:@"Send" forState:UIControlStateNormal];
    [submitButton addTarget:self action:@selector(sendForm) forControlEvents:UIControlEventTouchUpInside];
    submitButton.frame = CGRectInset(submitButton.frame, -2.0f, -2.0f);
    submitButton.layer.borderColor = [UIColor whiteColor].CGColor;
    submitButton.layer.borderWidth = 1.0f;
    
    [self addSubview:submitButton];
    
    UIButton *closeButton = [[UIButton alloc] initWithFrame:CGRectMake(22, 420, self.frame.size.width - 44, 40)];
    closeButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    closeButton.titleLabel.textColor = [UIColor whiteColor];
    [closeButton setTitle:@"Go Back" forState:UIControlStateNormal];
    [closeButton addTarget:self.delegate action:@selector(returnToHome) forControlEvents:UIControlEventTouchUpInside];
    closeButton.frame = CGRectInset(closeButton.frame, -2.0f, -2.0f);
    closeButton.layer.borderColor = [UIColor whiteColor].CGColor;
    closeButton.layer.borderWidth = 1.0f;
    
    [self addSubview:closeButton];
    
}

-(void)sendForm {
    NSMutableArray *formErrors;
    // Is Name Field empty?
    if(![self.nameField hasText]){
        NSString *message = @"name";
        [formErrors addObject:message];
    }
    
    // Is Email Field empty?
    if(![self.emailField hasText]) {
        NSString *message = @"email";
        [formErrors addObject:message];
    }
    
    // Is Message Field empty?
    if(![self.messageField hasText]){
        NSString *message = @"message";
        [formErrors addObject:message];
    }
    
    if([formErrors count] == 0){
        [self.delegate sendContactForm];
    }
    
    [self resignFirstResponder];
}

#pragma mark Text Field Delegates

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    [textField becomeFirstResponder];
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    [textField resignFirstResponder];
}

-(void)textViewDidBeginEditing:(UITextView *)textView {
    [textView becomeFirstResponder];
}

-(void)textViewDidEndEditing:(UITextView *)textView {
    [textView resignFirstResponder];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
