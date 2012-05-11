//
//  New.m
//  Zapsibcombank
//
//  Created by Yazhenskikh Stanislaw on 13.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "New.h"
#import "Config.h"
#import "SBJson.h"
#import "NSURLConnection+Block.h"

static New *_new;

@implementation New
@synthesize date = _date;
@synthesize title = _title;
@synthesize text = _text;

+ (void)initialize {
    _new = [[New alloc] init];
}

+ (void)get:(int)page withDelegate:(id<NewDelegate>)delegate {    
    //NSURLRequest *request = [NSURLRequest requestWithURL:url];    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *url = [NSURL URLWithString:[API_PATH stringByAppendingPathComponent:[NSString stringWithFormat:@"/news/%d", page]]];
        NSError *error;
        NSString *responseString = [NSString stringWithContentsOfURL:url encoding:NSWindowsCP1251StringEncoding error:&error];
        if (error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [delegate newsDidFailWithError:error];
            });
        }
        else {
            NSMutableArray *result = [[NSMutableArray alloc] init];
            
            SBJsonParser *parser = [[SBJsonParser alloc] init];
            NSArray *news = [parser objectWithString:responseString];
            for (NSDictionary *new in news) {
                New *n = [[New alloc] init];
                NSDateFormatter *df = [[NSDateFormatter alloc] init];
                df.dateFormat = @"yyyy-MM-dd HH:mm:ss";
                n.date = [df dateFromString:[new objectForKey:@"date"]];
                n.title = [new objectForKey:@"title"];
                n.text = [new objectForKey:@"content"];
                
                [result addObject:n];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [delegate newsDidLoad:result];
            });
        }
    });
    
//    [NSURLConnection asyncRequest:request successBlock:^(NSData *data, NSURLResponse *response) {
//        
//        //NSLog(@"News reveived: %@", [NSString stringWithUTF8String:data.bytes]);
//        
//        NSMutableArray *result = [[NSMutableArray alloc] init];
//        
//        SBJsonParser *parser = [[SBJsonParser alloc] init];
//        NSArray *news = [parser objectWithData:data];
//        for (NSDictionary *new in news) {
//            New *n = [[New alloc] init];
//            NSDateFormatter *df = [[NSDateFormatter alloc] init];
//            df.dateFormat = @"yyyy-MM-dd HH:mm:ss";
//            n.date = [df dateFromString:[new objectForKey:@"date"]];
//            n.title = [new objectForKey:@"title"];
//            n.text = [new objectForKey:@"content"];
//            
//            [result addObject:n];
//        }
//     [delegate newsDidLoad:result];
//    } failureBlock:^(NSData *data, NSError *error) {
//        [delegate newsDidFailWithError:error];
//    }];
}

@end
