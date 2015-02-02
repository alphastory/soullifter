//
//  AboutViewController.h
//  The Soul Lifter
//
//  Created by Matthew Wagner on 1/11/15.
//  Copyright (c) 2015 Planet Soul. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AboutView.h"

@interface AboutViewController : UIViewController <AboutViewDelegate>

@property (strong, nonatomic) AboutView *aboutView;

@end
