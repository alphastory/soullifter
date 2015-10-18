//
//  CollectionModel.m
//  The Soul Lifter
//
//  Created by Kyle Sebestyen on 9/28/15.
//  Copyright © 2015 Planet Soul. All rights reserved.
//

#import "CollectionModel.h"

@implementation CollectionModel


-(id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super initWithDictionary:dictionary];
    
    self.collectionName = dictionary[@"collectionName"];
    
    cards = [NSMutableArray new];
    
    return self;
}

-(void)addCard:(Card*)card
{
    [cards addObject:card];
}

-(void)addCards:(NSArray*)_cards
{
    for(int i = 0; i < _cards.count; i++){
        [self addCard:_cards[i]];
    }
}

-(Card*)cardAtIndex:(int)index
{
    return cards[index];
}

-(int)count
{
    return (int)cards.count;
}

@end
