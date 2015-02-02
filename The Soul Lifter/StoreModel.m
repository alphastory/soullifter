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
        self.collections = [[NSMutableArray alloc] init];
        [self getData];
    }
    return self;
}

-(void)getData {
    NSLog(@"Getting Data");
    NSString *url = @"https://api.dropbox.com/1/metadata/auto/Soul%20Lifter/?list=true";
    [MattConnection sendPostRequestToUrl:url payload:@{} withCallback:^(id json) {
        NSMutableDictionary *db_cards = [[NSMutableDictionary alloc] init];
        db_cards = json[@"contents"];
    }];
}

- (void)setupModelForView:(NSDictionary*)cards withCallback:(void(^)(NSDictionary *json))callback {
    NSString *apiPath = @"https://api.dropbox.com/1/metadata/auto/";
    for (NSDictionary *card in cards) {
        NSString *path = card[@"path"];
        NSString *staticPath = [NSString stringWithFormat:@"%@/%@/static.png", apiPath, path];
        NSString *animatedPath = [NSString stringWithFormat:@"%@/%@/animated.mp4", apiPath, path];
        NSDictionary *tempCard = [[NSDictionary alloc] initWithObjects:@[staticPath, animatedPath] forKeys:@[@"static", @"animated"]];
        [self.collections addObject:tempCard];
    }
}

@end
