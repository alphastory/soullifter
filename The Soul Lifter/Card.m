//
//  Card.m
//  The Soul Lifter
//
//  Created by Matthew Wagner on 1/8/15.
//  Copyright (c) 2015 Planet Soul. All rights reserved.
//

#import "Card.h"
#import <ContentfulDeliveryAPI/ContentfulDeliveryAPI.h>
#import "NSFileManager+Paths.h"
#define API_DEFAULT @"http://soullifter.co"

@implementation Card

- (id)initWithName:(NSString *)name {
    self = [super init];
    if( self ){
        self.title = name;
    }
    return self;
}

-(void)markAsFavorite {
    self.favorite = YES;
}

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if((self = [super init])) {
        //decode properties, other class vars
        self.isAnimated = dictionaryBoolValue(dictionary[@"animated"]);
        self.identifier = dictionary[@"identifier"];
        self.type = dictionary[@"type"];
        self.title = dictionary[@"title"];
        self.staticCard = dictionary[@"static"];
        self.price = dictionary[@"price"];
        
        
        id previewObject = dictionary[@"preview"];
        if([previewObject isKindOfClass:[CDAAsset class]])
        {
            self.preview = ((CDAAsset*)dictionary[@"preview"]).URL.absoluteString;
        }
        else if([previewObject isKindOfClass:[NSString class]]){
            //this is used for testing data from local json.
            self.preview = dictionary[@"preview"];
        }
        
        
        self.isCollection = dictionaryBoolValue(dictionary[@"isCollection"]);
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)decoder {
    if((self = [super init])) {
        //decode properties, other class vars
        self.identifier = [decoder decodeObjectForKey:@"identifier"];
        self.type = [decoder decodeObjectForKey:@"type"];
        self.title = [decoder decodeObjectForKey:@"title"];
        self.staticCard = [decoder decodeObjectForKey:@"static"];
        self.animatedCard = [decoder decodeObjectForKey:@"animated"];
        
        
//        NSLog(@"%@", self.animatedCard);
        self.lastUsed = [decoder decodeObjectForKey:@"lastUsed"];
        self.favorite = [decoder decodeBoolForKey:@"favorite"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    //Encode properties, other class variables, etc
    [encoder encodeObject:self.identifier forKey:@"identifier"];
    [encoder encodeObject:self.type forKey:@"type"];
    [encoder encodeObject:self.title forKey:@"title"];
    [encoder encodeObject:self.staticCard forKey:@"static"];
    [encoder encodeObject:self.animatedCard forKey:@"animated"];
    [encoder encodeObject:self.lastUsed forKey:@"lastUsed"];
    [encoder encodeBool:self.favorite forKey:@"favorite"];
}


//Use this method to retrieve purchased files.
-(NSURL*)getURLForPurchasedIdentifier
{
    NSString *contentVersion = [[NSUserDefaults standardUserDefaults] stringForKey:self.identifier];
    
    if(contentVersion != nil)
    {
        //TODO, MATT you'll need to build in a switch to determine if this is an animated or Static card type
        NSString *assetName = [self.animatedCard lastPathComponent];
        
        NSString *filePath = [NSString stringWithFormat:@"%@/Content/%@", [Card getStatingPathForDownload:self.identifier], assetName];
        return [NSURL fileURLWithPath:filePath];
    }
    return nil;
}

+(NSURL*)getStagingURLForDownload:(NSString*)productIdentifier
{
    return [NSURL fileURLWithPath:[Card getStatingPathForDownload:productIdentifier]];
}

+(NSString*)getStatingPathForDownload:(NSString*)productIdentifier
{
    return [NSString stringWithFormat:@"%@/%@", [NSFileManager IAPDirectory], productIdentifier];
}

bool dictionaryBoolValue(NSString* value)
{
    return value != nil && [value boolValue];
}

@end
