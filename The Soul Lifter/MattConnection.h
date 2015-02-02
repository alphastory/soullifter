//
//  MattConnection.h
//  The Soul Lifter
//
//  Created by Matthew Wagner on 1/27/15.
//  Copyright (c) 2015 Planet Soul. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MattConnection : NSObject

typedef void (^MattConnectionCallback)(id json);

@property (strong, nonatomic) NSString *accessToken;

+ (void)sendPostRequestToUrl:(NSString *)url payload:(NSDictionary *)payload withCallback:(MattConnectionCallback)callback;
+ (void)sendGetRequest:(NSString *)url withCallback:(MattConnectionCallback)callback;

@end