//
//  News.h
//  Zabsibcombank
//
//  Created by Yazhenskikh Stanislaw on 02.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "New.h"

@interface News : NSObject <UITableViewDataSource, UITableViewDelegate, NewDelegate>
@property (nonatomic, unsafe_unretained) IBOutlet UIView *view;
@property (nonatomic, unsafe_unretained) IBOutlet UITableView *tableView;
- (void)loadNews;
@end
