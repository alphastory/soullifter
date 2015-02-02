//
//  HomeView.h
//  The Soul Lifter
//
//  Created by Matthew Wagner on 1/8/15.
//  Copyright (c) 2015 Planet Soul. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HomeViewDelegate <NSObject>
    -(void)loadViewForIdentifier:(NSString *)identifier;
    -(void)showContactView;
    -(void)showAboutView;
    -(void)showSettingsView;
    -(void)showStoreView;
@end

@interface HomeView : UIView {
    CGFloat width;
    CGFloat height;
    UIColor *surfBlue;
}

@property (strong, nonatomic) NSMutableArray *buttons;
@property (assign, nonatomic) id <HomeViewDelegate> delegate;

@end
