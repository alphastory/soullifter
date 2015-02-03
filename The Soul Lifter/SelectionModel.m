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
            NSLog(@"%@", card.favorite ? @"YES" : @"NO");
            if(card.favorite){
                [allCards addObject:card];
                self.filtered = allCards;
            }
        }
    } else if([type isEqualToString:@"Recents"]){
        for (Card *card in self.data) {
            // If card.lastUsed is <= Date.now() - Date.30 days ago
            NSString *end = [NSString stringWithFormat:@"%@", card.lastUsed];
            if(!end){
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
        for(Card *card in self.data){
            NSLog(@"%@", card.title);
        }
    }
}

-(void)setCardDefaults {
    NSLog(@"Setting Defaults");
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
    [self saveCardData];
}

-(void)saveCardData {
    NSLog(@"Saving Card Data");
    [NSUserDefaults resetStandardUserDefaults];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.defaultData = nil;
    self.defaultData = [[NSMutableArray alloc] init];
    for (Card *card in self.data) {
        card.favorite = YES;
        NSLog(@"%@", card.favorite ? @"YES" : @"NO");
        NSData *cardData = [NSKeyedArchiver archivedDataWithRootObject:card];
        [self.defaultData addObject:cardData];
    }
    NSData *allCardData = [NSKeyedArchiver archivedDataWithRootObject:self.defaultData];
    [defaults setObject:allCardData forKey:@"cards"];
    [defaults synchronize];
    [defaults synchronize];
}

-(void)getSavedCardData {
    NSLog(@"Get saved Data");
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults removeObjectForKey:@"cards"];
    if([defaults objectForKey:@"cards"]){
        NSData *encodedObject = [defaults objectForKey:@"cards"];
        self.defaultData = [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
        NSMutableArray *temp = [[NSMutableArray alloc] init];
        for (NSData *data in self.defaultData) {
            Card *card = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            [temp addObject:card];
        }
        self.data = temp;
    } else {
        NSLog(@"No Object For Key");
        self.data = [[NSMutableArray alloc] init];
        self.defaultData = [[NSMutableArray alloc] init];
        [self setCardDefaults];
    }
}

@end
