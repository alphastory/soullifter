//
//  StoreView.h
//  The Soul Lifter
//
//  Created by Matthew Wagner on 1/25/15.
//  Copyright (c) 2015 Planet Soul. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Card.h"
#import <ContentfulDeliveryAPI/ContentfulDeliveryAPI.h>
#import <MediaPlayer/MediaPlayer.h>
//#import "PurchasingView.h"

@protocol StoreViewDelegate <NSObject>
-(void)returnToHome;
-(void)getProducts;
-(void)restorePurchases;
-(void)purchaseCardWithIdentifier:(NSString*)identifier;
-(void)purchaseComplete:(id)transaction;
-(void)alreadyPurchased;
@end

@interface StoreView : UIView {
    UIColor *surfBlue;
    UIColor *whiteOpaque;
    UIFont *montserrat;
    UIView *overlay;
    UIView *modal;
    UIButton *closeBtn;
    UIButton *buyCard;
    MPMoviePlayerController *moviePlayer;
    BOOL isLoadingPreview;
    
    UIActivityIndicatorView *purchasingSpinner;
    
//    PurchasingView *purchasingView;
}

@property (assign, nonatomic) id <StoreViewDelegate> delegate;
@property (strong, nonatomic) NSString *viewTitle;
@property (strong, nonatomic) UIScrollView *cardsView;
@property (strong, nonatomic) IBOutlet UIPageControl *cardsCount;
@property (strong, nonatomic) UIActivityIndicatorView *indicator;
@property (strong, nonatomic) UIActivityIndicatorView *videoIndicator;
@property (strong, nonatomic) NSMutableArray *allCards;
@property (strong, nonatomic) NSDictionary *activeCard;

-(void)buildView;
-(void)addCardsToUIWithData:(NSMutableArray*)cardsList;
-(void)updatePurchaseStatus:(NSString*)status isDone:(BOOL)isDone withTransaction:(id)transaction;
-(void)alreadyPurchased;
@end
