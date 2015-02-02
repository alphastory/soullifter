//
//  StoreView.m
//  The Soul Lifter
//
//  Created by Matthew Wagner on 1/25/15.
//  Copyright (c) 2015 Planet Soul. All rights reserved.
//

#import "StoreView.h"

@implementation StoreView

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor whiteColor];
        surfBlue = [UIColor colorWithRed:99.0f/255.0f green:209.0f/255.0f blue:244.0f/255.0f alpha:1.0f];
        whiteOpaque = [UIColor colorWithWhite:1.0f alpha:0.5f];
        montserrat = [UIFont fontWithName:@"Montserrat-Bold" size:14.0f];
        // Build NSDictionary of all "Recent Cards"
        NSString *cardOneTitle = @"Card One";
        NSString *cardOneType = @"public.image";
        NSString *cardOneTitleCard = @"cardOneTitleCard.png";
        NSString *cardOneFullCard = @"cardOneFullCard.png";
        NSDictionary *cardOne = [[NSDictionary alloc] initWithObjects:@[cardOneTitle, cardOneType, cardOneTitleCard, cardOneFullCard] forKeys:@[@"Title", @"Type", @"Titlecard", @"Fullcard"]];

        NSString *cardTwoTitle = @"Card Two";
        NSString *cardTwoType = @"public.image";
        NSString *cardTwoTitleCard = @"cardTwoTitleCard.png";
        NSString *cardTwoFullCard = @"cardTwoFullCard.png";
        NSDictionary *cardTwo = [[NSDictionary alloc] initWithObjects:@[cardTwoTitle, cardTwoType, cardTwoTitleCard, cardTwoFullCard] forKeys:@[@"Title", @"Type", @"Titlecard", @"Fullcard"]];

        NSString *cardThreeTitle = @"Card Three";
        NSString *cardThreeType = @"public.image";
        NSString *cardThreeTitleCard = @"cardThreeTitleCard.png";
        NSString *cardThreeFullCard = @"cardThreeFullCard.png";
        NSDictionary *cardThree = [[NSDictionary alloc] initWithObjects:@[cardThreeTitle, cardThreeType, cardThreeTitleCard, cardThreeFullCard] forKeys:@[@"Title", @"Type", @"Titlecard", @"Fullcard"]];

        self.allCards = [[NSMutableArray alloc] initWithObjects:cardOne, cardTwo, cardThree, nil];
//        self.allCards = [[NSMutableArray alloc] init];
        [self buildView];
    }
    return self;
}

-(void)buildView {CGFloat height = self.frame.size.height;
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
    self.cardsView.contentSize = CGSizeMake(((self.cardsView.frame.size.width - 80) * [self.allCards count]) + 80, self.cardsView.frame.size.height);
    self.cardsView.pagingEnabled = NO;
    self.cardsView.scrollEnabled = NO;
    [self addSubview:self.cardsView];
    //    [self addCardsToUI];
    
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
    [sendAsText setTitle:@"Buy this Card - $0.99" forState:UIControlStateNormal];
    [sendAsText setBackgroundColor:surfBlue];
    [sendAsText setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [[sendAsText titleLabel] setFont:montserrat];
    [self addSubview:sendAsText];
    
    // Add the Buy Action
//    [sendAsText addTarget:self action:@selector(sendCardAsText) forControlEvents:UIControlEventTouchUpInside];
    
    // Send as Email Button
    UIButton *sendAsEmail = [[UIButton alloc] initWithFrame:CGRectMake(0, height - (height * .2), width, (height * .1) - 1)];
    [sendAsEmail setTitle:@"Buy this Collection - $4.99" forState:UIControlStateNormal];
    [sendAsEmail setBackgroundColor:surfBlue];
    [sendAsEmail setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [[sendAsEmail titleLabel] setFont:montserrat];
    [self addSubview:sendAsEmail];
    
    // Add the Send as Email Action
//    [sendAsEmail addTarget:self action:@selector(sendCardAsEmail) forControlEvents:UIControlEventTouchUpInside];
    
    // Add the Go Back Button
    UIButton *goBackButton = [[UIButton alloc] initWithFrame:CGRectMake(0, height - (height * .1), width, (height * .1))];
    [goBackButton setTitle:@"Go Back" forState:UIControlStateNormal];
    [goBackButton setBackgroundColor:surfBlue];
    [goBackButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [[goBackButton titleLabel] setFont:montserrat];
    [self addSubview:goBackButton];
    
    // Add the Go Back Action
    [goBackButton addTarget:self action:@selector(goBackClicked) forControlEvents:UIControlEventTouchUpInside];
}

-(void)addCardsToUI {
    //    UIColor *surfBlue = [UIColor colorWithRed:99.0f/255.0f green:209.0f/255.0f blue:244.0f/255.0f alpha:1.0f];
    self.cardsView.contentSize = CGSizeMake(((self.cardsView.frame.size.width - 80) * [self.allCards count]) + 80, self.cardsView.frame.size.height);
    
    NSLog(@"%@", self.allCards);
    
    if([self.allCards count] > 0){
        
        CGRect frame;
        for( int i = 0; i < [self.allCards count]; i++){
            if([self.allCards objectAtIndex:i]){
                NSDictionary *card = [self.allCards objectAtIndex:i];
                //            NSString *cardTitle = [card objectForKey:@"Title"];
                //            UIImage *fullcard = [card objectForKey:@"Fullcard"];
                
                // Make the view to put the card in.
                //            frame.origin.x = (i == 0 ) ? 40 : (self.cardsView.frame.size.width * i) - (40 * i);
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
                NSURL *imagePath = [[NSURL alloc] initWithString:[card objectForKey:@"Titlecard"]];
                NSData *imageData = [[NSData alloc] initWithContentsOfURL:imagePath];
                UIImage *currentCard = [UIImage imageWithData:imageData];
                UIImageView *currentCardView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, frame.size.width - 20, frame.size.height - 20)];
                currentCardView.contentMode = UIViewContentModeScaleAspectFill;
                currentCardView.image = currentCard;
                [subview addSubview:currentCardView];
                
                // If there is an object after this one, show it.
                //            if([self.allCards objectAtIndex:(i + 1)]){
                //                UIImage *nextCard = [[self.allCards objectAtIndex:(i + 1)] objectForKey:@"Titlecard"];
                //                UIImageView *nextCardView = [[UIImageView alloc] initWithFrame:CGRectMake((frame.size.width - 20), 20, frame.size.width - 40, frame.size.height - 40)];
                //                nextCardView.image = nextCard;
                //                [subview addSubview:nextCardView];
                //            }
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
    
    self.activeCard = [self.allCards objectAtIndex:0];
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
    NSLog(@"Scrolling back one card");
    if( self.cardsCount.currentPage - 1 >= 0){
        NSInteger page = self.cardsCount.currentPage - 1;
        self.activeCard = [self.allCards objectAtIndex:page];
        CGPoint destination = CGPointMake((self.cardsView.frame.size.width - 40) * page, 0);
        [self.cardsView setContentOffset:destination animated:YES];
        self.cardsCount.currentPage = page;
    }
}

- (void)scrollForwardOneCard {
    NSLog(@"Scrolling forward one card");
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
    NSLog(@"Go Back");
    [self.delegate returnToHome];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
