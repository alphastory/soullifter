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
//        [self getSavedCardData];
    }
    return self;
}

-(void)filterCardsByType:(NSString*)type {
    NSLog(@"Getting Data for Type: %@", type);
    // Retrieve File List
    
    NSMutableArray *allCards = [[NSMutableArray alloc] init];
    if([type isEqualToString:@"Favorites"]){
        for (Card *card in self.data) {
            if(card.favorite){
                [allCards addObject:card];
                self.filtered = allCards;
            }
        }
    } else if([type isEqualToString:@"Recents"]){
        for (Card *card in self.data) {
            if( card.lastUsed ){
                // If card.lastUsed is <= Date.now() - Date.30 days ago
                NSString *end = [NSString stringWithFormat:@"%@", card.lastUsed];
                NSDateFormatter *f = [[NSDateFormatter alloc] init];
                [f setDateFormat:@"yyyy-MM-ddHH:mm:ss ZZZ"];
                NSDate *startDate = [NSDate date];
                NSDate *endDate = [f dateFromString:end];
                
                
                NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
                NSDateComponents *components = [gregorianCalendar components:NSDayCalendarUnit
                                                                    fromDate:startDate
                                                                      toDate:endDate
                                                                     options:0];
                NSLog(@"%ld", (long)components.day);
                if(components.day <= 30){
                    [allCards addObject:card];
                    self.filtered = allCards;
                }
            }
        }
    } else if([type isEqualToString:@"Static"] || [type isEqualToString:@"Animated"]){
        self.filtered = self.data;
    }
}

-(void)setCardDefaults {
    NSLog(@"No Object For Key");
    self.data = [[NSMutableArray alloc] init];
    Card *cardOne = [[Card alloc] initWithName:@"Card One"];
    cardOne.staticCard = @"cardOneFullCard.png";
    cardOne.animatedCard = @"cardOneFullCard.png";
    [self.data addObject:cardOne];

    Card *cardTwo = [[Card alloc] initWithName:@"Card Two"];
    cardTwo.staticCard = @"cardTwoFullCard.png";
    cardTwo.animatedCard = @"cardTwoFullCard.png";
    [self.data addObject:cardTwo];
    
    Card *cardThree = [[Card alloc] initWithName:@"Card Three"];
    cardThree.staticCard = @"cardThreeFullCard.png";
    cardThree.animatedCard = @"cardThreeFullCard.png";
    [self.data addObject:cardThree];
    
    // Check for purchased content
    
    [self saveCardData];
}

-(void)saveCardData {
    [NSUserDefaults resetStandardUserDefaults];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *allCardData = [NSKeyedArchiver archivedDataWithRootObject:self.data];
    [defaults setObject:allCardData forKey:@"cards"];
    [defaults synchronize];
}

-(void)getSavedCardData {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if([defaults objectForKey:@"cards"]){
        self.defaultData = [NSKeyedUnarchiver unarchiveObjectWithData:[defaults objectForKey:@"cards"]];
        if( [self.defaultData count] > 0){
            NSMutableArray *temp = [[NSMutableArray alloc] init];
            for (Card *card in self.defaultData) {
                [temp addObject:card];
            }
            self.data = [[NSMutableArray alloc] initWithArray:temp];
        } else {
            [self setCardDefaults];
        }
    } else {
        [self setCardDefaults];
    }
}

@end
