//
//  SelectionView.h
//  The Soul Lifter
//
//  Created by Matthew Wagner on 1/8/15.
//  Copyright (c) 2015 Planet Soul. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MFMessageComposeViewController.h>
#import <MessageUI/MFMailComposeViewController.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "Card.h"

@protocol SelectionViewDelegate <NSObject>
    -(void)returnToHome;
    -(void)getCardsOfType:(NSString*)type;
    -(void)showMessageViewController:(MFMessageComposeViewController*)viewController;
    -(void)showMailViewController:(MFMailComposeViewController*)viewController;
    -(void)updateCardData;
//    -(void)setData;
@end

@interface SelectionView : UIView {
    UIColor *surfBlue;
    UIColor *whiteOpaque;
    UIFont *montserrat;
}

@property (strong, nonatomic) NSString *viewTitle;
@property (strong, nonatomic) UIScrollView *cardsView;
@property (strong, nonatomic) IBOutlet UIPageControl *cardsCount;
@property (strong, nonatomic) UIActivityIndicatorView *indicator;
@property (strong, nonatomic) NSMutableArray *allCards;
@property (strong, nonatomic) Card *activeCard;
@property (assign, nonatomic) id <SelectionViewDelegate> delegate;

-(id)initWithFrame:(CGRect)frame;
-(void)buildView;
-(void)addCardsToUIWithData:(NSMutableArray*)cardsList;

@end
