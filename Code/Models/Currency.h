//
//  Currency.h
//  Zapsibcombank
//
//  Created by Yazhenskikh Stanislaw on 13.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Currency;

@protocol CurrencyDelegate <NSObject>
- (void)currencyDidLoad:(Currency *)currency;
- (void)currencyDidFail;
@end

@interface Currency : NSObject
@property (nonatomic, strong) NSMutableArray *course;

+ (void)getWithDelegate:(id <CurrencyDelegate>)delegate;
@end
