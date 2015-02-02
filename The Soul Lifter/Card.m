//
//  Card.m
//  The Soul Lifter
//
//  Created by Matthew Wagner on 1/8/15.
//  Copyright (c) 2015 Planet Soul. All rights reserved.
//

#import "Card.h"
#define API_DEFAULT @"http://soullifter.co"

@implementation Card

- (id)initWithName:(NSString *)name {
    self = [super init];
    if( self ){
        self.title = name;
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
        self.lastUsed = [decoder decodeObjectForKey:@"lastUsed"];
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
//    [encoder encodeObject:self.favorite forKey:@"favorite"];
}

@end
