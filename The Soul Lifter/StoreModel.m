//
//  StoreModel.m
//  The Soul Lifter
//
//  Created by Matthew Wagner on 1/25/15.
//  Copyright (c) 2015 Planet Soul. All rights reserved.
//

#import "StoreModel.h"

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

#pragma mark SKProductRequestDelegate Protocol

-(void)getDataWithProductIdentifiers:(NSString*)productIdentifier {
    NSArray *productIdentifiers = [[NSArray alloc] initWithObjects:productIdentifier, nil];
    self.productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:[NSSet setWithArray:productIdentifiers]];
    self.productsRequest.delegate = self;
    [self.productsRequest start];
}

-(void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response {
    NSLog(@"%@", response.products);
    for( NSString *invalidIdentifier in response.invalidProductIdentifiers ){
        // Handle invalidities
        NSLog(@"invalid products %@", invalidIdentifier);
    }
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
        BOOL animated = [[[imageURL lowercaseString] pathExtension] isEqualToString:@"mp4"];
        
        
        [product setObject:title forKey:@"title"];
        [product setObject:imageURL forKey:@"preview"];
        [product setObject:price forKey:@"price"];
        [product setObject:identifier forKey:@"identifier"];
        [product setObject:@(animated) forKey:@"animated"];
        
        [products addObject:product];
    }
    callback(products);
}

@end
