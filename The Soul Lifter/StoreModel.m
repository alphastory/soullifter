//
//  StoreModel.m
//  The Soul Lifter
//
//  Created by Matthew Wagner on 1/25/15.
//  Copyright (c) 2015 Planet Soul. All rights reserved.
//

#import "StoreModel.h"
#import "Card.h"
#import "NSUserDefaults+NSUserDefaults.h"
#import "NSFileManager+Paths.h"
#import "StoreDataSource.h"

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
        
        StoreDataSource *sds = [[StoreDataSource alloc]initWithProducts:self.products];
        
//        [self setupModelForViewWithCallback:^(NSArray *products) {
            [self.delegate receivedDataFromModel:sds];
//            [self getDataWithProductIdentifiers:self.identifiers];
//        }];
    } failure:^(CDAResponse *response, NSError *error) {
        NSLog(@"Errors");
        NSLog(@"%@", error);
    }];
}

-(BOOL)alreadyPurchased:(NSString*)productIdentifier
{
    return [[NSUserDefaults standardUserDefaults] stringForKey:productIdentifier] != nil;
}

-(void)saveDownload:(SKDownload*)download
{
    [[NSUserDefaults standardUserDefaults] setValue:download.contentVersion forKey:download.contentIdentifier];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void)restorePurchases
{
    //https://developer.apple.com/library/ios/documentation/NetworkingInternet/Conceptual/StoreKitGuide/Chapters/Restoring.html#//apple_ref/doc/uid/TP40008267-CH8-SW9
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
}

#pragma mark SKPaymentTransactionObserver
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions
{
    NSMutableArray *restoring = [NSMutableArray new];
    NSMutableArray *otherTransactions = [NSMutableArray new];
    for (SKPaymentTransaction *transaction in transactions) {
        if(transaction.transactionState == SKPaymentTransactionStateRestored)
        {
            NSLog(@"restoring %@", transaction.transactionIdentifier);
            [restoring addObject:transaction];
        }
        else{
            [otherTransactions addObject:transaction];
        }
    }
    
    if(restoring.count > 0){
        [self.delegate willRestorePurchases:restoring];
        [self processMultipleDownloads:restoring];
    }

    for (SKPaymentTransaction *transaction in otherTransactions) {
        
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
                [self.delegate purchaseStateDeferred:transaction];
                break;
                
            case SKPaymentTransactionStateFailed:
                [self.delegate purchaseStateFailed:transaction];
                break;
                
            case SKPaymentTransactionStatePurchased:
                [self processDownloads:transaction];
                break;
                
//                case SKPaymentTransactionStateRestored:
//                    [self.delegate purchaseStateRestored];
//                    break;
                
                default:
                    
                    // For debugging
                    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                    NSLog(@"Unexpected transaction state %@", @(transaction.transactionState));
                    break;
                
        }
    }
}

-(void)processMultipleDownloads:(NSArray*)transactions
{
//    SKPaymentTransaction*
    for(SKPaymentTransaction *t in transactions)
    {
        [self processDownloads:t];
    }
}

-(void)processDownloads:(SKPaymentTransaction*)transaction
{
    if(transaction.downloads.count > 0){
        [[SKPaymentQueue defaultQueue] startDownloads:transaction.downloads];
    }
    else{
        //TODO handle no downloads
    }
}

- (void)paymentQueue:(SKPaymentQueue *)queue updatedDownloads:(NSArray *)downloads
{
    BOOL allDone = YES;
    for(SKDownload* download in downloads)
    {
        NSLog(@"paymentQueue update: %li %f", (long)download.downloadState, download.progress);
        if(download.downloadState != SKDownloadStateFinished)
        {
            allDone = NO;
        }
        else{
            [self stagePayload:download];
            [self saveDownload:download];
        }
    }
    
    if(allDone)
    {
        SKDownload *d = downloads[0];
        [self.delegate purchaseStatePurchased:d.transaction];
        [self finishTransaction:d.transaction];
    }
}

-(void)stagePayload:(SKDownload*)download
{
    NSURL *fromURL = download.contentURL;
    NSURL *toURL = [Card getStagingURLForDownload:download.contentIdentifier];
    NSError *error = nil;
    [[NSFileManager defaultManager]moveItemAtURL:fromURL toURL:toURL error:&error];
    
    if(error != nil){
        NSLog(@"stagePayload error %@", error.localizedDescription);
    }
//    assert(error == nil);
}

-(void)paymentQueueRestoreCompletedTransactionsFinished:(SKPaymentQueue *)queue
{
    [self.delegate didFinishRestoringPurchases];
}

-(void)paymentQueue:(SKPaymentQueue *)queue restoreCompletedTransactionsFailedWithError:(NSError *)error
{
    [self.delegate didFailToRestorePurchases:error];
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
//    NSArray *productIdentifiers = [[NSArray alloc] initWithObjects:productIdentifier, nil];

//    self.productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:[NSSet setWithArray:@[@"co.soullifter.TheSoulLifter.ItsYouAndMe",@"co.soullifter.TheSoulLifter.YoureNotAlone"]]];
    
    self.productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:[NSSet setWithArray:@[productIdentifier]]];
    
    self.productsRequest.delegate = self;
    [self.productsRequest start];
}

-(void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response {
    NSLog(@"%@", response.products);
    
    //TODO handle more than one product being available. This is posbile if an array was passed in to the SKProductsRequest.
    //currently this  requests a payment for the first item. We'd need to extend this to purchase multiples at once.
//    assert(response.products.count < 2);
    
    for( NSString *invalidIdentifier in response.invalidProductIdentifiers ){
        // Handle invalidities
        NSLog(@"invalid products %@", invalidIdentifier);
    }
    
    
    for (int i = 0; i < response.products.count; i++) {
        [self requestPayment:response.products[i]];
    }
    
    
//    if(response.products.count == 1)
//    {
//        [self requestPayment:response.products[0]];
//    }
//    else{
//        NSLog(@"no products to buy!");
//    }
}


-(void)requestPayment:(SKProduct*)product
{
    currentPayment = [SKMutablePayment paymentWithProduct:product];
    currentPayment.quantity = 1;
    [[SKPaymentQueue defaultQueue] addPayment:currentPayment];
    //calls back on the paymentQueue:updatedTransactions
}

-(void)finishTransaction:(SKPaymentTransaction*)transaction
{
    NSLog(@"finished %@", transaction.transactionIdentifier);
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
}

-(void)transactionResolved:(SKPaymentTransaction*)transaction
{
    [self finishTransaction:transaction];
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
