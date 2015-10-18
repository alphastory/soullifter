//
//  StoreDataSource.h
//  The Soul Lifter
//
//  Created by Kyle Sebestyen on 10/6/15.
//  Copyright © 2015 Planet Soul. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StoreDataSource : NSObject
{
    NSArray *collections;
}
-(id)initWithProducts:(NSArray*)productsDictionaries;
-(NSArray*)getCollections;
@end
