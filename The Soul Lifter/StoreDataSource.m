//
//  StoreDataSource.m
//  The Soul Lifter
//
//  Created by Kyle Sebestyen on 10/6/15.
//  Copyright © 2015 Planet Soul. All rights reserved.
//

#import "StoreDataSource.h"
#import "Card.h"
#import "CollectionModel.h"

@implementation StoreDataSource

-(id)initWithProducts:(NSArray*)productsDictionaries
{
    self = [super init];
    
    NSMutableArray *flat_collections = [NSMutableArray new];
    
    //Test dictionaries
    NSMutableArray *productsAndTestProductDictionaries = [NSMutableArray new];
    [productsAndTestProductDictionaries addObjectsFromArray:productsDictionaries];
//    [productsAndTestProductDictionaries addObjectsFromArray:[self getTestRecords]];
    
    for(NSDictionary *item in productsAndTestProductDictionaries)
    {
        CollectionModel *c = [[CollectionModel alloc]initWithDictionary:item];
        [flat_collections addObject:c];
    }
    
    NSMutableArray *stacked_collections = [NSMutableArray new];
    
    for(CollectionModel *item in flat_collections)
    {
        if(item.isCollection){
            NSArray *cardsInCollection = [self getCardsInCollection:flat_collections withCollectionName:item.collectionName];
            [item addCards:cardsInCollection];
            [stacked_collections addObject:item];
        }
    }
    
    collections = stacked_collections;
    
    return self;
}


-(NSArray*)getCardsInCollection:(NSArray*)allCards withCollectionName:(NSString*)collectionName
{
    NSMutableArray *linkedCards = [NSMutableArray new];
    for(CollectionModel *c in allCards)
    {
        if([c.collectionName isEqualToString:collectionName] && !c.isCollection)
        {
            [linkedCards addObject:c];
        }
    }
    
    return linkedCards;
}

-(NSArray*)getCollections
{
    return collections;
}

-(NSArray*)getTestRecords
{
    NSString*path = [[NSBundle mainBundle]pathForResource:@"testData" ofType:@"json"];
    NSString* jsonString = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSError *jsonError;
    NSArray *jsonDataArray = [[NSArray alloc]init];
    jsonDataArray = [NSJSONSerialization JSONObjectWithData:[jsonString dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&jsonError];
    
    return jsonDataArray;
}

@end
