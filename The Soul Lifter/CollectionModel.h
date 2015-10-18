//
//  CollectionModel.h
//  The Soul Lifter
//
//  Created by Kyle Sebestyen on 9/28/15.
//  Copyright © 2015 Planet Soul. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface CollectionModel : Card
{
    NSMutableArray*cards;
}

@property(nonatomic, assign)NSString*collectionName;

-(void)addCard:(Card*)card;
-(void)addCards:(NSArray*)_cards;
-(Card*)cardAtIndex:(int)index;
-(int)count;

@end
