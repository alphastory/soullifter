//
//  NSFileManager+Paths.m
//  The Soul Lifter
//
//  Created by Kyle Sebestyen on 8/25/15.
//  Copyright (c) 2015 Planet Soul. All rights reserved.
//

#import "NSFileManager+Paths.h"

@implementation NSFileManager (Paths)

+(NSString*)IAPDirectory
{
    NSString *dir = [NSString stringWithFormat:@"%@/cards", NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0]];
    BOOL isDir;
    if(![[NSFileManager defaultManager]fileExistsAtPath:dir isDirectory:&isDir])
    {
        NSError *error = nil;
        [[NSFileManager defaultManager]createDirectoryAtPath:dir withIntermediateDirectories:NO attributes:nil error:&error];
        if(!error)
        {
            //don't backup anything in the directory to icloud
            BOOL success = [[NSURL fileURLWithPath:dir] setResourceValue: [NSNumber numberWithBool: YES]
                                          forKey: NSURLIsExcludedFromBackupKey error: &error];
            
        }
    }
    return dir;
}

@end
