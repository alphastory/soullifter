//
//  MattConnection.m
//  The Soul Lifter
//
//  Created by Matthew Wagner on 1/27/15.
//  Copyright (c) 2015 Planet Soul. All rights reserved.
//

#import "MattConnection.h"

@implementation MattConnection

+ (void)sendPostRequestToUrl:(NSString *)url payload:(NSDictionary *)payload withCallback:(MattConnectionCallback)callback {
    NSError *error;
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:120.0];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"Bearer 6369ecefd79aaa5f8771e338566e9e686e2bb761a54711e72762bd69284f80ce" forHTTPHeaderField:@"Authorization"];
    [request setHTTPMethod:@"POST"];
    NSData *payloadData = [NSJSONSerialization dataWithJSONObject:payload options:NSJSONWritingPrettyPrinted error:&error];
    request.HTTPBody = payloadData;
    [MattConnection sendRequest:request withCallback:callback];
}

+ (void)sendGetRequest:(NSString *)url withCallback:(MattConnectionCallback)callback {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:120.0];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"Bearer 6369ecefd79aaa5f8771e338566e9e686e2bb761a54711e72762bd69284f80ce" forHTTPHeaderField:@"Authorization"];
    [request setHTTPMethod:@"GET"];
    [MattConnection sendRequest:request withCallback:callback];
}

+ (void)sendRequest:(NSMutableURLRequest *)req withCallback:(void(^)(NSDictionary *json))callback {
    NSString *devicetoken = [[NSUserDefaults standardUserDefaults] stringForKey:@"devicetoken"];
    [req setValue:devicetoken forHTTPHeaderField:@"devicetoken"];
    [NSURLConnection sendAsynchronousRequest:req queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                               if(connectionError){
                                   NSLog(@"%@", [connectionError localizedDescription]);
                               }
                               else if(data) {
                                   NSMutableDictionary *json = [NSJSONSerialization
                                                                JSONObjectWithData:data
                                                                options:kNilOptions
                                                                error:&connectionError];
                                   if(callback) {
                                       if(!json){
                                           json = @{
                                                     @"response": response,
                                                     @"error"   : connectionError
                                                   };
                                       }
                                       callback(json);
                                       
                                   }
                               }
                           }];
}
@end