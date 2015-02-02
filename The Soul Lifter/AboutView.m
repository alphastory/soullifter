//
//  AboutView.m
//  The Soul Lifter
//
//  Created by Matthew Wagner on 1/11/15.
//  Copyright (c) 2015 Planet Soul. All rights reserved.
//

#import "AboutView.h"

@implementation AboutView

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self){
        surfBlue = [UIColor colorWithRed:99.0f/255.0f green:209.0f/255.0f blue:244.0f/255.0f alpha:1.0f];
        self.backgroundColor = surfBlue;
        montserrat = [UIFont fontWithName:@"Montserrat-Regular" size:14.0f];
        [self buildView];
    }
    return self;
}

-(void)buildView {
    UITextView *bioLabel = [[UITextView alloc] initWithFrame:CGRectMake(20, 20, self.frame.size.width - 40, self.frame.size.height - 120)];
    NSString *bioTextOne = @"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi a erat fermentum, scelerisque neque sit amet, blandit purus. Morbi convallis consectetur ligula, sit amet posuere felis. Vestibulum feugiat lobortis nisi nec finibus. Curabitur id mollis magna, vel ultrices ante. Nulla finibus arcu id volutpat vestibulum. In malesuada faucibus eros ac iaculis. Aliquam pellentesque odio nec leo iaculis, id blandit turpis eleifend. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Aenean libero nisi, facilisis ac condimentum vel, suscipit ullamcorper tellus. Ut sit amet viverra lacus, vel pulvinar velit. Proin faucibus tempor mollis. Aliquam vel quam in metus congue lobortis.";
    NSString *bioTextTwo = @"Fusce dignissim elit neque, vitae hendrerit nisi ornare sed. Maecenas efficitur, risus at efficitur dignissim, nulla urna venenatis elit, id vulputate nunc lacus vel ligula. Vestibulum dictum hendrerit laoreet. Vestibulum quis mattis massa. Nam imperdiet iaculis mauris ut cursus. Donec ac tempus mi. Pellentesque molestie turpis urna, at mattis mauris porta a. Cras elementum ut dui vel pellentesque. Etiam quis volutpat felis, quis suscipit ligula. Etiam vestibulum porta risus nec ultrices. In justo augue, porttitor quis auctor eu, consequat eget turpis.";
    bioLabel.editable = NO;
    bioLabel.backgroundColor = surfBlue;
    bioLabel.font = montserrat;
    bioLabel.text = [NSString stringWithFormat:@"%@\r\n\r\n%@", bioTextOne, bioTextTwo];
    bioLabel.textColor = [UIColor whiteColor];
    [self addSubview:bioLabel];
    
    UIButton *closeButton = [[UIButton alloc] initWithFrame:CGRectMake(22, self.frame.size.height - 60, self.frame.size.width - 44, 40)];
    closeButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    closeButton.titleLabel.textColor = [UIColor whiteColor];
    [closeButton setTitle:@"Go Back" forState:UIControlStateNormal];
    [closeButton addTarget:self.delegate action:@selector(returnToHome) forControlEvents:UIControlEventTouchUpInside];
    closeButton.frame = CGRectInset(closeButton.frame, -2.0f, -2.0f);
    closeButton.layer.borderColor = [UIColor whiteColor].CGColor;
    closeButton.layer.borderWidth = 1.0f;
    
    [self addSubview:closeButton];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
