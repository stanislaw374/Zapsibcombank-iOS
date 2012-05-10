//
//  NSURLConnection+Block.m
//  Zapsibcombank
//
//  Created by Yazhenskikh Stanislaw on 13.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NSURLConnection+Block.h"

@implementation NSURLConnection (Block)
+ (void)asyncRequest:(NSURLRequest *)request successBlock :(void (^)(NSData *, NSURLResponse *))success failureBlock:(void (^)(NSData *, NSError *))failure {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURLResponse *response;
        NSError *error;
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error) {
                failure(data, error);
            }
            else {
                success(data, response);
            }
        });
    });
}
@end
