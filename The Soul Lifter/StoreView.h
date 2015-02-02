//
//  StoreView.h
//  The Soul Lifter
//
//  Created by Matthew Wagner on 1/25/15.
//  Copyright (c) 2015 Planet Soul. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol StoreViewDelegate <NSObject>
-(void)returnToHome;
@end

@interface StoreView : UIView {
    UIColor *surfBlue;
    UIColor *whiteOpaque;
    UIFont *montserrat;
}

@property (assign, nonatomic) id <StoreViewDelegate> delegate;
@property (strong, nonatomic) NSString *viewTitle;
@property (strong, nonatomic) UIScrollView *cardsView;
@property (strong, nonatomic) IBOutlet UIPageControl *cardsCount;
@property (strong, nonatomic) NSMutableArray *allCards;
@property (strong, nonatomic) NSDictionary *activeCard;

@end
