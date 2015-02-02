//
//  SettingsVIew.h
//  The Soul Lifter
//
//  Created by Matthew Wagner on 1/11/15.
//  Copyright (c) 2015 Planet Soul. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SettingsViewDelegate <NSObject>
-(void)returnToHome;
@end

@interface SettingsView : UIView

@property (assign, nonatomic) id <SettingsViewDelegate> delegate;

@end
