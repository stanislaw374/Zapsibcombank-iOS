//
//  New.h
//  Zapsibcombank
//
//  Created by Yazhenskikh Stanislaw on 13.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NewDelegate <NSObject>
@optional
- (void)newsDidLoad:(NSArray *)news;
- (void)newsDidFailWithError:(NSError *)error;
@end

@interface New : NSObject
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *text;

+ (void)get:(int)page withDelegate:(id <NewDelegate>)delegate;
@end
