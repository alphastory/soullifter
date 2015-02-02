//
//  HomeController.h
//  The Soul Lifter
//
//  Created by Matthew Wagner on 1/8/15.
//  Copyright (c) 2015 Planet Soul. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeView.h"
#import "SelectionViewController.h"
#import "ContactViewController.h"
#import "AboutViewController.h"
#import "SettingsViewController.h"
#import "StoreViewController.h"

@interface HomeController : UIViewController <HomeViewDelegate>

@property (strong, nonatomic) UIView *view;
@property (strong, nonatomic) SelectionViewController *selectViewController;
@property (strong, nonatomic) ContactViewController *contactViewController;
@property (strong, nonatomic) AboutViewController *aboutViewController;
@property (strong, nonatomic) SettingsViewController *settingsViewController;
@property (strong, nonatomic) StoreViewController *storeViewController;

-(void)loadViewForIdentifier:(NSString *)identifier;
-(void)showContactView;

@end

