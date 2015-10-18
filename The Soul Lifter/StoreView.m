//
//  StoreView.m
//  The Soul Lifter
//
//  Created by Matthew Wagner on 1/25/15.
//  Copyright (c) 2015 Planet Soul. All rights reserved.
//

#import "StoreView.h"
#import "BackArrowView.h"
#import "CollectionModel.h"

@implementation StoreView

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor whiteColor];
        surfBlue = [UIColor colorWithRed:99.0f/255.0f green:209.0f/255.0f blue:244.0f/255.0f alpha:1.0f];
        whiteOpaque = [UIColor colorWithWhite:1.0f alpha:0.5f];
        montserrat = [UIFont fontWithName:@"Montserrat-Bold" size:14.0f];

    }
    return self;
}

#pragma mark Interface

-(void)buildView {
    
    // Build the View
    CGFloat height = self.frame.size.height;
    CGFloat width = self.frame.size.width;
    
    // Add Title Bar
    UILabel *selectionTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, height * .1)];
    [selectionTitle setTextColor:[UIColor whiteColor]];
    [selectionTitle setBackgroundColor:surfBlue];
    [selectionTitle setText:@"Store"];
    [selectionTitle setTextAlignment:NSTextAlignmentCenter];
    [selectionTitle setFont:montserrat];
    [self addSubview:selectionTitle];
    
    // Add Scroll View
    self.cardsView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, selectionTitle.frame.size.height + 1, width, (height * .5) - 2)];
    self.cardsView.contentSize = CGSizeMake(((self.cardsView.frame.size.width - 80) * [self.activeCollection count]) + 80, self.cardsView.frame.size.height);
    self.cardsView.pagingEnabled = NO;
    self.cardsView.scrollEnabled = NO;
    [self addSubview:self.cardsView];
    
    // Add Progress Indicator
    [self addActivityIndicator];
    
    // Add the Page Control Indicators
    self.cardsCount = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.cardsView.frame.origin.y + self.cardsView.frame.size.height - 40, width, 40)];
    self.cardsCount.numberOfPages = [self.activeCollection count];
    self.cardsCount.backgroundColor = [UIColor clearColor];
    self.cardsCount.pageIndicatorTintColor = whiteOpaque;
    self.cardsCount.currentPageIndicatorTintColor = [UIColor whiteColor];
    self.cardsCount.layer.shadowRadius = 3;
    self.cardsCount.layer.shadowOpacity = 0.5;
    self.cardsCount.layer.shadowColor = [UIColor blackColor].CGColor;
    self.cardsCount.currentPage = 0;
    self.cardsView.backgroundColor = surfBlue;
    [self addSubview:self.cardsCount];
    
    // Send as Text Button
    buyCard = [[UIButton alloc] initWithFrame:CGRectMake(0, height - (height * .4), width, (height * .1) - 1)];
    [buyCard setTitle:@"Buy Card" forState:UIControlStateNormal];
    [buyCard setBackgroundColor:surfBlue];
    [buyCard setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [[buyCard titleLabel] setFont:montserrat];
    [self addSubview:buyCard];
    
    // Add the Send as Text Action
//    [buyCard addTarget:self action:@selector(restorePurchesesButtonDidPress:) forControlEvents:UIControlEventTouchUpInside];
    [buyCard addTarget:self action:@selector(buyCurrentCard) forControlEvents:UIControlEventTouchUpInside];
    
    // Send as Email Button
    buyCollectionButton = [[UIButton alloc] initWithFrame:CGRectMake(0, height - (height * .3), width, (height * .1) - 1)];
    [buyCollectionButton setTitle:@"Buy Collection" forState:UIControlStateNormal];
    [buyCollectionButton setBackgroundColor:surfBlue];
    [buyCollectionButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [[buyCollectionButton titleLabel] setFont:montserrat];
    [self addSubview:buyCollectionButton];
    
    UIButton *restorIAPButton = [[UIButton alloc] initWithFrame:CGRectMake(0, height - (height * .1), width, (height * .1) - 1)];
    [restorIAPButton setTitle:@"Restore In-App Purchases" forState:UIControlStateNormal];
    [restorIAPButton setBackgroundColor:surfBlue];
    [restorIAPButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [[restorIAPButton titleLabel] setFont:montserrat];
    [self addSubview:restorIAPButton];
    [restorIAPButton addTarget:self action:@selector(restorePurchasesButtonDidPress:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [buyCollectionButton addTarget:self action:@selector(buyCurrentCollection) forControlEvents:UIControlEventTouchUpInside];
    
    BackArrowView *backArrow = [[BackArrowView alloc]initWithFrame:CGRectMake(13, (height * .05)-7, 7, 15)];
    backArrow.backgroundColor = surfBlue;
    [self addSubview:backArrow];
    
    
    // Add the Go Back Button
    UIButton *goBackButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 150, height * .1)];
    [goBackButton setTitle:@"Go Back" forState:UIControlStateNormal];
    [goBackButton setBackgroundColor:[UIColor clearColor]];
    goBackButton.titleLabel.textAlignment = NSTextAlignmentLeft;
    goBackButton.titleEdgeInsets = UIEdgeInsetsMake(10, 25, 10, 10);
    goBackButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [goBackButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [[goBackButton titleLabel] setFont:montserrat];
    [self addSubview:goBackButton];
    
    
    UIButton *viewAllCollectionsButton = [[UIButton alloc] initWithFrame:CGRectMake(0, height - (height * .2), width, (height * .1) - 1)];
    [viewAllCollectionsButton setTitle:@"View all collections" forState:UIControlStateNormal];
    [viewAllCollectionsButton setBackgroundColor:surfBlue];
    [viewAllCollectionsButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [[viewAllCollectionsButton titleLabel] setFont:montserrat];
    [self addSubview:viewAllCollectionsButton];
    [viewAllCollectionsButton addTarget:self action:@selector(viewAllCollectionsButtonDidPress:) forControlEvents:UIControlEventTouchUpInside];
    
    // Add the Go Back Action
    [goBackButton addTarget:self action:@selector(goBackClicked) forControlEvents:UIControlEventTouchUpInside];
    
//    [self.delegate getProducts];
}

-(void)viewAllCollectionsButtonDidPress:(UIButton*)sender
{
    [self.delegate viewAllCollections:[storeDataSource getCollections]];
}

-(void)resetView
{
    int count = (int)self.cardsView.subviews.count-1;
    for(int i = count; i >= 0; i--)
    {
        [self.cardsView.subviews[0] removeFromSuperview];
    }
    
    count = (int)self.cardsView.gestureRecognizers.count-1;
    for(int i = count; i >= 0; i--)
    {
        [self.cardsView removeGestureRecognizer:self.cardsView.gestureRecognizers[0]];
    }
}

-(void)showCardsForCollection:(CollectionModel*)collection
{
    if(collection == self.activeCollection)
    {
        return;
    }
    
    [self resetView];
    self.activeCollection = collection;
    [buyCollectionButton setTitle:[NSString stringWithFormat:@"Buy %@ Collection - $%@", collection.collectionName, collection.price] forState:UIControlStateNormal];
    
    NSLog(@"this collection has %i cards in it.",[collection count]);
    
    self.cardsView.contentSize = CGSizeMake(((self.cardsView.frame.size.width - 80) * [collection count]) + 80, self.cardsView.frame.size.height);
    if([collection count] > 0){
        
        CGRect frame;
        for( int i = 0; i < [collection count]; i++){
            if([collection cardAtIndex:i]){
                Card *card = [collection cardAtIndex:i];

                self.activeCard = card;
                
                // Make the view to put the card in.
                frame.origin.x = ((self.cardsView.frame.size.width - 40) * i) + 20;
                frame.origin.y = 0;
                frame.size.width = self.cardsView.frame.size.width - 40;
                frame.size.height = self.cardsView.frame.size.height;
                
                UIView *subview = [[UIView alloc] initWithFrame:frame];
                subview.frame = CGRectInset(subview.frame, -2.0f, -2.0f);
                subview.layer.borderColor = [UIColor whiteColor].CGColor;
                subview.layer.borderWidth = 1.0f;
                subview.backgroundColor = surfBlue;
                [self.cardsView addSubview:subview];
                
                // Set the price
                [buyCard setTitle:[NSString stringWithFormat:@"Buy Card - $%@", card.price] forState:UIControlStateNormal];
                
                // Get the current card.
                NSURL *imageURL = [NSURL URLWithString:card.preview];
                
                NSData *imageData = [[NSData alloc] initWithContentsOfURL:imageURL];
                UIImage *currentCard = [UIImage imageWithData:imageData];
                
                //                UIImage *currentCard = [UIImage imageNamed:card.staticCard];
                UIImageView *currentCardView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, subview.frame.size.width - 20, subview.frame.size.height - 20)];
                currentCardView.contentMode = UIViewContentModeScaleAspectFill;
                currentCardView.clipsToBounds = YES;
                currentCardView.image = currentCard;
                [subview addSubview:currentCardView];
            }
        }
        self.cardsCount.numberOfPages = [collection count];
    }
    
    // add SwipeGestureRecognizer to your ScrollView:
    UISwipeGestureRecognizer *swipeForward = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipeScreen:)];
    swipeForward.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.cardsView addGestureRecognizer:swipeForward];
    
    UISwipeGestureRecognizer *swipeBackward = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipeScreen:)];
    swipeBackward.direction = UISwipeGestureRecognizerDirectionRight;
    [self.cardsView addGestureRecognizer:swipeBackward];
    
    // Show the Preview Gesture
    if( [collection count] > 0 ){
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(playCardPreview)];
        singleTap.numberOfTapsRequired = 1;
        [self.cardsView addGestureRecognizer:singleTap];
    }
    
    if( [collection count] > 0 ){
        self.activeCard = [collection cardAtIndex:0];
    } else {
        UILabel *noCards = [[UILabel alloc] initWithFrame:CGRectMake(0, (self.cardsView.frame.size.height / 2) - 25, self.cardsView.frame.size.width, 50)];
        noCards.text = @"No cards available for purchase.";
        noCards.font = montserrat;
        noCards.textColor = [UIColor grayColor];
        noCards.textAlignment = NSTextAlignmentCenter;
        [self.cardsView addSubview:noCards];
    }
    [self removeActivityIndicator];
    
}

-(void)restorePurchasesButtonDidPress:(UIButton*)sender
{
    [self.delegate restorePurchases];
}

-(void)buyCurrentCard {
    [self buyIdentifier:self.activeCard.identifier isCollection:false];
}

-(void)buyCurrentCollection {
    [self buyIdentifier:self.activeCollection.identifier isCollection:true];
}

-(void)buyIdentifier:(NSString*)identifier isCollection:(BOOL)isCollection
{
    if(!purchasingSpinner){
        purchasingSpinner = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        
        UIButton *targetView = isCollection ? buyCollectionButton : buyCard;

        purchasingSpinner.center = CGPointMake(targetView.frame.origin.x + targetView.frame.size.width - (purchasingSpinner.bounds.size.width + 15), targetView.center.y);
        [self addSubview:purchasingSpinner];
    }
    
    [purchasingSpinner startAnimating];
    
    //    purchasingView = (PurchasingView*)[[NSBundle mainBundle]loadNibNamed:@"PurchasingView" owner:nil options:nil][0];
    //    purchasingView.delegate = self;
    
    //    [self addSubview:purchasingView];
    //    purchasingView.center = self.center;
    
    //    [purchasingView beginPurchasing];
    
    
    [self.delegate purchaseCardWithIdentifier:identifier];// self.activeCard[@"identifier"]];
}

-(void)addCardsToUIWithData:(StoreDataSource*)_storeDataSource {
    
    storeDataSource = _storeDataSource;
    [self showCardsForCollection:[self getCollectionAtIndex:0]];
}

-(CollectionModel*)getCollectionAtIndex:(int)index
{
    if([storeDataSource getCollections].count > index){
        return [storeDataSource getCollections][index];
    }
    else{
        return nil;
    }
}

-(void)playCardPreview {
    NSLog(@"Playing Preview");
    // Show modal view
    
    if(!overlay){
        overlay = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        overlay.backgroundColor = [UIColor blackColor];
        overlay.alpha = 0.4;
    }
    [self addSubview:overlay];
    
    if(!modal){
        modal = [[UIView alloc] initWithFrame:CGRectMake(20, 20, self.frame.size.width - 40, self.frame.size.height - 40)];
        modal.backgroundColor = [UIColor whiteColor];
        modal.contentMode = UIViewContentModeScaleAspectFit;
    }
    [self addSubview:modal];
    

    if(self.activeCard.isAnimated){
     
        NSString *url = [NSString stringWithFormat:@"%@", self.activeCard.animatedCard];//self.activeCard[@"animatedPreview"]];
        
        [self tearDownMoviePlayer];
        
        isLoadingPreview = YES;
        
        self.videoIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [modal addSubview:self.videoIndicator];
        self.videoIndicator.center = CGPointMake(modal.frame.size.width/2, modal.frame.size.height/2);
        [self.videoIndicator startAnimating];
        
        moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:[NSURL URLWithString:url]];
        
        moviePlayer.view.frame = CGRectMake(0, 0, 480, 320);
        [moviePlayer setControlStyle:MPMovieControlStyleNone];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(moviePlayBackDidFinish:)
                                                     name:MPMoviePlayerPlaybackDidFinishNotification
                                                   object:moviePlayer];

        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(movieNetworkStateDidChange:)
                                                     name:MPMoviePlayerLoadStateDidChangeNotification
                                                   object:moviePlayer];
        
        moviePlayer.shouldAutoplay = YES;
        [moviePlayer play];
        
    }
    else{
        NSString *url = [NSString stringWithFormat:@"%@", self.activeCard.preview];
        NSURL *imageURL = [NSURL URLWithString:url];
        NSData *imageData = [[NSData alloc] initWithContentsOfURL:imageURL];
        UIImage *previewImage = [UIImage imageWithData:imageData];
        CGFloat imageWidth = previewImage.size.width;
        CGFloat imageHeight = previewImage.size.height;
        CGFloat aspect = imageWidth / imageHeight;
        
        if(isnan(aspect))
        {
            aspect = 0;
        }
        
        CGRect newFrame = CGRectMake(20, 40, self.frame.size.width - 40, (self.frame.size.height * aspect) - 50);
        modal.frame = newFrame;
        UIImageView *preview = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, modal.frame.size.width - 20, modal.frame.size.height - 20)];
        preview.contentMode = UIViewContentModeScaleAspectFit;
        preview.image = previewImage;
        [modal addSubview:preview];
    }
    
 
    
    // Add Play icon, if video doesn't.
    
    // Add Close button
    if(!closeBtn){
        closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(modal.frame.size.width, 30, 30, 30)];
        [closeBtn setImage:[UIImage imageNamed:@"closeBtn.png"] forState:UIControlStateNormal];
        closeBtn.imageView.contentScaleFactor = 0.5f;
        closeBtn.titleLabel.textColor = [UIColor blackColor];
        closeBtn.backgroundColor = [UIColor whiteColor];
        [closeBtn addTarget:self action:@selector(closeModalPreview) forControlEvents:UIControlEventTouchUpInside];
    }
    
    [self addSubview:closeBtn];
    
//    UITapGestureRecognizer *closeModal = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeModalPreview)];
//    closeModal.numberOfTapsRequired = 1;
//    [closeBtn addGestureRecognizer:closeModal];
}

-(void) moviePlayBackDidFinish:(NSNotification*)notification {
    //repeat movie
    [moviePlayer play];
}

-(void) movieNetworkStateDidChange:(NSNotification*)notification
{
//    NSLog(@"load state: %lu",(unsigned long)moviePlayer.loadState);
    if(isLoadingPreview){
        if(moviePlayer.loadState == MPMovieLoadStatePlayable)
        {
            isLoadingPreview = NO;
            //the video is loaded, so now we know it's width and height, it's "naturalSize"
            CGRect newFrame = CGRectInset(self.frame, 20, 40);
            
            newFrame.size = [self CGSizeAspectFit:moviePlayer.naturalSize boundingSize:newFrame.size];

            [moviePlayer play];
            modal.frame = CGRectInset(newFrame,-10,-10);
            [modal addSubview:moviePlayer.view];
            moviePlayer.view.frame = CGRectMake(10,10,newFrame.size.width, newFrame.size.height);
        }
        else if(moviePlayer.loadState == MPMovieLoadStateStalled || moviePlayer.loadState == MPMovieLoadStateUnknown)
        {
            isLoadingPreview = NO;
            [self closeModalPreview];
            [self doAlert:@"Could not play the card preview."];
        }
    }
}


-(CGSize) CGSizeAspectFit:(CGSize)aspectRatio boundingSize:(CGSize)boundingSize
{
    CGFloat mW = boundingSize.width / aspectRatio.width;
    CGFloat mH = boundingSize.height / aspectRatio.height;
    
    CGSize output = CGSizeMake(boundingSize.width, boundingSize.height);
    
    if( mH < mW ){
        output.width = boundingSize.height / aspectRatio.height * aspectRatio.width;
    }
    else if( mW < mH )
    {
        output.height = boundingSize.width / aspectRatio.width * aspectRatio.height;
    }
    return output;
}

-(void)tearDownMoviePlayer
{
    if(moviePlayer != nil){
        [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:moviePlayer];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerLoadStateDidChangeNotification object:moviePlayer];
        [moviePlayer stop];
        [moviePlayer.view removeFromSuperview];
        moviePlayer = nil;
        
        [self.videoIndicator stopAnimating];
        [self.videoIndicator removeFromSuperview];
        self.videoIndicator = nil;
    }
}

-(void)doAlert:(NSString*)message
{
    [[[UIAlertView alloc]initWithTitle:@"" message:message delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil]show];
}


-(void)closeModalPreview {
    [self tearDownMoviePlayer];
    
    [modal.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    [modal removeFromSuperview];
    [overlay removeFromSuperview];
    [closeBtn removeFromSuperview];
}

-(void)addActivityIndicator {
    self.indicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake((self.cardsView.frame.size.width / 2) - 25, (self.cardsView.frame.size.height / 2) - 25, 50, 50)];
    [self.indicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
    [self.indicator startAnimating];
    [self.cardsView addSubview:self.indicator];
}

-(void)removeActivityIndicator {
    [self.indicator stopAnimating];
    [self.indicator removeFromSuperview];
}
#pragma mark Gesture Selectors

// handle the swipes here
- (void)didSwipeScreen:(UISwipeGestureRecognizer *)gesture {
    switch (gesture.direction) {
        case UISwipeGestureRecognizerDirectionLeft:
            [self scrollForwardOneCard];
            break;
        case UISwipeGestureRecognizerDirectionRight:
            [self scrollBackOneCard];
            break;
        default:
            break;
    }
}

- (void)scrollBackOneCard {
    if( self.cardsCount.currentPage - 1 >= 0){
        int page = (int)(self.cardsCount.currentPage - 1);
        self.activeCard = [self.activeCollection cardAtIndex:page];
        CGPoint destination = CGPointMake((self.cardsView.frame.size.width - 40) * page, 0);
        [self.cardsView setContentOffset:destination animated:YES];
        self.cardsCount.currentPage = page;
        [buyCard setTitle:[NSString stringWithFormat:@"Buy Card - $%@", self.activeCard.price] forState:UIControlStateNormal];
    }
}

- (void)scrollForwardOneCard {
    if( self.cardsCount.currentPage + 1 < self.cardsCount.numberOfPages){
        int page = (int)(self.cardsCount.currentPage + 1);
        self.activeCard = [self.activeCollection cardAtIndex:page];
        CGPoint destination = CGPointMake((self.cardsView.frame.size.width - 40) * page, 0);
        [self.cardsView setContentOffset:destination animated:YES];
        self.cardsCount.currentPage = page;
        [buyCard setTitle:[NSString stringWithFormat:@"Buy Card - $%@", self.activeCard.price] forState:UIControlStateNormal];
    }
}

#pragma mark pruchaseUIMethods
-(void)alreadyPurchased
{
    [purchasingSpinner stopAnimating];
    [self doAlert:@"This card has already been purchased"];
}

-(void)updatePurchaseStatus:(NSString*)status isDone:(BOOL)isDone withTransaction:(id)transaction
{
//    [purchasingView updatePurchaseState:status];
    
    if(isDone)
    {
        [purchasingSpinner stopAnimating];
        [self transactionEnd:transaction];
    }
}

#pragma mark - PurchasingViewDelegate
//-(void)userDidDismissPurchasingView
//{
//    [self transactionEnd];
//}
//
//-(void)userDidCancelPurchase
//{
//    [self userDidDismissPurchasingView];
//    
//    //TODO: see if we can cancel a transaction
//}

-(void)transactionEnd:(id)transaction
{
    [_delegate purchaseComplete:transaction];
}

#pragma mark Go Back

-(void)goBackClicked {
    [self.delegate returnToHome];
}

@end
