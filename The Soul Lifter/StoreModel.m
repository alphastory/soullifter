//
//  StoreModel.m
//  The Soul Lifter
//
//  Created by Matthew Wagner on 1/25/15.
//  Copyright (c) 2015 Planet Soul. All rights reserved.
//

#import "StoreModel.h"
#import "NSUserDefaults+NSUserDefaults.h"

@implementation StoreModel

-(id)init {
    self = [super init];
    if(self){
        self.products = [[NSMutableArray alloc] init];
        self.identifiers = [[NSMutableArray alloc] init];
        
        [self getProductIdentifiers];
    }
    return self;
}

-(void)getProductIdentifiers {
    
    self.contentful = [[CDAClient alloc] initWithSpaceKey:@"d9dwm1vmidcl"
                                              accessToken:@"6369ecefd79aaa5f8771e338566e9e686e2bb761a54711e72762bd69284f80ce"];
    
    [self.contentful fetchEntriesWithSuccess:^(CDAResponse *response, CDAArray *array) {
        for (CDAEntry *entry in array.items) {
            NSString *identifier = [entry.fields objectForKey:@"identifier"];
            [self.products addObject:entry.fields];
            [self.identifiers addObject:identifier];
        }
        [self setupModelForViewWithCallback:^(NSArray *products) {
            [self.delegate receivedDataFromModel:products];
//            [self getDataWithProductIdentifiers:self.identifiers];
        }];
    } failure:^(CDAResponse *response, NSError *error) {
        NSLog(@"Errors");
        NSLog(@"%@", error);
    }];
}

-(BOOL)alreadyPurchased:(NSString*)productIdentifier
{
    return [[NSUserDefaults standardUserDefaults] stringForKey:productIdentifier] != nil;
}

-(void)savePayment:(SKPayment*)payment
{
    [[NSUserDefaults standardUserDefaults]setInteger:payment.quantity forKey:payment.productIdentifier];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark SKPaymentTransactionObserver
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions
{
    for (SKPaymentTransaction *transaction in transactions) {
        
        if([currentPayment.productIdentifier isEqualToString:transaction.payment.productIdentifier]){
            currentTransaction = transaction;
        }
        else{
            [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
            return;
        }
        
        switch (transaction.transactionState) {
            case SKPaymentTransactionStatePurchasing:
                [self.delegate purchaseStatePurchasing];
                break;
                
            case SKPaymentTransactionStateDeferred:
                [self.delegate purchaseStateDeferred];
                break;
                
            case SKPaymentTransactionStateFailed:
                [self.delegate purchaseStateFailed];
                break;
                
            case SKPaymentTransactionStatePurchased:
                [self savePayment:transaction.payment];
                [self.delegate purchaseStatePurchased];
                break;
                
            case SKPaymentTransactionStateRestored:
                [self savePayment:transaction.payment];
                [self.delegate purchaseStateRestored];
                break;
                
            default:
                
                // For debugging
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                NSLog(@"Unexpected transaction state %@", @(transaction.transactionState));
                break;
                
        }
    }
}

#pragma mark SKProductRequestDelegate Protocol

-(void)buyCard:(NSString*)productIdentifier
{
    if([self alreadyPurchased:productIdentifier])
    {
        [self.delegate purchaseStateAlreadyPurchased];

    }
    else{
        [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
        [self getDataWithProductIdentifiers:productIdentifier];
    }
}

-(void)getDataWithProductIdentifiers:(NSString*)productIdentifier {
    NSArray *productIdentifiers = [[NSArray alloc] initWithObjects:productIdentifier, nil];
    self.productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:[NSSet setWithArray:productIdentifiers]];
    self.productsRequest.delegate = self;
    [self.productsRequest start];
}

-(void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response {
    NSLog(@"%@", response.products);
    
    //TODO handle more than one product being available. This is posbile if an array was passed in to the SKProductsRequest.
    //currently this  requests a payment for the first item. We'd need to extend this to purchase multiples at once.
    assert(response.products.count < 2);
    
    for( NSString *invalidIdentifier in response.invalidProductIdentifiers ){
        // Handle invalidities
        NSLog(@"invalid products %@", invalidIdentifier);
    }
    
    if(response.products.count == 1)
    {
        [self requestPayment:response.products[0]];
    }
    else{
        NSLog(@"no products to buy!");
    }
}


-(void)requestPayment:(SKProduct*)product
{
    currentPayment = [SKMutablePayment paymentWithProduct:product];
    currentPayment.quantity = 1;
    [[SKPaymentQueue defaultQueue] addPayment:currentPayment];
}

-(void)transactionResolved
{
    [[SKPaymentQueue defaultQueue] finishTransaction:currentTransaction];
}

- (void)setupModelForViewWithCallback:(void(^)(NSArray *products))callback {
    NSMutableArray *products = [[NSMutableArray alloc] init];
    for (NSDictionary *card in self.products) {
        NSMutableDictionary *product = [[NSMutableDictionary alloc] init];
        // Get Preview Image
        CDAAsset *previewAsset = card[@"preview"];
        NSString *imageURL = [NSString stringWithFormat:@"http:%@", previewAsset.fields[@"file"][@"url"]];
        
        // Get Title
        NSString *title = card[@"title"];
        NSString *price = card[@"price"];
        NSString *identifier = card[@"identifier"];
        
        BOOL animated = card[@"animated"] != nil ? [card[@"animated"]boolValue] : NO;
        
        if(animated)
        {
            CDAAsset *animatedPreview = card[@"animatedPreview"];
            NSString *animatedPreviewURL = [NSString stringWithFormat:@"http:%@", animatedPreview.fields[@"file"][@"url"]];
            [product setObject:animatedPreviewURL forKey:@"animatedPreview"];
        }
        
        [product setObject:title forKey:@"title"];
        [product setObject:imageURL forKey:@"preview"];
        [product setObject:price forKey:@"price"];
        [product setObject:identifier forKey:@"identifier"];
        [product setObject:@(animated) forKey:@"animated"];
        
        [products addObject:product];
    }
    callback(products);
}

-(void)unload
{
    [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
}

@end
