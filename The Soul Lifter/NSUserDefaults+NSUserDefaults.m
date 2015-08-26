//
//  NSUserDefaults+NSUserDefaults.m
//  The Soul Lifter
//
//  Created by Kyle Sebestyen on 8/24/15.
//  Copyright (c) 2015 Planet Soul. All rights reserved.
//

#import "NSUserDefaults+NSUserDefaults.h"

@implementation NSUserDefaults (NSUserDefaults)


-(void) setBool:(NSString*)key value:(BOOL)value {
    [[NSUserDefaults standardUserDefaults]setBool:value forKey:key];
    [[NSUserDefaults  standardUserDefaults]synchronize];
}

-(void) setInteger:(NSString*)key value:(int)value {
    [[NSUserDefaults standardUserDefaults]setInteger:value forKey:key];
    [[NSUserDefaults  standardUserDefaults]synchronize];
}


@end
