//
//  NSUserDefaults+NSUserDefaults.h
//  The Soul Lifter
//
//  Created by Kyle Sebestyen on 8/24/15.
//  Copyright (c) 2015 Planet Soul. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaults (NSUserDefaults)

-(void) setBool:(NSString*)key value:(BOOL)value;
-(void) setInteger:(NSString*)key value:(int)value;
-(void) setString:(NSString*)key value:(NSString*)value;

@end
