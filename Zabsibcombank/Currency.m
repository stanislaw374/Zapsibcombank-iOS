//
//  Currency.m
//  Zapsibcombank
//
//  Created by Yazhenskikh Stanislaw on 13.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Currency.h"
#import "Config.h"
#import "NSURLConnection+Block.h"
#import "SBJson.h"
#import "HTMLParser.h"

@implementation Currency
@synthesize course = _course;

- (NSMutableArray *)course {
    if (!_course) {
        _course = [[NSMutableArray alloc] init];
    }
    return _course;
}

+ (void)getWithDelegate:(id<CurrencyDelegate>)delegate {    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        NSError *error;
        NSURL *url = [NSURL URLWithString:@"http://zapsibkombank.ru"];
        NSString *htmlString = [NSString stringWithContentsOfURL:url encoding:NSWindowsCP1251StringEncoding error:&error];        
        
        if (error) {
            NSLog(@"%@, error: %@", NSStringFromSelector(_cmd), error.localizedDescription);
            dispatch_async(dispatch_get_main_queue(), ^{
                [delegate currencyDidFail];
            });
        }
        
        HTMLParser *parser = [[HTMLParser alloc] initWithString:htmlString error:&error];
        if (error) {
            NSLog(@"%@, error: %@", NSStringFromSelector(_cmd), error.localizedDescription);            
            dispatch_async(dispatch_get_main_queue(), ^{
                [delegate currencyDidFail];
            });
        }
        else {
            HTMLNode *bodyNode = [parser body];                    
            HTMLNode *currencyDiv = [bodyNode findChildOfClass:@"course"];
            NSArray *rows = [currencyDiv findChildTags:@"tr"];
            
            Currency *currency = [[Currency alloc] init];
            
            for (int i = 1; i < rows.count; i++) {
                HTMLNode *row = (HTMLNode *)[rows objectAtIndex:i];
                NSArray *columns = [row findChildTags:@"td"];
                
                NSMutableDictionary *c = [NSMutableDictionary dictionary];
                [c setObject:((HTMLNode *)[columns objectAtIndex:0]).contents forKey:@"currency"];
                [c setObject:((HTMLNode *)[columns objectAtIndex:1]).contents forKey:@"purchase"];
                [c setObject:((HTMLNode *)[columns objectAtIndex:2]).contents forKey:@"sale"];
                [c setObject:((HTMLNode *)[columns objectAtIndex:3]).contents forKey:@"cb"];                            
                
                [currency.course addObject:c];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [delegate currencyDidLoad:currency];
            });
        }        
    });
}
@end
