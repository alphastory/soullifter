//
//  SettingsViewController.h
//  The Soul Lifter
//
//  Created by Matthew Wagner on 1/11/15.
//  Copyright (c) 2015 Planet Soul. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingsView.h"

@interface SettingsViewController : UIViewController <SettingsViewDelegate>

@property (strong, nonatomic) SettingsView *settingsView;

@end
