//
//  Card.h
//  The Soul Lifter
//
//  Created by Matthew Wagner on 1/8/15.
//  Copyright (c) 2015 Planet Soul. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MattConnection.h"

@protocol CardDelegate <NSObject>
@optional
    -(void)addCardToObject:(NSObject*)card;
//    -(void)addCardsToCardView;
@end

@class UIImage;

@interface Card : NSObject <NSURLConnectionDelegate, NSURLConnectionDataDelegate, NSCoding>

@property (strong, nonatomic) NSString *identifier;
@property (strong, nonatomic) NSString *type;
@property (strong, nonatomic) NSString *title;
@property (retain, nonatomic) NSString *staticCard;
@property (strong, nonatomic) NSString *animatedCard;
@property (strong, nonatomic) NSString *price;
@property (strong, nonatomic) NSString *preview;
@property (strong, nonatomic) NSDate *lastUsed;
@property (nonatomic) BOOL favorite;
@property (nonatomic) BOOL isCollection;
@property (nonatomic) BOOL isAnimated;

@property (assign, nonatomic) id<CardDelegate> delegate;

- (id)initWithName:(NSString *)name;
- (id)initWithDictionary:(NSDictionary *)dictionary;
- (id)initWithCoder:(NSCoder *)decoder;
- (void)encodeWithCoder:(NSCoder *)encoder;
- (void)markAsFavorite;
+(NSURL*)getStagingURLForDownload:(NSString*)productIdentifier;
+(NSString*)getStatingPathForDownload:(NSString*)productIdentifier;
@end
