//
//  HomeView.m
//  The Soul Lifter
//
//  Created by Matthew Wagner on 1/8/15.
//  Copyright (c) 2015 Planet Soul. All rights reserved.
//

#import "HomeView.h"
#import "SelectionViewController.h"

@implementation HomeView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if( self ){
        
        // Define sizes
        width = self.frame.size.width;
        height = self.frame.size.height;
        surfBlue = [UIColor colorWithRed:99.0f/255.0f green:209.0f/255.0f blue:244.0f/255.0f alpha:1.0f];
        self.backgroundColor = [UIColor whiteColor];
        
        // Add Buttons
        [self addButtons];
        
    }
    return self;
}

- (void)addButtons {
    self.buttons = [[NSMutableArray alloc] init];
    CGFloat buttonWidth  = width / 2;
    CGFloat buttonHeight = ( height * .5 ) / 2;
    
    CGFloat rowOne   = ( height * .0 ) + 0;
    CGFloat rowTwo   = ( height * .25 ) + 2;
    CGFloat rowThree = ( height * .5 ) + 4;
    CGFloat rowFour  = ( height * .85 ) + 6;
    
    CGFloat colOne   = ( width * .0 ) + 0;
    CGFloat colTwo   = ( width * .5 ) + 2;
    
    CGRect topLeft      = CGRectMake(colOne, rowOne, buttonWidth - 1, buttonHeight - 1);
    CGRect topRight     = CGRectMake(colTwo, rowOne, buttonWidth, buttonHeight - 1);
    CGRect lowerLeft    = CGRectMake(colOne, rowTwo, buttonWidth - 1, buttonHeight - 1);
    CGRect lowerRight   = CGRectMake(colTwo, rowTwo, buttonWidth, buttonHeight - 1);
    CGRect fullMid      = CGRectMake(colOne, rowThree, width, (height * .35) - 1);
//    CGRect bottomLeft   = CGRectMake(0, rowFour, (width / 3) - 2, height * .15);
    CGRect bottomLeft   = CGRectMake(0, rowFour, (width / 2) - 1, height * .15);
//    CGRect bottomMid    = CGRectMake(( width * .33 ) + 2, rowFour, ( width / 3 ) - 2, height * .15);
//    CGRect bottomRight  = CGRectMake(( width * .66 ) + 4, rowFour, ( width / 3 ) - 2, height * .15);
    CGRect bottomRight  = CGRectMake(( width * .5 ) + 2, rowFour, ( width / 2 ) - 2, height * .15);
    
    // Create and Add the Recents Button
    [self newButtonAtLocation:topLeft andIdentifier:@"recents"];
    
    // Create and Add the Favorites Button
    [self newButtonAtLocation:topRight andIdentifier:@"favorites"];
    
    // Create and Add the Static Button
    [self newButtonAtLocation:lowerLeft andIdentifier:@"static"];
    
    // Create and Add the Animated Button
    [self newButtonAtLocation:lowerRight andIdentifier:@"animated"];
    
    // Create and Add the Shop Button
    [self newButtonAtLocation:fullMid andIdentifier:@"store"];
    
    // Create and Add the Contact Button
    [self newButtonAtLocation:bottomLeft andIdentifier:@"contact"];
    
    // Create and Add the Settings Button
//    [self newButtonAtLocation:bottomMid andIdentifier:@"settings"];
    
    // Create and Add the About Button
    [self newButtonAtLocation:bottomRight andIdentifier:@"about"];
    
    // Add all of the buttons to the view.
    for(int i = 0; i < [self.buttons count]; i++){
        [self addSubview:[self.buttons objectAtIndex:i]];
        [[self.buttons objectAtIndex:i] addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void) buttonAction:(UIButton *)sender {
    NSString *identifier = sender.titleLabel.text;
    BOOL isRecents      = [identifier isEqualToString:@"recents"];
    BOOL isFavorites    = [identifier isEqualToString:@"favorites"];
    BOOL isStatics      = [identifier isEqualToString:@"static"];
    BOOL isAnimateds    = [identifier isEqualToString:@"animated"];
    BOOL isStore        = [identifier isEqualToString:@"store"];
    BOOL isContact      = [identifier isEqualToString:@"contact"];
    BOOL isSettings     = [identifier isEqualToString:@"settings"];
    BOOL isAbout        = [identifier isEqualToString:@"about"];
    
    if( isRecents || isFavorites || isStatics || isAnimateds ){
        [self.delegate loadViewForIdentifier:identifier];
    } else if( isStore ){
        [self.delegate showStoreView];
    } else if( isContact ){
        [self.delegate showContactView];
    } else if( isSettings ){
        [self.delegate showSettingsView];
    } else if( isAbout ){
        [self.delegate showAboutView];
    }
}

- (void) newButtonAtLocation:(CGRect)location andIdentifier:(NSString *)title {
    UIImage *icon = [UIImage imageNamed:title];
    UIImage *active = [UIImage imageNamed:[NSString stringWithFormat:@"%@_active", title]];
    UIButton *button = [[UIButton alloc] initWithFrame:location];
    [button setBackgroundColor:surfBlue];
    [button setImage:icon forState:UIControlStateNormal];
    [button setImage:active forState:UIControlStateHighlighted];
    button.titleLabel.text = title;
    button.titleLabel.hidden = YES;
    button.frame = CGRectInset(button.frame, -1.0f, -1.0f);
    [self.buttons addObject:button];
}

@end
