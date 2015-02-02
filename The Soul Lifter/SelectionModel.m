//
//  SelectionModel.m
//  The Soul Lifter
//
//  Created by Matthew Wagner on 1/15/15.
//  Copyright (c) 2015 Planet Soul. All rights reserved.
//

#import "SelectionModel.h"

@implementation SelectionModel

-(id)initForType:(NSString*)type {
    self = [super init];
    if( self ){
        [self getSavedCardData];
    }
    return self;
}

-(void)filterCardsByType:(NSString*)type {
    NSLog(@"Getting Data for Type: %@", type);
    // Retrieve File List
    
    NSMutableArray *allCards = [[NSMutableArray alloc] init];
    for (Card *card in self.data) {
        if([type isEqualToString:@"favorites"]){
            if(card.favorite){
                [allCards addObject:card];
                self.filtered = allCards;
            }
        }
    }
}

-(void)setCardDefaults {
    Card *cardOne = [[Card alloc] initWithName:@"Card One"];
    cardOne.staticCard = @"cardOneFullCard.png";
    cardOne.animatedCard = @"cardOneFullCard.png";
    NSData *dataOne = [NSKeyedArchiver archivedDataWithRootObject:cardOne];
    [self.defaultData addObject:dataOne];
    [self.data addObject:cardOne];

    Card *cardTwo = [[Card alloc] initWithName:@"Card Two"];
    cardTwo.staticCard = @"cardTwoFullCard.png";
    cardTwo.animatedCard = @"cardTwoFullCard.png";
    NSData *dataTwo = [NSKeyedArchiver archivedDataWithRootObject:cardTwo];
    [self.defaultData addObject:dataTwo];
    [self.data addObject:cardTwo];
    
    Card *cardThree = [[Card alloc] initWithName:@"Card Three"];
    cardThree.staticCard = @"cardThreeFullCard.png";
    cardThree.animatedCard = @"cardThreeFullCard.png";
    NSData *dataThree = [NSKeyedArchiver archivedDataWithRootObject:cardThree];
    [self.defaultData addObject:dataThree];
    [self.data addObject:cardThree];
    
    [self.delegate sendCardsToView];
    [self saveCardData];
}

-(void)saveCardData {
    [NSUserDefaults resetStandardUserDefaults];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *cardData = [NSKeyedArchiver archivedDataWithRootObject:self.defaultData];
    [defaults setObject:cardData forKey:@"cards"];
    [defaults synchronize];
}

-(void)getSavedCardData {
//    NSMutableArray *allCards = [[NSMutableArray alloc] init];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"cards"];
    if([defaults objectForKey:@"cards"]){
        NSData *encodedObject = [defaults objectForKey:@"cards"];
        self.defaultData = [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
    } else {
        self.data = [[NSMutableArray alloc] init];
        self.defaultData = [[NSMutableArray alloc] init];
        [self setCardDefaults];
    }
    
    [self.delegate sendCardsToView];
}

@end
