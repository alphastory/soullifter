//
//  StoreModel.h
//  The Soul Lifter
//
//  Created by Matthew Wagner on 1/25/15.
//  Copyright (c) 2015 Planet Soul. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MattConnection.h"

@protocol StoreModelDelegate <NSObject>
@optional
-(void)receivedDataFromModel:(NSDictionary*)data;
@end

@interface StoreModel : NSObject

@property (strong, nonatomic) id <StoreModelDelegate> delegate;
@property (strong, nonatomic) NSMutableArray *collections;


@end
