//
//  StoreModel.h
//  The Soul Lifter
//
//  Created by Matthew Wagner on 1/25/15.
//  Copyright (c) 2015 Planet Soul. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MattConnection.h"
#import <StoreKit/StoreKit.h>
#import <ContentfulDeliveryAPI/ContentfulDeliveryAPI.h>


@protocol StoreModelDelegate <NSObject>
@optional
-(void)receivedDataFromModel:(NSArray *)products;
@end

@interface StoreModel : NSObject <SKProductsRequestDelegate>

@property (strong, nonatomic) id <StoreModelDelegate> delegate;
@property (strong, nonatomic) NSMutableArray *identifiers;
@property (strong, nonatomic) NSMutableArray *products;
@property (strong, nonatomic) SKProductsRequest *productsRequest;
@property (strong, nonatomic) CDAClient *contentful;

-(void)getDataWithProductIdentifiers:(NSString*)productIdentifier;

@end
