//
//  SelectionModel.h
//  The Soul Lifter
//
//  Created by Matthew Wagner on 1/15/15.
//  Copyright (c) 2015 Planet Soul. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MattConnection.h"
#import "Card.h"

#pragma mark Delegate Protocol
@protocol SelectionModelDelegate
    @required

    @optional
    -(void)fetchingCardsFailedWithError;
    -(void)sendCardsToView;
    -(void)receivedCardsJSON:(NSData*)data forType:(NSString*)type;
    -(void)setupView;
@end

#pragma mark Object
@interface SelectionModel : NSObject

typedef void (^SelectionModelCallback)(void);

@property (weak, nonatomic) id<SelectionModelDelegate> delegate;
@property (strong, nonatomic) NSMutableArray *data;
@property (strong, nonatomic) NSMutableArray *defaultData;
@property (strong, nonatomic) NSMutableArray *filtered;

-(id)initForType:(NSString*)type;
-(void)setCardDefaults;
-(void)getSavedCardData;
-(void)filterCardsByType:(NSString*)type;
-(void)saveCardData;

@end
