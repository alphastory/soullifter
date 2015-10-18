//
//  StoreViewController.m
//  The Soul Lifter
//
//  Created by Matthew Wagner on 1/25/15.
//  Copyright (c) 2015 Planet Soul. All rights reserved.
//

#import "StoreViewController.h"
//#import <DropboxSDK/DropboxSDK.h>
#import "MattConnection.h"

@interface StoreViewController ()

@end

@implementation StoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Create the Model
    self.storeModel = [[StoreModel alloc] init];
    self.storeModel.delegate = self;
    
    // Create the View
    self.storeView = [[StoreView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.storeView.delegate = self;
    
    self.view = self.storeView;
    [self.storeView buildView];
}
//
//- (void)sessionDidReceiveAuthorizationFailure:(DBSession *)session userId:(NSString *)userId {
//    NSLog(@"Authorization Failed");
//}

-(void)restorePurchases
{
    [self.storeModel restorePurchases];
}

-(void)purchaseCardWithIdentifier:(NSString *)identifier {
    [self.storeModel buyCard:identifier];
}

-(void)listContent:(NSArray*)products {
    for (SKProduct *product in products) {
        if(product.downloadable){
            NSMutableDictionary *info = [[NSMutableDictionary alloc] init];
            info[@"price"] = product.price;
            info[@"title"] = product.localizedTitle;
            info[@"description"] = product.localizedDescription;
            NSLog(@"%@", info);
        }
    }
}

-(void)sendCardsToView {
    [self.storeView addCardsToUIWithData:self.storeModel.products];
}

-(void)getProducts {
    if( [self.storeModel respondsToSelector:@selector(getDataWithProductIdentifiers:)]){
        NSLog(@"Retrieving Products");
        [self.storeModel getDataWithProductIdentifiers:@""];
//        self.storeView.allCards = self.storeModel.products;
    }
    [self sendCardsToView];
}

- (void)returnToHome {
    [self.storeModel unload];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)doAlert:(NSString*)message
{
    [[[UIAlertView alloc]initWithTitle:@"" message:message delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil]show];
}

#pragma mark - CollectionSelectorProtocol
-(void)collectionSelectorDidSelectCollection:(CollectionModel *)collection
{
    //I want to view cards from this collection please
    [self.storeView showCardsForCollection:collection];
}

#pragma mark - StoreViewDelegate
-(void)purchaseComplete:(id)transaction
{
    [self.storeModel transactionResolved:transaction];
}

#pragma mark - StoreModelDelegate
-(void)willRestorePurchases:(NSArray *)transactions
{
    if(!restoringAlert){
        restoringAlert = [[UIAlertView alloc]initWithTitle:@"Restoring In App Purchases" message:@"" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
        [restoringAlert show];
    }
}

-(void)didFinishRestoringPurchases
{
    [self removeRestoringAlert];
}

-(void)didFailToRestorePurchases:(NSError*)error
{
    [self removeRestoringAlert];
    [self doAlert:@"Could not restore In App Purchases at this time. Please try again later."];
}

-(void)removeRestoringAlert
{
    if(restoringAlert){
        [restoringAlert dismissWithClickedButtonIndex:0 animated:YES];
        restoringAlert = nil;
    }
}

-(void)receivedDataFromModel:(StoreDataSource *)storeDataSource {
    //    NSLog(@"Received Products");
    //    NSLog(@"%@", products);
    //    [self listContent:products];
    [self.storeView addCardsToUIWithData:storeDataSource];
}

-(void)purchaseStateAlreadyPurchased
{
    [self.storeView alreadyPurchased];
}

-(void)purchaseStatePurchasing
{
    [self.storeView updatePurchaseStatus:@"Purchasing" isDone:NO withTransaction:nil];
}

-(void)purchaseStatePurchased:(SKPaymentTransaction*)transaction
{
    
    [self.storeView updatePurchaseStatus:@"Purchased Successfully!" isDone:YES withTransaction:transaction];
}

-(void)purchaseStateFailed:(SKPaymentTransaction*)transaction
{
    [self.storeView updatePurchaseStatus:@"Purchase Failed" isDone:YES withTransaction:transaction];
}

-(void)purchaseStateDeferred:(SKPaymentTransaction*)transaction
{
    [self.storeView updatePurchaseStatus:@"Purchase Deferred" isDone:YES withTransaction:transaction];
}

-(void)purchaseStateRestored
{
//    [self.storeView updatePurchaseStatus:@"Purchase Restored" isDone:NO];
}

-(void)viewAllCollections:(NSArray*)collections
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    CollectionSelectorTableViewController *selector = (CollectionSelectorTableViewController *)[sb instantiateViewControllerWithIdentifier:@"CollectionSelectorTableViewController"];
    selector.collectionDelegate = self;
    [selector setCollections:collections];
    [self presentViewController:selector animated:YES completion:nil];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
