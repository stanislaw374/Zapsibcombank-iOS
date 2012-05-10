//
//  Currencies.h
//  Zapsibcombank
//
//  Created by Yazhenskikh Stanislaw on 13.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Currency.h"

@interface Currencies : NSObject <UITableViewDataSource, UITableViewDelegate, CurrencyDelegate>
@property (nonatomic, unsafe_unretained) IBOutlet UITableView *tableView;
- (void)loadCurrency;
@end
