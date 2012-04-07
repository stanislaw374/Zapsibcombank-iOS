//
//  CitiesView.h
//  Zabsibcombank
//
//  Created by Yazhenskikh Stanislaw on 03.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CitiesPickerDelegate
- (void)citiesPickerDidPickCity:(NSDictionary *)city;
@end

@interface CitiesView : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>
@property (nonatomic, unsafe_unretained) id<CitiesPickerDelegate> delegate;
@property (unsafe_unretained, nonatomic) IBOutlet UITableView *tableView;
@end

