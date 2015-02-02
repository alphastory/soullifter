//
//  ContactView.h
//  The Soul Lifter
//
//  Created by Matthew Wagner on 1/11/15.
//  Copyright (c) 2015 Planet Soul. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ContactViewDelegate <NSObject>
-(void)returnToHome;
-(void)sendContactForm;
@end

@interface ContactView : UIView <UITextFieldDelegate, UITextViewDelegate> {
    UIColor *surfBlue;
}

@property (assign, nonatomic) id <ContactViewDelegate> delegate;
@property (strong, nonatomic) UITextField *nameField;
@property (strong, nonatomic) UITextField *emailField;
@property (strong, nonatomic) UITextView *messageField;

@end
