//
//  SelectionView.m
//  The Soul Lifter
//
//  Created by Matthew Wagner on 1/8/15.
//  Copyright (c) 2015 Planet Soul. All rights reserved.
//

#import "SelectionView.h"
#import "Card.h"

@implementation SelectionView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if( self ){
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
    [selectionTitle setText:self.viewTitle];
    [selectionTitle setTextAlignment:NSTextAlignmentCenter];
    [selectionTitle setFont:montserrat];
    [self addSubview:selectionTitle];
    
    // Add Scroll View
    self.cardsView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, selectionTitle.frame.size.height + 1, width, (height * .5) - 2)];
    self.cardsView.contentSize = CGSizeMake(((self.cardsView.frame.size.width - 80) * [self.allCards count]) + 80, self.cardsView.frame.size.height);
    self.cardsView.pagingEnabled = NO;
    self.cardsView.scrollEnabled = NO;
    [self addSubview:self.cardsView];
    
    // Add Progress Indicator
    [self addActivityIndicator];
    
    // Add the Page Control Indicators
    self.cardsCount = [[UIPageControl alloc] initWithFrame:CGRectMake(0, height - (height * .4), width, (height * .1) -1)];
    self.cardsCount.numberOfPages = [self.allCards count];
    self.cardsCount.backgroundColor = surfBlue;
    self.cardsCount.pageIndicatorTintColor = whiteOpaque;
    self.cardsCount.currentPageIndicatorTintColor = [UIColor whiteColor];
    self.cardsCount.currentPage = 0;
    [self addSubview:self.cardsCount];
    
    // Send as Text Button
    UIButton *sendAsText = [[UIButton alloc] initWithFrame:CGRectMake(0, height - (height * .3), width, (height * .1) - 1)];
    [sendAsText setTitle:@"Send as Text" forState:UIControlStateNormal];
    [sendAsText setBackgroundColor:surfBlue];
    [sendAsText setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [[sendAsText titleLabel] setFont:montserrat];
    [self addSubview:sendAsText];
    
    // Add the Send as Text Action
    [sendAsText addTarget:self action:@selector(sendCardAsText) forControlEvents:UIControlEventTouchUpInside];
    
    // Send as Email Button
    UIButton *sendAsEmail = [[UIButton alloc] initWithFrame:CGRectMake(0, height - (height * .2), width, (height * .1) - 1)];
    [sendAsEmail setTitle:@"Send as Email" forState:UIControlStateNormal];
    [sendAsEmail setBackgroundColor:surfBlue];
    [sendAsEmail setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [[sendAsEmail titleLabel] setFont:montserrat];
    [self addSubview:sendAsEmail];
    
    // Add the Send as Email Action
    [sendAsEmail addTarget:self action:@selector(sendCardAsEmail) forControlEvents:UIControlEventTouchUpInside];
    
    // Add the Go Back Button
    UIButton *goBackButton = [[UIButton alloc] initWithFrame:CGRectMake(0, height - (height * .1), width, (height * .1))];
    [goBackButton setTitle:@"Go Back" forState:UIControlStateNormal];
    [goBackButton setBackgroundColor:surfBlue];
    [goBackButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [[goBackButton titleLabel] setFont:montserrat];
    [self addSubview:goBackButton];
    
    // Add the Go Back Action
    [goBackButton addTarget:self action:@selector(goBackClicked) forControlEvents:UIControlEventTouchUpInside];
    
    [self.delegate getCardsOfType:self.viewTitle];
}

-(void)addCardsToUIWithData:(NSMutableArray*)cardsList {
    
    self.allCards = [[NSMutableArray alloc] initWithArray:cardsList];
    self.cardsView.contentSize = CGSizeMake(((self.cardsView.frame.size.width - 80) * [self.allCards count]) + 80, self.cardsView.frame.size.height);
    if([self.allCards count] > 0){
        
        CGRect frame;
        for( int i = 0; i < [self.allCards count]; i++){
            if([self.allCards objectAtIndex:i]){
                Card *card = [self.allCards objectAtIndex:i];
                
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
                
                // Get the current card.
                UIImage *currentCard = [UIImage imageNamed:card.staticCard];
                UIImageView *currentCardView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, frame.size.width - 20, frame.size.height - 20)];
                currentCardView.contentMode = UIViewContentModeScaleAspectFill;
                currentCardView.image = currentCard;
                [subview addSubview:currentCardView];
            }
        }
        self.cardsCount.numberOfPages = [self.allCards count];
    }
    
    // add SwipeGestureRecognizer to your ScrollView:
    UISwipeGestureRecognizer *swipeForward = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipeScreen:)];
    swipeForward.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.cardsView addGestureRecognizer:swipeForward];
    
    UISwipeGestureRecognizer *swipeBackward = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipeScreen:)];
    swipeBackward.direction = UISwipeGestureRecognizerDirectionRight;
    [self.cardsView addGestureRecognizer:swipeBackward];
    
    
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addCardToFavorites)];
    doubleTap.numberOfTapsRequired = 2;
    [self.cardsView addGestureRecognizer:doubleTap];
    
    if([self.viewTitle isEqualToString:@"Animated"]){
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(playCardPreview)];
        singleTap.numberOfTapsRequired = 1;
        [self.cardsView addGestureRecognizer:singleTap];
        [singleTap requireGestureRecognizerToFail:doubleTap];
    }
    
    if( [self.allCards count] > 0 ){
        self.activeCard = [self.allCards objectAtIndex:0];
    } else {
        UILabel *noCards = [[UILabel alloc] initWithFrame:CGRectMake(0, (self.cardsView.frame.size.height / 2) - 25, self.cardsView.frame.size.width, 50)];
        noCards.text = [NSString stringWithFormat:@"No cards marked as %@.", self.viewTitle];
        noCards.font = montserrat;
        noCards.textColor = [UIColor grayColor];
        noCards.textAlignment = NSTextAlignmentCenter;
        [self.cardsView addSubview:noCards];
    }
    [self removeActivityIndicator];
}

-(void)addCardToFavorites {
    NSLog(@"Adding Card To Favorites: %@", self.activeCard.title);
//    self.activeCard.favorite = YES;
    [self.activeCard markAsFavorite];
    
    // Show Heart Icon
    UIImage *heart = [UIImage imageNamed:@"FavoriteHeart.png"];
    UIImageView *favorited = [[UIImageView alloc] initWithFrame:CGRectMake((self.cardsView.frame.size.width / 2) - 26, (self.cardsView.frame.size.height * 0.6), 52, 41)];
    favorited.image = heart;
    [self addSubview:favorited];
    
    [UIView animateWithDuration:1.5 animations:^{
        favorited.alpha = 0;
    } completion:^(BOOL finished) {
        [favorited removeFromSuperview];
    }];
    
    
    [self.delegate updateCardData];
}

-(void)playCardPreview {
    NSLog(@"Playing Preview");
    // Show modal view
    UIView *overlay = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    overlay.backgroundColor = [UIColor blackColor];
    overlay.alpha = 0.4;
    [self addSubview:overlay];
    
    UIView *modal = [[UIView alloc] initWithFrame:CGRectMake(20, 20, self.frame.size.width - 40, self.frame.size.height - 40)];
    modal.backgroundColor = [UIColor whiteColor];
    modal.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:modal];
    

    UIImage *previewImage = [UIImage imageNamed:self.activeCard.animatedCard];
    CGFloat imageWidth = previewImage.size.width;
    CGFloat imageHeight = previewImage.size.height;
    CGFloat aspect = imageWidth / imageHeight;
    CGRect newFrame = CGRectMake(20, 40, self.frame.size.width - 40, (self.frame.size.height * aspect) - 50);
    modal.frame = newFrame;
    UIImageView *preview = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, modal.frame.size.width - 20, modal.frame.size.height - 20)];
    preview.contentMode = UIViewContentModeScaleAspectFit;
    preview.image = previewImage;
    [modal addSubview:preview];
    
    // Add Play icon, if video doesn't.
    
    // Add Close button
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

#pragma mark Send Card

-(void)sendCardAsText {
    NSLog(@"Sending as Text");
    MFMessageComposeViewController *messageVC = [[MFMessageComposeViewController alloc] init];
//    NSLog(@"%hhd", [MFMessageComposeViewController respondsToSelector:@selector(canSendAttachments)]);
    if([MFMessageComposeViewController respondsToSelector:@selector(canSendAttachments)] ){
        if([MFMessageComposeViewController canSendAttachments]){
            NSString *filename = self.activeCard.staticCard;
            NSString* uti = (NSString*)kUTTypeMessage;
            UIImage *image = [UIImage imageNamed:filename];
            NSData* attachment = UIImageJPEGRepresentation(image, 1.0);
            [messageVC addAttachmentData:attachment typeIdentifier:uti filename:filename];
            [self.delegate showMessageViewController:messageVC];
        }
    } else {
        UIAlertView *noAttach = [[UIAlertView alloc] initWithTitle:@"Cannot Send Attachments" message:@"Your version of iOS does not support sending attachments via an application. Please update your iOS version." delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [noAttach show];
    }
}

-(void)sendCardAsEmail {
    MFMailComposeViewController *messageVC = [[MFMailComposeViewController alloc] init];
    if([MFMailComposeViewController canSendMail]){
        NSString *subject = self.activeCard.title;
        NSString *eCard = self.activeCard.staticCard;
        NSString* uti = (NSString*)kUTTypeMessage;
        UIImage *image = [UIImage imageNamed:eCard];
        NSData* attachment = UIImageJPEGRepresentation(image, 1.0);
        [messageVC setSubject:subject];
        [messageVC addAttachmentData:attachment mimeType:uti fileName:eCard];
        [messageVC setMessageBody:@"Test Body" isHTML:YES];
        [self.delegate showMailViewController:messageVC];
    }
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
        NSInteger page = self.cardsCount.currentPage - 1;
        self.activeCard = [self.allCards objectAtIndex:page];
        CGPoint destination = CGPointMake((self.cardsView.frame.size.width - 40) * page, 0);
        [self.cardsView setContentOffset:destination animated:YES];
        self.cardsCount.currentPage = page;
    }
}

- (void)scrollForwardOneCard {
    if( self.cardsCount.currentPage + 1 < self.cardsCount.numberOfPages){
        NSInteger page = self.cardsCount.currentPage + 1;
        self.activeCard = [self.allCards objectAtIndex:page];
        CGPoint destination = CGPointMake((self.cardsView.frame.size.width - 40) * page, 0);
        [self.cardsView setContentOffset:destination animated:YES];
        self.cardsCount.currentPage = page;
    }
}

#pragma mark Go Back

-(void)goBackClicked {
    [self.delegate returnToHome];
}

@end
