//
//  AboutView.h
//  The Soul Lifter
//
//  Created by Matthew Wagner on 1/11/15.
//  Copyright (c) 2015 Planet Soul. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AboutViewDelegate <NSObject>
-(void)returnToHome;
@end

@interface AboutView : UIView {
    UIColor *surfBlue;
    UIFont *montserrat;
}

@property (assign, nonatomic) id <AboutViewDelegate> delegate;

@end
